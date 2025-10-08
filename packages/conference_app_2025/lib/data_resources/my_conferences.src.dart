import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:xsoulspace_state_utils/xsoulspace_state_utils.dart';

/// {@template my_conferences_resource}
/// Resource for managing user's scheduled conference sessions.
///
/// Maintains an internal time-grouped cache for efficient schedule display.
/// Sessions are automatically sorted and grouped by time when added or removed.
///
/// Example:
/// ```dart
/// // Add session to schedule
/// myConferencesResource.add(session);
///
/// // Get overlapping sessions at a specific time
/// final overlaps = myConferencesResource.getOverlappingSessions(dateTime);
///
/// // Get sessions sorted by time
/// final timeline = myConferencesResource.timelineSessions;
/// ```
/// {@endtemplate}
class MyConferencesResource
    extends OrderedMapNotifier<ConferenceSessionId, ConferenceSession> {
  /// {@macro my_conferences_resource}
  MyConferencesResource() : super(toKey: (final session) => session.id);

  /// All sessions sorted by start time
  List<ConferenceSessionId> _sortedByStartTime = [];

  /// Time-grouped cache: sessions grouped by start hour
  final Map<int, List<ConferenceSessionId>> _groupedByTime = {};

  /// Get all sessions sorted by start time
  List<ConferenceSession> get timelineSessions => _sortedByStartTime
      .map((final id) => this[id])
      .whereType<ConferenceSession>()
      .toList();
  @override
  void upsert(
    final ConferenceSession value, {
    final bool putFirst = false,
    final ConferenceSessionId? key,
  }) {
    super.upsert(value, putFirst: putFirst, key: key);
    _rebuildCache();
  }

  @override
  void assignAll(final Map<ConferenceSessionId, ConferenceSession> map) {
    super.assignAll(map);
    _rebuildCache();
  }

  @override
  void remove(final ConferenceSessionId key) {
    super.remove(key);
    _rebuildCache();
  }

  @override
  void clear() {
    super.clear();
    _rebuildCache();
  }

  @override
  void assignAllOrdered(final Iterable<ConferenceSession> items) {
    super.assignAllOrdered(items);
    _rebuildCache();
  }

  @override
  void operator []=(
    final ConferenceSessionId key,
    final ConferenceSession value,
  ) {
    super[key] = value;
    _rebuildCache();
  }

  /// Rebuild time-grouped cache and timeline
  void _rebuildCache() {
    _groupedByTime.clear();

    final sortedSessionsIds = <ConferenceSessionId>[...keys]
      // Sort by start time
      ..sort((final a, final b) {
        final aStart = this[a]?.startAt;
        final bStart = this[b]?.startAt;
        if (aStart == null || bStart == null) return 0;
        return aStart.compareTo(bStart);
      });

    _sortedByStartTime = sortedSessionsIds;

    // Group by hour
    for (final sessionId in sortedSessionsIds) {
      final startAt = this[sessionId]?.startAt;
      if (startAt == null) continue;

      final hourKey = _getHourKey(startAt);
      _groupedByTime.update(
        hourKey,
        (final value) => value..add(sessionId),
        ifAbsent: () => [sessionId],
      );
    }

    notifyListeners();
  }

  /// Get hour key for grouping (minutes from midnight)
  int _getHourKey(final DateTime dateTime) =>
      dateTime.hour * 60 + dateTime.minute;

  /// Get sessions that overlap with the given time range
  List<ConferenceSession> getOverlappingSessions(
    final DateTime startTime,
    final DateTime endTime,
  ) {
    final overlapping = <ConferenceSession>[];

    for (final sessionId in _sortedByStartTime) {
      final sessionStart = this[sessionId]?.startAt;
      final sessionEnd = this[sessionId]?.endAt;

      if (sessionStart == null || sessionEnd == null) continue;

      // Check if sessions overlap
      if (sessionStart.isBefore(endTime) && sessionEnd.isAfter(startTime)) {
        final session = this[sessionId];
        if (session == null) continue;
        overlapping.add(session);
      }
    }

    return overlapping;
  }

  /// Get sessions within a specific hour range
  List<ConferenceSession> getSessionsInHourRange(
    final int startHour,
    final int endHour,
  ) {
    final sessions = <ConferenceSession>[];

    for (var hour = startHour; hour <= endHour; hour++) {
      final hourSessions = _groupedByTime[hour * 60];
      if (hourSessions == null) continue;
      sessions.addAll(
        hourSessions.map((final id) => this[id]).whereType<ConferenceSession>(),
      );
    }

    return sessions;
  }

  /// Check if a session has conflicts with existing schedule
  bool hasConflicts(final ConferenceSession session) {
    final startAt = session.startAt;
    final endAt = session.endAt;

    if (startAt == null || endAt == null) return false;

    return getOverlappingSessions(
      startAt,
      endAt,
    ).where((final s) => s.id != session.id).isNotEmpty;
  }

  /// Check if a session is in the schedule
  bool hasSession(final ConferenceSessionId id) => containsKey(id);
}

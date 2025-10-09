import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/ui_conferences/ui_conference_details_screen.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// {@template ui_my_schedule_screen}
/// Screen displaying user's scheduled conference sessions in a timeline view.
///
/// Features:
/// - Full 00:00-24:00 timeline
/// - Sessions positioned by time
/// - Overlapping sessions displayed side-by-side
/// - Tap to navigate to details
/// {@endtemplate}
class UiMyScheduleScreen extends StatelessWidget {
  /// {@macro ui_my_schedule_screen}
  const UiMyScheduleScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final myConferences = context.watch<MyConferencesResource>();
    final sessions = myConferences.timelineSessions;

    return UiScaffold(
      appBar: AppBar(title: const Text('My Schedule')),
      body: sessions.isEmpty
          ? Column(
              children: [
                const Spacer(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text('Add some sessions to your schedule')),
                  ],
                ),
                const Spacer(),
                UiButton(
                  onPressed: () =>
                      context.goNamed(AppRoute.allConferences.name),
                  text: 'Add sessions',
                ),
                const Gap(24),
              ],
            )
          : _ScheduleTimeline(sessions: sessions),
    );
  }
}

class _ScheduleTimeline extends StatelessWidget {
  const _ScheduleTimeline({required this.sessions});

  final List<ConferenceSession> sessions;

  /// Height in pixels for 1 hour
  static const double hourHeight = 80;

  /// Width of time label column
  static const double timeLabelWidth = 60;

  @override
  Widget build(final BuildContext context) {
    // Build hour marks for 24 hours
    final hourMarks = List.generate(24, (final i) => i);
    const totalHeight = 24 * hourHeight;

    return SingleChildScrollView(
      child: Row(
        children: [
          // Time labels column
          SizedBox(
            width: timeLabelWidth,
            height: totalHeight,
            child: Column(
              children: hourMarks
                  .map(
                    (final hour) => SizedBox(
                      height: hourHeight,
                      child: _TimeLabel(hour: hour),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Sessions area
          Expanded(
            child: SizedBox(
              height: totalHeight,
              child: Stack(
                children: [
                  // Hour dividers
                  ...hourMarks.map(
                    (final hour) => Positioned(
                      top: hour * hourHeight,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),

                  // Sessions
                  ..._buildSessionWidgets(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSessionWidgets(final BuildContext context) {
    final widgets = <Widget>[];
    final processedSessions = <ConferenceSessionId>{};

    for (final session in sessions) {
      if (processedSessions.contains(session.id)) continue;

      final startAt = session.startAt;
      final endAt = session.endAt;

      if (startAt == null || endAt == null) continue;

      // Find overlapping sessions
      final overlapping = sessions.where((final s) {
        final sStart = s.startAt;
        final sEnd = s.endAt;
        if (sStart == null || sEnd == null) return false;
        return sStart.isBefore(endAt) && sEnd.isAfter(startAt);
      }).toList();

      processedSessions.addAll(overlapping.map((final s) => s.id));

      if (overlapping.length > 2) {
        // Show first 2 and a button for more
        widgets.add(
          _buildOverlappingGroup(
            context,
            overlapping.sublist(0, 2),
            startAt,
            endAt,
            moreCount: overlapping.length - 2,
            allSessions: overlapping,
          ),
        );
      } else if (overlapping.length == 2) {
        // Show both side by side
        widgets.add(
          _buildOverlappingGroup(context, overlapping, startAt, endAt),
        );
      } else {
        // Single session
        widgets.add(_buildSingleSession(context, session, startAt, endAt));
      }
    }

    return widgets;
  }

  Widget _buildSingleSession(
    final BuildContext context,
    final ConferenceSession session,
    final DateTime startAt,
    final DateTime endAt,
  ) {
    final topOffset = _calculateTopOffset(startAt);
    final height = _calculateHeight(startAt, endAt);

    return Positioned(
      top: topOffset,
      left: 8,
      right: 8,
      height: height,
      child: _SessionCard(
        session: session,
        onTap: () => context.goNamed(
          AppRoute.myScheduleDetails.name,
          pathParameters: {'id': session.id.value},
          extra: session,
        ),
      ),
    );
  }

  Widget _buildOverlappingGroup(
    final BuildContext context,
    final List<ConferenceSession> group,
    final DateTime startAt,
    final DateTime endAt, {
    final int moreCount = 0,
    final List<ConferenceSession>? allSessions,
  }) {
    final topOffset = _calculateTopOffset(startAt);
    final height = _calculateHeight(startAt, endAt);
    final hasMore = moreCount > 0;

    return Positioned(
      top: topOffset,
      left: 8,
      right: 8,
      height: height,
      child: Row(
        children: [
          ...group.asMap().entries.map(
            (final entry) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: entry.key < group.length - 1 || hasMore ? 4 : 0,
                ),
                child: _SessionCard(
                  session: entry.value,
                  isCompact: true,
                  onTap: () => context.goNamed(
                    AppRoute.myScheduleDetails.name,
                    pathParameters: {'id': entry.value.id.value},
                    extra: entry.value,
                  ),
                ),
              ),
            ),
          ),
          if (hasMore)
            SizedBox(
              width: 40,
              child: Material(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () =>
                      _showAllOverlappingSessions(context, allSessions!),
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                    child: Text(
                      '+$moreCount',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _calculateTopOffset(final DateTime startAt) {
    final minutesFromMidnight = startAt.hour * 60 + startAt.minute;
    return (minutesFromMidnight / 60.0) * hourHeight;
  }

  double _calculateHeight(final DateTime startAt, final DateTime endAt) {
    final durationMinutes = endAt.difference(startAt).inMinutes;
    return (durationMinutes / 60.0) * hourHeight;
  }

  Future<void> _showAllOverlappingSessions(
    final BuildContext context,
    final List<ConferenceSession> sessions,
  ) => showDialog<void>(
    context: context,
    builder: (final context) => _OverlappingSessionsDialog(sessions: sessions),
  );
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.hour});

  final int hour;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final hourStr = hour.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          '$hourStr:00',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.onTap,
    this.isCompact = false,
  });

  final ConferenceSession session;
  final VoidCallback onTap;
  final bool isCompact;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isCompact ? 8 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                session.title,
                style:
                    (isCompact
                            ? theme.textTheme.bodySmall
                            : theme.textTheme.bodyMedium)
                        ?.copyWith(fontWeight: FontWeight.w600),
                maxLines: isCompact ? 2 : 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (!isCompact) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.room,
                      size: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        session.room,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OverlappingSessionsDialog extends StatelessWidget {
  const _OverlappingSessionsDialog({required this.sessions});

  final List<ConferenceSession> sessions;

  String _formatTimeRange(final ConferenceSession session) {
    final start = session.startAt;
    final end = session.endAt;

    if (start == null || end == null) return '';

    final startStr =
        '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    final endStr =
        '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';

    return '$startStr - $endStr';
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overlapping Sessions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sessions.length,
                itemBuilder: (final context, final index) {
                  final session = sessions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(session.title),
                      subtitle: Text(
                        '${_formatTimeRange(session)} • ${session.room}',
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (final context) => UiConferenceDetailsScreen(
                            sessionId: session.id,
                            session: session,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

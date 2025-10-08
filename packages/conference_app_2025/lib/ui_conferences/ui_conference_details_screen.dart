import 'dart:async';

import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/data_api/data_api.dart';

/// {@template ui_conference_details_screen}
/// Screen displaying detailed information about a conference session.
///
/// Shows title, abstract, time, room, tags, and speaker details.
/// Provides button to add/remove from schedule.
/// {@endtemplate}
class UiConferenceDetailsScreen extends StatefulWidget {
  /// {@macro ui_conference_details_screen}
  const UiConferenceDetailsScreen({
    this.sessionId = ConferenceSessionId.empty,
    this.session = ConferenceSession.empty,
    super.key,
  });

  final ConferenceSessionId sessionId;
  final ConferenceSession session;

  @override
  State<UiConferenceDetailsScreen> createState() =>
      _UiConferenceDetailsScreenState();
}

class _UiConferenceDetailsScreenState extends State<UiConferenceDetailsScreen>
    with HasResources, HasCommands {
  ConferenceSession? _session;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_loadSession());
  }

  Future<void> _loadSession() async {
    if (widget.session.isEmpty) {
      if (mounted) setState(() => _session = widget.session);
      return;
    }

    if (mounted) setState(() => _isLoading = true);
    final sessionId = widget.sessionId;
    if (sessionId.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      if (mounted) setState(() => _error = 'Session ID is not provided');
      return;
    }

    // Get session from API
    final conferenceApi = Di.instance.get<ConferenceApiI>();
    final result = await conferenceApi.getConferenceById(sessionId);

    setState(() {
      _session = result.id.isEmpty ? null : result;
      _isLoading = false;
    });
  }

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

  void _toggleSchedule() {
    final session = _session;
    if (session == null) return;

    final isInSchedule = myConferencesResource.hasSession(session.id);

    if (isInSchedule) {
      removeConferenceFromScheduleCommand.execute(session.id);
    } else {
      addConferenceToScheduleCommand.execute(session);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return UiScaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return UiScaffold(
        appBar: AppBar(),
        body: Center(child: Text(_error!)),
      );
    }

    final session = _session;
    if (session == null) {
      return UiScaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Conference session not found')),
      );
    }

    final myConferences = context.watch<MyConferencesResource>();
    final isInSchedule = myConferences.hasSession(session.id);
    final timeRange = _formatTimeRange(session);

    return UiScaffold(
      appBar: AppBar(title: const Text('Conference Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title
          Text(
            session.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Time and room
          _InfoRow(icon: Icons.access_time, text: timeRange),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.room, text: session.room),
          const SizedBox(height: 16),

          // Tags
          if (session.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: session.tags
                  .map(
                    (final tag) => UiChip(label: tag.value, onSelected: null),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Abstract
          Text(
            'About',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(session.abstractText, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),

          // Speakers
          if (session.speakerIds.isNotEmpty) ...[
            Text(
              'Speakers',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...session.speakerIds.map(
              (final speakerId) => _SpeakerCard(speakerId: speakerId),
            ),
          ],

          const SizedBox(height: 80), // Space for FAB
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleSchedule,
        icon: Icon(isInSchedule ? Icons.bookmark_remove : Icons.bookmark_add),
        label: Text(isInSchedule ? 'Remove from Schedule' : 'Add to Schedule'),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(text, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  const _SpeakerCard({required this.speakerId});

  final SpeakerId speakerId;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final speakersResource = context.watch<SpeakersResource>();
    final speaker = speakersResource[speakerId];

    // If speaker not found, create placeholder
    final speakerName = speaker?.name ?? speakerId.value;
    final speakerBio = speaker?.bio ?? 'Speaker';
    final avatarUrl = speaker?.avatarUrl;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.primaryContainer,
              backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl == null || avatarUrl.isEmpty
                  ? Text(
                      speakerName.isNotEmpty
                          ? speakerName[0].toUpperCase()
                          : 'S',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    speakerName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    speakerBio,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

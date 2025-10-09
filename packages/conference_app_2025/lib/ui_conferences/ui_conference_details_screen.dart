import 'dart:async';

import 'package:conference_app_2025/common_imports.dart';

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
    with HasResources, HasApi {
  ConferenceSession? _session;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_loadSession());
  }

  Future<void> _loadSession() async {
    _error = null;
    if (widget.session.isNotEmpty) {
      if (mounted) {
        setState(() {
          _session = widget.session;
          _isLoading = false;
        });
      }
      return;
    }

    // Otherwise, fetch from API (e.g., for deep links)
    if (mounted) setState(() => _isLoading = true);
    final sessionId = widget.sessionId;
    if (sessionId.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      if (mounted) setState(() => _error = 'Session ID is not provided');
      return;
    }
    try {
      final result = await conferenceApi.getConferenceById(sessionId);

      setState(() => _session = result.id.isEmpty ? null : result);
    } on NetworkException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleSchedule() async {
    final session = _session;
    if (session == null) return;

    final isInSchedule = myConferencesResource.hasSession(session.id);

    if (isInSchedule) {
      const RemoveConferenceFromScheduleCommand().execute(session.id);
      // Cancel the notification
      await const CancelConferenceNotificationCommand().execute(session.id);
    } else {
      const AddConferenceToScheduleCommand().execute(session);
      // Schedule a notification 10 minutes before the conference
      await const ScheduleConferenceNotificationCommand().execute(session);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return UiScaffold(
        appBar: AppBar(),
        body: const Center(child: UiLoadingIndicator()),
      );
    }

    if (_error != null) {
      return UiScaffold(
        appBar: AppBar(),
        body: Center(
          child: UiErrorMessagesBanner(
            messages: [
              AppMessage(
                id: AppMessageId.create(),
                message: _error!,
                type: AppMessageType.error,
              ),
            ],
            onRetry: _loadSession,
            onDismiss: (final id) {},
          ),
        ),
      );
    }

    final session = _session;
    if (session == null) {
      return UiScaffold(
        appBar: AppBar(),
        body: const Center(child: UiText('Conference session not found')),
      );
    }

    final myConferences = context.watch<MyConferencesResource>();
    final isInSchedule = myConferences.hasSession(session.id);
    final dateTime = formatDateTimeRange(session.startAt, session.endAt);

    return UiScaffold(
      appBar: AppBar(title: const UiText('Conference Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title
          UiText(
            session.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Date, time and room
          _InfoRow(icon: Icons.calendar_today, text: dateTime.date),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.access_time, text: dateTime.time),
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
          UiText(
            'About',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          UiText(session.abstractText, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 24),

          // Speakers
          if (session.speakerIds.isNotEmpty) ...[
            UiText(
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
        label: UiText(
          isInSchedule ? 'Remove from Schedule' : 'Add to Schedule',
        ),
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
        UiText(text, style: theme.textTheme.bodyLarge),
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
                  ? UiText(
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
                  UiText(
                    speakerName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  UiText(
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

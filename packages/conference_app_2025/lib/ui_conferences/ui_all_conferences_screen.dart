import 'package:conference_app_2025/common_imports.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xsoulspace_ui_foundation/xsoulspace_ui_foundation.dart';

/// {@template ui_all_conferences_screen}
/// Screen displaying all available conference sessions.
///
/// Features:
/// - Search by title
/// - Filter by tags (multi-select)
/// - Paginated list
/// - Tap to navigate to details
/// {@endtemplate}
class UiAllConferencesScreen extends StatefulWidget {
  /// {@macro ui_all_conferences_screen}
  const UiAllConferencesScreen({super.key});

  @override
  State<UiAllConferencesScreen> createState() => _UiAllConferencesScreenState();
}

class _UiAllConferencesScreenState extends State<UiAllConferencesScreen>
    with HasApi {
  final _searchController = TextEditingController();
  final _selectedTags = <ConferenceTag>{};
  late final _pagingController = AllConferencesResource(
    requestBuilder:
        AllConferencesPagingControllerRequestsBuilder.filteredConferences(
          conferenceApi: conferenceApi,
          selectedTags: _selectedTags,
          searchQuery: _searchController.text.toLowerCase(),
        ),
  );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _pagingController.loadFirstPage();
  }

  void _onSearchChanged() => _pagingController.refresh();
  void _changeTags(final Set<ConferenceTag> tags) {
    setState(
      () => _selectedTags
        ..clear()
        ..addAll(tags),
    );
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final conferenceTagsResource = context.watch<ConferenceTagsResource>();
    final myConferences = context.watch<MyConferencesResource>();

    return UiScaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('All Conferences')),

          // Search bar
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: UiSearchBar(
              controller: _searchController,
              hintText: 'Search conferences...',
            ).toSliver(),
          ),

          // Filter chips
          if (conferenceTagsResource.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: UiMultichipsRow<ConferenceTag>(
                items: conferenceTagsResource.orderedValues,
                labelBuilder: (final tag) => tag.value,
                selectedItems: _selectedTags,
                selectionMode: UiMultichipsSelectionMode.multiple,
                onSelectionChanged: _changeTags,
              ).toSliver(),
            ),

          const SliverGap(8),

          // Conference list
          _ConferencesList(
            allConferencesResource: _pagingController,
            myConferencesResource: myConferences,
          ),
        ],
      ),
    );
  }
}

class _ConferencesList extends StatelessWidget {
  const _ConferencesList({
    required this.allConferencesResource,
    required this.myConferencesResource,
  });

  final AllConferencesResource allConferencesResource;
  final MyConferencesResource myConferencesResource;

  @override
  Widget build(final BuildContext context) => PagingListener(
    controller: allConferencesResource.pager,
    builder: (final context, final state, final fetchNextPage) =>
        PagedSliverList(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate<ConferenceSession>(
            noItemsFoundIndicatorBuilder: (final context) =>
                const Center(child: Text('No conferences match your filters')),
            itemBuilder: (final context, final item, final index) =>
                _ConferenceListItem(
                  session: item,
                  key: ValueKey(item.id),
                  isInSchedule: myConferencesResource.containsKey(item.id),
                  onTap: () => context.goNamed(
                    AppRoute.conferenceDetails.name,
                    extra: item,
                    pathParameters: {'id': item.id.value},
                  ),
                ),

            newPageErrorIndicatorBuilder: (final context) =>
                _ErrorMessagesBanner(
                  messages: [
                    AppMessage(
                      id: AppMessageId.create(),
                      message: 'Failed to load conferences',
                      type: AppMessageType.error,
                      feature: AppMessageFeatureTarget.loadConferences,
                    ),
                  ],
                  onRetry: allConferencesResource.pager.fetchNextPage,
                  onDismiss: (final id) {},
                ),
          ),
        ),
  );
}

class _ErrorMessagesBanner extends StatelessWidget {
  const _ErrorMessagesBanner({
    required this.messages,
    required this.onRetry,
    required this.onDismiss,
    this.showDismissButton = false,
  });

  final List<AppMessage> messages;
  final VoidCallback onRetry;
  final bool showDismissButton;
  final void Function(AppMessageId messageId) onDismiss;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final errorMessages = messages
        .where((final m) => m.type == AppMessageType.error)
        .toList();

    if (errorMessages.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  errorMessages.first.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
              if (showDismissButton)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  onPressed: () => onDismiss(errorMessages.first.id),
                  tooltip: 'Dismiss',
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Dismiss message and retry
                onDismiss(errorMessages.first.id);
                onRetry();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConferenceListItem extends StatelessWidget {
  const _ConferenceListItem({
    required this.session,
    required this.isInSchedule,
    required this.onTap,
    required super.key,
  });

  final ConferenceSession session;
  final bool isInSchedule;
  final VoidCallback onTap;

  String _formatTimeRange() {
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
    final timeRange = _formatTimeRange();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      session.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isInSchedule)
                    Icon(
                      Icons.bookmark,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeRange,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.room,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session.room,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              if (session.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: session.tags
                      .map(
                        (final tag) =>
                            UiChip(label: tag.value, onSelected: null),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

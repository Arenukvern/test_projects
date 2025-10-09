import 'package:conference_app_2025/common_imports.dart';
import 'package:xsoulspace_ui_foundation/xsoulspace_ui_foundation.dart';

/// Since we don't use this class in UI,
/// we don't need to use observer pattern
class MutableConferenceControllersResource
    extends
        MutableOrderedMap<UnifiedPagingControllerId, AllConferencesResource> {
  MutableConferenceControllersResource() : super(toKey: (final src) => src.id);

  AllConferencesResource createController({
    required final AllConferencesPagingControllerRequestsBuilder requestBuilder,
  }) {
    final controller = AllConferencesResource(requestBuilder: requestBuilder);
    upsert(controller);
    return controller;
  }

  void disposeController(final UnifiedPagingControllerId id) {
    final controller = this[id];
    controller?.dispose();
    remove(id);
  }

  void updateItem(final ConferenceSession item) {
    for (final controller in values) {
      controller.replaceItem(item);
    }
  }

  void dispose() {
    for (final controller in values) {
      controller.dispose();
    }
  }
}

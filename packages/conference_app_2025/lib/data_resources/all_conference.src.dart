import 'package:conference_app_2025/data_api/data_api.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:xsoulspace_ui_foundation/xsoulspace_ui_foundation.dart';

final class AllConferencesResource
    extends BasePagingController<ConferenceSession> {
  AllConferencesResource({required this.requestBuilder}) : super();
  @override
  final AllConferencesPagingControllerRequestsBuilder requestBuilder;
}

class AllConferencesPagingControllerRequestsBuilder
    extends PagingControllerRequestsBuilder<ConferenceSession> {
  AllConferencesPagingControllerRequestsBuilder({required super.onLoadData});

  factory AllConferencesPagingControllerRequestsBuilder.allConferences({
    required final ConferenceApiI conferenceApi,
  }) => AllConferencesPagingControllerRequestsBuilder(
    onLoadData: conferenceApi.getPaginatedConferences,
  );
}

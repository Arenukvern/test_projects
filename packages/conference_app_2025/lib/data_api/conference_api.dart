import 'package:conference_app_2025/data_mocks/data_mocks.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:xsoulspace_ui_foundation/xsoulspace_ui_foundation.dart';

abstract interface class ConferenceApiI {
  Future<PagingControllerPageModel<ConferenceSession>> getPaginatedConferences(
    final int page,
  );
  Future<List<ConferenceSession>> getMyConferences();
}

class ConferenceApiMockImpl implements ConferenceApiI {
  ConferenceApiMockImpl();

  @override
  Future<PagingControllerPageModel<ConferenceSession>> getPaginatedConferences(
    final int page,
  ) async {
    final data = mockConferencesPaginatedJson[page];
    return PagingControllerPageModel(
      values: jsonDecodeListAs(data).map(ConferenceSession.fromJson).toList(),
      currentPage: page,
      pagesCount: mockConferencesPaginatedJson.length,
    );
  }

  @override
  Future<List<ConferenceSession>> getMyConferences() async => [];
}

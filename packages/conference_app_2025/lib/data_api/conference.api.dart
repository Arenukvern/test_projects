import 'package:conference_app_2025/data_mocks/data_mocks.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:xsoulspace_ui_foundation/xsoulspace_ui_foundation.dart';

abstract interface class ConferenceApiI {
  Future<PagingControllerPageModel<ConferenceSession>> getPaginatedConferences({
    required final int page,
    required final Set<ConferenceTag> selectedTags,
    required final String searchQuery,
  });
  Future<List<ConferenceSession>> getMyConferences();
  Future<ConferenceSession> getConferenceById(
    final ConferenceSessionId sessionId,
  );
}

class ConferenceApiMockImpl implements ConferenceApiI {
  ConferenceApiMockImpl();

  @override
  Future<PagingControllerPageModel<ConferenceSession>> getPaginatedConferences({
    required final int page,
    required final Set<ConferenceTag> selectedTags,
    required final String searchQuery,
  }) async {
    const dataPerPage = 10;
    Iterable<ConferenceSession> iterable =
        jsonDecodeListAs<Map<String, dynamic>>(
          mockConferencesPaginatedJson,

          /// in production, we should use map(ConferenceSession.fromJson)
          /// instead of cast<ConferenceSession>()
        ).cast<ConferenceSession>();
    if (searchQuery.isNotEmpty || selectedTags.isNotEmpty) {
      iterable = iterable.where(
        (final session) =>
            session.tags.any(selectedTags.contains) &&
            session.title.toLowerCase().contains(searchQuery.toLowerCase()),
      );
    }
    final result = iterable
        .skip((page - 1) * dataPerPage)
        .take(dataPerPage)
        .toList();

    final pagesCount = (iterable.length / dataPerPage).ceil();
    return PagingControllerPageModel(
      values: result,
      currentPage: page,
      pagesCount: pagesCount,
    );
  }

  @override
  Future<List<ConferenceSession>> getMyConferences() async => [];

  @override
  Future<ConferenceSession> getConferenceById(
    final ConferenceSessionId sessionId,
  ) async => jsonDecodeListAs(mockConferencesPaginatedJson)
      .map(ConferenceSession.fromJson)
      .firstWhere(
        (final session) => session.id == sessionId,
        orElse: () => ConferenceSession.empty,
      );
}

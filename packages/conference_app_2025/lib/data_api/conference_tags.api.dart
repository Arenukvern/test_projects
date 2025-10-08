import 'package:conference_app_2025/data_mocks/data_mocks.dart';
import 'package:conference_app_2025/data_models/data_models.dart';

abstract interface class ConferenceTagsApiI {
  Future<List<ConferenceTag>> getConferenceTags();
}

class ConferenceTagsApiMockImpl implements ConferenceTagsApiI {
  @override
  Future<List<ConferenceTag>> getConferenceTags() async =>
      mockConferenceTagsJson.map(ConferenceTag.fromJson).toList();
}

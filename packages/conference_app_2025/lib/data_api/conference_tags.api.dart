import 'package:conference_app_2025/data_mocks/data_mocks.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/di/di.dart';

abstract interface class ConferenceTagsApiI {
  Future<List<ConferenceTag>> getConferenceTags();
}

class ConferenceTagsApiMockImpl
    with HasUtilities
    implements ConferenceTagsApiI {
  @override
  Future<List<ConferenceTag>> getConferenceTags() => networkSimulator.simulate(
    () async => mockConferenceTagsJson.map(ConferenceTag.fromJson).toList(),
    message: 'Failed to load conference tags',
  );
}

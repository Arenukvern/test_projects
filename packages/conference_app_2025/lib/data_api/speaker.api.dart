import 'package:conference_app_2025/data_mocks/data_mocks.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:from_json_to_json/from_json_to_json.dart';

abstract interface class SpeakerApiI {
  Future<List<Speaker>> getSpeakers();
}

class SpeakerApiMockImpl implements SpeakerApiI {
  @override
  Future<List<Speaker>> getSpeakers() async =>
      jsonDecodeListAs(mockSpeakersJson).map(Speaker.fromJson).toList();
}

// ignore_for_file: avoid_annotating_with_dynamic

import 'package:conference_app_2025/data_listeners/streaming_client_api.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/di/di.dart';

class ConferenceUpdatesListener extends ClientApiListener with HasResources {
  @override
  void onServerData(final dynamic data) {
    // doesn't work, just to demonstate the idea, how
    // items would be updated in the UI if we had a streaming API
    final conference = ConferenceSession.fromJson(data);
    conferenceControllersResource.updateItem(conference);
  }
}

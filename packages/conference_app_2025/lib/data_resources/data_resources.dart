import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:xsoulspace_state_utils/xsoulspace_state_utils.dart';

export 'all_conference.src.dart';
export 'app_messages.src.dart';
export 'app_status.src.dart';
export 'my_conferences.src.dart';
export 'network_simulation_settings.src.dart';
export 'text_scale.src.dart';
export 'theme_brightness.src.dart';

class ConferenceTagsResource
    extends OrderedMapNotifier<ConferenceTag, ConferenceTag> {
  ConferenceTagsResource() : super(toKey: (final tag) => tag);
}

class SpeakersResource extends OrderedMapNotifier<SpeakerId, Speaker> {
  SpeakersResource() : super(toKey: (final speaker) => speaker.id);
}

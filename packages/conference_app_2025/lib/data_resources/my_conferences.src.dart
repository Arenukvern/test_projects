import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:xsoulspace_state_utils/xsoulspace_state_utils.dart';

class MyConferencesResource
    extends OrderedMapNotifier<ConferenceSessionId, ConferenceSession> {
  MyConferencesResource() : super(toKey: (final session) => session.id);
}

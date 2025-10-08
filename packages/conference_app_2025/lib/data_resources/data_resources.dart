import 'package:conference_app_2025/common_imports.dart';

class MyConferencesResource
    extends OrderedMapNotifier<ConferenceSessionId, ConferenceSession> {
  MyConferencesResource() : super(toKey: (final session) => session.id);
}

class ConferenceTagsResource
    extends OrderedMapNotifier<ConferenceTag, ConferenceTag> {
  ConferenceTagsResource() : super(toKey: (final tag) => tag);
}

class SpeakersResource extends OrderedMapNotifier<SpeakerId, Speaker> {
  SpeakersResource() : super(toKey: (final speaker) => speaker.id);
}

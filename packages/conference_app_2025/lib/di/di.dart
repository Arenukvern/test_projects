// ignore_for_file: avoid_annotating_with_dynamic

import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/data_api/data_api.dart';
import 'package:conference_app_2025/data_listeners/streaming_client_api.dart';
import 'package:get_it/get_it.dart';

T _g<T extends Object>({
  final dynamic param1,
  final dynamic param2,
  final String? instanceName,
  final Type? type,
}) => Di._implementation.get<T>(
  param1: param1,
  param2: param2,
  instanceName: instanceName,
  type: type,
);

void _disposabler(final ChangeNotifier d) => d.dispose();

class Di {
  Di._();
  static Di get instance => _implementation;
  static final Di _implementation = Di._();
  late final _rl = GetIt.instance.registerLazySingleton;

  /// Get a registered dependency
  T get<T extends Object>({
    final dynamic param1,
    final dynamic param2,
    final String? instanceName,
    final Type? type,
  }) => GetIt.instance.get<T>(
    param1: param1,
    param2: param2,
    instanceName: instanceName,
    type: type,
  );

  void register() {
    _rl<StreamingClientApi>(
      StreamingClientApiMock.new,
      dispose: (final d) => d.dispose(),
    );
    _rl<ConferenceApiI>(ConferenceApiMockImpl.new);
    _rl<ConferenceTagsApiI>(ConferenceTagsApiMockImpl.new);
    _rl<SpeakerApiI>(SpeakerApiMockImpl.new);
    _rl(MyConferencesResource.new, dispose: _disposabler);
    _rl(ConferenceTagsResource.new, dispose: _disposabler);
    _rl(SpeakersResource.new, dispose: _disposabler);
    _rl(TextScaleResource.new, dispose: _disposabler);
    _rl(ThemeBrightnessResource.new, dispose: _disposabler);
  }

  Future<void> dispose() => GetIt.instance.reset();
}

mixin HasResources {
  MyConferencesResource get myConferencesResource => _g();
  ConferenceTagsResource get conferenceTagsResource => _g();
  SpeakersResource get speakersResource => _g();
  TextScaleResource get textScaleResource => _g();
  ThemeBrightnessResource get themeBrightnessResource => _g();
}

mixin HasApi {
  StreamingClientApi get clientApi => _g<StreamingClientApi>();
  ConferenceApiI get conferenceApi => _g<ConferenceApiI>();
  ConferenceTagsApiI get conferenceTagsApi => _g<ConferenceTagsApiI>();
  SpeakerApiI get speakerApi => _g<SpeakerApiI>();
}

// ignore_for_file: avoid_annotating_with_dynamic

import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/data_listeners/client_api.dart';
import 'package:get_it/get_it.dart';

T _g<T extends Object>({
  final dynamic param1,
  final dynamic param2,
  final String? instanceName,
  final Type? type,
}) => Di._implementation._g<T>(
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
  late final _g = GetIt.instance.get;

  void register() {
    _rl<ClientApi>(ClientApiMock.new, dispose: (final d) => d.dispose());
  }

  Future<void> dispose() => GetIt.instance.reset();
}

mixin ResourcesMixin {}
mixin ApiMixin {
  ClientApi get clientApi => _g<ClientApi>();
}

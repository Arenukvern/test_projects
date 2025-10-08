// ignore_for_file: avoid_annotating_with_dynamic

import 'package:carflutter_2025sep/data_listeners/client_api.dart';
import 'package:carflutter_2025sep/data_resources/data_resources.dart';
import 'package:flutter/widgets.dart';
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
    _rl(GameStatusResources.new, dispose: _disposabler);
    _rl(VehiclesResource.new, dispose: _disposabler);
    _rl(CurrentVehicleIdResource.new, dispose: _disposabler);
    _rl<ClientApi>(ClientApiMock.new, dispose: (final d) => d.dispose());
  }

  Future<void> dispose() => GetIt.instance.reset();
}

mixin ResourcesMixin {
  VehiclesResource get vehiclesResource => _g<VehiclesResource>();
  GameStatusResources get gameStatusResource => _g<GameStatusResources>();
  CurrentVehicleIdResource get currentVehicleIdResource =>
      _g<CurrentVehicleIdResource>();
}
mixin ApiMixin {
  ClientApi get clientApi => _g<ClientApi>();
}

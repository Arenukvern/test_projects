// ignore_for_file: avoid_annotating_with_dynamic

import 'package:carflutter_2025sep/data_resources/game_status.src.dart';
import 'package:carflutter_2025sep/data_resources/vehicles.src.dart';
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

void _r<T extends Object>(
  final T instance, {
  final String? instanceName,
  final bool? signalsReady,
  final DisposingFunc<T>? dispose,
}) => Di._implementation._r<T>(
  instance,
  instanceName: instanceName,
  signalsReady: signalsReady,
  dispose: dispose,
);

void _rl<T extends Object>(
  final FactoryFunc<T> factoryFunc, {
  final String? instanceName,
  final DisposingFunc<T>? dispose,
  final bool useWeakReference = false,
}) => Di._implementation._rl<T>(
  factoryFunc,
  instanceName: instanceName,
  dispose: dispose,
  useWeakReference: useWeakReference,
);

class Di {
  factory Di() => _implementation;
  Di._();
  static final Di _implementation = Di._();
  final _getIt = GetIt.instance;
  late final _r = _getIt.registerSingleton;
  late final _rl = _getIt.registerLazySingleton;
  late final _g = _getIt.get;

  void register() {
    _rl(GameStatusResources.new);
    _rl(VehiclesResource.new);
  }
}

mixin ResourcesMixin {
  VehiclesResource get vehiclesResource => _g<VehiclesResource>();
  GameStatusResources get gameStatusResource => _g<GameStatusResources>();
}

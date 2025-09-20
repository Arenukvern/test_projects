import 'package:carflutter_2025sep/common_imports.dart';

Vehicle useCurrentVehicle(final BuildContext context) {
  final currentVehicleId = context.watch<CurrentVehicleIdResource>();
  final currentVehicle = context.select<VehiclesResource, Vehicle>(
    (final vehicles) => vehicles[currentVehicleId.value] ?? Vehicle.empty,
  );
  return currentVehicle;
}

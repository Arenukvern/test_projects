import 'package:carflutter_2025sep/common_imports.dart';
import 'package:carflutter_2025sep/data_listeners/data_listeners.dart';
import 'package:from_json_to_json/from_json_to_json.dart';

class VehicleListener with ResourcesMixin implements ClientApiListener {
  @override
  void onServerData(final ServerToClientAction actionId, [final String? data]) {
    switch (actionId) {
      case ServerToClientAction.carList:
        final jsonList = jsonDecodeListAs<Map<String, dynamic>>(data);
        final vehicles = jsonList.map(Vehicle.fromJson).toList();
        vehiclesResource.assignAllOrdered(vehicles);
        if (currentVehicleIdResource.value.isEmpty && vehicles.isNotEmpty) {
          currentVehicleIdResource.value = vehicles.first.id;
        }
      case ServerToClientAction.carStatusUpdate:
        final jsonMap = jsonDecodeMapAs<String, dynamic>(data);
        final statusUpdate = VehicleStatusUpdate.fromJson(jsonMap);
        // will throw if the vehicle is not found
        vehiclesResource.update(
          statusUpdate.id,
          (final vehicle) => vehicle.copyWith(status: statusUpdate.status),
        );
      case ServerToClientAction.carRemoval:
        final vehicles = vehiclesResource.orderedValues;
        if (vehicles.isEmpty) {
          return;
        }
        final vehicleId = VehicleId.fromJson(data);
        final chosenIndex = vehicles.indexWhere((final v) => v.id == vehicleId);
        final currentVehicleId = currentVehicleIdResource.value;
        if (currentVehicleId != vehicleId) {
          vehiclesResource.remove(vehicleId);
          return;
        }
        if (vehicles.length == 1) {
          // the user should be redirected to the initial screen
          currentVehicleIdResource.value = VehicleId.empty;
          return;
        }

        final vehicle = (chosenIndex == vehicles.length - 1
            ? vehicles[chosenIndex > 0 ? chosenIndex - 1 : 0]
            : vehicles[chosenIndex + 1]);

        final nextVehicle = vehicle ?? vehicles.last;
        currentVehicleIdResource.value = nextVehicle.id;
        vehiclesResource.remove(vehicleId);

      case ServerToClientAction.familyMembershipStatus:
      // noop
    }
  }
}

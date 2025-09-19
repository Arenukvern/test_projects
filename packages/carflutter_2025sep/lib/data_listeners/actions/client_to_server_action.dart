import 'package:collection/collection.dart';

/// Enum representing outgoing client actions (client → server).
///
/// These actions are sent from the client to the server to request
/// specific operations or information. Each action corresponds to
/// a user interaction or system request.
enum ClientToServerAction {
  /// Request to show PTS (vehicle registration) for selected car.
  ///
  /// Sends car ID to display vehicle registration documents.
  showVehiclePts(0),

  /// Request to load/unload vehicle.
  ///
  /// Sends car ID to toggle vehicle loading status.
  loadUnloadVehicle(1),

  /// Request to show vehicle location.
  ///
  /// Sends car ID to display vehicle's current location.
  showVehicleLocation(2),

  /// Request to sell vehicle to government.
  ///
  /// Sends car ID to initiate government sale process.
  sellVehicleToGovernment(3),

  /// Request to add vehicle to family.
  ///
  /// Sends car ID to add vehicle to player's family.
  addVehicleToFamily(4),

  /// Request to park vehicle.
  ///
  /// Sends car ID to park the vehicle.
  parkVehicle(5);

  /// Creates a [ClientToServerAction] with the given action ID.
  const ClientToServerAction(this.actionId);

  /// The numeric action ID used in server communication.
  final int actionId;

  /// Gets a [ClientToServerAction] by its action ID.
  ///
  /// Returns null if no action with the given ID exists.
  static ClientToServerAction? fromActionId(final int actionId) =>
      ClientToServerAction.values.firstWhereOrNull(
        (final element) => element.actionId == actionId,
      );
}

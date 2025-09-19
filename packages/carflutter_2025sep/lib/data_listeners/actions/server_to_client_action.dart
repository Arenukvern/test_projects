/// Enum representing incoming server actions (server → client).
///
/// These actions are received from the server and processed by the client.
/// Each action corresponds to a specific type of data or notification
/// sent by the server to update the client's state.
enum ServerToClientAction {
  /// List of cars with complete car information.
  ///
  /// Contains array of car objects with id, imageName, number, region,
  /// country, model, mileage, fuel, status, price, and leftTime.
  carList(0),

  /// Family membership status indicator.
  ///
  /// Contains "true" or "false" string indicating whether the player
  /// is in a family. Affects visibility of "add to family" button.
  familyMembershipStatus(1),

  /// Car status update notification.
  ///
  /// Contains car ID and new status (0 = unloaded, 1 = loaded).
  /// Used to update the status of a specific car in the list.
  carStatusUpdate(2),

  /// Car removal notification.
  ///
  /// Contains car ID as string to remove from the car list.
  /// If the removed car is currently displayed, switch to another car.
  carRemoval(3);

  /// Creates a [ServerToClientAction] with the given action ID.
  const ServerToClientAction(this.actionId);

  /// The numeric action ID used in server communication.
  final int actionId;
}

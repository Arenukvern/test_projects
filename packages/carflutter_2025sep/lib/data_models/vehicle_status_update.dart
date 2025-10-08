// ignore_for_file: avoid_annotating_with_dynamic

import 'package:carflutter_2025sep/data_models/data_models.dart';
import 'package:from_json_to_json/from_json_to_json.dart';

extension type const VehicleStatusUpdate._(Map<String, dynamic> value) {
  /// Creates a [VehicleStatusUpdate] with required fields.
  factory VehicleStatusUpdate({
    required final VehicleId id,
    required final VehicleStatus status,
  }) => VehicleStatusUpdate._({'id': id, 'status': status.index});

  /// Creates a [VehicleStatusUpdate] from JSON data.
  ///
  /// Safely converts JSON input to a status update model.
  factory VehicleStatusUpdate.fromJson(final dynamic json) {
    final map = jsonDecodeMap(json);
    return VehicleStatusUpdate._(map);
  }

  /// Converts this [VehicleStatusUpdate] to JSON.
  Map<String, dynamic> toJson() => value;

  /// ID of the car whose status was updated.
  VehicleId get id => VehicleId.fromJson(value['id']);

  /// New status of the car (0 = unloaded, 1 = loaded).
  VehicleStatus get status => VehicleStatus.fromJson(value['status']);

  /// Empty [VehicleStatusUpdate] for initialization.
  static const empty = VehicleStatusUpdate._({});
}

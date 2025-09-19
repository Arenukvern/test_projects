// ignore_for_file: avoid_annotating_with_dynamic

import 'package:from_json_to_json/from_json_to_json.dart';

extension type const VehicleId(String value) {
  /// Creates a [VehicleId] from JSON data.
  ///
  /// Safely converts JSON input to an integer value.
  factory VehicleId.fromJson(final dynamic json) =>
      VehicleId(jsonDecodeString(json));

  static const empty = VehicleId('');
}

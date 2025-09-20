// ignore_for_file: avoid_annotating_with_dynamic

import 'package:carflutter_2025sep/data_models/data_models.dart';
import 'package:from_json_to_json/from_json_to_json.dart';

enum VehicleStatus {
  // 0 Unloaded
  unloaded,
  // 1 Loaded
  loaded;

  factory VehicleStatus.fromJson(final dynamic json) {
    try {
      return VehicleStatus.values[jsonDecodeInt(json)];
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return VehicleStatus.unloaded;
    }
  }
}

/// Extension type that represents a complete car data model.
///
/// Contains all information about a car including identification,
/// appearance, location, status, and pricing details.
extension type const Vehicle._(Map<String, dynamic> value) {
  /// Creates a [Vehicle] with all required fields.
  factory Vehicle({
    final VehicleId id = VehicleId.empty,
    final String imageName = '',
    final String number = '',
    final String region = '',
    final String country = '',
    final String model = '',
    final int mileage = 0,
    final int fuel = 0,
    final VehicleStatus status = VehicleStatus.unloaded,
    final int price = 0,
    final int leftTime = 0,
  }) => Vehicle._({
    'id': id,
    'imageName': imageName,
    'number': number,
    'region': region,
    'country': country,
    'model': model,
    'mileage': mileage,
    'fuel': fuel,
    'status': status,
    'price': price,
    'leftTime': leftTime,
  });

  /// Creates a [Vehicle] from JSON data.
  ///
  /// Safely converts JSON input to a car model with all fields.
  factory Vehicle.fromJson(final dynamic json) {
    final map = jsonDecodeMap(json);
    return Vehicle._(map);
  }

  /// Converts this [Vehicle] to JSON.
  Map<String, dynamic> toJson() => value;

  /// Unique identifier for this car.
  VehicleId get id => VehicleId.fromJson(value['id']);

  /// Name of the car's render image.
  String get imageName => jsonDecodeString(value['imageName']);

  /// Main part of the license plate number.
  String get number => jsonDecodeString(value['number']);

  /// Region of the license plate.
  String get region => jsonDecodeString(value['region']);

  /// Country code (RU, UA, BY, KZ, BR).
  String get country => jsonDecodeString(value['country']);

  /// Car model name.
  String get model => jsonDecodeString(value['model']);

  /// Mileage in kilometers.
  int get mileage => jsonDecodeInt(value['mileage']);

  /// Fuel amount in liters.
  int get fuel => jsonDecodeInt(value['fuel']);

  VehicleStatus get status => VehicleStatus.fromJson(value['status']);

  /// Car price.
  int get price => jsonDecodeInt(value['price']);

  /// Remaining time in hours for temporary cars.
  ///
  /// -1 means no timer should be displayed.
  /// If less than 1 hour remains, still send "1".
  int get leftTime => jsonDecodeInt(value['leftTime']);

  /// Whether this car has a complete license plate.
  ///
  /// Returns false if any of [number], [region], or [country] is empty.
  bool get hasCompleteLicensePlate =>
      number.isNotEmpty && region.isNotEmpty && country.isNotEmpty;

  /// Whether this car should show a timer.
  ///
  /// Returns true if [leftTime] is not -1.
  bool get shouldShowTimer => leftTime != -1;

  /// Whether this car is temporary (has timer).
  bool get isTemporary => shouldShowTimer;

  /// Whether this car is permanent (no timer).
  bool get isPermanent => !shouldShowTimer;

  /// Empty [Vehicle] for initialization.
  static const empty = Vehicle._({});

  Vehicle copyWith({
    final VehicleId? id,
    final String? imageName,
    final String? number,
    final String? region,
    final String? country,
    final String? model,
    final int? mileage,
    final int? fuel,
    final VehicleStatus? status,
    final int? price,
    final int? leftTime,
  }) => Vehicle(
    id: id ?? this.id,
    imageName: imageName ?? this.imageName,
    number: number ?? this.number,
    region: region ?? this.region,
    country: country ?? this.country,
    model: model ?? this.model,
    mileage: mileage ?? this.mileage,
    fuel: fuel ?? this.fuel,
    status: status ?? this.status,
    price: price ?? this.price,
    leftTime: leftTime ?? this.leftTime,
  );
}

import 'package:carflutter_2025sep/data_models/data_models.dart';
import 'package:xsoulspace_state_utils/xsoulspace_state_utils.dart';

class VehiclesResource extends OrderedMapNotifier<VehicleId, Vehicle> {
  VehiclesResource() : super(toKey: (final vehicle) => vehicle.id);
}

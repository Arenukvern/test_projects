import 'package:flutter/foundation.dart';

/// {@template network_simulation_settings_resource}
/// Resource that controls whether network simulation is enabled.
///
/// When enabled, mock APIs will:
/// - Add random delays (500-1000ms)
/// - Randomly fail with 10% probability
///
/// This is useful for testing loading states, error handling,
/// and user experience under poor network conditions.
///
/// Example usage:
/// ```dart
/// final settings = context.read<NetworkSimulationSettingsResource>();
/// settings.value = false; // Disable simulation
/// ```
/// {@endtemplate}
class NetworkSimulationSettingsResource extends ValueNotifier<bool> {
  /// {@macro network_simulation_settings_resource}
  ///
  /// [enabled] - Initial state, defaults to true for development
  NetworkSimulationSettingsResource({final bool enabled = true})
    : super(enabled);
}

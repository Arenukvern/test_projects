import 'dart:math';

import 'package:conference_app_2025/core/network_exception.dart';
import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/app_messages.src.dart';
import 'package:conference_app_2025/data_resources/network_simulation_settings.src.dart';

/// {@template network_simulator}
/// Utility class for simulating network conditions in mock APIs.
///
/// Provides realistic network behavior for development and testing:
/// - Random delays between 500-1000ms
/// - 10% failure rate throwing [NetworkException]
///
/// Simulation can be toggled via [NetworkSimulationSettingsResource].
///
/// Example usage:
/// ```dart
/// class ConferenceApiMockImpl implements ConferenceApiI {
///   const ConferenceApiMockImpl(this.networkSimulator);
///
///   final NetworkSimulator networkSimulator;
///
///   @override
///   Future<List<Conference>> getConferences() =>
///       networkSimulator.simulate(() async {
///         // Actual data fetching logic
///         return mockConferences;
///       });
/// }
/// ```
/// {@endtemplate}
class NetworkSimulator {
  /// {@macro network_simulator}
  const NetworkSimulator({
    required this.settingsResource,
    required this.appMessagesResource,
  });

  final NetworkSimulationSettingsResource settingsResource;
  final AppMessagesResource appMessagesResource;
  static final _random = Random();

  /// Simulates network conditions for the given operation.
  ///
  /// If simulation is enabled:
  /// - Adds random delay between 500-1000ms
  /// - Throws [NetworkException] with 10% probability
  ///
  /// Returns the result of [operation] if successful.
  Future<T> simulate<T>(
    final Future<T> Function() operation, {
    required final String message,
    final AppMessageFeatureTarget? feature,
  }) async {
    if (settingsResource.value) {
      // Simulate network delay
      final delayMs = 500 + _random.nextInt(500);
      await Future.delayed(Duration(milliseconds: delayMs));

      // Simulate network error with 10% probability
      if (_random.nextInt(100) < 10) {
        appMessagesResource.upsert(
          AppMessage(
            id: AppMessageId.create(),
            message: message,
            type: AppMessageType.error,
            feature: feature,
          ),
        );
        throw const NetworkException('Network request failed');
      }
    }

    return operation();
  }
}

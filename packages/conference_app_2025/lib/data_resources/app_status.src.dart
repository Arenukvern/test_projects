import 'package:flutter/foundation.dart';

/// {@template app_status}
/// Enum representing the application's current status during initialization
/// and runtime.
///
/// Used to track whether the app is loading critical resources, ready
/// for user interaction, or in an error state.
/// {@endtemplate}
enum AppStatus {
  /// Initial loading of critical resources
  loading,

  /// App is ready for user interaction
  ready,

  /// An error occurred during loading
  error,
}

/// {@template app_status_resource}
/// Resource that manages the application's loading and initialization state.
///
/// This resource tracks whether the app is still loading critical data,
/// ready for use, or encountered an error. It's used primarily during
/// the initial app loading sequence.
///
/// Example usage:
/// ```dart
/// final appStatus = context.watch<AppStatusResource>();
/// if (appStatus.value == AppStatus.loading) {
///   return LoadingIndicator();
/// }
/// ```
/// {@endtemplate}
class AppStatusResource extends ValueNotifier<AppStatus> {
  /// {@macro app_status_resource}
  AppStatusResource() : super(AppStatus.loading);
}

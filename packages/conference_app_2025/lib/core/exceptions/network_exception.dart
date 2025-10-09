/// {@template network_exception}
/// Exception thrown when a network operation fails during mock API simulation.
///
/// This exception is used to simulate network failures in development
/// and testing environments. It provides a consistent error type that
/// can be caught and handled by commands and UI layers.
///
/// Example usage:
/// ```dart
/// try {
///   await conferenceApi.getConferences();
/// } on NetworkException catch (e) {
///   // Handle network error
///   print('Network failed: ${e.message}');
/// }
/// ```
/// {@endtemplate}
class NetworkException implements Exception {
  /// {@macro network_exception}
  const NetworkException(this.message, {this.stackTrace});

  /// Human-readable error message
  final String message;

  /// Optional stack trace for debugging
  final StackTrace? stackTrace;

  @override
  String toString() => 'NetworkException: $message';
}

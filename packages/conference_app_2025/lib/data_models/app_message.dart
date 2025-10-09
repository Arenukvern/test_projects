// ignore_for_file: avoid_annotating_with_dynamic

import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:xsoulspace_foundation/xsoulspace_foundation.dart';

/// {@template app_message_type}
/// Type of message to display to the user.
/// {@endtemplate}
enum AppMessageType {
  /// Informational message
  info,

  /// Warning message
  warning,

  /// Error message
  error,
}

enum AppMessageFeatureTarget { loadConferences }

/// {@template app_message}
/// Represents a user-facing message with metadata.
///
/// Used to display errors, warnings, and info messages across the app.
/// Messages are stored in [AppMessagesResource] and can be displayed
/// in UI components.
///
/// Example usage:
/// ```dart
/// final message = AppMessage(
///   id: AppMessageId('network_error'),
///   message: 'Failed to load data',
///   type: AppMessageType.error,
/// );
/// ```
/// {@endtemplate}
extension type const AppMessage._(Map<String, dynamic> _json) {
  /// {@macro app_message}
  factory AppMessage({
    final AppMessageId id = AppMessageId.empty,
    final String message = '',
    final AppMessageType type = AppMessageType.info,
    final DateTime? timestamp,
    final AppMessageFeatureTarget? feature,
  }) => AppMessage._({
    'id': id,
    'message': message,
    'type': type.name,
    'timestamp': (timestamp ?? DateTime.now()).toIso8601String(),
    'feature': feature?.name,
  });

  /// Message feature target
  AppMessageFeatureTarget? get feature {
    try {
      final feature = jsonDecodeString(_json['feature']);
      if (feature.isEmpty) return null;
      return AppMessageFeatureTarget.values.byName(feature);
    } catch (e) {
      return null;
    }
  }

  /// Message unique identifier
  AppMessageId get id => AppMessageId.fromJson(_json['id']);

  /// Message content
  String get message => jsonDecodeString(_json['message']);

  /// Message type
  AppMessageType get type {
    final type = jsonDecodeString(_json['type']);
    return AppMessageType.values.firstWhere(
      (final t) => t.name == type,
      orElse: () => AppMessageType.info,
    );
  }

  /// When the message was created
  DateTime? get timestamp => dateTimeFromIso8601String(_json['timestamp']);
  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  /// Empty message placeholder
  static final AppMessage empty = AppMessage();
}

/// {@template app_message_id}
/// Unique identifier for an app message.
/// {@endtemplate}
extension type const AppMessageId._(String value) {
  /// {@macro app_message_id}
  factory AppMessageId.create() => AppMessageId._(IdCreator.create());
  factory AppMessageId.fromJson(final dynamic value) =>
      AppMessageId._(jsonDecodeString(value));

  static const empty = AppMessageId._('');

  bool get isEmpty => value.isEmpty;
  bool get isNotEmpty => value.isNotEmpty;
}

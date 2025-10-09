// ignore_for_file: avoid_annotating_with_dynamic

import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:xsoulspace_state_utils/xsoulspace_state_utils.dart';

/// {@template app_messages_resource}
/// Resource that manages user-facing messages across the application.
///
/// Messages are ordered by creation time and can be added or removed
/// dynamically. Used primarily for displaying errors, warnings, and
/// notifications to users.
///
/// Example usage:
/// ```dart
/// final messagesResource = context.watch<AppMessagesResource>();
///
/// // Add error message
/// messagesResource.add(AppMessage.create(
///   id: AppMessageId('error_1'),
///   message: 'Network request failed',
///   type: AppMessageType.error,
/// ));
///
/// // Remove message
/// messagesResource.removeByKey(AppMessageId('error_1'));
/// ```
/// {@endtemplate}
class AppMessagesResource extends OrderedMapNotifier<AppMessageId, AppMessage> {
  /// {@macro app_messages_resource}
  AppMessagesResource() : super(toKey: (final message) => message.id);
}

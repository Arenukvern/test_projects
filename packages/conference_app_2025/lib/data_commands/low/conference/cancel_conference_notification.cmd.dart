import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/di/di.dart';

/// {@template cancel_conference_notification_command}
/// Command to cancel a scheduled notification for a conference session.
///
/// Only works on iOS.
///
/// Example:
/// ```dart
/// final command = CancelConferenceNotificationCommand();
/// await command.execute(sessionId);
/// ```
/// {@endtemplate}
class CancelConferenceNotificationCommand with HasServices {
  /// {@macro cancel_conference_notification_command}
  const CancelConferenceNotificationCommand();

  /// Execute the command to cancel a notification
  Future<void> execute(final ConferenceSessionId sessionId) async =>
      notificationService.cancelConferenceNotification(sessionId);
}

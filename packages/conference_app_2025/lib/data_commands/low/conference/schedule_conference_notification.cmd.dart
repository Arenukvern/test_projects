import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/di/di.dart';

/// {@template schedule_conference_notification_command}
/// Command to schedule a local notification for a conference session.
///
/// Schedules a notification 10 minutes before the conference starts.
/// Only works on iOS. Requests permissions on first use.
///
/// Example:
/// ```dart
/// final command = ScheduleConferenceNotificationCommand();
/// await command.execute(session);
/// ```
/// {@endtemplate}
class ScheduleConferenceNotificationCommand with HasServices {
  /// {@macro schedule_conference_notification_command}
  const ScheduleConferenceNotificationCommand();

  /// Execute the command to schedule a notification
  ///
  /// Returns true if the notification was scheduled successfully
  Future<bool> execute(final ConferenceSession session) =>
      notificationService.scheduleConferenceNotification(session);
}

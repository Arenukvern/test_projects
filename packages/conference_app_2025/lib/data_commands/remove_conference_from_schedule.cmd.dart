import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';

/// {@template remove_conference_from_schedule_command}
/// Command to remove a conference session from the user's schedule.
///
/// Removes the session from [MyConferencesResource] which automatically
/// updates the time-grouped cache for efficient schedule display.
///
/// Example:
/// ```dart
/// final command = RemoveConferenceFromScheduleCommand(
///   myConferencesResource: myConferencesResource,
/// );
/// command.execute(sessionId);
/// ```
/// {@endtemplate}
class RemoveConferenceFromScheduleCommand {
  /// {@macro remove_conference_from_schedule_command}
  const RemoveConferenceFromScheduleCommand({
    required this.myConferencesResource,
  });

  final MyConferencesResource myConferencesResource;

  /// Execute the command to remove a session from the schedule
  void execute(final ConferenceSessionId sessionId) {
    myConferencesResource.remove(sessionId);
  }
}

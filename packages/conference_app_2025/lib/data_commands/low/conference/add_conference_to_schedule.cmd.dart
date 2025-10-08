import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/di/di.dart';

/// {@template add_conference_to_schedule_command}
/// Command to add a conference session to the user's schedule.
///
/// Adds the session to [MyConferencesResource] which automatically
/// updates the time-grouped cache for efficient schedule display.
///
/// Example:
/// ```dart
/// final command = AddConferenceToScheduleCommand(
///   myConferencesResource: myConferencesResource,
/// );
/// command.execute(session);
/// ```
/// {@endtemplate}
class AddConferenceToScheduleCommand with HasResources {
  /// {@macro add_conference_to_schedule_command}
  const AddConferenceToScheduleCommand();

  /// Execute the command to add a session to the schedule
  void execute(final ConferenceSession session) {
    myConferencesResource.upsert(session);
  }
}

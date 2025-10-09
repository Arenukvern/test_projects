import 'package:conference_app_2025/common_imports.dart';

/// {@template load_my_conferences_command}
/// Command to load the user's scheduled conference sessions.
///
/// Fetches the list of conferences the user has added to their schedule
/// and populates the [MyConferencesResource] with the results.
///
/// This is typically called during app initialization to ensure the
/// user's schedule is available immediately.
/// {@endtemplate}
class LoadMyConferencesCommand with HasApi, HasResources {
  /// {@macro load_my_conferences_command}
  const LoadMyConferencesCommand();

  /// Executes the command to load scheduled conferences
  Future<void> execute() async {
    final conferences = await conferenceApi.getMyConferences();
    myConferencesResource.assignAllOrdered(conferences);
  }
}

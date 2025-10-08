import 'package:conference_app_2025/common_imports.dart';

/// {@template load_resources_command}
/// High-level command that loads all critical resources during app initialization.
///
/// This command runs in parallel:
/// - Conference tags (for filtering)
/// - Speakers/persons information
/// - User's scheduled conferences
///
/// Used during the splash screen loading sequence to ensure all
/// critical data is available before navigating to the main app.
/// {@endtemplate}
class LoadResourcesCommand with HasApi, HasResources {
  /// {@macro load_resources_command}
  const LoadResourcesCommand();

  /// Executes all resource loading operations in parallel
  Future<void> execute() async {
    await Future.wait([
      const LoadConferenceTagsCommand().execute(),
      const LoadPersonsCommand().execute(),
      const LoadMyConferencesCommand().execute(),
    ]);
  }
}

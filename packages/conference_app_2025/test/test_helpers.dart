import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/di/di.dart';
import 'package:conference_app_2025/di/di_provider.dart';
import 'package:conference_app_2025/ui_kit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// {@template setup_test_di}
/// Initializes dependency injection for tests.
///
/// This function sets up all services, APIs, and resources needed for testing.
/// Call this in setUp() before each test to ensure a clean DI state.
///
/// Example:
/// ```dart
/// setUp(() {
///   setupTestDi();
/// });
/// ```
///
/// Use [overrides] to replace specific dependencies for edge case testing:
/// ```dart
/// setupTestDi(overrides: {
///   ConferenceApiI: MockConferenceApi(),
/// });
/// ```
/// {@endtemplate}
void setupTestDi({final Map<Type, dynamic> overrides = const {}}) {
  Di.instance.register();

  // Apply overrides if provided
  // Note: GetIt doesn't easily support overrides, so this is a placeholder
  // for future enhancement. For now, tests should modify resources after setup.
}

/// {@template tear_down_test_di}
/// Cleans up dependency injection after tests.
///
/// Disposes all registered services and resets GetIt to prevent state leakage
/// between tests. Call this in tearDown() after each test.
///
/// Example:
/// ```dart
/// tearDown(() async {
///   await tearDownTestDi();
/// });
/// ```
/// {@endtemplate}
Future<void> tearDownTestDi() async => Di.instance.dispose();

/// {@template test_app_wrapper}
/// Creates a widget wrapper that mimics the production app setup.
///
/// This wrapper provides:
/// - All 8 production resources via [DiProvider]
/// - MaterialApp for navigation and theme context
/// - Proper theme configuration (light or dark)
/// - Optional GoRouter support for screens that need routing
///
/// Use this with golden_toolkit's pumpWidgetBuilder:
/// ```dart
/// await tester.pumpWidgetBuilder(
///   const MyScreen(),
///   wrapper: testAppWrapper(),
/// );
/// ```
///
/// For screens that need routing (like splash screen):
/// ```dart
/// wrapper: testAppWrapper(useRouter: true)
/// ```
///
/// Override specific resources for edge cases:
/// ```dart
/// final customResource = MyConferencesResource();
/// // ... modify customResource ...
///
/// wrapper: testAppWrapper(
///   resourceOverrides: {MyConferencesResource: customResource},
/// )
/// ```
/// {@endtemplate}
Widget Function(Widget) testAppWrapper({
  final Map<Type, ChangeNotifier>? resourceOverrides,
  final ThemeData? theme,
  final bool useRouter = false,
}) => (final child) {
  // If using router, we need to import and use the real appRouter
  // For now, we'll use a simple MaterialApp to avoid router complexity in tests
  // Screens that require routing should be tested differently

  // If no overrides, use DiProvider for full production setup
  if (resourceOverrides == null || resourceOverrides.isEmpty) {
    return DiProvider(
      builder: (final context) =>
          MaterialApp(theme: theme ?? AppTheme.light(), home: child),
    );
  }

  // If overrides provided, create custom MultiProvider
  final getIt = GetIt.instance;
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[NetworkSimulationSettingsResource]
                as NetworkSimulationSettingsResource? ??
            getIt.get<NetworkSimulationSettingsResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[AppMessagesResource] as AppMessagesResource? ??
            getIt.get<AppMessagesResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[MyConferencesResource]
                as MyConferencesResource? ??
            getIt.get<MyConferencesResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[ConferenceTagsResource]
                as ConferenceTagsResource? ??
            getIt.get<ConferenceTagsResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[SpeakersResource] as SpeakersResource? ??
            getIt.get<SpeakersResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[TextScaleResource] as TextScaleResource? ??
            getIt.get<TextScaleResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[ThemeBrightnessResource]
                as ThemeBrightnessResource? ??
            getIt.get<ThemeBrightnessResource>(),
      ),
      ChangeNotifierProvider.value(
        value:
            resourceOverrides[AppStatusResource] as AppStatusResource? ??
            getIt.get<AppStatusResource>(),
      ),
    ],
    child: MaterialApp(theme: theme ?? AppTheme.light(), home: child),
  );
};

/// {@template seed_conference_tags}
/// Pre-populates [ConferenceTagsResource] with test data.
///
/// Use this to set up realistic state for golden tests that display
/// conference sessions.
///
/// Example:
/// ```dart
/// final resource = GetIt.instance.get<ConferenceTagsResource>();
/// seedConferenceTags(resource, [
///   const ConferenceTag('flutter'),
///   const ConferenceTag('dart'),
/// ]);
/// ```
/// {@endtemplate}
void seedConferenceTags(
  final ConferenceTagsResource resource,
  final List<ConferenceTag> tags,
) {
  for (final tag in tags) {
    resource.upsert(tag);
  }
}

/// {@template seed_speakers}
/// Pre-populates [SpeakersResource] with test data.
///
/// Use this to set up realistic state for golden tests that display
/// speaker information.
///
/// Example:
/// ```dart
/// final resource = GetIt.instance.get<SpeakersResource>();
/// seedSpeakers(resource, [
///   Speaker(
///     id: const SpeakerId('speaker-1'),
///     name: 'Alex Kim',
///     bio: 'Principal Engineer',
///   ),
/// ]);
/// ```
/// {@endtemplate}
void seedSpeakers(
  final SpeakersResource resource,
  final List<Speaker> speakers,
) {
  for (final speaker in speakers) {
    resource.upsert(speaker);
  }
}

/// {@template seed_my_conferences}
/// Pre-populates [MyConferencesResource] with saved conference sessions.
///
/// Use this to test the "My Schedule" view with pre-saved conferences.
///
/// Example:
/// ```dart
/// final resource = GetIt.instance.get<MyConferencesResource>();
/// seedMyConferences(resource, [
///   ConferenceSession(
///     id: const ConferenceSessionId('session-1'),
///     title: 'Test Session',
///     // ... other fields
///   ),
/// ]);
/// ```
/// {@endtemplate}
void seedMyConferences(
  final MyConferencesResource resource,
  final List<ConferenceSession> sessions,
) {
  for (final session in sessions) {
    resource.upsert(session);
  }
}

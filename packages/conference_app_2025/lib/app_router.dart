import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/ui_conferences/ui_all_conferences_screen.dart';
import 'package:conference_app_2025/ui_conferences/ui_conference_details_screen.dart';
import 'package:conference_app_2025/ui_home/ui_home_screen.dart';
import 'package:conference_app_2025/ui_profile/ui_profile_screen.dart';
import 'package:conference_app_2025/ui_schedule/ui_my_schedule_screen.dart';
import 'package:conference_app_2025/ui_splash/ui_splash_screen.dart';
import 'package:go_router/go_router.dart';

/// {@template app_router}
/// Main router configuration for the application
///
/// Uses enum-based type-safe routing with GoRouter for navigation.
/// All routes are defined using AppRoute enum values to prevent
/// hardcoded string errors and ensure type safety.
///
/// Features:
/// - Bottom tab navigation for main screens
/// - Deep linking support for conference details (myapp://conference/{id})
/// - Type-safe route parameters
/// - Handles both cold start and warm start deep links
/// {@endtemplate}
final appRouter = GoRouter(
  initialLocation: AppRoute.splash.path,
  redirect: (final context, final state) => _handleDeepLink(state),
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: AppRoute.splash.name,
      builder: (final context, final state) => const UiSplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (final context, final state, final navigationShell) =>
          UiHomeScreen(navigationShell: navigationShell),
      branches: [
        // Branch 0: All Conferences
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.allConferences.path,
              name: AppRoute.allConferences.name,
              builder: (final context, final state) =>
                  const UiAllConferencesScreen(),
              routes: [
                // Conference details as child route
                GoRoute(
                  path: ':id',
                  name: AppRoute.conferenceDetails.name,

                  builder: (final context, final state) {
                    final sessionId = ConferenceSessionId.fromJson(
                      state.pathParameters['id'],
                    );
                    final session = ConferenceSession.fromJson(state.extra);
                    return UiConferenceDetailsScreen(
                      sessionId: sessionId,
                      key: ValueKey(sessionId),
                      session: session,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // Branch 1: My Schedule
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.mySchedule.path,
              name: AppRoute.mySchedule.name,
              builder: (final context, final state) =>
                  const UiMyScheduleScreen(),

              routes: [
                GoRoute(
                  path: ':id',
                  name: AppRoute.myScheduleDetails.name,
                  builder: (final context, final state) {
                    final sessionId = ConferenceSessionId.fromJson(
                      state.pathParameters['id'],
                    );
                    final session = ConferenceSession.fromJson(state.extra);
                    return UiConferenceDetailsScreen(
                      sessionId: sessionId,
                      key: ValueKey(sessionId),
                      session: session,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // Branch 2: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              name: AppRoute.profile.name,
              builder: (final context, final state) => const UiProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Handles deep link navigation for myapp://conference/{id}
///
/// Extracts conference ID from the URI and redirects to conference details.
/// Works for both cold start (app closed) and warm start (app running).
String? _handleDeepLink(final GoRouterState state) {
  final uri = state.uri;

  // Handle myapp://conference/{id} deep links
  if (uri.scheme == 'myapp' && uri.host == 'conference') {
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      final conferenceId = pathSegments.first;
      // Navigate to conference details via all conferences route
      return '/conferences/$conferenceId';
    }
  }

  return null;
}

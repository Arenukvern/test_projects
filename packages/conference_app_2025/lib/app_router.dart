import 'package:conference_app_2025/common_imports.dart';
import 'package:conference_app_2025/ui_home/ui_home_screen.dart';
import 'package:conference_app_2025/ui_vehicle/ui_vehicle_room_screen.dart';
import 'package:go_router/go_router.dart';

/// {@template app_router}
/// Main router configuration for the application
///
/// Uses enum-based type-safe routing with GoRouter for navigation.
/// All routes are defined using AppRoute enum values to prevent
/// hardcoded string errors and ensure type safety.
/// {@endtemplate}
final appRouter = GoRouter(
  initialLocation: AppRoute.home.path,
  routes: [
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (final context, final state) => const UiHomeScreen(),
    ),
  ],
);

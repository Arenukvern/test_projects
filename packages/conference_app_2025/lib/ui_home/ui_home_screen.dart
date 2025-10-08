import 'package:conference_app_2025/common_imports.dart';
import 'package:go_router/go_router.dart';

part 'ui_bottom_nav_shell.dart';

/// {@template ui_home_screen}
/// Custom bottom navigation shell for the main application tabs.
///
/// Provides navigation between All Conferences, My Schedule, and Profile screens
/// using a custom bottom navigation bar that matches the app's design system.
/// {@endtemplate}
class UiHomeScreen extends StatelessWidget {
  /// {@macro ui_home_screen}
  const UiHomeScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: _BottomNavBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (final index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
    ),
  );
}

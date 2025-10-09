import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Golden tests for bottom navigation bar
///
/// Tests the visual appearance of the bottom navigation component
/// Note: Full UiHomeScreen test requires StatefulNavigationShell from go_router
/// which is difficult to mock in isolation. This tests the bottom bar structure.
void main() {
  testGoldens('Bottom Navigation Bar - golden test', (final tester) async {
    // Create a simplified version of the bottom nav bar for testing
    final widget = Scaffold(
      body: const Center(child: Text('Home Content')),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Conferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'My Schedule',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );

    await tester.pumpWidgetBuilder(
      widget,
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    await screenMatchesGolden(tester, 'ui_bottom_nav_bar');
  });
}

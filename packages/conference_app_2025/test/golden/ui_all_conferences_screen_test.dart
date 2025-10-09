import 'package:conference_app_2025/ui_conferences/ui_all_conferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_helpers.dart';

/// Golden tests for [UiAllConferencesScreen]
///
/// Tests the visual appearance of the conferences list screen
void main() {
  setUp(setupTestDi);

  tearDown(() async {
    await tearDownTestDi();
  });

  testGoldens('UiAllConferencesScreen - empty state', (final tester) async {
    // Test with empty state (no data seeded)
    await tester.pumpWidgetBuilder(
      const UiAllConferencesScreen(),
      wrapper: testAppWrapper(),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_all_conferences_screen');
  });
}

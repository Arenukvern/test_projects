import 'package:conference_app_2025/ui_schedule/ui_my_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_helpers.dart';

/// Golden tests for [UiMyScheduleScreen]
///
/// Tests the visual appearance of the my schedule screen
void main() {
  setUp(setupTestDi);

  tearDown(() async {
    await tearDownTestDi();
  });

  testGoldens('UiMyScheduleScreen - empty state', (final tester) async {
    // Test with empty schedule (no saved conferences)
    await tester.pumpWidgetBuilder(
      const UiMyScheduleScreen(),
      wrapper: testAppWrapper(),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_my_schedule_screen');
  });
}

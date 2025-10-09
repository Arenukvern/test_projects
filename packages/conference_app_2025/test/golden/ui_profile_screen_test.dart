import 'package:conference_app_2025/ui_profile/ui_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_helpers.dart';

/// Golden tests for [UiProfileScreen]
///
/// Tests the visual appearance of the profile/settings screen
void main() {
  setUp(setupTestDi);

  tearDown(() async {
    await tearDownTestDi();
  });

  testGoldens('UiProfileScreen - default settings', (final tester) async {
    await tester.pumpWidgetBuilder(
      const UiProfileScreen(),
      wrapper: testAppWrapper(),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    await screenMatchesGolden(tester, 'ui_profile_screen');
  });
}

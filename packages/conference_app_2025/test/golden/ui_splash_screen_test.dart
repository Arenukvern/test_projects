import 'package:conference_app_2025/ui_splash/ui_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Golden tests for [UiSplashScreen]
///
/// Tests the visual appearance of the splash screen
void main() {
  testGoldens('UiSplashScreen - golden test', (final tester) async {
    await tester.pumpWidgetBuilder(
      const UiSplashScreen(),
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    await screenMatchesGolden(tester, 'ui_splash_screen');
  });
}

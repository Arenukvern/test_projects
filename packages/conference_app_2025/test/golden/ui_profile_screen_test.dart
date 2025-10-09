import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/ui_profile/ui_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

/// Golden tests for [UiProfileScreen]
///
/// Tests the visual appearance of the profile/settings screen
void main() {
  testGoldens('UiProfileScreen - golden test', (final tester) async {
    await tester.pumpWidgetBuilder(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (final _) => TextScaleResource()),
          ChangeNotifierProvider(
            create: (final _) => ThemeBrightnessResource(),
          ),
        ],
        child: const UiProfileScreen(),
      ),
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    await screenMatchesGolden(tester, 'ui_profile_screen');
  });
}

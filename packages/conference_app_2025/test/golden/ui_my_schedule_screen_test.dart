import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/ui_schedule/ui_my_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

/// Golden tests for [UiMyScheduleScreen]
///
/// Tests the visual appearance of the my schedule screen
void main() {
  testGoldens('UiMyScheduleScreen - golden test', (final tester) async {
    // Create mock resources
    final myConferencesResource = MyConferencesResource();
    final speakersResource = SpeakersResource();

    await tester.pumpWidgetBuilder(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: myConferencesResource),
          ChangeNotifierProvider.value(value: speakersResource),
        ],
        child: const UiMyScheduleScreen(),
      ),
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_my_schedule_screen');
  });
}

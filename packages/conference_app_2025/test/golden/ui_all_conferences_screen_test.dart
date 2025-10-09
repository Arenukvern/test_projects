import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/ui_conferences/ui_all_conferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

/// Golden tests for [UiAllConferencesScreen]
///
/// Tests the visual appearance of the conferences list screen
void main() {
  testGoldens('UiAllConferencesScreen - golden test', (final tester) async {
    // Create mock resources with some data
    final conferencesResource = ConferenceTagsResource();

    await tester.pumpWidgetBuilder(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: conferencesResource),
          ChangeNotifierProvider(create: (final _) => MyConferencesResource()),
        ],
        child: const UiAllConferencesScreen(),
      ),
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_all_conferences_screen');
  });
}

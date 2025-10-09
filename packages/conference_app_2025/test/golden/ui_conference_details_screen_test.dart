import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/ui_conferences/ui_conference_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

/// Golden tests for [UiConferenceDetailsScreen]
///
/// Tests the visual appearance of the conference details screen
void main() {
  testGoldens('UiConferenceDetailsScreen - golden test', (final tester) async {
    // Create mock session data
    final mockSession = ConferenceSession(
      id: const ConferenceSessionId('test-id'),
      title: 'Test Conference Session',
      abstractText: 'This is a test conference session for golden testing.',
      startAt: DateTime(2025, 10, 21, 9),
      endAt: DateTime(2025, 10, 21, 9, 45),
      room: 'Main Hall',
      tags: [
        const ConferenceTag('flutter'),
        const ConferenceTag('architecture'),
      ],
      speakerIds: [const SpeakerId('speaker-1')],
    );

    // Create mock resources
    final myConferencesResource = MyConferencesResource();
    final speakersResource = SpeakersResource();

    await tester.pumpWidgetBuilder(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: myConferencesResource),
          ChangeNotifierProvider.value(value: speakersResource),
        ],
        child: UiConferenceDetailsScreen(
          sessionId: mockSession.id,
          session: mockSession,
        ),
      ),
      wrapper: materialAppWrapper(theme: ThemeData.light()),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_conference_details_screen');
  });
}

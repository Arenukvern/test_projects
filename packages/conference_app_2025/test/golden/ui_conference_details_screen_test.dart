import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/data_resources/data_resources.dart';
import 'package:conference_app_2025/ui_conferences/ui_conference_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_helpers.dart';

/// Golden tests for [UiConferenceDetailsScreen]
///
/// Tests the visual appearance of the conference details screen
void main() {
  setUp(setupTestDi);

  tearDown(() async {
    await tearDownTestDi();
  });

  testGoldens('UiConferenceDetailsScreen - with speaker', (final tester) async {
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

    // Seed speaker data
    final speakersResource = GetIt.instance.get<SpeakersResource>();
    seedSpeakers(speakersResource, [
      Speaker(
        id: const SpeakerId('speaker-1'),
        name: 'Alex Kim',
        bio: 'Principal Engineer at Tech Corp',
      ),
    ]);

    await tester.pumpWidgetBuilder(
      UiConferenceDetailsScreen(
        sessionId: mockSession.id,
        session: mockSession,
      ),
      wrapper: testAppWrapper(),
      surfaceSize: const Size(375, 667), // iPhone SE size
    );

    // Wait for initial render
    await tester.pump();

    await screenMatchesGolden(tester, 'ui_conference_details_screen');
  });
}

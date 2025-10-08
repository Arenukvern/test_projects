import 'dart:convert';

/// Mock conference sessions data in JSON format.
/// This can be used for testing, seeding, or as a fixture for parsing.
final List<String> mockConferencesPaginatedJson = [
  jsonEncode([
    {
      'id': '1',
      'title': 'Conference Session 1',
      'abstractText': 'Abstract for Conference Session 1',
      'startAt': '2025-01-01T09:00:00.000Z',
      'endAt': '2025-01-01T10:00:00.000Z',
      'room': 'Room 1',
      'tags': ['Tag 1', 'Tag 2'],
      'speakerIds': ['Speaker 1', 'Speaker 2'],
    },
    {
      'id': '2',
      'title': 'Conference Session 2',
      'abstractText': 'Abstract for Conference Session 2',
      'startAt': '2025-01-01T11:00:00.000Z',
      'endAt': '2025-01-01T12:00:00.000Z',
      'room': 'Room 2',
      'tags': ['Tag 3', 'Tag 4'],
      'speakerIds': ['Speaker 3', 'Speaker 4'],
    },
  ]),
  jsonEncode([
    {
      'id': '3',
      'title': 'Conference Session 3',
      'abstractText': 'Abstract for Conference Session 3',
      'startAt': '2025-01-01T13:00:00.000Z',
      'endAt': '2025-01-01T14:00:00.000Z',
      'room': 'Room 3',
      'tags': ['Tag 5', 'Tag 6'],
      'speakerIds': ['Speaker 5', 'Speaker 6'],
    },
    {
      'id': '4',
      'title': 'Conference Session 4',
      'abstractText': 'Abstract for Conference Session 4',
      'startAt': '2025-01-01T15:00:00.000Z',
      'endAt': '2025-01-01T16:00:00.000Z',
      'room': 'Room 4',
      'tags': ['Tag 7', 'Tag 8'],
      'speakerIds': ['Speaker 7', 'Speaker 8'],
    },
    {
      'id': '5',
      'title': 'Conference Session 5',
      'abstractText': 'Abstract for Conference Session 5',
      'startAt': '2025-01-01T17:00:00.000Z',
      'endAt': '2025-01-01T18:00:00.000Z',
      'room': 'Room 5',
      'tags': ['Tag 9', 'Tag 10'],
      'speakerIds': ['Speaker 9', 'Speaker 10'],
    },
    {
      'id': '6',
      'title': 'Conference Session 6',
      'abstractText': 'Abstract for Conference Session 6',
      'startAt': '2025-01-01T19:00:00.000Z',
      'endAt': '2025-01-01T20:00:00.000Z',
      'room': 'Room 6',
      'tags': ['Tag 11', 'Tag 12'],
      'speakerIds': ['Speaker 11', 'Speaker 12'],
    },
  ]),
];

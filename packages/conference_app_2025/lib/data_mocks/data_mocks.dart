/// Mock conference sessions data in JSON format.
/// This can be used for testing, seeding, or as a fixture for parsing.
final List<Map<String, dynamic>> mockConferencesPaginatedJson = [
  {
    'id': '1',
    'title': 'Conference Session 1',
    'abstract': 'Abstract for Conference Session 1',
    'start_at': '2025-01-01T09:00:00.000Z',
    'end_at': '2025-01-01T10:00:00.000Z',
    'room': 'Room 1',
    'tags': ['flutter', 'architecture'],
    'speaker_ids': ['p1', 'p2'],
  },
  {
    'id': '2',
    'title': 'Conference Session 2',
    'abstract': 'Abstract for Conference Session 2',
    'start_at': '2025-01-01T11:00:00.000Z',
    'end_at': '2025-01-01T12:00:00.000Z',
    'room': 'Room 2',
    'tags': ['architecture', 'design'],
    'speaker_ids': ['p3', 'p4'],
  },

  {
    'id': '3',
    'title': 'Conference Session 3',
    'abstract': 'Abstract for Conference Session 3',
    'start_at': '2025-01-01T13:00:00.000Z',
    'end_at': '2025-01-01T14:00:00.000Z',
    'room': 'Room 3',
    'tags': ['flutter', 'architecture'],
    'speaker_ids': ['p5', 'p6'],
  },
  {
    'id': '4',
    'title': 'Conference Session 4',
    'abstract': 'Abstract for Conference Session 4',
    'start_at': '2025-01-01T15:00:00.000Z',
    'end_at': '2025-01-01T16:00:00.000Z',
    'room': 'Room 4',
    'tags': ['architecture', 'development'],
    'speaker_ids': ['p7', 'p8'],
  },
  {
    'id': '5',
    'title': 'Conference Session 5',
    'abstract': 'Abstract for Conference Session 5',
    'start_at': '2025-01-01T17:00:00.000Z',
    'end_at': '2025-01-01T18:00:00.000Z',
    'room': 'Room 5',
    'tags': ['flutter', 'development'],
    'speaker_ids': ['p9', 'p10'],
  },
  {
    'id': '6',
    'title': 'Conference Session 6',
    'abstract': 'Abstract for Conference Session 6',
    'start_at': '2025-01-01T19:00:00.000Z',
    'end_at': '2025-01-01T20:00:00.000Z',
    'room': 'Room 6',
    'tags': ['flutter', 'testing'],
    'speaker_ids': ['p11', 'p12'],
  },
  ...List.generate(
    1000,
    (final index) => {
      'id': '${index + 7}',
      'title':
          'Conference Session ${['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Theta', 'Sigma', 'Omega'][index % 9]} #${index + 7}',
      'abstract':
          'This is a session about ${['Flutter', 'Architecture', 'Testing', 'Design', 'Leadership', 'Maintenance'][index % 6]} and its impact on ${['mobile', 'web', 'cloud', 'AI', 'IoT'][index % 5]} development.',
      'start_at':
          '2025-01-01T${(8 + (index % 10)).toString().padLeft(2, '0')}:00:00.000Z',
      'end_at':
          '2025-01-01T${(9 + (index % 10)).toString().padLeft(2, '0')}:00:00.000Z',
      'room': 'Room ${index % 10 + 1}',
      'tags': ([
        'flutter',
        'architecture',
        'testing',
        'design',
        'leadership',
        'maintenance',
      ]..shuffle()).sublist(0, 2 + (index % 3)), // 2-3 random tags

      'speaker_ids': ([
        'p1',
        'p2',
        'p3',
        'p4',
        'p5',
        'p6',
        'p7',
        'p8',
        'p9',
        'p10',
      ]..shuffle()).sublist(0, 1 + (index % 2)), // 1-2 random speakers
    },
  ),
];

final List<Map<String, dynamic>> mockSpeakersJson = [
  {'id': 'p1', 'name': 'John Smith', 'bio': 'SE with 100+ years of experience'},
  {'id': 'p2', 'name': 'May Smith', 'bio': 'CTO with 20+ years of experience'},
  {'id': 'p3', 'name': 'Loki Beam', 'bio': 'CEO with 30+ years of experience'},
  {'id': 'p4', 'name': 'Jim Beam', 'bio': 'CEO with 30+ years of experience'},
  {'id': 'p5', 'name': 'John Bond', 'bio': 'CFO with 40+ years of experience'},
  {'id': 'p6', 'name': 'Bro Black', 'bio': 'CEO with 30+ years of experience'},
  {
    'id': 'p7',
    'name': 'Kaenu Beens',
    'bio': 'CEO with 100+ years of experience',
  },
  {
    'id': 'p8',
    'name': 'Scarlett Fox',
    'bio': 'CEO with 100+ years of experience',
  },
  {
    'id': 'p9',
    'name': 'Jason Bond',
    'bio': 'Software Engineer with 3500+ years of experience',
  },
  {
    'id': 'p10',
    'name': 'Mike Bonds',
    'bio': 'Software Engineer with 100+ years of experience',
  },
  {
    'id': 'p11',
    'name': 'Sylvester Bonds',
    'bio': 'CTO with 100+ years of experience',
  },
  {
    'id': 'p12',
    'name': 'Arnold Bonds',
    'bio': 'Architect with 100+ years of experience',
  },
];

final List<String> mockConferenceTagsJson = [
  'flutter',
  'architecture',
  'design',
  'testing',
  'maintenance',
  'leadership',
];

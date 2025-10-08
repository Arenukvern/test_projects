// ignore_for_file: avoid_annotating_with_dynamic

import 'package:from_json_to_json/from_json_to_json.dart';

/// Extension type that represents a unique identifier for a session.
///
/// Used to distinguish between different sessions in the conference.
/// Provides type-safe JSON serialization/deserialization.
extension type const SessionId(String value) {
  factory SessionId.fromJson(final dynamic value) =>
      SessionId(jsonDecodeString(value));
  String toJson() => value;

  bool get isEmpty => value.isEmpty;
  bool get isNotEmpty => value.isNotEmpty;

  SessionId whenEmptyUse(final SessionId other) => isEmpty ? other : this;

  static const empty = SessionId('');
}

/// Extension type that represents a unique identifier for a speaker.
///
/// Used to distinguish between different speakers in the conference.
/// Provides type-safe JSON serialization/deserialization.
extension type const SpeakerId(String value) {
  factory SpeakerId.fromJson(final dynamic value) =>
      SpeakerId(jsonDecodeString(value));
  String toJson() => value;

  bool get isEmpty => value.isEmpty;
  bool get isNotEmpty => value.isNotEmpty;

  SpeakerId whenEmptyUse(final SpeakerId other) => isEmpty ? other : this;

  static const empty = SpeakerId('');
}

/// Extension type that represents a unique tag for a session or speaker.
///
/// Used to categorize sessions and speakers in the conference.
/// Provides type-safe JSON serialization/deserialization.
extension type const TagModel(String value) {
  factory TagModel.fromJson(final dynamic value) =>
      TagModel(jsonDecodeString(value));
  String toJson() => value;

  bool get isEmpty => value.isEmpty;
  bool get isNotEmpty => value.isNotEmpty;

  TagModel whenEmptyUse(final TagModel other) => isEmpty ? other : this;

  static const empty = TagModel('');
}

/// Extension type that represents a session at the conference.
///
/// Contains all relevant information about a session, including its
/// title, abstract, timing, room, tags, and associated speakers.
///
/// Uses from_json_to_json for type-safe JSON handling.
///
/// Example:
///
///```json
/// {
///   "id": "c1",
///   "title": "Declarative UI Patterns in Flutter",
///   "abstract": "How to structure modern Flutter UIs…",
///   "start_at": "2025-10-21T09:00:00Z",
///   "end_at": "2025-10-21T09:45:00Z",
///   "room": "Main Hall",
///   "tags": ["flutter","architecture"],
///   "speaker_ids": ["p1"]
/// }
/// ```
extension type const SessionModel._(Map<String, dynamic> value) {
  /// Creates a [SessionModel] from individual fields.
  factory SessionModel({
    required final SessionId id,
    required final String title,
    required final String abstractText,
    required final DateTime startAt,
    required final DateTime endAt,
    required final String room,
    required final List<TagModel> tags,
    required final List<SpeakerId> speakerIds,
  }) => SessionModel._({
    'id': id,
    'title': title,
    'abstract': abstractText,
    'start_at': startAt.toIso8601String(),
    'end_at': endAt.toIso8601String(),
    'room': room,
    'tags': tags,
    'speaker_ids': speakerIds,
  });

  /// Creates a [SessionModel] from JSON.
  factory SessionModel.fromJson(final dynamic json) =>
      SessionModel._(jsonDecodeMapAs<String, dynamic>(json));

  /// The unique identifier for the session.
  SessionId get id => SessionId.fromJson(value['id']);

  /// The title of the session.
  String get title => jsonDecodeString(value['title']);

  /// The abstract/summary of the session.
  String get abstractText => jsonDecodeString(value['abstract']);

  /// The start time of the session (UTC).
  DateTime? get startAt =>
      dateTimeFromIso8601String(jsonDecodeString(value['start_at']));

  /// The end time of the session (UTC).
  DateTime? get endAt =>
      dateTimeFromIso8601String(jsonDecodeString(value['end_at']));

  /// The room where the session takes place.
  String get room => jsonDecodeString(value['room']);

  /// The tags associated with the session.
  List<TagModel> get tags =>
      jsonDecodeListAs<String>(value['tags']).map(TagModel.fromJson).toList();

  /// The list of speaker IDs for this session.
  List<SpeakerId> get speakerIds => jsonDecodeListAs<String>(
    value['speaker_ids'],
  ).map(SpeakerId.new).toList();

  /// Converts the model to JSON.
  Map<String, dynamic> toJson() => value;

  /// An empty session model.
  static const empty = SessionModel._({});
}

/// Immutable model representing a speaker.
///
/// Example:
///
/// ```json
/// {
///   "id": "p1",
///   "name": "Alex Kim",
///   "bio": "Principal Engineer",
///   "avatar_url": null
/// }
/// ```
extension type const SpeakerModel._(Map<String, dynamic> value) {
  /// Creates a [SpeakerModel] from fields.
  factory SpeakerModel({
    required final SpeakerId id,
    required final String name,
    required final String bio,
    final String? avatarUrl,
  }) => SpeakerModel._({
    'id': id,
    'name': name,
    'bio': bio,
    'avatar_url': avatarUrl,
  });

  /// Creates a [SpeakerModel] from JSON.
  factory SpeakerModel.fromJson(final dynamic json) =>
      SpeakerModel._(jsonDecodeMapAs<String, dynamic>(json));

  /// The unique identifier for the speaker.
  SpeakerId get id => SpeakerId.fromJson(value['id']);

  /// The name of the speaker.
  String get name => jsonDecodeString(value['name']);

  /// The biography or title of the speaker.
  String get bio => jsonDecodeString(value['bio']);

  /// The avatar URL of the speaker
  ///
  /// Can be empty, if not provided.
  String get avatarUrl => jsonDecodeString(value['avatar_url']);

  /// Converts the model to JSON.
  Map<String, dynamic> toJson() => value;

  /// An empty speaker model.
  static const empty = SpeakerModel._({});
}

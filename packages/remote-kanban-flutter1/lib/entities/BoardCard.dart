import 'package:json_annotation/json_annotation.dart';

part 'BoardCard.g.dart';
// To generate run flutter pub run build_runner build

@JsonSerializable()
class BoardCard {
  int id;
  // ignore: non_constant_identifier_names
  int seq_num;
  String row;
  String text;
  // ignore: non_constant_identifier_names
  BoardCard({this.seq_num, this.id, this.row, this.text});
  factory BoardCard.fromJson(Map<String, dynamic> json) =>
      _$BoardCardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardCardToJson(this);
}

@JsonSerializable()
class BoardCards {
  List<BoardCard> cards;
  BoardCards();
  factory BoardCards.fromJson(Map<String, dynamic> json) =>
      _$BoardCardsFromJson(json);

  Map<String, dynamic> toJson() => _$BoardCardsToJson(this);
}

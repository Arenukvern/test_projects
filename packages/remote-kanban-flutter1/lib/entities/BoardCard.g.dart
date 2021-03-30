// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BoardCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardCard _$BoardCardFromJson(Map<String, dynamic> json) {
  return BoardCard(
    seq_num: json['seq_num'] as int,
    id: json['id'] as int,
    row: json['row'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$BoardCardToJson(BoardCard instance) => <String, dynamic>{
      'id': instance.id,
      'seq_num': instance.seq_num,
      'row': instance.row,
      'text': instance.text,
    };

BoardCards _$BoardCardsFromJson(Map<String, dynamic> json) {
  return BoardCards()
    ..cards = (json['cards'] as List)
        ?.map((e) =>
            e == null ? null : BoardCard.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BoardCardsToJson(BoardCards instance) =>
    <String, dynamic>{
      'cards': instance.cards,
    };

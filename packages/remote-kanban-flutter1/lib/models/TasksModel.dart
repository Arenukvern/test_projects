import 'package:flutter/foundation.dart';
import 'package:test_fl_kanban/entities/BoardCard.dart';
import 'package:test_fl_kanban/services/CardsService.dart';

class TasksModel extends ChangeNotifier {
  CardService _cardService = CardService();
  final Map<String, List<BoardCard>> columnsWithCards = {};

  List<BoardCard> getTasksForColumn({@required String columnId}) {
    return !columnsWithCards.containsKey(columnId)
        ? []
        : columnsWithCards[columnId];
  }

  Future<bool> fetchTasksForColumn({@required String columnId}) async {
    var cards = await _cardService.getCards(row: columnId);
    // List<BoardCard> cards = [
    //   BoardCard(id: 0, row: '0', seq_num: 0, text: 'xxx')
    // ];
    columnsWithCards.update(columnId, (value) => cards, ifAbsent: () => cards);
    return true;
  }
}

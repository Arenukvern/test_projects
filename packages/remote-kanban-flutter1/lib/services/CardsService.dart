import 'package:test_fl_kanban/constants/Api.dart';
import 'package:test_fl_kanban/constants/RequestMethods.dart';
import 'package:test_fl_kanban/entities/BoardCard.dart';
import 'package:test_fl_kanban/entities/CommonError.dart';
import 'package:test_fl_kanban/services/FetchService.dart';

class CardService {
  create(BoardCard card) async {
    return await FetchService.fetch(
        body: {'text': card.text, 'row': card.row},
        requestMethod: RequestMethods.post,
        url: '${Api.cards}');
  }

  update(BoardCard card) async {
    try {
      var repsonse = await FetchService.fetch(
          body: card.toJson(),
          requestMethod: RequestMethods.patch,
          url: '${Api.cards}${card.id}/');
      BoardCard updatedCard = BoardCard.fromJson(repsonse.data);
      return updatedCard;
      // ignore: unused_catch_clause
    } on CommonError catch (e) {
      // TODO: implement BoadCard Errors
    }
  }

  delete(int cardId) async {
    return await FetchService.fetch(
        requestMethod: RequestMethods.delete, url: '$Api.cards$cardId/');
  }

  Future<List<BoardCard>> getCards({String row}) async {
    try {
      var response = await FetchService.fetch(
          requestMethod: RequestMethods.getRequest,
          url: '${Api.cards}',
          checkToken: true,
          urlSearchParams: row != null ? {'row': row} : null);
      var cards = BoardCards.fromJson({'cards': response.data}).cards;
      return cards;

    } on CommonError catch (e) {
      print({'not fine', e.response, e.message});

      // TODO: add error handler
      return [];
    }
  }
}

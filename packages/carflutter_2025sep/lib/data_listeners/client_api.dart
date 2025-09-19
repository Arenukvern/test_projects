import 'dart:async';
import 'dart:developer' as developer;

import 'package:carflutter_2025sep/data_listeners/data_listeners.dart';

typedef ClientApiData = ({ServerToClientAction actionId, String? data});

class ClientApi {
  ClientApi();

  final _streamController = StreamController<ClientApiData>.broadcast();

  void notifyServer(
    final int uid,
    final ClientToServerAction actionId, [
    final String? data,
  ]) => developer.log('notifyServer: $actionId, $data');

  void onServerData(
    final ServerToClientAction actionId, [
    final String? data,
  ]) => _streamController.add((actionId: actionId, data: data));

  Stream<ClientApiData> get stream => _streamController.stream;

  void dispose() => unawaited(_streamController.close());
}

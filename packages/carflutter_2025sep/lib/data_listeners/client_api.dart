import 'dart:async';
import 'dart:developer' as developer;

import 'package:carflutter_2025sep/data_listeners/data_listeners.dart';
import 'package:carflutter_2025sep/data_mocks/data_mocks.dart';
import 'package:carflutter_2025sep/data_models/data_models.dart';
import 'package:flutter/widgets.dart';

typedef ClientApiData = ({ServerToClientAction actionId, String? data});

abstract interface class ClientApiListener {
  void onServerData(final ServerToClientAction actionId, [final String? data]);
}

abstract base class ClientApi {
  ClientApi();

  final _streamController = StreamController<ClientApiData>.broadcast();
  final _listeners = <ClientApiListener>{};

  void pingReady() {
    onServerData(ServerToClientAction.carList, DataMocks.vehicleList);
  }

  void notifyServer(
    final UserInterfaceUid uid,
    final ClientToServerAction actionId, [
    final String? data,
  ]);

  @mustCallSuper
  void onServerData(final ServerToClientAction actionId, [final String? data]) {
    _streamController.add((actionId: actionId, data: data));
    for (final listener in _listeners) {
      listener.onServerData(actionId, data);
    }
  }

  Stream<ClientApiData> get stream => _streamController.stream;

  void dispose() {
    _listeners.clear();
    unawaited(_streamController.close());
  }

  void addListener(final ClientApiListener listener) {
    _listeners.add(listener);
  }

  void removeListener(final ClientApiListener listener) {
    _listeners.remove(listener);
  }
}

final class ClientApiMock extends ClientApi {
  ClientApiMock();

  @override
  void notifyServer(
    final UserInterfaceUid uid,
    final ClientToServerAction actionId, [
    final String? data,
  ]) => developer.log('notifyServer: $actionId, $data');
}

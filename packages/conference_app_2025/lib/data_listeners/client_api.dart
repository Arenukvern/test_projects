import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

abstract interface class ClientApiListener {
  void onServerData(final ServerToClientAction actionId, [final String? data]);
}

abstract base class ClientApi {
  ClientApi();

  final _streamController = StreamController<ClientApiData>.broadcast();
  final _listeners = <ClientApiListener>{};

  void pingReady() {}

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
}

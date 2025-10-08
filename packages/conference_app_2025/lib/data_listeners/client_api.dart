// ignore_for_file: avoid_annotating_with_dynamic

import 'dart:async';

import 'package:flutter/widgets.dart';

typedef ClientApiData = dynamic;

// ignore: one_member_abstracts
abstract interface class ClientApiListener {
  void onServerData(final dynamic data);
}

abstract base class ClientApi {
  ClientApi();

  final _streamController = StreamController<ClientApiData>.broadcast();
  final _listeners = <ClientApiListener>{};

  void init() {
    _streamController.stream.listen(onServerData);
  }

  @mustCallSuper
  void onServerData(final dynamic data) {
    for (final listener in _listeners) {
      listener.onServerData(data);
    }
  }

  Future<void> dispose() async {
    _listeners.clear();
    await _streamController.close();
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

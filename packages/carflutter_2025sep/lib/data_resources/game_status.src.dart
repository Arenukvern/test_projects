import 'package:flutter/material.dart';

enum GameStatus { loading, loaded, error }

class GameStatusResources extends ValueNotifier<GameStatus> {
  GameStatusResources() : super(GameStatus.loading);
}

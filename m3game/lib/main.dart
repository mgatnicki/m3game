import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:m3game/controller.dart';

void main() {
  runApp(
    GameWidget(
      game: Controller(),
    ),
  );
}

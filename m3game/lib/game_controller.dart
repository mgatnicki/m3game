import 'dart:ffi';

import 'package:flame/components/component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3game/objects/background.dart';
import 'package:m3game/objects/gem.dart';

class GameController extends BaseGame with HorizontalDragDetector, VerticalDragDetector {
  GameController(Size size) {
    this.size = size;
    add(Background(size));
    add(Gem(Type.a, 50, 50, 50));
  }

  @override
  void onVerticalDragStart(DragStartDetails details) => print('start ${details.localPosition}');

  @override
  void onVerticalDragEnd(DragEndDetails details) =>
      print('end ${details.velocity.pixelsPerSecond}');

  @override
  void onVerticalDragDown(DragDownDetails details) => print('down ${details.localPosition}');

  // @override
  // void onTapUp(TapUpDetails details) => print(details.localPosition);

  // @override
  // void onTapDown(TapDownDetails details) => print(details.localPosition);

  @override
  void update(double t) {
    super.update(t);
  }
}

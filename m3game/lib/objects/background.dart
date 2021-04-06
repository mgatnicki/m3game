import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent {
  Background(Size size) {
    this.x = 0;
    this.y = 0;
    this.width = size.width;
    this.height = size.height;
  }

  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTRB(x, y, width, height), Paint()..color = Colors.white);
  }
}

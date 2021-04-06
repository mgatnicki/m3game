import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

enum Type { a, b, c, d }

class Gem extends PositionComponent {
  Type type;

  Gem(this.type, double x, double y, double size) {
    this.anchor = Anchor.bottomRight;
    this.x = x;
    this.y = y;
    this.width = size;
    this.height = size;
  }

  @override
  void render(Canvas c) {
    c.drawCircle(Offset.zero, width * 0.5, Paint()..color = Colors.red);
  }
}

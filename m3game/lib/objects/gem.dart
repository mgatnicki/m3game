import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:m3game/objects/board.dart';

import 'dart:math' as math;

import 'package:m3game/utils/colors.dart';

enum Type { a, b, c, d }
math.Random random = math.Random();

class Gem extends PositionComponent {
  final Type type;
  final Board board;
  Paint paint;
  double radius;
  int column;
  int row;

  Gem(this.board, this.type, this.column, this.row)
      : super(size: Vector2(board.gemSize, board.gemSize)) {
    paint = getPaint(type);
    radius = board.gemSize * 0.5 * 0.75;
    position.setValues(
      column * board.gemSize * 0.5,
      row * board.gemSize * 0.5,
    );
  }

  static Type get randomType => Type.values.elementAt(random.nextInt(Type.values.length));

  @override
  void render(Canvas c) {
    super.render(c);
    final Offset offset = (position + size / 2).toOffset();
    c.drawCircle(offset, radius, paint);
  }

  static Paint getPaint(Type type) {
    switch (type) {
      case Type.a:
        return Paints.red;
      case Type.b:
        return Paints.blue;
      case Type.c:
        return Paints.green;
      case Type.d:
        return Paints.magenta;
      default:
        return Paints.white;
    }
  }

  @override
  String toString() => position.toString();
}

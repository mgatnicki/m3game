import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:m3game/objects/board.dart';
import 'package:m3game/utils/colors.dart';

import 'dart:math' as math;

const bool kData = false;
const bool khitbox = false;

enum Type { a, b, c, d }
math.Random random = math.Random();

class Gem extends PositionComponent {
  double _halfSize;
  double _hitboxSize;
  double _hitboxHalfSize;
  double _hitboxShift;

  final Type type;
  final Board board;

  Paint paint;
  double radius;
  int column;
  int row;
  bool active;

  Gem(this.board, this.type, this.column, this.row)
      : super(
          size: Vector2(board.gemSize, board.gemSize),
          position: Vector2(column * board.gemSize, row * board.gemSize),
        ) {
    paint = getPaint(type);
    _halfSize = board.gemSize * 0.5;
    radius = _halfSize * 0.75;
    _hitboxSize = board.gemSize * 0.75;
    _hitboxHalfSize = _hitboxSize * 0.5;
    _hitboxShift = (board.gemSize - _hitboxSize) * 0.5;
    active = false;
    log('gem: [$column,$row]  ->  $position');
  }

  static Type get randomType => Type.values.elementAt(random.nextInt(Type.values.length));

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

  bool isNeighbour(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      final int c = (gem.column - column).abs();
      final int r = (gem.row - row).abs();
      return (c == 0 || c == 1) && (r == 0 || r == 1);
    }
    return false;
  }

  bool isInside(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    final bool dt1 = dy > -dx + _hitboxSize - _hitboxShift;
    final bool dt2 = dy > dx - _hitboxHalfSize;
    final bool dt3 = dy < -dx + 2 * _hitboxShift + 3 * _hitboxHalfSize;
    final bool dt4 = dy < dx + _hitboxHalfSize;
    return dt1 && dt2 && dt3 && dt4;
  }

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawLine(Offset(0, 0), Offset(width, 0), Paints.black);
    c.drawLine(Offset(width, 0), Offset(width, height), Paints.black);
    c.drawLine(Offset(width, height), Offset(0, height), Paints.black);
    c.drawLine(Offset(0, height), Offset(0, 0), Paints.black);
    final Offset offset = (size / 2).toOffset();
    if (active) {
      c.drawCircle(offset, radius * 1.1, Paints.black);
    }
    c.drawCircle(offset, radius, paint);
    if (kData) {
      renderText(c, '$x,$y');
      renderText(c, '${x + width},$y', offset: Offset(width, 0), textWidthRatio: 1);
      renderText(
        c,
        '${x + width},${y + height}',
        offset: Offset(width, height),
        textWidthRatio: 1,
        textHeightRatio: 1,
      );
      renderText(
        c,
        '$x,${y + height}',
        offset: Offset(0, height),
        textHeightRatio: 1,
      );
    }
    if (khitbox) {
      renderHitBox(c);
    }
  }

  void renderText(
    Canvas c,
    String text, {
    Offset offset = Offset.zero,
    double textWidthRatio = 0.0,
    double textHeightRatio = 0.0,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      c,
      offset - Offset(textWidthRatio * textPainter.width, textHeightRatio * textPainter.height),
    );
  }

  void renderHitBox(Canvas c) {
    final double x1 = _hitboxShift;
    final double x2 = _hitboxShift + _hitboxHalfSize;
    final double x3 = _hitboxShift + _hitboxSize;
    final double y1 = _hitboxShift + _hitboxHalfSize;
    final double y2 = _hitboxShift;
    final double y3 = _hitboxShift + _hitboxSize;
    c.drawLine(Offset(x1, y1), Offset(x2, y2), Paints.black);
    c.drawLine(Offset(x2, y2), Offset(x3, y1), Paints.black);
    c.drawLine(Offset(x3, y1), Offset(x2, y3), Paints.black);
    c.drawLine(Offset(x2, y3), Offset(x1, y1), Paints.black);
  }

  @override
  String toString() => type.toString();
}

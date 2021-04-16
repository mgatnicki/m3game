import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3game/objects/board.dart';

class Controller extends BaseGame with MultiTouchDragDetector {
  bool running = true;
  double gemSize = 0;
  Board board;
  int _currrentPointerId;
  Offset lastPosition;

  @override
  Future<void> onLoad() async {
    const int columns = 4;
    const int rows = 3;
    gemSize = size.x / (columns + 1);
    board = Board(
      0 + (size.x - columns * gemSize) * 0.5,
      0 + (size.y - rows * gemSize) * 0.5,
      columns,
      rows,
      gemSize,
    );
    add(board);
  }

  @override
  void onDragStart(int pointerId, Vector2 startPosition) {
    _currrentPointerId = pointerId;
    lastPosition = startPosition.toOffset();
    board.onDragStart(lastPosition.dx, lastPosition.dy);
    super.onDragStart(pointerId, startPosition);
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateDetails details) {
    if (_currrentPointerId == pointerId) {
      lastPosition = details.localPosition;
      board.onDragUpdate(lastPosition.dx, lastPosition.dy);
    }
    super.onDragUpdate(pointerId, details);
  }

  @override
  void onDragEnd(int pointerId, DragEndDetails details) {
    if (_currrentPointerId == pointerId) {
      board.onDragEnd(lastPosition.dx, lastPosition.dy);
      _currrentPointerId = null;
      lastPosition = null;
    }

    super.onDragEnd(pointerId, details);
  }
}

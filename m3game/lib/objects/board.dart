import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:m3game/objects/gem.dart';
import 'package:m3game/utils/colors.dart';
import 'package:m3game/utils/gem_stack.dart';
import 'package:m3game/utils/gems_table.dart';
import 'package:m3game/utils/render_text.dart';

import 'dart:math' as math;

class Board extends PositionComponent {
  GemsTable _table;
  GemStack _selected;
  Gem _current;

  final int columns;
  final int rows;
  final double gemSize;

  Board(double x, double y, this.columns, this.rows, this.gemSize)
      : super(size: Vector2(columns * gemSize, rows * gemSize)) {
    position.setValues(x, y);
    _selected = GemStack();
    _table = GemsTable(columns, rows);
    final List<Type> types = <Type>[Type.a, Type.b, Type.c, Type.d, Type.e];
    final List<Gem> gems = [];
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        gems.add(Gem(this, types[j], i, j));
      }
    }
    _table.addMany(gems);
  }

  Future<void> onLoad() async {
    _table.forEach((Gem gem) => addChild(gem));
  }

  bool inside(double x, double y) => x >= 0 && x <= size.x && y >= 0 && y <= size.y;
  int getColumn(double x) => x ~/ gemSize;
  int getRow(double y) => y ~/ gemSize;

  void select(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      gem.select();
      _selected.push(gem);
    }
  }

  void onDragStart(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      final int column = getColumn(dx);
      final int row = getRow(dy);
      final Gem gem = _table.get(column, row);
      _current = gem;
      if (gem != null && gem.isInside(dx, dy)) {
        select(gem);
      }
    }
  }

  void onDragUpdate(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      final int column = getColumn(dx);
      final int row = getRow(dy);
      final Gem gem = _table.get(column, row);
      _current = gem;
      if (gem != null && gem.isInside(dx, dy)) {
        if (gem.isSelected) {
          if (_selected.length > 1) {
            log('$_selected   ->   ${_selected.peekBeforeLast()}');
            final Gem beforeLast = _selected.peekBeforeLast();
            if (gem == beforeLast) {
              final Gem poped = _selected.pop();
              poped.unselect();
            }
          }
        } else {
          // gem not selected
          if (_selected.any) {
            // some other games are selected
            final Gem lastGem = _selected.peek();
            if (lastGem.type == gem.type && lastGem.isNeighbour(gem)) {
              select(gem);
            }
          } else {
            // no gems selected so far
            select(gem);
          }
        }
      }
    }
  }

  void onDragEnd(double x, double y) {
    if (_selected.collectable) {
      final Iterator<Gem> it = _selected.iterator;
      while (it.moveNext()) {
        it.current.unselect();
        _table.remove(it.current);
        removeChild(it.current);
      }
      // _table.collect(_selected);
      _selected.clear();
    } else {
      _selected.unselectAndClear();
    }
    _current = null;
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(size.toRect(), Paints.white);

    final String current =
        _current != null ? '${_current.type}[${_current.column},${_current.row}]' : 'none';
    final Gem bl = _selected.peekBeforeLast();
    final String beforeLast = bl != null ? '${bl.type}[${bl.column},${bl.row}]' : 'none';
    renderText(c, beforeLast, offset: Offset(0, -66), color: Colors.white, size: 16);
    renderText(c, current, offset: Offset(0, -44), color: Colors.white, size: 16);
    renderText(c, _selected.toString(), offset: Offset(0, -22), color: Colors.white, size: 16);
  }

  @override
  String toString() {
    final StringBuffer b = StringBuffer();
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        b.write(_table.get(i, j).position);
        b.write('\t\t');
      }
      b.writeln();
    }
    return b.toString();
  }
}

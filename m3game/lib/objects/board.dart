import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:m3game/objects/gem.dart';
import 'package:m3game/utils/colors.dart';
import 'package:m3game/utils/gem_stack.dart';
import 'package:m3game/utils/gems_table.dart';

import 'dart:math' as math;

class Board extends PositionComponent {
  GemsTable _table;
  int _currentColumn;
  int _currentRow;
  GemStack _selectedGems;

  final int columns;
  final int rows;
  final double gemSize;

  Board(double x, double y, this.columns, this.rows, this.gemSize)
      : super(size: Vector2(columns * gemSize, rows * gemSize)) {
    position.setValues(x, y);
    _selectedGems = GemStack();
    _table = GemsTable(columns, rows);

    final List<Type> types = <Type>[Type.a, Type.b, Type.c, Type.d, Type.e];
    // final List<Gem> gems = [];
    // for (int i = 0; i < columns; i++) {
    //   for (int j = 0; j < rows; j++) {
    //     gems.add(Gem(this, types[j], i, j));
    //   }
    // }
    final List<Gem> gems = <Gem>[
      // 0
      Gem(this, types[0], 0, 0),
      Gem(this, types[0], 0, 1),
      Gem(this, types[0], 0, 2),
      // 1
      Gem(this, types[1], 1, 0),
      Gem(this, types[1], 1, 1),
      Gem(this, types[1], 1, 2),
      // 2
      Gem(this, types[2], 2, 0),
      Gem(this, types[2], 2, 1),
      Gem(this, types[2], 2, 2),
      // 3
      Gem(this, types[3], 3, 0),
      Gem(this, types[3], 3, 1),
      Gem(this, types[3], 3, 2),
    ];
    _table.addMany(gems);
    log('$_table');
  }

  Future<void> onLoad() async {
    _table.forEach((Gem gem) => addChild(gem));
  }

  bool inside(double x, double y) => x >= 0 && x <= size.x && y >= 0 && y <= size.y;
  int getColumn(double x) => x ~/ gemSize;
  int getRow(double y) => y ~/ gemSize;

  bool select(Gem gem) {
    // assert(gem != null);
    // if (gem != null) {
    //   if (_selectedGems.isEmpty) {
    //     gem._active = true;
    //     _selectedGems.add(gem);
    //     return true;
    //   } else {
    //     if (_selectedGems.last.type == gem.type && _selectedGems.last.isNeighbour(gem)) {
    //       if (_selectedGems.length > 1) {
    //         final lastButOne = _selectedGems[_selectedGems.length - 1 - 1];
    //         if (lastButOne._active && lastButOne == gem) {
    //           unselect(_selectedGems.last);
    //           return false;
    //         }
    //       }
    //       gem._active = true;
    //       _selectedGems.add(gem);
    //       return true;
    //     }
    //   }
    // }
    return false;
  }

  bool unselect(Gem gem) {
    // assert(gem != null);
    // if (gem != null) {
    //   assert(_selectedGems.contains(gem));
    //   if (gem._active && _selectedGems.contains(gem)) {
    //     gem._active = false;
    //     _selectedGems.remove(gem);
    //     return true;
    //   }
    // }
    return false;
  }

  void onDragStart(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      _currentColumn = getColumn(dx);
      _currentRow = getRow(dy);
      final Gem gem = _table.get(_currentColumn, _currentRow);
      if (gem.isInside(dx, dy)) {
        select(gem);
      }
    }
  }

  void onDragUpdate(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      final int newColumn = getColumn(dx);
      final int newRow = getRow(dy);
      final Gem gem = _table.get(newColumn, newRow);
      if (gem.isInside(dx, dy)) {
        if (_currentColumn != newColumn || _currentRow != newRow) {
          if (select(gem)) {
            _currentColumn = newColumn;
            _currentRow = newRow;
          }
        }
      }
    }
  }

  void onDragEnd(double x, double y) {
    _selectedGems.unselectAndClear();
    _currentColumn = -1;
    _currentRow = -1;
  }

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(size.toRect(), Paints.white);
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

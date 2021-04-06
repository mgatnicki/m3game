import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:m3game/objects/gem.dart';
import 'package:m3game/utils/colors.dart';

import 'dart:math' as math;

class Board extends PositionComponent {
  List<List<Gem>> _gems;
  int _currentColumn;
  int _currentRow;
  List<Gem> _selectedGems;

  final int columns;
  final int rows;
  final double gemSize;

  Board(double x, double y, this.columns, this.rows, this.gemSize)
      : super(size: Vector2(columns * gemSize, rows * gemSize)) {
    position.setValues(x, y);
    _gems = List.generate(columns, (_) => List(rows), growable: false);
    _selectedGems = [];
  }

  Future<void> onLoad() async {
    Gem gem;
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        gem = Gem(this, Gem.randomType, i, j);
        set(i, j, gem);
        addChild(gem);
      }
    }
  }

  Gem get(int x, int y) => _gems[x][y];
  bool inside(double x, double y) => x >= 0 && x <= size.x && y >= 0 && y <= size.y;
  int getColumn(double x) => x ~/ gemSize;
  int getRow(double y) => y ~/ gemSize;

  bool select(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      if (_selectedGems.isEmpty) {
        gem.active = true;
        _selectedGems.add(gem);
        return true;
      } else {
        if (_selectedGems.last.type == gem.type && _selectedGems.last.isNeighbour(gem)) {
          if (_selectedGems.length > 1) {
            final lastButOne = _selectedGems[_selectedGems.length - 1 - 1];
            if (lastButOne.active && lastButOne == gem) {
              unselect(_selectedGems.last);
              return false;
            }
          }
          gem.active = true;
          _selectedGems.add(gem);
          return true;
        }
      }
    }
    return false;
  }

  bool unselect(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      assert(_selectedGems.contains(gem));
      if (gem.active && _selectedGems.contains(gem)) {
        gem.active = false;
        _selectedGems.remove(gem);
        return true;
      }
    }
    return false;
  }

  void set(int x, int y, Gem item) => _gems[x][y] = item;

  void clear(int x, int y) => _gems[x][y] = null;

  void onDragStart(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      _currentColumn = getColumn(dx);
      _currentRow = getRow(dy);
      final Gem gem = get(_currentColumn, _currentRow);
      log(gem.isInside(dx, dy).toString());
      select(gem);
    }
  }

  void onDragUpdate(double x, double y) {
    final double dx = x - this.x;
    final double dy = y - this.y;
    if (inside(dx, dy)) {
      final int newColumn = getColumn(dx);
      final int newRow = getRow(dy);
      if (_currentColumn != newColumn || _currentRow != newRow) {
        select(get(newColumn, newRow));
        _currentColumn = newColumn;
        _currentRow = newRow;
      }
    }
  }

  void onDragEnd(double x, double y) {
    _selectedGems.forEach((Gem gem) => gem.active = false);
    _selectedGems.clear();
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
        b.write(get(i, j).position);
        b.write('\t\t');
      }
      b.writeln();
    }
    return b.toString();
  }
}

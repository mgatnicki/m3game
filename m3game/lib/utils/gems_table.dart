import 'dart:developer';

import 'package:m3game/objects/gem.dart';

class GemsTable {
  List<Gem> _gems;
  int _length;

  final int columns;
  final int rows;

  GemsTable(this.columns, this.rows) {
    _length = columns * rows;
    _gems = [];
    for (int i = 0; i < _length; i++) {
      _gems.add(null);
    }
  }

  void _insert(Gem gem) => _gems[gem.column + columns * gem.row] = gem;

  void addMany(List<Gem> gems) {
    final bool isGems = gems != null && gems.isNotEmpty && gems.every((Gem g) => g != null);
    if (isGems) {
      for (int n = 0; n < gems.length; n++) {
        _insert(gems[n]);
      }
    }
  }

  void add(Gem gem) {
    final bool isGem = gem != null;
    final bool isGems = _gems != null && _gems.isNotEmpty;
    assert(isGem);
    assert(isGems);
    if (isGem && isGems) {
      _insert(gem);
    }
  }

  void forEach(void f(Gem element)) {
    for (Gem gem in _gems) {
      if (gem != null) {
        f(gem);
      }
    }
  }

  Gem get(int column, int row) => _gems[column + columns * row];

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < columns; i++) {
        sb.write(_gems[i + columns * j]);
        if (i < columns - 1) {
          sb.write(', ');
        }
      }
      sb.writeln();
    }
    return sb.toString();
  }
}

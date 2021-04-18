import 'package:m3game/objects/gem.dart';
import 'package:m3game/utils/gem_stack.dart';

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

  Gem get(int column, int row) => _gems[column + columns * row];

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

  void remove(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      final int index = _gems.indexOf(gem);
      assert(index != -1);
      if (index != -1) {
        _gems.insert(index, null);
      }
    }
  }

  void forEach(void f(Gem element)) {
    for (Gem gem in _gems) {
      if (gem != null) {
        f(gem);
      }
    }
  }

  // void collect(GemStack gems) {
  //   assert(gems != null);
  //   if (gems != null) {
  //     final Iterator<Gem> it = gems.iterator;
  //     while (it.moveNext()) {
  //       it.current.unselect();
  //       assert(_gems.contains(it.current));
  //       if (_gems.contains(it.current)) {
  //         _gems.remove(it.current);
  //       }
  //     }
  //   }
  // }

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

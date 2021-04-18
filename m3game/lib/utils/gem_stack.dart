import 'dart:developer';

import 'package:m3game/objects/gem.dart';

class GemStack {
  List<Gem> _gems;

  int get length => _gems.length;
  bool get any => _gems.isNotEmpty;
  Iterator<Gem> get iterator => _gems.iterator;
  bool get collectable => length >= 3;

  GemStack() {
    _gems = [];
  }

  void push(Gem gem) {
    assert(gem != null);
    if (gem != null) {
      _gems.add(gem);
    }
  }

  Gem pop() {
    Gem gem;
    if (_gems.isNotEmpty) {
      gem = _gems.removeLast();
    }
    return gem;
  }

  void remove(Gem gem) {
    assert(gem != null);
    if (gem != null && _gems.contains(gem)) {
      _gems.remove(gem);
    }
  }

  Gem peek() {
    Gem gem;
    if (_gems.isNotEmpty) {
      gem = _gems.last;
    }
    return gem;
  }

  Gem peekBeforeLast() {
    Gem gem;
    if (length > 1) {
      return _gems.elementAt(_gems.length - 2);
    }
    return gem;
  }

  void unselectAndClear() {
    final Iterator<Gem> it = _gems.iterator;
    while (it.moveNext()) {
      it.current.unselect();
    }
    clear();
  }

  void clear() => _gems.clear();

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    sb.write('($length) ');
    for (int i = _gems.length - 1; i >= 0; i--) {
      sb.write('${_gems[i].type}[${_gems[i].column},${_gems[i].row}]');
      if (i > 1) {
        sb.write(', ');
      }
    }
    return sb.toString();
  }
}

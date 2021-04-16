import 'package:m3game/objects/gem.dart';

class GemStack {
  List<Gem> _gems;

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

  Gem peek() {
    Gem gem;
    if (_gems.isNotEmpty) {
      gem = _gems.last;
    }
    return gem;
  }

  void unselectAndClear() {
    final Iterator<Gem> it = _gems.iterator;
    while (it.moveNext()) {
      it.current.unselect();
    }
    _gems.clear();
  }
}

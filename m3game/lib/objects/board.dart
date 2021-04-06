import 'dart:developer';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:m3game/objects/gem.dart';
import 'package:m3game/utils/colors.dart';

class Board extends PositionComponent {
  List<List<Gem>> _gems;

  final int columns;
  final int rows;
  final double gemSize;

  Board(double x, double y, this.columns, this.rows, this.gemSize) {
    position.setValues(x, y);
    size.setValues(columns * gemSize, rows * gemSize);
    _gems = List.generate(columns, (_) => List(rows), growable: false);
  }

  Gem get(int x, int y) => _gems[x][y];
  void set(int x, int y, Gem item) => _gems[x][y] = item;
  void clear(int x, int y) => _gems[x][y] = null;

  void forEach(Function(Gem) f) {
    final Iterator it = _gems.iterator;
    while (it.moveNext()) {
      f.call(it.current);
    }
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

  @override
  void render(Canvas c) {
    super.render(c);
    c.drawRect(size.toRect(), Paints.white);
  }

  void onDragStart(double x, double y) {
    if (inside(x, y)) {
      log('[$x,$y] inside(${inside(x, y)})');
      // log(this.toString());
    }
  }

  void onDragUpdate(double x, double y) {
    if (inside(x, y)) {
      log('[$x,$y] inside(${inside(x, y)})');
    }
  }

  void onDragEnd(double x, double y) {
    if (inside(x, y)) {
      log('[$x,$y] inside(${inside(x, y)})');
    }
  }

  bool inside(double x, double y) =>
      x >= this.x && x <= this.x + size.x && y >= this.y && y <= this.y + size.y;

  // int getColumn(double x) =>

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

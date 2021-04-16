import 'dart:ui';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Paints {
  static Paint white = BasicPalette.white.paint();
  static Paint black = BasicPalette.black.paint();

  static Paint red = BasicPalette.red.paint();
  static Paint green = BasicPalette.green.paint();
  static Paint blue = BasicPalette.blue.paint();
  static Paint magenta = BasicPalette.magenta.paint();

  static Paint cyan = PaletteEntry(Colors.cyan).paint();
}

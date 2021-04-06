import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:m3game/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util util = Util();
  Size size = await util.initialDimensions();
  util.fullScreen();
  util.setPortraitUpOnly();
  GameController game = GameController(size);
  runApp(game.widget);
}

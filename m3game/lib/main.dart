import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:m3game/controller.dart';

void main() {
  runApp(GameWidget(game: Controller())

      // Scaffold(
      //   appBar: AppBar(),
      //   body: GameWidget(
      //     game: Controller(),
      //   ),
      // ),
      // MaterialApp(home: Core()),
      );
}

class Core extends StatelessWidget {
  const Core({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: GameWidget(
          game: Controller(),
        ),
      ),
    );
  }
}

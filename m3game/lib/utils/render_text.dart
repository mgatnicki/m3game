import 'package:flutter/material.dart';

void renderText(
  Canvas c,
  String text, {
  Offset offset = Offset.zero,
  double textWidthRatio = 0.0,
  double textHeightRatio = 0.0,
  Color color = Colors.black,
  double size = 12,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  textPainter.paint(
    c,
    offset - Offset(textWidthRatio * textPainter.width, textHeightRatio * textPainter.height),
  );
}

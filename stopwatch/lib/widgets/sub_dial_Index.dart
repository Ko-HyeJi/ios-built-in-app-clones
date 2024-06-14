import 'dart:math';

import 'package:flutter/material.dart';

class SubDialIndex extends StatelessWidget {
  const SubDialIndex({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SubDialIndexPainter(radius: radius),
    );
  }
}

class SubDialIndexPainter extends CustomPainter {
  SubDialIndexPainter({
    required this.radius,
  });

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    const double radiantStep = pi / 6 * 2;
    for (var i = 0; i < 6; i++) {
      final offset =
          Offset(sin(-i * radiantStep) * radius, cos(-i * radiantStep) * radius);
      _drawText(
        canvas: canvas,
        offset: offset,
        text: (i < 4 ? (i * 5 + 15) : i * 5 - 15).toString(),
        fontSize: radius * 0.4,
      );
    }
  }

  void _drawText({
    required Canvas canvas,
    required Offset offset,
    required String text,
    required double fontSize,
  }) {
    final textSpan = TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ));

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final xCenter = (offset.dx - textPainter.width / 2);
    final yCenter = (offset.dy - textPainter.height / 2);

    textPainter.paint(canvas, Offset(xCenter, yCenter));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class DialIndex extends StatelessWidget {
  const DialIndex({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DialIndexPainter(radius: radius),
    );
  }
}

class DialIndexPainter extends CustomPainter {
  DialIndexPainter({
    required this.radius,
  });

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    const double radiantStep = pi / 12 * 2;
    for (var i = 0; i < 12; i++) {
      final offset =
          Offset(sin(-i * radiantStep) * radius, cos(-i * radiantStep) * radius);
      _drawText(
        canvas: canvas,
        offset: offset,
        text: (i < 7 ? i * 5 + 30 : i * 5 - 30).toString(),
        fontSize: radius * 0.18,
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
          fontWeight: FontWeight.w500,
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

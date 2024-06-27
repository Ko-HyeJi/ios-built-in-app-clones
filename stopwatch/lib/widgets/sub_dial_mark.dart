import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch/assets/custom_colors.dart';

class SubDialMark extends StatelessWidget {
  const SubDialMark({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SubDialMarkPainter(radius: radius),
    );
  }
}

class SubDialMarkPainter extends CustomPainter {
  SubDialMarkPainter({
    required this.radius,
  });

  final double radius;
  double lineLength = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..strokeWidth = radius * 0.03;

    const double radiantStep = pi / 60 * 2;
    for (int i = 0; i < 60; i++) {
      if (i % 2 == 0) {
        lineLength = radius * 0.18;
      } else {
        lineLength = radius * 0.1;
      }

      if (i % 10 == 0) {
        paint.color = CustomColors.white;
      } else {
        paint.color = CustomColors.dialMarkGrey;
      }

      canvas.drawLine(
        Offset(sin(i * radiantStep) * radius, cos(i * radiantStep) * radius),
        Offset(sin(i * radiantStep) * (radius - lineLength),
            cos(i * radiantStep) * (radius - lineLength)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

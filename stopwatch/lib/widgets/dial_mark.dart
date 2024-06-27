import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch/assets/custom_colors.dart';

class DialMark extends StatelessWidget {
  const DialMark({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DialMarkPainter(radius: radius),
    );
  }
}

class DialMarkPainter extends CustomPainter {
  DialMarkPainter({
    required this.radius,
  });

  final double radius;
  double lineLength = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..strokeWidth = radius * 0.012;

    const double radiantStep = pi / 240 * 2;
    for (int i = 0; i < 240; i++) {
      if (i % 4 == 0) {
        lineLength = radius * 0.08;
      } else {
        lineLength = radius * 0.05;
      }

      if (i % 20 == 0) {
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
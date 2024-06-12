import 'dart:math';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class OuterCircle extends StatelessWidget {
  const OuterCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: DottedCirclePainter(radius: 128),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  const DottedCirclePainter({
    required this.radius,
  });

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = CustomColors.white
      ..blendMode = CustomColors.blendMode;

    const double radiantStep = pi / 180 * 2;
    for (int i = 0; i < 180; i++) {
      if (i % 15 == 0) {
        paint.strokeWidth = 2.5;
      } else {
        paint.strokeWidth = 1.0;
      }

      canvas.drawLine(
        Offset(sin(i * radiantStep) * radius, cos(i * radiantStep) * radius),
        Offset(sin(i * radiantStep) * (radius - 18),
            cos(i * radiantStep) * (radius - 18)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.red
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return false;
  }
}

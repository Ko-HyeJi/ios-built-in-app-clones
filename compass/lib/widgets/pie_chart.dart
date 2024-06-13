import 'dart:math';
import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Movement extends StatelessWidget {
  const Movement({
    super.key,
    required this.moving,
  });

  final double moving;

  @override
  Widget build(BuildContext context) {
    return Rotation(
      rotationAngle: moving > 0 ? -180 - moving : -180,
      child: Container(
        color: Colors.yellow,
        child: CustomPaint(
          painter: MovementPainter(
            radius: 109,
            moving: moving,
            lineLength: 35,
          ),
        ),
      ),
    );
  }
}

class MovementPainter extends CustomPainter {
  const MovementPainter({
    required this.radius,
    required this.moving,
    required this.lineLength,
  });

  final double radius;
  final double moving;
  final double lineLength;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = CustomColors.red
      ..strokeWidth = 2.0;

    const double radiantStep = pi / 360 * 2;
    for (int i = 0; i < moving.abs(); i++) {
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

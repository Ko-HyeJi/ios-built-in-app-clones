import 'package:flutter/material.dart';

class SecondHand extends StatelessWidget {
  const SecondHand({
    super.key,
    required this.radius,
    required this.color,
    required this.seconds,
  });

  final double radius;
  final Color color;
  final double seconds;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(seconds / 60),
      child: CustomPaint(
        painter: SecondHandPainter(
          radius: radius,
          color: color,
        ),
      ),
    );
  }
}

class SecondHandPainter extends CustomPainter {
  SecondHandPainter({
    super.repaint,
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;
  late final circleSize = radius * 0.02;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = radius * 0.015
      ..style = PaintingStyle.stroke;

    var center = const Offset(0, 0);
    canvas.drawCircle(center, circleSize, paint);

    var p1 = Offset(0, -circleSize);
    var p2 = Offset(0, -radius);
    canvas.drawLine(p1, p2, paint);

    p1 = Offset(0, circleSize);
    p2 = Offset(0, radius * 0.2);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

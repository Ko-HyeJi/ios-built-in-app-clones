import 'package:flutter/material.dart';

class MinuteHand extends StatelessWidget {
  const MinuteHand({
    super.key,
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MinuteHandPainter(
        radius: radius,
        color: color,
      ),
    );
  }
}

class MinuteHandPainter extends CustomPainter {
  MinuteHandPainter({
    super.repaint,
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;
  late final circleSize = radius * 0.07;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = radius * 0.035
      ..style = PaintingStyle.fill;

    var center = const Offset(0, 0);
    canvas.drawCircle(center, circleSize, paint);

    var p1 = Offset(0, -circleSize);
    var p2 = Offset(0, -radius);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

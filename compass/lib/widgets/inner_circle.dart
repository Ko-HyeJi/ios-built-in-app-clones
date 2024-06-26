import 'package:compass/widgets/cross.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class InnerCircle extends StatelessWidget {
  const InnerCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: CirclePainter(radius: 45),
        ),
        CustomPaint(
          size: Size(20, 20),
          painter: CrossPainter(strokeWidth: 0.8),
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  const CirclePainter({
    required this.radius,
  });

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = CustomColors.grey;

    Offset center = const Offset(0, 0);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

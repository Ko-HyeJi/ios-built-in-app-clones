import 'package:compass/main.dart';
import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class StartPoint extends StatelessWidget {
  const StartPoint({
    super.key,
    required this.moving,
    required this.startingPoint,
  });

  final int moving;
  final int startingPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Rotation(
          rotationAngle: -moving,
          child: Text(
            startingPoint.toInt().toString(),
            style: const TextStyle(
                color: CustomColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        CustomPaint(
          size: const Size(46, 46),
          painter: BarPainter(),
        )
      ],
    );
  }
}

class BarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.white
      ..strokeWidth = 2.5;

    Offset p1 = Offset(size.width / 2, 0);
    Offset p2 = Offset(size.width / 2, size.height);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

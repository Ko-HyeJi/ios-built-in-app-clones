import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Movement extends StatelessWidget {
  const Movement({
    super.key,
    required this.moving,
  });

  final int moving;

  @override
  Widget build(BuildContext context) {
    return Rotation(
      rotationAngle: moving < 0 ? moving : 0,
      child: Stack(
        children: [
          for (var i = 0; i < moving.abs(); i++)
            Rotation(
              rotationAngle: i,
              child: CustomPaint(
                size: const Size(155, 155),
                painter: MovementPainter(),
              ),
            ),
        ],
      ),
    );
  }
}

class MovementPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.red
      ..strokeWidth = 2.0;

    Offset p1 = Offset(size.width - 25, size.height - 25);
    Offset p2 = Offset(size.width, size.height);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

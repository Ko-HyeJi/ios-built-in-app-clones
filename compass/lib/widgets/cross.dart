import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class CrossPainter extends CustomPainter {
  const CrossPainter({required this.strokeWidth});

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.grey2
      ..strokeWidth = strokeWidth;

    Offset p1 = Offset(size.width / 2, 0);
    Offset p2 = Offset(size.width / 2, size.height);
    canvas.drawLine(p1, p2, paint);

    p1 = Offset(0, size.height / 2);
    p2 = Offset(size.width, size.height / 2);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

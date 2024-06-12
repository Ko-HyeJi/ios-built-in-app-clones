import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Stick extends StatelessWidget {
  const Stick({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3.5,
      height: 60,
      color: CustomColors.white,
    );
  }
}

class StickPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // const lineLength = 35;

    Paint paint = Paint()
      ..color = CustomColors.white
      ..strokeWidth = 4
      ..blendMode = CustomColors.blendMode;

    Offset p1 = Offset(size.width + 22, size.height + 22);
    Offset p2 = Offset(size.width - 22, size.height - 22);

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

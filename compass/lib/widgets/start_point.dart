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

        // TODO: CustomPainter로 변경
        Container(
          width: 2.5,
          height: 43,
          color: CustomColors.white,
        ),
      ],
    );
  }
}

class BarPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
  
}
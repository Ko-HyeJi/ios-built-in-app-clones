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
        // const SizedBox(
        //   height: 5,
        // ),
        Container(
          width: 2.5,
          height: 43,
          color: CustomColors.white,
        ),
      ],
    );
  }
}

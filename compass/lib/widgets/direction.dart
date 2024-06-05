import 'package:compass/color+.dart';
import 'package:flutter/material.dart';

class Direction extends StatelessWidget {
  const Direction({
    super.key,
    required this.rotationAngle,
  });

  final double rotationAngle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 210,
          height: 210,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: const Text(
                  '북',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: const Text(
                  '남',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 210,
          height: 210,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: const Text(
                  '서',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: const Text(
                  '동',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:compass/color+.dart';
import 'package:flutter/material.dart';
import 'package:compass/main.dart';

class Direction extends StatelessWidget {
  const Direction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        SizedBox(
          width: 210,
          height: 210,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: Text(
                  '북',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: Text(
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
                child: Text(
                  '서',
                  style: TextStyle(fontSize: 27, color: CustomColors.white),
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(-rotationAngle / 360),
                child: Text(
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

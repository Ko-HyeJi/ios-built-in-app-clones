import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';

import '../color+.dart';

class StartPoint extends StatelessWidget {
  const StartPoint({
    super.key,
    required this.moving,
    required this.startPoint,
  });

  final int moving;
  final int startPoint;

  @override
  Widget build(BuildContext context) {
    return Rotation(
      rotationAngle: (moving),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 57),
        child: Column(
          children: [
            RotationTransition(
              turns: AlwaysStoppedAnimation(moving / 360),
              child: Text(
                startPoint.toInt().toString(),
                style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 5,
              height: 40,
              color: CustomColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

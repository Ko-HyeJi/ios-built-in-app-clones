import 'package:compass/color+.dart';
import 'package:flutter/material.dart';

class Angle extends StatelessWidget {
  const Angle({
    super.key,
    required this.rotationAngle,
  });

  final int rotationAngle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 6; i++)
          SizedBox(
            height: 350,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(i * 30 / 360),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RotationTransition(
                      turns: AlwaysStoppedAnimation(
                          -30 * (i + ((360 - rotationAngle) / 30)) / 360),
                      child: Text(
                        '${i * 30}',
                        style: const TextStyle(
                          color: CustomColors.grey2,
                          fontSize: 16,
                        ),
                      )),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(
                        -30 * (i + ((360 - rotationAngle) / 30)) / 360),
                    child: Text(
                      '${i * 30 + 180}',
                      style: const TextStyle(
                        color: CustomColors.grey2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

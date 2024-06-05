import 'package:flutter/material.dart';
import 'package:compass/main.dart';

class Angle extends StatelessWidget {
  const Angle({super.key});

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
                          -30 * (i + (rotationAngle / 30)) / 360),
                      child: Text(
                        '${i * 30}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      )),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(
                        -30 * (i + (rotationAngle / 30)) / 360),
                    child: Text(
                      '${i * 30 + 180}',
                      style: const TextStyle(
                        color: Colors.white70,
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

import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Direction extends StatelessWidget {
  const Direction({
    super.key,
    required this.rotationAngle,
  });

  final int rotationAngle;
  static const _fontSize = 27.0;
  static const _fontColor = CustomColors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 215,
          height: 215,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(360 + rotationAngle / 360),
                child: const Text(
                  '북',
                  style: TextStyle(fontSize: _fontSize, color: _fontColor),
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(360 + rotationAngle / 360),
                child: const Text(
                  '남',
                  style: TextStyle(fontSize: _fontSize, color: _fontColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 215,
          height: 215,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotationTransition(
                  turns: AlwaysStoppedAnimation(360 + rotationAngle / 360),
                  child: const Text(
                    '서',
                    style: TextStyle(fontSize: _fontSize, color: _fontColor),
                  ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(360 + rotationAngle / 360),
                  child: const Text(
                    '동',
                    style: TextStyle(fontSize: _fontSize, color: _fontColor),
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

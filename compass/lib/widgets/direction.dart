import 'package:compass/widgets/rotation.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Direction extends StatelessWidget {
  const Direction({
    super.key,
    required this.rotationAngle,
  });

  final double rotationAngle;
  static const _size = 215.0;
  static const _fontSize = 27.0;
  static const _fontColor = CustomColors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: _size,
          height: _size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Rotation(
                rotationAngle: -rotationAngle,
                child: const Text(
                  '북',
                  style: TextStyle(fontSize: _fontSize, color: _fontColor),
                ),
              ),
              Rotation(
                rotationAngle: -rotationAngle,
                child: const Text(
                  '남',
                  style: TextStyle(fontSize: _fontSize, color: _fontColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: _size,
          height: _size,
          child: Rotation(
            rotationAngle: -90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Rotation(
                  rotationAngle: -rotationAngle + 90,
                  child: const Text(
                    '동',
                    style: TextStyle(fontSize: _fontSize, color: _fontColor),
                  ),
                ),
                Rotation(
                  rotationAngle: -rotationAngle + 90,
                  child: const Text(
                    '서',
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

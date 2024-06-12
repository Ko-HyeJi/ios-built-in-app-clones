import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Angle extends StatelessWidget {
  const Angle({
    super.key,
    required this.rotationAngle,
    required this.showPieChart,
    required this.startingPoint,
  });

  final double rotationAngle;
  final bool showPieChart;
  final int startingPoint;
  static const _fontColor = CustomColors.white;
  static const _fontSize = 15.0;
  static const _fontWeight = FontWeight.w500;

  double _calculateOpacity(int num) {
    if (showPieChart) {
      if ((num - startingPoint).abs() < 12) {
        return 0;
      } else if (num == 0 && startingPoint > 348) {
        return 0;
      }
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 6; i++)
          SizedBox(
            height: 345,
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
                        style: TextStyle(
                          color: _fontColor.withOpacity(showPieChart ? 0.7 : 1.0),
                          fontSize: _fontSize,
                          fontWeight: _fontWeight,
                        ),
                      )),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(
                        -30 * (i + ((360 - rotationAngle) / 30)) / 360),
                    child: Text(
                      '${i * 30 + 180}',
                      style: TextStyle(
                        color: _fontColor.withOpacity(showPieChart ? 0.7 : 1.0),
                        fontSize: _fontSize,
                        fontWeight: _fontWeight,
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

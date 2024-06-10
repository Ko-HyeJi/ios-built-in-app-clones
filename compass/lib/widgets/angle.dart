import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Angle extends StatelessWidget {
  const Angle({
    super.key,
    required this.rotationAngle,
    required this.showPieChart,
  });

  final int rotationAngle;
  final bool showPieChart;
  static const _fontColor1 = CustomColors.white;
  static const _fontColor2 = CustomColors.grey2;
  static const _fontSize = 15.0;
  static const _fontWeight = FontWeight.w500;

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
                          color: showPieChart ? _fontColor2 : _fontColor1,
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
                        color: showPieChart ? _fontColor2 : _fontColor1,
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

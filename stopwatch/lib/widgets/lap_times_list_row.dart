import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/models/lap.model.dart';

class LapTimesListRow extends StatelessWidget {
  const LapTimesListRow({
    super.key,
    required this.lap,
    required this.index,
  });

  final Lap lap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랩 ${lap.times.length - index}',
          style: TextStyle(
            color: index == lap.minIndex
                ? CustomColors.textGreen
                : index == lap.maxIndex
                ? CustomColors.textRed
                : CustomColors.white,
            fontSize: 18,
          ),
        ),
        Text(
          formatTime(lap.times[index]),
          style: TextStyle(
            color: index == lap.minIndex
                ? CustomColors.textGreen
                : index == lap.maxIndex
                ? CustomColors.textRed
                : CustomColors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

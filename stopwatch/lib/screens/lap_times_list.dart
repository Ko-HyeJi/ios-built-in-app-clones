import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/models/lap.model.dart';
import 'package:stopwatch/widgets/custom_divider.dart';
import 'package:stopwatch/widgets/lap_times_list_row.dart';

class LapTimesList extends StatelessWidget {
  const LapTimesList({
    super.key,
    required this.lap,
    required this.stopwatch,
  });

  final Lap lap;
  final Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomDivider(),
          if (stopwatch.elapsed.inMilliseconds > 0)
            Column(
              children: [
                LapTimesListRow(
                  index: lap.times.length,
                  time: formattedTime(showSlowly(stopwatch.elapsed.inMilliseconds)),
                  color: CustomColors.white,
                ),
                const CustomDivider(),
              ],
            ),
          if (lap.times.isNotEmpty)
            for (var i = lap.times.length - 1; i >= 0; i--)
              Column(
                children: [
                  LapTimesListRow(
                    index: i,
                    time: formattedTime(lap.times[i]),
                    color: (lap.times.length >= 2 && i == lap.minIndex)
                        ? CustomColors.textGreen
                        : (lap.times.length >= 2 && i == lap.maxIndex)
                            ? CustomColors.textRed
                            : CustomColors.white,
                  ),
                  const CustomDivider(),
                ],
              ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/services/stopwatch.service.dart';
import 'package:stopwatch/widgets/custom_divider.dart';
import 'package:stopwatch/widgets/lap_times_list_row.dart';

class LapTimesList extends StatelessWidget {
  final StopwatchService _stopwatch = StopwatchService();

  LapTimesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomDivider(),
          if (!_stopwatch.isReset)
            Column(
              children: [
                StreamBuilder<int>(
                  stream: _stopwatch.elapsedTimeStream,
                  builder: (context, snapshot) {
                    return LapTimesListRow(
                      index: _stopwatch.lapRecord.times.length,
                      time: formattedTime(
                          showSlowly(snapshot.data ?? 0)),
                      color: CustomColors.white,
                    );
                  }
                ),
                const CustomDivider(),
              ],
            ),
          if (_stopwatch.lapRecord.times.isNotEmpty)
            for (var i = _stopwatch.lapRecord.times.length - 1; i >= 0; i--)
              Column(
                children: [
                  LapTimesListRow(
                    index: i,
                    time: formattedTime(_stopwatch.lapRecord.times[i]),
                    color: (_stopwatch.lapRecord.times.length >= 2 && i == _stopwatch.lapRecord.minIndex)
                        ? CustomColors.textGreen
                        : (_stopwatch.lapRecord.times.length >= 2 && i == _stopwatch.lapRecord.maxIndex)
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

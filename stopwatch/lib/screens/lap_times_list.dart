import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/models/lap.model.dart';
import 'package:stopwatch/widgets/lap_times_list_row.dart';

class LapTimesList extends StatelessWidget {
  const LapTimesList({
    super.key,
    required this.lap,
  });

  final Lap lap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(0, -deviceWidth * 0.04),
          child: const Divider(
            thickness: 0.2,
            color: Colors.white30,
          ),
        ),
    ListView.separated(
    padding: EdgeInsets.zero,
    itemCount: lap.times.length,
    itemBuilder: (context, index) {
    return Padding(
    padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.001),
              child: LapTimesListRow(lap: lap, index: index,),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.2,
              color: Colors.white30,
            );
          },
        ),
      ],
    );
  }
}

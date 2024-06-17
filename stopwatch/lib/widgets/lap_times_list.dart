import 'package:flutter/material.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/models/lap.model.dart';

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
            thickness: 0.5,
            color: Colors.white30,
          ),
        ),
        ListView.separated(
          reverse: true,
          padding: EdgeInsets.zero,
          itemCount: lap.lapTimes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.001),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '랩 ${index + 1}',
                    style: TextStyle(
                      color: index == lap.minIndex
                          ? Colors.green
                          : index == lap.maxIndex
                              ? Colors.red
                              : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    lap.lapTimes[index],
                    style: TextStyle(
                      color: index == lap.minIndex
                          ? Colors.green
                          : index == lap.maxIndex
                              ? Colors.red
                              : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.5,
              color: Colors.white30,
            );
          },
        ),
      ],
    );
  }
}

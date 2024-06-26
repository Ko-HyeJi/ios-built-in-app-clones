import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/services/stopwatch.service.dart';
import 'package:stopwatch/widgets/second_hand.dart';
import 'package:stopwatch/widgets/sub_dial.dart';
import 'package:stopwatch/widgets/dial.dart';

class CircularStopwatch extends StatelessWidget {
  final StopwatchService _stopwatch = StopwatchService();

  CircularStopwatch({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, width * 0.2),
          child: TextStopwatch(
            width: width * 0.28,
            fontWeight: FontWeight.w500,
          ),
        ),
        StreamBuilder<int>(
            stream: _stopwatch.elapsedTimeStream,
            builder: (context, snapshot) {
              return SubDial(
                size: width * 0.3,
                minutes: (snapshot.data ?? 0) / 60000,
              );
            }),
        Dial(
          size: width,
        ),
        StreamBuilder<int>(
            stream: _stopwatch.lapTimeStream,
            builder: (context, snapshot) {
              return SecondHand(
                radius: width * 0.5,
                color: CustomColors.blue,
                seconds: (snapshot.data ?? 0) / 1000,
              );
            }),
        StreamBuilder<int>(
            stream: _stopwatch.elapsedTimeStream,
            builder: (context, snapshot) {
              return SecondHand(
                radius: width * 0.5,
                color: CustomColors.orange,
                seconds: (snapshot.data ?? 0) / 1000,
              );
            }),
      ],
    );
  }
}

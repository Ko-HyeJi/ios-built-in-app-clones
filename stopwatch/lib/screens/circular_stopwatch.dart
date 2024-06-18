import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/widgets/second_hand.dart';
import 'package:stopwatch/widgets/sub_dial.dart';
import 'package:stopwatch/widgets/dial.dart';

class CircularStopwatch extends StatelessWidget {
  const CircularStopwatch({
    super.key,
    required this.elapsedTime,
  });

  final Duration elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, deviceWidth * 0.18),
          child: TextStopwatch(
            width: deviceWidth * 0.25,
            fontWeight: FontWeight.w500,
            elapsedTime: elapsedTime,
          ),
        ),
        SubDial(
          size: deviceWidth * 0.27,
        ),
        Dial(
          size: deviceWidth * 0.9,
        ),
        SecondHand(
          radius: deviceWidth * 0.9 * 0.5,
          color: CustomColors.blue,
          seconds: 25.0,
        ),
        SecondHand(
          radius: deviceWidth * 0.9 * 0.5,
          color: CustomColors.orange,
          seconds: elapsedTime.inMilliseconds / 1000,
        ),
      ],
    );
  }
}

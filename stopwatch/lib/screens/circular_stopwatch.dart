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
    required this.lapElapsedTime,
  });

  final int elapsedTime;
  final int lapElapsedTime;

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
            elapsedTime: showSlowly(elapsedTime),
          ),
        ),
        SubDial(
          size: deviceWidth * 0.27,
          minutes: elapsedTime / 60000,
        ),
        Dial(
          size: deviceWidth * 0.9,
        ),
        SecondHand(
          radius: deviceWidth * 0.9 * 0.5,
          color: CustomColors.blue,
          seconds: lapElapsedTime / 1000,
        ),
        SecondHand(
          radius: deviceWidth * 0.9 * 0.5,
          color: CustomColors.orange,
          seconds: elapsedTime / 1000,
        ),
      ],
    );
  }
}

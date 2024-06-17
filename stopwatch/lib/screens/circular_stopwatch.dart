import 'package:flutter/material.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/widgets/second_hand.dart';
import 'package:stopwatch/widgets/sub_dial.dart';
import 'package:stopwatch/widgets/dial.dart';

class CircularStopwatch extends StatelessWidget {
  const CircularStopwatch({
    super.key,
  });

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
            min: 30,
            sec: 55,
            msec: 27,
          ),
        ),
        SecondHand(
          radius: deviceWidth * 0.9 * 0.5,
          color: Colors.blueAccent,
          seconds: 25.0,
        ),
        SubDial(
          size: deviceWidth * 0.27,
        ),
        Dial(
          size: deviceWidth * 0.9,
        ),
      ],
    );
  }
}

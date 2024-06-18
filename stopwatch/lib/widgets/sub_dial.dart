import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/widgets/minute_hand.dart';
import 'package:stopwatch/widgets/sub_dial_Index.dart';
import 'package:stopwatch/widgets/sub_dial_mark.dart';

class SubDial extends StatelessWidget {
  const SubDial({
    super.key,
    required this.size,
    required this.minutes,
  });

  final double size;
  final double minutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SubDialMark(radius: size * 0.5),
            SubDialIndex(radius: size * 0.3),
            MinuteHand(
              radius: size * 0.5,
              color: CustomColors.orange,
              minutes: minutes,
            ),
          ],
        ),
        SizedBox(
          height: size * 1.2,
        ),
      ],
    );
  }
}

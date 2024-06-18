import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';

class TextStopwatch extends StatelessWidget {
  const TextStopwatch({
    super.key,
    required this.width,
    required this.fontWeight,
    required this.elapsedTime,
  });

  final double width;
  final FontWeight fontWeight;
  final Duration elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        formatTime(elapsedTime.inMilliseconds),
        style: TextStyle(
          color: CustomColors.white,
          fontSize: width * 0.23,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

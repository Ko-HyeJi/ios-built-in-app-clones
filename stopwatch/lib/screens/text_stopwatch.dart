import 'package:flutter/material.dart';
import 'package:stopwatch/assets/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/services/stopwatch.service.dart';

class TextStopwatch extends StatelessWidget {
  final StopwatchService _stopwatch = StopwatchService();

  TextStopwatch({
    super.key,
    required this.width,
    required this.fontWeight,
  });

  final double width;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopwatch.elapsedTimeStream,
      builder: (context, snapshot) {
        final elapsedTime = snapshot.data ?? 0;
        return Center(
          child: Text(
            formattedTime(showSlowly(elapsedTime)),
            style: TextStyle(
              color: CustomColors.white,
              fontSize: width * 0.23,
              fontWeight: fontWeight,
              fontFeatures: const [FontFeature.tabularFigures()], /// Monospaced Font
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class LapTimesListRow extends StatelessWidget {
  const LapTimesListRow({
    super.key,
    required this.index,
    required this.time,
    required this.color,
  });

  final int index;
  final String time;
  final Color color;
  final fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랩 ${index + 1}',
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

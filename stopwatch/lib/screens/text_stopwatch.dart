import 'package:flutter/material.dart';

class TextStopwatch extends StatelessWidget {
  const TextStopwatch({
    super.key,
    required this.width,
    required this.fontWeight,
    required this.min,
    required this.sec,
    required this.msec,
  });

  final double width;
  final FontWeight fontWeight;
  final int min;
  final int sec;
  final int msec;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '$min:$sec.$msec',
              style: TextStyle(
                color: Colors.white,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

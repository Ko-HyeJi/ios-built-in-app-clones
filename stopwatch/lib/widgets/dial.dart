import 'package:flutter/material.dart';
import 'package:stopwatch/widgets/dial_Index.dart';
import 'package:stopwatch/widgets/dial_mark.dart';
import 'package:stopwatch/widgets/second_hand.dart';

class Dial extends StatelessWidget {
  const Dial({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DialMark(radius: size * 0.5),
        DialIndex(radius: size * 0.4),
        SecondHand(
          radius: size * 0.5,
          color: Colors.orangeAccent,
          seconds: 3.0,
        ),
      ],
    );
  }
}

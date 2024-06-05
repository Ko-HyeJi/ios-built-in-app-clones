import 'package:compass/color+.dart';
import 'package:flutter/material.dart';

class Cross extends StatelessWidget {
  const Cross({
    super.key,
    required this.size,
    required this.thick,
  });

  final double size;
  final double thick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: thick,
          height: size,
          color: CustomColors.grey2,
        ),
        Container(
          width: size,
          height: thick,
          color: CustomColors.grey2,
        ),
      ],
    );
  }
}

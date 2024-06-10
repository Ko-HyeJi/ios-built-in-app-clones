import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Cross extends StatelessWidget {
  const Cross({
    super.key,
    required this.size,
    required this.thick,
  });

  final double size;
  final double thick;
  static const _color = CustomColors.grey2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: thick,
          height: size,
          color: _color,
        ),
        Container(
          width: size,
          height: thick,
          color: _color,
        ),
      ],
    );
  }
}

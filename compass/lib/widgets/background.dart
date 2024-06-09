import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: CustomColors.black,
    );
  }
}

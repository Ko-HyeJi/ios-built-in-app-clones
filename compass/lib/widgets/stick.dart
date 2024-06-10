import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class Stick extends StatelessWidget {
  const Stick({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3.5,
      height: 60,
      color: CustomColors.white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:compass/main.dart';

import '../color+.dart';

class LargeText extends StatelessWidget {
  const LargeText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.w200,
        color: CustomColors.white,
      ),
    );
  }
}

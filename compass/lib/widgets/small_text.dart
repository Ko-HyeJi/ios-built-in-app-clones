import 'package:flutter/material.dart';
import 'package:compass/main.dart';

import '../color+.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: CustomColors.white,
      ),
    );
  }
}

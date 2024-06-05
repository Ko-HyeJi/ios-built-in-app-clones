import 'package:flutter/material.dart';
import 'package:compass/main.dart';

import '../color+.dart';

class Stick extends StatelessWidget {
  const Stick({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 5,
          height: 60,
          color: CustomColors.white,
          margin: const EdgeInsets.all(80),
        ),
      ],
    );
  }
}

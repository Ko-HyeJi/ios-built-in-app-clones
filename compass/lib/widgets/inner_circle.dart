import 'package:flutter/material.dart';
import 'package:compass/main.dart';

import '../color+.dart';

class InnerCircle extends StatelessWidget {
  const InnerCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.grey,
      ),
      margin: const EdgeInsets.all(153),
    );
  }
}

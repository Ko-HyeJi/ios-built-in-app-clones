import 'package:compass/widgets/cross.dart';
import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class InnerCircle extends StatelessWidget {
  const InnerCircle({
    super.key,
  });

  // TODO: CustomPainter로 변경
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.grey,
          ),
        ),
        const Cross(
          size: 0.8,
          thick: 20,
        ),
      ],
    );
  }
}

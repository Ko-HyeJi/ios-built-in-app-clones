import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../color+.dart';

class OuterCircle extends StatelessWidget {
  const OuterCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: DottedBorder(
            borderType: BorderType.Circle,
            strokeWidth: 20,
            color: CustomColors.white,
            dashPattern: const [1, 3.5],
            child: const ClipRRect(),
          ),
        ),
        SizedBox(
          height: 250,
          width: 250,
          child: DottedBorder(
            borderType: BorderType.Circle,
            strokeWidth: 20,
            color: CustomColors.white,
            dashPattern: const [2.5, 63],
            child: const ClipRRect(),
          ),
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(0 / 360),
          child: Transform.translate(
            offset: const Offset(
              120,
              -28,
            ),
            child: const Image(
              image: AssetImage('assets/arrowtriangle.png'),
              height: 12,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:compass/color+.dart';

class OuterCircle extends StatelessWidget {
  const OuterCircle({
    super.key,
  });

  static const _thin = [0.75, 3.85];
  static const _thick = [2.5, 61.5];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 245,
          width: 245,
          child: DottedBorder(
            borderType: BorderType.Circle,
            strokeWidth: 17.5,
            color: CustomColors.white,
            dashPattern: _thin,
            child: const ClipRRect(),
          ),
        ),
        SizedBox(
          height: 245,
          width: 245,
          child: DottedBorder(
            borderType: BorderType.Circle,
            strokeWidth: 17.5,
            color: CustomColors.white,
            dashPattern: _thick,
            child: const ClipRRect(),
          ),
        ),
        Transform.translate(
          offset: const Offset(
            118,
            -28,
          ),
          child: const Image(
            image: AssetImage('assets/arrowtriangle.png'),
            height: 12,
          ),
        ),
      ],
    );
  }
}

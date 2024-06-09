import 'package:flutter/material.dart';
import 'package:compass/color+.dart';

class LargeText extends StatelessWidget {
  const LargeText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;
  static const _fontSize = 70.0;
  static const _fontWeight = FontWeight.w200;
  static const _fontColor = CustomColors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _fontWeight,
                  color: _fontColor,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15,),
              Text(
                text2,
                style: const TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _fontWeight,
                  color: _fontColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

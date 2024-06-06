import 'package:flutter/material.dart';
import '../color+.dart';

class LargeText extends StatelessWidget {
  const LargeText({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

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
                  fontSize: 70,
                  fontWeight: FontWeight.w200,
                  color: CustomColors.white,
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
                  fontSize: 70,
                  fontWeight: FontWeight.w200,
                  color: CustomColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

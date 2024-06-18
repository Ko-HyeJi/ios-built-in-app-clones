import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/main.dart';

class PageIndication extends StatelessWidget {
  const PageIndication({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 2; i++)
          IndicatorItem(
            size: deviceWidth * 0.02,
            color: pageIndex == i ? CustomColors.white : CustomColors.grey2,
          )
      ],
    );
  }
}

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({
    super.key,
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

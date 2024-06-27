import 'package:flutter/material.dart';
import 'package:stopwatch/assets/custom_colors.dart';
import 'package:stopwatch/main.dart';

class PageIndication extends StatelessWidget {
  const PageIndication({
    super.key,
    required this.pageIndex,
    required this.itemSize,
  });

  final int pageIndex;
  final double itemSize;

  Widget _buildIndicatorItem(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 2; i++)
          _buildIndicatorItem(pageIndex == i ? CustomColors.white : CustomColors.indicatorGrey)
      ],
    );
  }
}

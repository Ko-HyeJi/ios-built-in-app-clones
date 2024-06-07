import 'package:flutter/material.dart';
import 'package:compass/main.dart';
import 'package:pie_chart/pie_chart.dart';

import '../color+.dart';

class pieChart extends StatelessWidget {
  const pieChart({
    super.key,
    required this.dataMap,
    required this.moving,
  });

  final Map<String, double> dataMap;
  final int moving;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(moving > 0 ? -moving / 360 : 0),
      child: SizedBox(
        width: 208,
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          animationDuration: const Duration(seconds: 0),
          initialAngleInDegree: -90,
          colorList: const [CustomColors.red, CustomColors.black,],
          ringStrokeWidth: 35,
          chartValuesOptions:
          const ChartValuesOptions(showChartValues: false),
          legendOptions:
          const LegendOptions(showLegends: false),
        ),
      ),
    );
  }
}

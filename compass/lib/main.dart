import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(App());
}

const int rotationAngle = 30;
const double moving = 90;

class App extends StatelessWidget {
  App({super.key});

  final dataMap = <String, double>{
    "1": moving,
    "2": 360 - moving,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Flexible(
                flex: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// background
                    Container(
                      color: Colors.black,
                    ),

                    /// stick
                    Column(
                      children: [
                        Container(
                          width: 5,
                          height: 70,
                          color: Colors.white,
                          margin: EdgeInsets.all(32),
                        ),
                      ],
                    ),

                    /// center circle
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      margin: const EdgeInsets.all(150),
                    ),

                    /// rotation layer
                    RotationTransition(
                      turns: AlwaysStoppedAnimation(rotationAngle / 360),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 270,
                            width: 270,
                            child: DottedBorder(
                              borderType: BorderType.Circle,
                              strokeWidth: 20,
                              color: Colors.grey.withOpacity(0.5),
                              dashPattern: [2, 3],
                              child: ClipRRect(),
                            ),
                          ),
                          SizedBox(
                            height: 270,
                            width: 270,
                            child: DottedBorder(
                              borderType: BorderType.Circle,
                              strokeWidth: 20,
                              color: Colors.white,
                              dashPattern: [3, 50],
                              child: ClipRRect(),
                            ),
                          ),
                          RotationTransition(
                              turns: AlwaysStoppedAnimation(
                                  -rotationAngle * 4 / 360),
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.red,
                                size: 50,
                              )),
                        ],
                      ),
                    ),

                    /// pie chart
                    SizedBox(
                      width: 225,
                      child: PieChart(
                        dataMap: dataMap,
                        chartType: ChartType.ring,
                        animationDuration: Duration(seconds: 0),
                        initialAngleInDegree: -90,
                        colorList: [Colors.red, Colors.black],
                        ringStrokeWidth: 35,
                        chartValuesOptions:
                            ChartValuesOptions(showChartValues: false),
                        legendOptions: LegendOptions(showLegends: false),
                      ),
                    ),

                    /// 동,서,남,북

                    const RotationTransition(
                      turns: AlwaysStoppedAnimation(rotationAngle / 360),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 230,
                            height: 230,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      -rotationAngle / 360),
                                  child: Text(
                                    '북',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      -rotationAngle / 360),
                                  child: Text(
                                    '남',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 230,
                            height: 230,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      -rotationAngle / 360),
                                  child: Text(
                                    '서',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      -rotationAngle / 360),
                                  child: Text(
                                    '동',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// small cross
                    Container(
                      width: 1.5,
                      height: 20,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 20,
                      height: 1.5,
                      color: Colors.grey,
                    ),

                    /// large cross
                    Container(
                      width: 0.8,
                      height: 170,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 170,
                      height: 0.8,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                    ),
                    const Text(
                      '240° 남서',
                      style: TextStyle(
                        fontSize: 75,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black,
                    ),
                    const Column(
                      children: [
                        Text(
                          '37°46\'21\"북 122°29\'32\"서',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'San Francisco, CA',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '고도 39.6m',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

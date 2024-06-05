import 'package:compass/widgets/background.dart';
import 'package:compass/widgets/direction.dart';
import 'package:compass/widgets/inner_circle.dart';
import 'package:compass/widgets/cross.dart';
import 'package:compass/widgets/angle.dart';
import 'package:compass/widgets/outer_circle.dart';
import 'package:compass/widgets/pie_chart.dart';
import 'package:compass/widgets/rotation.dart';
import 'package:compass/widgets/small_text.dart';
import 'package:compass/widgets/large_text.dart';
import 'package:compass/widgets/stick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  var showPieChart = false;
  var moving = 0.0;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  double? heading = 0;
  double startPoint = 0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
        if (widget.showPieChart) {
          widget.moving = heading!.toDouble() - startPoint;
        }
      });
    });
  }

  void onTapAction() {
    setState(() {
      if (!widget.showPieChart) {
        startPoint = heading!.toDouble();
      } else {
        startPoint = 0;
      }
      widget.showPieChart = !widget.showPieChart;
    });
  }

  String getDirection(int angle) {
    if (angle >= 338 || angle < 23) {
      return '북';
    } else if (angle >= 23 && angle < 68) {
      return '북동';
    } else if (angle >= 68 && angle < 113) {
      return '동';
    } else if (angle >= 113 && angle < 158) {
      return '남동';
    } else if (angle >= 158 && angle < 203) {
      return '남';
    } else if (angle >= 203 && angle < 248) {
      return '남서';
    } else if (angle >= 248 && angle < 293) {
      return '서';
    } else {
      return '북서';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              /// Section 1
              Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: onTapAction,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// background
                      const Background(height: double.infinity),

                      /// inner circle
                      const InnerCircle(),

                      /// small cross
                      const Cross(
                        size: 1.5,
                        thick: 20,
                      ),

                      /// large cross
                      const Cross(
                        size: 0.8,
                        thick: 150,
                      ),

                      /// display angle
                      Rotation(
                        rotationAngle: (360 - heading!.toDouble()),
                        child: Angle(
                          rotationAngle: (360 - heading!.toDouble()),
                        ),
                      ),

                      /// stick
                      const Stick(),

                      /// outer circle
                      Rotation(
                        rotationAngle: (360 - heading!.toDouble()),
                        child: const OuterCircle(),
                      ),

                      /// pie chart
                      if (widget.showPieChart)
                        pieChart(
                          dataMap: {
                            '1': widget.moving.abs(),
                            '2': 360 - widget.moving.abs(),
                          },
                          moving: widget.moving,
                        ),

                      /// direction
                      Rotation(
                        rotationAngle: (360 - heading!.toDouble()),
                        child: Direction(
                            rotationAngle: (360 - heading!.toDouble())),
                      ),
                    ],
                  ),
                ),
              ),

              /// Section 2
              Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Background(height: double.infinity),
                    LargeText(text: '${heading!.round().toString()}° ${getDirection(heading!.round())}'),
                  ],
                ),
              ),
              const Background(height: 10),

              /// Section 3
              const Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Background(height: double.infinity),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(text: '37°46\'21"북 122°29\'32"서'),
                        SmallText(text: 'San Francisco, CA'),
                        SmallText(text: '고도 39.6m'),
                      ],
                    ),
                  ],
                ),
              ),
              const Background(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

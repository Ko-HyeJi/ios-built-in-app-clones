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
import 'dart:async';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  var showPieChart = false;
  var rotationAngle = 120.0;
  var moving = 0.0;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// ========== test code ==========
  void onTapAction() {
    setState(() {
      widget.showPieChart = !widget.showPieChart;
      widget.showPieChart ? startTimer() : stopTimer();
    });
  }

  late Timer timer;

  void onTick(Timer timer) {
    if (widget.showPieChart) {
      setState(() {
        widget.moving += 1;
        widget.rotationAngle += 1;
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 30),
      onTick,
    );
  }

  void stopTimer() {
    timer.cancel();
    widget.moving = 0.0;
  }
  /// ==============================

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
                        rotationAngle: widget.rotationAngle,
                        child: Angle(
                          rotationAngle: widget.rotationAngle,
                        ),
                      ),

                      /// stick
                      const Stick(),

                      /// outer circle
                      Rotation(
                        rotationAngle: widget.rotationAngle,
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
                        rotationAngle: widget.rotationAngle,
                        child: Direction(rotationAngle: widget.rotationAngle),
                      ),
                    ],
                  ),
                ),
              ),

              /// Section 2
              const Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Background(height: double.infinity),
                    LargeText(text: '240° 남서'),
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

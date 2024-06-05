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

void main() {
  runApp(App());
}

const int rotationAngle = 120;
const double moving = -97;

class App extends StatelessWidget {
  App({super.key});

  final dataMap = <String, double>{
    "1": moving.abs(),
    "2": 360 - moving.abs(),
  };

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
                    const Rotation(child: Angle()),

                    /// stick
                    const Stick(),

                    /// outer circle
                    const Rotation(child: OuterCircle()),

                    /// pie chart
                    pieChart(dataMap: dataMap),

                    /// direction
                    const Rotation(child: Direction()),
                  ],
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

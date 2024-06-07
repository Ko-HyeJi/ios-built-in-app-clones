import 'package:compass/services/location_service.dart';
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
import 'package:compass/widgets/start_point.dart';
import 'package:compass/widgets/stick.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'models/geo_data_model.dart';

void main() {
  runApp(const CompassApp());
}

class CompassApp extends StatefulWidget {
  const CompassApp({super.key});

  @override
  State<CompassApp> createState() => _CompassAppState();
}

class _CompassAppState extends State<CompassApp> {
  final locationService = LocationService();
  GeoData? geoData;
  List<int> accelerometer = [0, 0];
  bool _showPieChart = false;
  int moving = 0;
  int heading = 0;
  int startPoint = 0;

  @override
  void initState() {
    super.initState();

    locationService.getGeoData().then((value) {
      setState(() {
        geoData = value;
      });
    });

    accelerometerEventStream().listen((AccelerometerEvent event) {
      final bf = accelerometer;
      accelerometer[0] = event.x.toInt();
      accelerometer[1] = event.y.toInt();
      if ((bf[0] != accelerometer[0]) || (bf[1] != accelerometer[1])) {
        setState(() {});
      }
    });

    FlutterCompass.events!.listen((event) {
      if (event.heading!.toInt() != heading) {
        setState(() {
          heading = event.heading!.toInt();
        });

        /// Haptic Feedback
        if (heading % 30 == 0) {
          HapticFeedback.lightImpact();
        }

        /// calculate moving
        if (_showPieChart) {
          if (startPoint > heading && startPoint > 180 && heading < 180) {
            moving = -((startPoint - 180) + (180 - heading));
          } else if (startPoint < heading && startPoint < 180 && heading > 180) {
            moving = (180 - startPoint) + (heading - 180);
          } else if (startPoint > 180 && heading < 180) {
            moving = (360 - startPoint) + heading;
          } else if (startPoint < 180 && heading > 180) {
            moving = -((360 - heading) + startPoint);
          } else {
            moving = heading - startPoint;
          }

          // if (moving.abs() > 180) {
          //   moving = -moving;
          // }
        }
      }
    });
  }

  void _onTapAction() {
    setState(() {
      if (!_showPieChart) {
        startPoint = heading;
      } else {
        startPoint = 0;
        moving = 0;
      }
      _showPieChart = !_showPieChart;
    });
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
                  onTap: _onTapAction,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// background
                      const Background(height: double.infinity),

                      /// inner circle
                      Transform.translate(
                        offset: Offset(
                          -accelerometer[0] * 2,
                          accelerometer[1] * 2,
                        ),
                        child: const InnerCircle(),
                      ),

                      /// small cross
                      Transform.translate(
                        offset: Offset(
                          -accelerometer[0] * 2,
                          accelerometer[1] * 2,
                        ),
                        child: const Cross(
                          size: 0.8,
                          thick: 20,
                        ),
                      ),

                      /// large cross
                      const Cross(
                        size: 0.8,
                        thick: 150,
                      ),

                      /// display angle
                      Rotation(
                        rotationAngle: (heading),
                        child: Angle(
                          rotationAngle: (heading),
                        ),
                      ),

                      /// stick
                      const Stick(),

                      /// start point
                      if (_showPieChart)
                        StartPoint(moving: moving, startPoint: startPoint),

                      /// outer circle
                      Rotation(
                        rotationAngle: (heading),
                        child: const OuterCircle(),
                      ),

                      /// pie chart
                      if (_showPieChart)
                        pieChart(
                          dataMap: {
                            '1': moving.abs().toDouble(),
                            '2': 360 - moving.abs().toDouble(),
                          },
                          moving: moving,
                        ),

                      /// direction
                      Rotation(
                        rotationAngle: (heading),
                        child: Direction(rotationAngle: (heading)),
                      ),

                      /// TODO: 디버깅 지워야 함
                      Text(moving.toString(), style: TextStyle(color: Colors.white, fontSize: 50),),
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
                    const Background(height: double.infinity),
                    LargeText(
                      text1: '${heading.round().toString()}°',
                      text2: locationService.getDirection(heading.round()),
                    ),
                  ],
                ),
              ),
              const Background(height: 10),

              /// Section 3
              Flexible(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Background(height: double.infinity),
                    if (geoData != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(
                              text:
                                  '${locationService.convertLatLng(geoData!.latitude, true)} ${locationService.convertLatLng(geoData!.longitude, false)}'),
                          SmallText(text: geoData!.address),
                          SmallText(text: '고도 ${geoData!.altitude.ceil()}m'),
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

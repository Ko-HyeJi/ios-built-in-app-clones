import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
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
import 'package:sensors_plus/sensors_plus.dart';
import 'package:compass/models/geo_data_model.dart';

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
  GeoData? _geoData;
  final List<double> _accelerometer = [0.0, 0.0];
  bool _showPieChart = false;
  int heading = 0;
  int moving = 0;
  int startingPoint = 0;

  @override
  void initState() {
    super.initState();

    locationService.getGeoData().then((value) {
      setState(() {
        _geoData = value;
      });
    });

    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer[0] = event.x;
        _accelerometer[1] = event.y;
      });
    });

    FlutterCompass.events!.listen((event) {
      if (event.heading!.toInt() != heading) {
        setState(() {
          heading = event.heading!.toInt();
        });

        /// Haptic Feedback
        if (heading % 30 == 0) {
          HapticFeedback.mediumImpact();
        }

        /// calculate moving
        if (_showPieChart) {
          if ((startingPoint > 180 && heading < 180) && moving > 0) {
            moving = (360 - startingPoint) + heading;
          } else if ((startingPoint < 180 && heading > 180) && moving < 0) {
            moving = -startingPoint + (heading - 360);
          } else {
            moving = heading - startingPoint;
          }

          if (moving.abs() > 180) {
            moving = -moving;
          }
        }
      }
    });
  }

  void _onTapAction() {
    setState(() {
      if (!_showPieChart) {
        startingPoint = heading;
      } else {
        startingPoint = 0;
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
                          _accelerometer[0] * -2,
                          _accelerometer[1] * 2,
                        ),
                        child: const InnerCircle(),
                      ),

                      /// small cross
                      Transform.translate(
                        offset: Offset(
                          _accelerometer[0] * -2,
                          _accelerometer[1] * 2,
                        ),
                        child: const Cross(
                          size: 0.8,
                          thick: 20,
                        ),
                      ),

                      /// large cross
                      const Cross(
                        size: 0.8,
                        thick: 145,
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
                        StartPoint(moving: moving, startPoint: startingPoint),

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
                    if (_geoData != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(
                              text:
                                  '${locationService.convertLatLng(_geoData!.latitude, true)} ${locationService.convertLatLng(_geoData!.longitude, false)}'),
                          SmallText(text: _geoData!.address),
                          SmallText(text: '고도 ${_geoData!.altitude.ceil()}m'),
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

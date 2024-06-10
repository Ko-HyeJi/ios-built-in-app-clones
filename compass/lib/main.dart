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
  final _locationService = LocationService();
  final List<int> _accelerometer = [0, 0];
  GeoData? _geoData;
  bool _showPieChart = false;
  int _heading = 0;
  int _moving = 0;
  int _startingPoint = 0;

  @override
  void initState() {
    super.initState();

    _locationService.getGeoData().then((value) {
      setState(() {
        _geoData = value;
      });
    });

    accelerometerEventStream().listen((AccelerometerEvent event) {
      if (event.x.toInt() != _accelerometer[0] ||
          event.y.toInt() != _accelerometer[1]) {
        setState(() {
          _accelerometer[0] = event.x.toInt();
          _accelerometer[1] = event.y.toInt();
        });
      }
    });

    FlutterCompass.events!.listen((event) {
      if (event.heading!.toInt() != _heading) {
        setState(() {
          _heading = event.heading!.toInt();
        });

        /// haptic feedback
        if (_heading % 30 == 0) {
          HapticFeedback.mediumImpact();
        }

        /// calculate moving
        if (_showPieChart) {
          if ((_startingPoint > 180 && _heading < 180) && _moving > 0) {
            _moving = (360 - _startingPoint) + _heading;
          } else if ((_startingPoint < 180 && _heading > 180) && _moving < 0) {
            _moving = -_startingPoint + (_heading - 360);
          } else {
            _moving = _heading - _startingPoint;
          }

          if (_moving.abs() > 180) {
            _moving = -_moving;
          }
        }
      }
    });
  }

  void _onTapAction() {
    setState(() {
      if (!_showPieChart) {
        _startingPoint = _heading;
      } else {
        _startingPoint = 0;
        _moving = 0;
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

                      /// large cross
                      const Cross(
                        size: 0.8,
                        thick: 145,
                      ),

                      /// pie chart
                      if (_showPieChart)
                        Movement(
                          dataMap: {
                            '1': _moving.abs().toDouble(),
                            '2': 360 - _moving.abs().toDouble(),
                          },
                          moving: _moving,
                        ),

                      /// rotation area
                      Rotation(
                        rotationAngle: _heading,
                        child: _RotationArea(
                          rotationAngle: _heading,
                          showPieChart: _showPieChart,
                          startingPoint: _startingPoint,
                        ),
                      ),

                      /// stick
                      Transform.translate(
                        offset: const Offset(0, -144),
                        child: const Stick(),
                      ),

                      /// start point
                      if (_showPieChart)
                        Rotation(
                          rotationAngle: _moving,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 60),
                            child: StartPoint(
                              moving: _moving,
                              startingPoint: _startingPoint,
                            ),
                          ),
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
                      text1: '${_heading.toString()}°',
                      text2: _locationService.getDirection(_heading),
                    ),
                  ],
                ),
              ),
              const Background(height: 20),

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
                                  '${_locationService.convertLatLng(_geoData!.latitude, true)} ${_locationService.convertLatLng(_geoData!.longitude, false)}'),
                          SmallText(
                              text:
                                  '${_geoData!.administrativeArea}, ${_geoData!.locality}'),
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

class _RotationArea extends StatelessWidget {
  const _RotationArea({
    required this.rotationAngle,
    required this.showPieChart,
    required this.startingPoint,
  });

  final int rotationAngle;
  final bool showPieChart;
  final int startingPoint;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Direction(rotationAngle: (rotationAngle)),
        const OuterCircle(),
        Angle(
          rotationAngle: (rotationAngle),
          showPieChart: showPieChart,
          startingPoint: startingPoint,
        ),
      ],
    );
  }
}

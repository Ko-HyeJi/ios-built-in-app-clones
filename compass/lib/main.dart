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
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
  double? heading = 0.0;
  double startPoint = 0.0;
  List<double> accelerometer = [0.0, 0.0];

  double? latitude;
  double? longitude;
  double? altitude;
  String? address;

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      altitude = position.altitude;
      print(convertLatLng(latitude!, true));
      print(convertLatLng(longitude!, false));
      getPlacemarks(latitude!, longitude!).then((value){
        address = value;
      });
    });
  }

  Future<String> getPlacemarks(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      var address = '';

      if (placemarks.isNotEmpty) {

        // Concatenate non-null components of the address
        var streets = placemarks.reversed
            .map((placemark) => placemark.street)
            .where((street) => street != null);

        // Filter out unwanted parts
        streets = streets.where((street) =>
        street!.toLowerCase() !=
            placemarks.reversed.last.locality!
                .toLowerCase()); // Remove city names
        streets =
            streets.where((street) => !street!.contains('+')); // Remove street codes

        address += streets.join(', ');

        address += ', ${placemarks.reversed.last.subLocality ?? ''}';
        address += ', ${placemarks.reversed.last.locality ?? ''}';
        address += ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.postalCode ?? ''}';
        address += ', ${placemarks.reversed.last.country ?? ''}';
      }

      // print("Your Address for ($lat, $long) is: $address");

      // return address;
      return '${placemarks.reversed.last.administrativeArea ?? ' - '}, ${placemarks.reversed.last.locality ?? ' - '}';
    } catch (e) {
      print("Error getting placemarks: $e");
      return "No Address";
    }
  }

  String convertLatLng(double decimal, bool isLat){
    String degree = "${decimal.toString().split(".")[0]}°";
    double minutesBeforeConversion =
    double.parse("0.${decimal.toString().split(".")[1]}");
    String minutes =
        "${(minutesBeforeConversion * 60).toString().split('.')[0]}'";
    double secondsBeforeConversion = double.parse(
        "0.${(minutesBeforeConversion * 60).toString().split('.')[1]}");
    String seconds =
        '${double.parse((secondsBeforeConversion * 60).toString()).toStringAsFixed(0)}"';
    String dmsOutput =
        '$degree$minutes$seconds ${isLat ? decimal > 0 ? '북' : '남' : decimal > 0 ? '동' : '서'}';
    return dmsOutput ;
  }

  @override
  void initState() {
    super.initState();
    getGeoData();

    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
        if (widget.showPieChart) {
          widget.moving = heading!.toDouble() - startPoint;
        }
        if (heading!.toInt() % 30 == 0) {
          HapticFeedback.lightImpact();
        }
      });
    });

    accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        accelerometer[0] = event.x * 1.5;
        accelerometer[1] = event.y * 1.5;
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );
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
                      Transform.translate(
                        offset: Offset(-accelerometer[0], accelerometer[1]),
                        child: const InnerCircle(),
                      ),

                      /// small cross
                      Transform.translate(
                        offset: Offset(-accelerometer[0], accelerometer[1]),
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
                    LargeText(
                      text1: '${heading!.round().toString()}°',
                      text2: getDirection(heading!.round()),
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
                    Background(height: double.infinity),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(text: '${convertLatLng(latitude ?? 0, true)} ${convertLatLng(longitude ?? 0, false)}'),
                        SmallText(text: address ?? ' - '),
                        SmallText(text: '고도 ${altitude?.ceil() ?? ' - '}m'),
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

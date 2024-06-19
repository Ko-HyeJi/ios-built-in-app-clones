import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/custom_colors.dart';
import 'package:stopwatch/models/lap.model.dart';
import 'package:stopwatch/services/platform.provider.dart';
import 'package:stopwatch/screens/circular_stopwatch.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/widgets/circle_button.dart';
import 'package:stopwatch/screens/lap_times_list.dart';
import 'package:stopwatch/widgets/page_indicator.dart';

late final double deviceWidth;
late final double deviceHeight;
const buttonRatio = 0.22;
const topMargin = 0.05;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await platformProvider.initPlatform();
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  @override
  void initState() {
    super.initState();
    deviceWidth = platformProvider.deviceData?.logicalSize.width ?? 0;
    deviceHeight = platformProvider.deviceData?.logicalSize.height ?? 0;
  }

  final PageController _pageController = PageController(initialPage: 1);
  var _currentPage = 1;
  final _lap = Lap();

  final Stopwatch _stopwatch = Stopwatch();
  final Stopwatch _lapStopwatch = Stopwatch();
  Timer? _timer;

  void _startStopwatch() {
    _stopwatch.start();
    _lapStopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      setState(() {});
    });
  }

  void _pauseStopwatch() {
    _stopwatch.stop();
    _lapStopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _lapStopwatch.reset();
    _lap.times.clear();
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  void _registerLap() {
    _lap.times.add(_lapStopwatch.elapsed.inMilliseconds);
    _lap.minIndex =
        _lap.times.indexOf(_lap.times.reduce((a, b) => a < b ? a : b));
    _lap.maxIndex =
        _lap.times.indexOf(_lap.times.reduce((a, b) => a > b ? a : b));
    _lapStopwatch.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: CustomColors.black,
        body: Column(
          children: [
            Container(
              width: deviceWidth,
              height: deviceWidth,
              margin: EdgeInsets.only(top: deviceHeight * topMargin),
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  TextStopwatch(
                    width: deviceWidth * 0.9,
                    fontWeight: FontWeight.w200,
                    elapsedTime: showSlowly(_stopwatch.elapsed.inMilliseconds),
                  ),
                  CircularStopwatch(
                    elapsedTime: _stopwatch.elapsed.inMilliseconds,
                    lapElapsedTime: _lapStopwatch.elapsed.inMilliseconds,
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -deviceWidth * buttonRatio / 2),
              child: SizedBox(
                width: deviceWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(
                      onTap: () {
                        _stopwatch.isRunning ? _registerLap() : _resetStopwatch();
                      },
                      size: deviceWidth * buttonRatio,
                      color: CustomColors.grey3
                          .withOpacity(_timer == null ? 0.5 : 1.0),
                      text: (_timer == null || _stopwatch.isRunning)
                          ? '랩'
                          : '재설정',
                      textColor: CustomColors.white
                          .withOpacity(_timer == null ? 0.5 : 1.0),
                    ),
                    PageIndication(pageIndex: _currentPage),
                    CircleButton(
                      onTap: () {
                        _stopwatch.isRunning ? _pauseStopwatch() : _startStopwatch();
                      },
                      size: deviceWidth * buttonRatio,
                      text: _stopwatch.isRunning ? '중단' : '시작',
                      color: _stopwatch.isRunning
                          ? CustomColors.red
                          : CustomColors.green,
                      textColor: _stopwatch.isRunning
                          ? CustomColors.textRed
                          : CustomColors.textGreen,
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -deviceWidth * buttonRatio / 2.5),
              child: SizedBox(
                width: deviceWidth * 0.9,
                height: deviceHeight -
                    deviceWidth -
                    (deviceWidth * buttonRatio) -
                    (deviceHeight * topMargin),
                child: LapTimesList(
                  lap: _lap,
                  stopwatch: _lapStopwatch,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formattedTime(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');
  String millisecondsStr = (milliseconds % 100).toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr.$millisecondsStr';
}

int showSlowly(int milliseconds) {
  return (milliseconds ~/ 73) * 73;
}

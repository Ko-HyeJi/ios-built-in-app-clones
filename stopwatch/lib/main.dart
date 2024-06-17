import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/models/lap.model.dart';
import 'package:stopwatch/services/platform.provider.dart';
import 'package:stopwatch/screens/circular_stopwatch.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/widgets/circle_button.dart';
import 'package:stopwatch/widgets/lap_times_list.dart';
import 'package:stopwatch/widgets/page_indicator.dart';

late final double deviceWidth;
late final double deviceHeight;
const buttonRatio = 0.22;

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
  Timer? _timer;

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  void _registerLap() {
    _lap.lapTimes.insert(0, _stopwatch.elapsed.inMilliseconds);
    _lap.minIndex = _lap.lapTimes.indexOf(_lap.lapTimes.reduce((a, b) => a < b ? a : b));
    _lap.maxIndex = _lap.lapTimes.indexOf(_lap.lapTimes.reduce((a, b) => a > b ? a : b));
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Transform.translate(
              offset: Offset(0, deviceWidth * buttonRatio * 0.25),
              child: SizedBox(
                width: deviceWidth,
                height: deviceWidth,
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
                      elapsedTime: _stopwatch.elapsed,
                    ),
                    CircularStopwatch(
                      elapsedTime: _stopwatch.elapsed,
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -deviceWidth * buttonRatio * 0.25),
              child: SizedBox(
                width: deviceWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(
                      onTap: () {
                        _stopwatch.isRunning ? _registerLap() : _resetTimer();
                      },
                      size: deviceWidth * buttonRatio,
                      color: Colors.grey,
                      text: _stopwatch.isRunning ? '랩' : '재설정',
                      textColor: Colors.white,
                    ),
                    PageIndication(pageIndex: _currentPage),
                    CircleButton(
                      onTap: () {
                        _stopwatch.isRunning ? _stopTimer() : _startTimer();
                      },
                      size: deviceWidth * buttonRatio,
                      text: _stopwatch.isRunning ? '중단' : '시작',
                      color: _stopwatch.isRunning ? Colors.red : Colors.green,
                      textColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              height: deviceHeight - deviceWidth - deviceWidth * buttonRatio,
              child: LapTimesList(
                lap: _lap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatTime(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');
  String millisecondsStr =
      (milliseconds % 100).toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr.$millisecondsStr';
}


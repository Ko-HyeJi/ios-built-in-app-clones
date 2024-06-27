import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/assets/custom_colors.dart';
import 'package:stopwatch/services/platform.provider.dart';
import 'package:stopwatch/screens/circular_stopwatch.dart';
import 'package:stopwatch/screens/text_stopwatch.dart';
import 'package:stopwatch/services/stopwatch.service.dart';
import 'package:stopwatch/widgets/circle_button.dart';
import 'package:stopwatch/screens/lap_times_list.dart';
import 'package:stopwatch/widgets/page_indicator.dart';

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
  final StopwatchService stopwatch = StopwatchService();
  late final double deviceWidth;
  late final double deviceHeight;
  final buttonRatio = 0.22;
  final topMargin = 0.05;

  @override
  void initState() {
    super.initState();
    deviceWidth = platformProvider.deviceData?.logicalSize.width ?? 0;
    deviceHeight = platformProvider.deviceData?.logicalSize.height ?? 0;
  }

  final PageController _pageController = PageController(initialPage: 1);
  var _currentPage = 1;

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
                  ),
                  CircularStopwatch(
                    width: deviceWidth * 0.9,
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
                        stopwatch.isRunning
                            ? stopwatch.lap()
                            : stopwatch.reset();
                        setState(() {});
                      },
                      size: deviceWidth * buttonRatio,
                      color: CustomColors.buttonGrey
                          .withOpacity(stopwatch.isReset ? 0.5 : 1.0),
                      text: (stopwatch.isReset || stopwatch.isRunning)
                          ? '랩'
                          : '재설정',
                      textColor: CustomColors.white
                          .withOpacity(stopwatch.isReset ? 0.5 : 1.0),
                    ),
                    PageIndication(
                        pageIndex: _currentPage, itemSize: deviceWidth * 0.02),
                    CircleButton(
                      onTap: () {
                        stopwatch.isRunning
                            ? stopwatch.stop()
                            : stopwatch.start();
                        setState(() {});
                      },
                      size: deviceWidth * buttonRatio,
                      text: stopwatch.isRunning ? '중단' : '시작',
                      color: stopwatch.isRunning
                          ? CustomColors.red
                          : CustomColors.green,
                      textColor: stopwatch.isRunning
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
                height: deviceHeight - deviceWidth - (deviceWidth * buttonRatio) - (deviceHeight * topMargin),
                child: LapTimesList(),
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
  return (milliseconds ~/ 57) * 57;
}

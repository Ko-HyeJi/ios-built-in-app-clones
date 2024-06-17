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

  final PageController pageController = PageController(initialPage: 1);
  var currentPage = 1;
  var lap = Lap();

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
                  controller: pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: [
                    TextStopwatch(
                      width: deviceWidth * 0.9,
                      fontWeight: FontWeight.w200,
                      min: 15,
                      sec: 10,
                      msec: 30,
                    ),
                    const CircularStopwatch(),
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
                      onTap: () {},
                      size: deviceWidth * buttonRatio,
                      color: Colors.grey,
                      text: '랩',
                      textColor: Colors.white,
                    ),
                    PageIndication(pageIndex: currentPage),
                    CircleButton(
                      onTap: () {},
                      size: deviceWidth * buttonRatio,
                      text: '시작',
                      color: Colors.green,
                      textColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.9,
              height: deviceHeight - deviceWidth - deviceWidth * buttonRatio,
              child: LapTimesList(lap: lap,),
            ),
          ],
        ),
      ),
    );
  }
}

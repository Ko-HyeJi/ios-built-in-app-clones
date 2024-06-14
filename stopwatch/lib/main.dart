import 'package:flutter/material.dart';
import 'package:stopwatch/services/platform.provider.dart';
import 'package:stopwatch/widgets/dial.dart';
import 'package:stopwatch/widgets/second_hand.dart';
import 'package:stopwatch/widgets/sub_dial.dart';

late final double deviceWidth;

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
  // late final double deviceWidth;

  @override
  void initState() {
    super.initState();
    deviceWidth = platformProvider.deviceData?.logicalSize.width ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: const AlwaysStoppedAnimation(0.3),
            child: SecondHand(
              radius: deviceWidth * 0.9 * 0.5,
              color: Colors.blueAccent,
            ),
          ),
          SubDial(
            size: deviceWidth * 0.27,
          ),
          Dial(
            size: deviceWidth * 0.9,
          ),
        ],
      ),
    );
  }
}

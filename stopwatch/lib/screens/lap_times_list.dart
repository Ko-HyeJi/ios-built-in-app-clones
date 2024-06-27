import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stopwatch/assets/custom_colors.dart';
import 'package:stopwatch/main.dart';
import 'package:stopwatch/services/stopwatch.service.dart';
import 'package:stopwatch/widgets/custom_divider.dart';
import 'package:stopwatch/widgets/lap_time_tile.dart';

class LapTimesList extends StatefulWidget {
  const LapTimesList({super.key});

  @override
  State<LapTimesList> createState() => _LapTimesListState();
}

class _LapTimesListState extends State<LapTimesList> {
  final StopwatchService _stopwatch = StopwatchService();
  final ScrollController _scrollController = ScrollController();
  bool _showDivider = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_showDivider) {
        setState(() {
          _showDivider = true;
        });
      } else if (_scrollController.offset < 0 && _showDivider) {
        setState(() {
          _showDivider = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCurrentLapTimeTile() {
    return StreamBuilder<int>(
      stream: _stopwatch.elapsedTimeStream,
      builder: (context, snapshot) {
        return LapTimeTile(
          index: _stopwatch.lapRecord.times.length,
          time: formattedTime(showSlowly(snapshot.data ?? 0)),
          color: CustomColors.white,
        );
      },
    );
  }

  Widget _buildLapTimeTiles() {
    final lapTimes = _stopwatch.lapRecord.times;
    final count = _stopwatch.lapRecord.times.length;
    final minIndex = _stopwatch.lapRecord.minIndex;
    final maxIndex = _stopwatch.lapRecord.maxIndex;

    return Column(
      children: [
        for (var i = 0; i < count; i++)
          LapTimeTile(
            index: count - i - 1,
            time: formattedTime(lapTimes[i]),
            color: (count >= 2 && i == minIndex)
                ? CustomColors.textGreen
                : (count >= 2 && i == maxIndex)
                    ? CustomColors.textRed
                    : CustomColors.white,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                const CustomDivider(),
                if (!_stopwatch.isReset) _buildCurrentLapTimeTile(),
                _buildLapTimeTiles(),
              ],
            ),
          ],
        ),
        if (_showDivider)
          Stack(
            children: [
              const CustomDivider(),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    widthFactor: 1.0,
                    heightFactor: 0.48,
                    child: Container(
                      color: CustomColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

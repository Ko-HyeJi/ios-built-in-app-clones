import 'dart:async';

import 'package:stopwatch/models/lap_record.model.dart';

class StopwatchService {
  static final _instance = StopwatchService._internal();
  factory StopwatchService() => _instance;
  StopwatchService._internal();

  final _elapsedTimeController = StreamController<int>.broadcast();
  final _lapTimeController = StreamController<int>.broadcast();
  final _stopwatch = Stopwatch();
  Timer? _timer;
  int _currentLapStartTime = 0;
  final lapRecord = LapRecord();

  Stream<int> get elapsedTimeStream => _elapsedTimeController.stream;
  Stream<int> get lapTimeStream => _lapTimeController.stream;
  bool get isRunning => _stopwatch.isRunning;
  bool get isReset => _timer == null;

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
        _elapsedTimeController.add(_stopwatch.elapsedMilliseconds);
        _lapTimeController
            .add(_stopwatch.elapsedMilliseconds - _currentLapStartTime);
      });
    }
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _elapsedTimeController.add(_stopwatch.elapsedMilliseconds);
      _lapTimeController
          .add(_stopwatch.elapsedMilliseconds - _currentLapStartTime);
    }
  }

  void reset() {
    _stopwatch.reset();
    _timer?.cancel();
    _timer = null;
    _currentLapStartTime = 0;
    _elapsedTimeController.add(0);
    _lapTimeController.add(0);
    lapRecord.times.clear();
  }

  void lap() {
    lapRecord.times.insert(0, _stopwatch.elapsedMilliseconds - _currentLapStartTime);
    lapRecord.minIndex = lapRecord.times
        .indexOf(lapRecord.times.reduce((a, b) => a < b ? a : b));
    lapRecord.maxIndex = lapRecord.times
        .indexOf(lapRecord.times.reduce((a, b) => a > b ? a : b));
    _currentLapStartTime = _stopwatch.elapsedMilliseconds;
  }

  void dispose() {
    _timer?.cancel();
    _elapsedTimeController.close();
    _lapTimeController.close();
  }
}

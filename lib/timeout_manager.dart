import 'dart:async';
import 'package:flutter/material.dart';

class TimeoutManager with ChangeNotifier {
  Timer? _timer;
  final int timeoutDuration; // in seconds

  TimeoutManager({required this.timeoutDuration});

  void startTimer(VoidCallback onTimeout) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(Duration(seconds: timeoutDuration), onTimeout);
  }

  void resetTimer(VoidCallback onTimeout) {
    startTimer(onTimeout);
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}

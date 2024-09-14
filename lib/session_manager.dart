import 'dart:async';
import 'package:flutter/material.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;

  SessionManager._internal();

  Timer? _inactivityTimer;
  final int _timeoutDuration = 300; // Session timeout duration in seconds (5 minutes)

  void startSessionTimeout(BuildContext context) {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: _timeoutDuration), () {
      _logoutUser(context);
    });
  }

  void resetSessionTimeout(BuildContext context) {
    startSessionTimeout(context);
  }

  void _logoutUser(BuildContext context) {
    // Perform logout action
    // For example, navigate to the login screen and clear user session data
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void cancelSessionTimeout() {
    _inactivityTimer?.cancel();
  }
}

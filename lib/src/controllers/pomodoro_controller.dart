import 'dart:async';

import 'package:flutter/material.dart';

enum PomodoroStatus {
  interval(color: Colors.greenAccent),
  pomodoro(color: Colors.redAccent);

  const PomodoroStatus({required this.color});

  final Color color;
}

class PomodoroController extends ChangeNotifier {
  PomodoroStatus _pomodoroStatus = PomodoroStatus.pomodoro;

  Timer? _intervalPomodoro;
  Timer? _pomodoro;

  int _minutesPomodoro = 25;
  int _secondsPomodoro = 0;
  int _minutesIntervalPomodoro = 5;
  int _secondsIntervalPomodoro = 0;

  int _minutes = 25;
  int _seconds = 0;
  int _minutesInterval = 5;
  int _secondsInterval = 0;

  int _oldTickPomodoro = 0;
  int _oldTickIntervalPomodoro = 0;

  late final int _fullPomodoroTimer =
      _minutesPomodoro * 60 + _secondsPomodoro + 1;
  late final _fullTimerIntervalPomodoro =
      _minutesIntervalPomodoro * 60 + _secondsIntervalPomodoro;

  double _progressValue = 1;

  PomodoroStatus get pomodoroStatus => _pomodoroStatus;

  bool get isActiveTimerPomodoro => _pomodoro?.isActive ?? false;
  bool get isActiveTimerIntervalPomodoro =>
      _intervalPomodoro?.isActive ?? false;

  double get progressValue => _progressValue;

  String get pomodoroTimer =>
      "${_minutesPomodoro < 10 ? _minutesPomodoro.toString().padLeft(2, "0") : _minutesPomodoro}:${_secondsPomodoro < 10 ? _secondsPomodoro.toString().padLeft(2, "0") : _secondsPomodoro}";
  String get intervalPomodoroTimer =>
      "${_minutesIntervalPomodoro < 10 ? _minutesIntervalPomodoro.toString().padLeft(2, "0") : _minutesIntervalPomodoro}:${_secondsIntervalPomodoro < 10 ? _secondsIntervalPomodoro.toString().padLeft(2, "0") : _secondsIntervalPomodoro}";

  String get minutesPomodoroText =>
      _minutes < 10 ? _minutes.toString().padLeft(2, "0") : _minutes.toString();
  String get secondsPomodoroText =>
      _seconds < 10 ? _seconds.toString().padLeft(2, "0") : _seconds.toString();

  String get minutesIntervalPomodoroText => _minutesInterval < 10
      ? _minutesInterval.toString().padLeft(2, "0")
      : _minutesInterval.toString();
  String get secondsIntervalPomodoroText => _secondsInterval < 10
      ? _secondsInterval.toString().padLeft(2, "0")
      : _secondsInterval.toString();

  int get minutesPomodoro => _minutes;
  int get secondsPomodoro => _seconds;
  int get minutesIntervalPomodoro => _minutesInterval;
  int get secondsIntervalPomodoro => _secondsInterval;

  bool get isPomodoro =>
      _pomodoroStatus == PomodoroStatus.pomodoro ? true : false;

  void playAndPausePomodoro() =>
      isActiveTimerPomodoro ? pausePomodoro() : startPomodoro();

  void playAndPauseIntervalPomodoro() => isActiveTimerIntervalPomodoro
      ? pauseIntervalPomodoro()
      : startIntervalPomodoro();

  void startPomodoro() {
    _pomodoro = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_secondsPomodoro == 0 && _minutesPomodoro == 0) {
        stopPomodoro();
        _pomodoroStatus = PomodoroStatus.interval;
      } else {
        if (_secondsPomodoro == 0) {
          _minutesPomodoro--;
          _secondsPomodoro = 59;
        } else {
          _secondsPomodoro--;
        }
        _progressValue = ((timer.tick + _oldTickPomodoro - 1) /
                (_fullPomodoroTimer - 1) *
                (0 - 1) +
            1);
        notifyListeners();
      }
    });
  }

  void startIntervalPomodoro() {
    _intervalPomodoro = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsIntervalPomodoro == 0 && _minutesIntervalPomodoro == 0) {
        stopIntervalPomodoro();
        _pomodoroStatus = PomodoroStatus.pomodoro;
      } else {
        if (_secondsIntervalPomodoro == 0) {
          _minutesIntervalPomodoro--;
          _secondsIntervalPomodoro = 59;
        } else {
          _secondsIntervalPomodoro--;
        }
        _progressValue = (timer.tick + _oldTickIntervalPomodoro - 1) /
                (_fullTimerIntervalPomodoro - 1) *
                (0 - 1) +
            1;
        notifyListeners();
      }
    });
  }

  void pausePomodoro() {
    _pomodoro?.cancel();
    _oldTickPomodoro += _pomodoro!.tick;
    notifyListeners();
  }

  void pauseIntervalPomodoro() {
    _intervalPomodoro?.cancel();
    _oldTickIntervalPomodoro += _intervalPomodoro!.tick;
    notifyListeners();
  }

  void skipPomodoro() {
    stopPomodoro();
    _pomodoroStatus = PomodoroStatus.interval;
    notifyListeners();
  }

  void skipIntervalPomodoro() {
    stopIntervalPomodoro();
    _pomodoroStatus = PomodoroStatus.pomodoro;
    notifyListeners();
  }

  void stopPomodoro() {
    _minutesPomodoro = _minutes;
    _secondsPomodoro = _seconds;
    _progressValue = 1;
    _pomodoro?.cancel();
    _pomodoro = null;
    notifyListeners();
  }

  void stopIntervalPomodoro() {
    _minutesIntervalPomodoro = _minutesInterval;
    _secondsIntervalPomodoro = _secondsInterval;
    _progressValue = 1;
    _intervalPomodoro?.cancel();
    _intervalPomodoro = null;
    notifyListeners();
  }

  void changeMinutesPomodoro(int newMinutes) {
    _minutes = newMinutes;
    if (newMinutes == -1) {
      _minutes = 59;
      _minutesPomodoro = _minutes;
    } else if (newMinutes == 60) {
      _minutes = 0;
      _minutesPomodoro = _minutes;
    } else {
      _minutesPomodoro = _minutes;
    }
    notifyListeners();
  }

  void changeSecondsPomodoro(int newSeconds) {
    _seconds = newSeconds;
    if (newSeconds == -1) {
      _seconds = 59;
      _secondsPomodoro = _seconds;
    } else if (newSeconds == 60) {
      _seconds = 0;
      _secondsPomodoro = _seconds;
    } else {
      _secondsPomodoro = _seconds;
    }
    notifyListeners();
  }

  void changeMinutesIntervalPomodoro(int newMinutesInterval) {
    _minutesInterval = newMinutesInterval;
    if (newMinutesInterval == -1) {
      _minutesInterval = 59;
      _minutesIntervalPomodoro = _minutesInterval;
    } else if (newMinutesInterval == 60) {
      _minutesInterval = 0;
      _minutesIntervalPomodoro = _minutesInterval;
    } else {
      _minutesIntervalPomodoro = _minutesInterval;
    }
    notifyListeners();
  }

  void changeSecondsIntervalPomodoro(int newSecondsInterval) {
    _secondsInterval = newSecondsInterval;
    if (newSecondsInterval == -1) {
      _secondsInterval = 59;
      _secondsIntervalPomodoro = _secondsInterval;
    } else if (newSecondsInterval == 60) {
      _secondsInterval = 0;
      _secondsIntervalPomodoro = _secondsInterval;
    } else {
      _secondsIntervalPomodoro = _secondsInterval;
    }
    notifyListeners();
  }
}

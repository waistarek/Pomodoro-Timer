import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../models/pomodoro_session.dart';
import '../models/task_item.dart';
import '../services/local_storage_service.dart';
import '../services/session_service.dart';
import '../services/sound_service.dart';
import '../timer/pomodoro_phase.dart';
import '../timer/timer_engine.dart';

class TimerProvider extends ChangeNotifier {
  TimerProvider(this._localStorage, this._sessionService, this._soundService) {
    _rebuildEngine();
  }

  final LocalStorageService _localStorage;
  final SessionService _sessionService;
  final SoundService _soundService;

  AppSettings _settings = const AppSettings();
  TaskItem? _selectedTask;
  late TimerEngine engine;
  Timer? _timer;
  DateTime? _phaseStartedAt;
  bool running = false;

  int get remainingSeconds => engine.remainingSeconds;
  String get formattedTime => TimerEngine.formatMMSS(engine.remainingSeconds);
  PomodoroPhase get phase => engine.phase;
  double get progress => engine.progress;
  int get completedPomodoros => engine.completedPomodoros;

  void updateSettings(AppSettings settings) {
    final changed = _settings != settings;
    _settings = settings;
    if (changed && !running) {
      _rebuildEngine(keepPomodoros: true);
      notifyListeners();
    }
  }

  void updateSelectedTask(TaskItem? task) {
    _selectedTask = task;
  }

  void startOrResume() {
    if (running) return;
    running = true;
    _phaseStartedAt ??= DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }

  void pause() {
    running = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void reset() {
    pause();
    _phaseStartedAt = null;
    engine.reset();
    notifyListeners();
  }

  Future<void> _tick() async {
    engine.tickOneSecond();
    if (engine.isFinished) {
      await _finishPhase();
    }
    notifyListeners();
  }

  Future<void> _finishPhase() async {
    final finishedPhase = engine.phase;
    final startedAt = _phaseStartedAt ?? DateTime.now().subtract(Duration(minutes: _durationForPhase(finishedPhase)));
    final endedAt = DateTime.now();

    if (_settings.soundEnabled) {
      try {
        await _soundService.playPhaseFinishedSound();
      } catch (_) {}
    }

    if (finishedPhase == PomodoroPhase.work) {
      await _localStorage.setJsonObject('last_completed_work', {'at': endedAt.toIso8601String()});
    }

    try {
      await _sessionService.createSession(
        PomodoroSession(
          taskId: _selectedTask?.remoteId,
          phaseType: finishedPhase.apiValue,
          durationMinutes: _durationForPhase(finishedPhase),
          completed: true,
          startedAt: startedAt,
          endedAt: endedAt,
        ),
      );
    } catch (_) {
      // Offline: Die App läuft weiter. Eine spätere echte Sync-Queue kann hier ergänzt werden.
    }

    engine.switchToNextPhase();
    _phaseStartedAt = DateTime.now();

    if (!_settings.autoStart) {
      pause();
    }
  }

  int _durationForPhase(PomodoroPhase phase) {
    switch (phase) {
      case PomodoroPhase.work:
        return _settings.workMinutes;
      case PomodoroPhase.shortBreak:
        return _settings.shortBreakMinutes;
      case PomodoroPhase.longBreak:
        return _settings.longBreakMinutes;
    }
  }

  void _rebuildEngine({bool keepPomodoros = false}) {
    final oldPomodoros = keepPomodoros ? (engine.completedPomodoros) : 0;
    engine = TimerEngine(
      workSeconds: _settings.workMinutes * 60,
      shortBreakSeconds: _settings.shortBreakMinutes * 60,
      longBreakSeconds: _settings.longBreakMinutes * 60,
      longBreakAfter: _settings.longBreakAfter,
      completedPomodoros: oldPomodoros,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

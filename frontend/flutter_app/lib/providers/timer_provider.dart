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
import 'package:uuid/uuid.dart';

class TimerProvider extends ChangeNotifier {
  TimerProvider(this._localStorage, this._sessionService, this._soundService) {
    _rebuildEngine();
  }

  final LocalStorageService _localStorage;
  final SessionService _sessionService;
  final SoundService _soundService;
  String? _phaseClientSessionId;

  AppSettings _settings = const AppSettings();
  TaskItem? _selectedTask;
  late TimerEngine engine;
  Timer? _timer;
  DateTime? _phaseStartedAt;
  DateTime? _phaseEndsAt;
  TaskItem? _phaseTask;
  bool running = false;

  
 int get remainingSeconds => engine.remainingSeconds;
 String get formattedTime => TimerEngine.formatMMSS(engine.remainingSeconds);
 PomodoroPhase get phase => engine.phase;
 bool get isBreak => engine.isBreak;
 bool get canSkipPause => engine.isBreak && !_finishingPhase;
 double get progress => engine.progress;
 int get completedPomodoros => engine.completedPomodoros;

 bool get isReady {
  return !running &&
      !_finishingPhase &&
      engine.remainingSeconds == engine.totalPhaseSeconds;
 }

 bool get isPaused {
  return !running &&
      !_finishingPhase &&
      engine.remainingSeconds < engine.totalPhaseSeconds;
 }

 String get statusLabel {
  if (_finishingPhase) {
    return 'Speichern ...';
  }

  if (running) {
    return 'Läuft';
  }

  if (isPaused) {
    return 'Pausiert';
  }

  return 'Bereit';
 }
 bool get canChangeTask {
    return isReady;
  }

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
    if (running || _finishingPhase) {
      return;
    }

    final now = DateTime.now();

    final isNewPhase = engine.remainingSeconds == engine.totalPhaseSeconds;

    running = true;

    if (isNewPhase) {
      _phaseStartedAt = now;
      _phaseTask = _selectedTask;
      _phaseClientSessionId = const Uuid().v4();
    } else {
      _phaseStartedAt ??= now;
    }

    _phaseEndsAt = now.add(
      Duration(seconds: engine.remainingSeconds),
    );

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => _tick(),
    );

    notifyListeners();
  }

  void pause() {
    if (_finishingPhase) return;

    _syncRemainingSecondsWithClock();

    running = false;
    _timer?.cancel();
    _timer = null;
    _phaseEndsAt = null;

    notifyListeners();
  }

  void reset() {
    if (_finishingPhase) return;

    pause();
    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;
    engine.reset();
    _phaseClientSessionId = null;

    notifyListeners();
  }

  void skipPause() {
    if (!canSkipPause) {
      return;
    }

    _timer?.cancel();
    _timer = null;

    running = false;
    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;
    _phaseClientSessionId = null;

    engine.skipBreak();

    if (_settings.autoStart) {
      startOrResume();
      return;
    }

    notifyListeners();
  }

  // here is the fix of the multipe rings at the end of a period
  bool _finishingPhase = false;

  Future<void> _tick() async {
    if (_finishingPhase) return;

    _syncRemainingSecondsWithClock();

    if (engine.isFinished) {
      await _finishPhaseOnce();
      return;
    }

    notifyListeners();
  }

  void _syncRemainingSecondsWithClock() {
    final end = _phaseEndsAt;
    if (end == null) return;

    final remaining = end.difference(DateTime.now()).inSeconds;
    engine.remainingSeconds = remaining > 0 ? remaining : 0;
  }

  Future<void> _finishPhaseOnce() async {
    if (_finishingPhase) return;

    _finishingPhase = true;

    _timer?.cancel();
    _timer = null;

    final finishedPhase = engine.phase;
    final startedAt = _phaseStartedAt ?? DateTime.now();
    final endedAt = _phaseEndsAt ?? DateTime.now();

    final durationMinutes = (engine.totalPhaseSeconds / 60).round();

    try {
      if (finishedPhase == PomodoroPhase.work) {
        await _localStorage.setJsonObject('last_completed_work', {
          'at': endedAt.toIso8601String(),
        });

        await _sessionService.createSession(
          PomodoroSession(
            clientSessionId: _phaseClientSessionId,
            taskId: _phaseTask?.remoteId,
            localTaskId: _phaseTask?.localId,
            taskTitle: _phaseTask?.title,
            phaseType: finishedPhase.apiValue,
            durationMinutes: durationMinutes,
            completed: true,
            startedAt: startedAt,
            endedAt: endedAt,
          ),
        );
      } else {
        await _sessionService.createSession(
          PomodoroSession(
            clientSessionId: _phaseClientSessionId,
            taskId: null,
            phaseType: finishedPhase.apiValue,
            durationMinutes: durationMinutes,
            completed: true,
            startedAt: startedAt,
            endedAt: endedAt,
          ),
        );
      }

      if (_settings.soundEnabled) {
        await _soundService.playPhaseFinishedSound();
      }
    } catch (_) {
      // Offline oder Fehler beim Speichern/Sound:
      // Die App läuft trotzdem weiter.
      // Später kann hier eine Sync-Queue ergänzt werden.
    } finally {
      engine.switchToNextPhase();

      _phaseClientSessionId = null;
      _phaseStartedAt = null;
      _phaseEndsAt = null;
      _phaseTask = null;

      _finishingPhase = false;
      running = false;

      if (_settings.autoStart) {
        startOrResume();
      } else {
        notifyListeners();
      }
    }
  }

  // the end

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

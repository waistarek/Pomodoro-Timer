import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/app_settings.dart';
import '../models/pomodoro_session.dart';
import '../models/task_item.dart';
import '../services/local_storage_service.dart';
import '../services/session_service.dart';
import '../services/sound_service.dart';
import '../timer/pomodoro_phase.dart';
import '../timer/timer_engine.dart';
import '../services/notification_service.dart';

const String _timerStateStorageKey = 'active_timer_state';

class TimerProvider extends ChangeNotifier {
  TimerProvider(
    this._localStorage,
    this._sessionService,
    this._soundService,
    this._notificationService,
  ) {
    _rebuildEngine();
    _restoreTimerState();
  }

  final LocalStorageService _localStorage;
  final SessionService _sessionService;
  final SoundService _soundService;
  final NotificationService _notificationService;

  AppSettings _settings = const AppSettings();
  TaskItem? _selectedTask;

  late TimerEngine engine;
  Timer? _timer;

  DateTime? _phaseStartedAt;
  DateTime? _phaseEndsAt;
  TaskItem? _phaseTask;
  String? _phaseClientSessionId;

  bool running = false;
  bool _finishingPhase = false;
  String? error;

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
  void clearError() {
    error = null;
    notifyListeners();
  }

  void updateSettings(AppSettings settings) {
    final changed = _settings != settings;

    _settings = settings;

    final canRebuildForSettings = !running &&
        !isPaused &&
        !_finishingPhase &&
        engine.phase == PomodoroPhase.work;

    if (changed && canRebuildForSettings) {
      _rebuildEngine(keepPomodoros: true);
      unawaited(_saveTimerState());
      notifyListeners();
    }
  }

  void updateSelectedTask(TaskItem? task) {
    _selectedTask = task;

    if (canChangeTask) {
      unawaited(_saveTimerState());
    }
  }

  void startOrResume() {
    if (running || _finishingPhase) {
      return;
    }
    error = null;
    unawaited(_notificationService.requestPermission());

    final now = DateTime.now();
    final isNewPhase = engine.remainingSeconds == engine.totalPhaseSeconds;

    running = true;

    if (isNewPhase) {
      _phaseStartedAt = now;
      _phaseTask = _selectedTask;
      _phaseClientSessionId = const Uuid().v4();
    } else {
      _phaseStartedAt ??= now;
      _phaseClientSessionId ??= const Uuid().v4();
    }

    _phaseEndsAt = now.add(
      Duration(seconds: engine.remainingSeconds),
    );

    _startTicker();

    unawaited(_saveTimerState());

    notifyListeners();
  }

  void pause() {
    if (_finishingPhase) {
      return;
    }

    _syncRemainingSecondsWithClock();

    running = false;
    _timer?.cancel();
    _timer = null;
    _phaseEndsAt = null;

    unawaited(_saveTimerState());

    notifyListeners();
  }

  void reset() {
    if (_finishingPhase) {
      return;
    }
    error = null;

    pause();

    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;
    _phaseClientSessionId = null;

    engine.reset();

    unawaited(_clearTimerState());

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

    unawaited(_saveTimerState());

    if (_settings.autoStart) {
      startOrResume();
      return;
    }

    notifyListeners();
  }

  Future<void> _tick() async {
    if (_finishingPhase) {
      return;
    }

    _syncRemainingSecondsWithClock();

    if (engine.isFinished) {
      await _finishPhaseOnce();
      return;
    }

    notifyListeners();
  }

  void _startTicker() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => _tick(),
    );
  }

  void _syncRemainingSecondsWithClock() {
    final end = _phaseEndsAt;

    if (end == null) {
      return;
    }

    final remaining = end.difference(DateTime.now()).inSeconds;

    engine.remainingSeconds = remaining > 0 ? remaining : 0;
  }

  Future<void> _finishPhaseOnce() async {
    if (_finishingPhase) {
      return;
    }

    _finishingPhase = true;

    _timer?.cancel();
    _timer = null;

    final finishedPhase = engine.phase;
    final startedAt = _phaseStartedAt ?? DateTime.now();
    final endedAt = _phaseEndsAt ?? DateTime.now();

    final durationMinutes = (engine.totalPhaseSeconds / 60).round();

    final session = PomodoroSession(
      clientSessionId: _phaseClientSessionId,
      taskId: finishedPhase == PomodoroPhase.work ? _phaseTask?.remoteId : null,
      localTaskId: finishedPhase == PomodoroPhase.work ? _phaseTask?.localId : null,
      taskTitle: finishedPhase == PomodoroPhase.work ? _phaseTask?.title : null,
      phaseType: finishedPhase.apiValue,
      durationMinutes: durationMinutes,
      completed: true,
      startedAt: startedAt,
      endedAt: endedAt,
    );

    try {
      if (finishedPhase == PomodoroPhase.work) {
        await _localStorage.setJsonObject('last_completed_work', {
          'at': endedAt.toIso8601String(),
        });
      }

      await _sessionService.createSession(session);
    } catch (exception, stackTrace) {
      debugPrint('Session konnte nicht gespeichert werden: $exception');
      debugPrintStack(stackTrace: stackTrace);

      error =
          'Die abgeschlossene Phase konnte nicht gespeichert werden. '
          'Die App läuft weiter, aber die Statistik kann unvollständig sein.';
    }

    if (_settings.soundEnabled) {
      try {
        await _soundService.playPhaseFinishedSound();
      } catch (exception, stackTrace) {
        debugPrint('Sound konnte nicht abgespielt werden: $exception');
        debugPrintStack(stackTrace: stackTrace);
      }
    }

    engine.switchToNextPhase();

    await _showPhaseFinishedNotification(finishedPhase);

    _phaseClientSessionId = null;
    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;

    _finishingPhase = false;
    running = false;

    await _saveTimerState();

    if (_settings.autoStart) {
      startOrResume();
    } else {
      notifyListeners();
    }
  }

  Future<void> _showPhaseFinishedNotification(
    PomodoroPhase finishedPhase,
  ) async {
    try {
      final title = switch (finishedPhase) {
        PomodoroPhase.work => 'Arbeitsphase beendet',
        PomodoroPhase.shortBreak => 'Kurze Pause beendet',
        PomodoroPhase.longBreak => 'Lange Pause beendet',
      };

      final body = switch (engine.phase) {
        PomodoroPhase.work => 'Zeit für die nächste Arbeitsphase.',
        PomodoroPhase.shortBreak => 'Zeit für eine kurze Pause.',
        PomodoroPhase.longBreak => 'Zeit für eine lange Pause.',
      };

      await _notificationService.showLocalInfo(title, body);
    } catch (exception, stackTrace) {
      debugPrint('Benachrichtigung konnte nicht angezeigt werden: $exception');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _rebuildEngine({bool keepPomodoros = false}) {
    final oldPomodoros = keepPomodoros ? engine.completedPomodoros : 0;

    engine = TimerEngine(
      workSeconds: _settings.workMinutes * 60,
      shortBreakSeconds: _settings.shortBreakMinutes * 60,
      longBreakSeconds: _settings.longBreakMinutes * 60,
      longBreakAfter: _settings.longBreakAfter,
      completedPomodoros: oldPomodoros,
    );
  }

  Future<void> _saveTimerState() {
    return _localStorage.setJsonObject(_timerStateStorageKey, {
      'phase': engine.phase.name,
      'remaining_seconds': engine.remainingSeconds,
      'completed_pomodoros': engine.completedPomodoros,
      'running': running,
      'phase_started_at': _phaseStartedAt?.toIso8601String(),
      'phase_ends_at': _phaseEndsAt?.toIso8601String(),
      'phase_client_session_id': _phaseClientSessionId,
      'phase_task': _phaseTask?.toJson(),
      'selected_task': _selectedTask?.toJson(),
      'work_seconds': engine.workSeconds,
      'short_break_seconds': engine.shortBreakSeconds,
      'long_break_seconds': engine.longBreakSeconds,
      'long_break_after': engine.longBreakAfter,
      'saved_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _clearTimerState() {
    return _localStorage.remove(_timerStateStorageKey);
  }

  void _restoreTimerState() {
    final state = _localStorage.getJsonObject(_timerStateStorageKey);

    if (state == null) {
      return;
    }

    try {
      final phase = _phaseFromName(state['phase']?.toString());
      final remainingSeconds = _asInt(state['remaining_seconds']);
      final completedPomodoros = _asInt(state['completed_pomodoros']);
      final workSeconds = _asInt(state['work_seconds']);
      final shortBreakSeconds = _asInt(state['short_break_seconds']);
      final longBreakSeconds = _asInt(state['long_break_seconds']);
      final longBreakAfter = _asInt(state['long_break_after']);

      if (phase == null ||
          remainingSeconds <= 0 ||
          workSeconds <= 0 ||
          shortBreakSeconds <= 0 ||
          longBreakSeconds <= 0 ||
          longBreakAfter <= 0) {
        unawaited(_clearTimerState());
        return;
      }

      engine = TimerEngine(
        workSeconds: workSeconds,
        shortBreakSeconds: shortBreakSeconds,
        longBreakSeconds: longBreakSeconds,
        longBreakAfter: longBreakAfter,
        completedPomodoros: completedPomodoros,
        phase: phase,
        remainingSeconds: remainingSeconds,
      );

      running = state['running'] == true;

      _phaseStartedAt = _parseDateTime(state['phase_started_at']);
      _phaseEndsAt = _parseDateTime(state['phase_ends_at']);
      _phaseClientSessionId = state['phase_client_session_id']?.toString();

      final phaseTaskJson = state['phase_task'];
      if (phaseTaskJson is Map<String, dynamic>) {
        _phaseTask = TaskItem.fromJson(phaseTaskJson);
      }

      final selectedTaskJson = state['selected_task'];
      if (selectedTaskJson is Map<String, dynamic>) {
        _selectedTask = TaskItem.fromJson(selectedTaskJson);
      }

      if (running) {
        _syncRemainingSecondsWithClock();

        if (engine.isFinished) {
          Future.microtask(_finishPhaseOnce);
        } else {
          _startTicker();
        }
      }
    } catch (_) {
      unawaited(_clearTimerState());
    }
  }

  PomodoroPhase? _phaseFromName(String? value) {
    return switch (value) {
      'work' => PomodoroPhase.work,
      'shortBreak' => PomodoroPhase.shortBreak,
      'longBreak' => PomodoroPhase.longBreak,
      _ => null,
    };
  }

  int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../models/app_settings.dart';
import '../models/pomodoro_session.dart';
import '../models/task_item.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';
import '../services/session_service.dart';
import '../services/sound_service.dart';
import '../timer/pomodoro_phase.dart';
import '../timer/timer_engine.dart';

const String _timerStateStorageKey = 'active_timer_state';

class TimerProvider extends ChangeNotifier with WidgetsBindingObserver {
  TimerProvider(
    this._localStorage,
    this._sessionService,
    this._soundService,
    this._notificationService,
  ) {
    WidgetsBinding.instance.addObserver(this);
    _rebuildEngine();
    _restoreTimerState();
  }

  final LocalStorageService _localStorage;
  final SessionService _sessionService;
  final SoundService _soundService;
  final NotificationService _notificationService;

  Future<void> Function()? _onWorkPhaseCompleted;

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
  int _activeSessionSyncs = 0;

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

  bool get isSaving {
    return _finishingPhase;
  }

  bool get isSessionSyncing {
    return _activeSessionSyncs > 0;
  }

  String get sessionSyncLabel {
    if (_activeSessionSyncs <= 1) {
      return 'Abgeschlossene Phase wird im Hintergrund gespeichert.';
    }

    return '$_activeSessionSyncs abgeschlossene Phasen werden im Hintergrund gespeichert.';
  }

  bool get canStartOrResume {
    return !running && !_finishingPhase;
  }

  bool get canReset {
    return !_finishingPhase;
  }

  TaskItem? get activePhaseTask {
    return _phaseTask;
  }

  TaskItem? get selectedTask {
    return _selectedTask;
  }

  TaskItem? get taskForDisplay {
    return _phaseTask ?? _selectedTask;
  }

  String get phaseDescriptionLabel {
    return switch (engine.phase) {
      PomodoroPhase.work => 'Fokuszeit',
      PomodoroPhase.shortBreak => 'Kurze Erholung',
      PomodoroPhase.longBreak => 'Längere Erholung',
    };
  }

  String get nextPhaseLabel {
    return switch (engine.phase) {
      PomodoroPhase.work => _nextBreakPhaseLabel(),
      PomodoroPhase.shortBreak => PomodoroPhase.work.label,
      PomodoroPhase.longBreak => PomodoroPhase.work.label,
    };
  }

  String get phaseProgressLabel {
    final totalSeconds = engine.totalPhaseSeconds;
    final elapsedSeconds =
        (totalSeconds - engine.remainingSeconds).clamp(0, totalSeconds).toInt();

    return '${TimerEngine.formatMMSS(elapsedSeconds)} von '
        '${TimerEngine.formatMMSS(totalSeconds)}';
  }

  String _nextBreakPhaseLabel() {
    final nextCompletedPomodoros = engine.completedPomodoros + 1;
    final shouldUseLongBreak =
        nextCompletedPomodoros % engine.longBreakAfter == 0;

    if (shouldUseLongBreak) {
      return PomodoroPhase.longBreak.label;
    }

    return PomodoroPhase.shortBreak.label;
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  void setWorkPhaseCompletedCallback(
    Future<void> Function() callback,
  ) {
    _onWorkPhaseCompleted = callback;
  }

  void syncWithRealTime() {
    if (!running || _finishingPhase) {
      return;
    }

    _syncRemainingSecondsWithClock();

    if (engine.isFinished) {
      unawaited(_finishPhaseOnce());
      return;
    }

    unawaited(_saveTimerState());
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
    if (!canChangeTask) {
      return;
    }

    if (_sameTaskSnapshot(_selectedTask, task)) {
      return;
    }

    _selectedTask = task;

    unawaited(_saveTimerState());

    notifyListeners();
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

  Future<void> clearForLogout() async {
    _timer?.cancel();
    _timer = null;

    running = false;
    _finishingPhase = false;
    _activeSessionSyncs = 0;
    error = null;

    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;
    _phaseClientSessionId = null;
    _selectedTask = null;

    _rebuildEngine();

    await _clearTimerState();

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
      localTaskId:
          finishedPhase == PomodoroPhase.work ? _phaseTask?.localId : null,
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
          'at': session.endedAt.toIso8601String(),
        });
      }

      await _sessionService.queueSessionForRetry(session);
    } catch (exception, stackTrace) {
      debugPrint('Session konnte nicht lokal vorgemerkt werden: $exception');
      debugPrintStack(stackTrace: stackTrace);

      error = 'Die abgeschlossene Phase konnte nicht lokal gespeichert werden.';
      _finishingPhase = false;
      running = false;

      await _saveTimerState();

      notifyListeners();
      return;
    }

    engine.switchToNextPhase();

    final nextPhase = engine.phase;

    _phaseClientSessionId = null;
    _phaseStartedAt = null;
    _phaseEndsAt = null;
    _phaseTask = null;

    _finishingPhase = false;
    running = false;

    await _saveTimerState();

    unawaited(
      _saveFinishedPhaseInBackground(
        session: session,
        finishedPhase: finishedPhase,
      ),
    );

    unawaited(_playPhaseFinishedSoundInBackground());

    unawaited(
      _showPhaseFinishedNotification(
        finishedPhase,
        nextPhase,
      ),
    );

    if (_settings.autoStart) {
      startOrResume();
    } else {
      notifyListeners();
    }
  }

  Future<void> _saveFinishedPhaseInBackground({
    required PomodoroSession session,
    required PomodoroPhase finishedPhase,
  }) async {
    _activeSessionSyncs++;
    notifyListeners();

    try {
      await _sessionService.syncPendingSessions();

      if (finishedPhase == PomodoroPhase.work) {
        await _notifyWorkPhaseCompleted();
      }
    } catch (exception, stackTrace) {
      debugPrint('Session konnte nicht synchronisiert werden: $exception');
      debugPrintStack(stackTrace: stackTrace);

      error = 'Die abgeschlossene Phase wurde lokal gespeichert, '
          'aber noch nicht mit dem Backend synchronisiert.';
    } finally {
      if (_activeSessionSyncs > 0) {
        _activeSessionSyncs--;
      }

      notifyListeners();
    }
  }

  Future<void> _playPhaseFinishedSoundInBackground() async {
    if (!_settings.soundEnabled) {
      return;
    }

    try {
      await _soundService.playPhaseFinishedSound();
    } catch (exception, stackTrace) {
      debugPrint('Sound konnte nicht abgespielt werden: $exception');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _notifyWorkPhaseCompleted() async {
    final callback = _onWorkPhaseCompleted;

    if (callback == null) {
      return;
    }

    try {
      await callback();
    } catch (exception, stackTrace) {
      debugPrint(
          'Aufgaben-Zähler konnten nicht aktualisiert werden: $exception');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _showPhaseFinishedNotification(
    PomodoroPhase finishedPhase,
    PomodoroPhase nextPhase,
  ) async {
    try {
      final title = switch (finishedPhase) {
        PomodoroPhase.work => 'Arbeitsphase beendet',
        PomodoroPhase.shortBreak => 'Kurze Pause beendet',
        PomodoroPhase.longBreak => 'Lange Pause beendet',
      };

      final body = switch (nextPhase) {
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

  bool _sameTaskSnapshot(TaskItem? first, TaskItem? second) {
    if (first == null || second == null) {
      return first == null && second == null;
    }

    return _sameTaskIdentity(first, second) &&
        first.remoteId == second.remoteId &&
        first.title == second.title &&
        first.completed == second.completed &&
        first.completedPomodoros == second.completedPomodoros;
  }

  bool _sameTaskIdentity(TaskItem first, TaskItem second) {
    if (first.remoteId != null && second.remoteId != null) {
      return first.remoteId == second.remoteId;
    }

    return first.localId == second.localId;
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
      final savedAt = _parseDateTime(state['saved_at']);

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
        _restoreRunningTimer(
          savedAt: savedAt,
          savedRemainingSeconds: remainingSeconds,
        );
      }
    } catch (_) {
      unawaited(_clearTimerState());
    }
  }

  void _restoreRunningTimer({
    required DateTime? savedAt,
    required int savedRemainingSeconds,
  }) {
    if (_phaseEndsAt == null) {
      final elapsedSeconds =
          savedAt == null ? 0 : DateTime.now().difference(savedAt).inSeconds;

      final normalizedElapsedSeconds =
          elapsedSeconds.clamp(0, savedRemainingSeconds).toInt();

      final recoveredRemainingSeconds =
          savedRemainingSeconds - normalizedElapsedSeconds;

      engine.remainingSeconds =
          recoveredRemainingSeconds > 0 ? recoveredRemainingSeconds : 0;

      if (engine.isFinished) {
        _phaseEndsAt = DateTime.now();
      } else {
        _phaseEndsAt = DateTime.now().add(
          Duration(seconds: engine.remainingSeconds),
        );
      }
    } else {
      _syncRemainingSecondsWithClock();
    }

    if (_phaseStartedAt == null && _phaseEndsAt != null) {
      _phaseStartedAt = _phaseEndsAt!.subtract(
        Duration(seconds: engine.totalPhaseSeconds),
      );
    }

    _phaseClientSessionId ??= const Uuid().v4();

    if (engine.isFinished) {
      Future.microtask(_finishPhaseOnce);
      return;
    }

    _startTicker();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      syncWithRealTime();
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      unawaited(_saveTimerState());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();

    super.dispose();
  }
}

import 'package:flutter/foundation.dart';

import '../models/stats.dart';
import '../services/stats_service.dart';

class StatsProvider extends ChangeNotifier {
  StatsProvider(this._statsService);

  final StatsService _statsService;

  StatsResponse stats = StatsResponse.empty();
  TaskStatsResponse taskStats = TaskStatsResponse.empty();

  bool loading = false;
  bool taskStatsLoading = false;

  String? error;
  String? taskStatsError;
  Future<StatsResponse> Function()? _lastStatsLoader;
  bool _taskStatsLoadedOnce = false;

  void clear() {
    stats = StatsResponse.empty();
    taskStats = TaskStatsResponse.empty();
    loading = false;
    taskStatsLoading = false;
    error = null;
    taskStatsError = null;
    _lastStatsLoader = null;
    _taskStatsLoadedOnce = false;
    notifyListeners();
  }

  Future<void> loadWeek(DateTime date) async {
    _lastStatsLoader = () => _statsService.week(date);
    await _load(_lastStatsLoader!);
  }

  Future<void> loadMonth(int year, int month) async {
    _lastStatsLoader = () => _statsService.month(year, month);
    await _load(_lastStatsLoader!);
  }

  Future<void> loadYear(int year) async {
    _lastStatsLoader = () => _statsService.year(year);
    await _load(_lastStatsLoader!);
  }

  Future<void> loadDaily() async {
    await loadWeek(DateTime.now());
  }

  Future<void> loadWeekly() async {
    final now = DateTime.now();

    await loadMonth(now.year, now.month);
  }

  Future<void> loadMonthly() async {
    await loadYear(DateTime.now().year);
  }

  Future<void> loadTaskStats() async {
    _taskStatsLoadedOnce = true;
    taskStatsLoading = true;
    taskStatsError = null;
    notifyListeners();

    try {
      taskStats = await _statsService.taskStats();
    } catch (_) {
      taskStatsError = 'Aufgabenstatistik konnte nicht geladen werden.';
    } finally {
      taskStatsLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCurrent() async {
    final loaders = <Future<void> Function()>[];

    final statsLoader = _lastStatsLoader;

    if (statsLoader != null) {
      loaders.add(() => _load(statsLoader));
    }

    if (_taskStatsLoadedOnce) {
      loaders.add(loadTaskStats);
    }

    if (loaders.isEmpty) {
      return;
    }

    await Future.wait(
      loaders.map((loader) => loader()),
    );
  }

  Future<void> _load(Future<StatsResponse> Function() loader) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      stats = await loader();
    } catch (_) {
      error =
          'Statistiken konnten nicht geladen werden. Bitte anmelden und Internetverbindung prüfen.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

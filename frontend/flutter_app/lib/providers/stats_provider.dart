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

  void clear() {
    stats = StatsResponse.empty();
    taskStats = TaskStatsResponse.empty();
    loading = false;
    taskStatsLoading = false;
    error = null;
    taskStatsError = null;
    notifyListeners();
  }

  Future<void> loadWeek(DateTime date) async {
    await _load(() => _statsService.week(date));
  }

  Future<void> loadMonth(int year, int month) async {
    await _load(() => _statsService.month(year, month));
  }

  Future<void> loadYear(int year) async {
    await _load(() => _statsService.year(year));
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
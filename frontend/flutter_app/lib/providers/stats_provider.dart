import 'package:flutter/foundation.dart';
import '../models/stats.dart';
import '../services/stats_service.dart';

class StatsProvider extends ChangeNotifier {
  StatsProvider(this._statsService);
  final StatsService _statsService;

  StatsResponse stats = StatsResponse.empty();
  bool loading = false;
  String? error;

  Future<void> loadDaily() async => _load(_statsService.daily);
  Future<void> loadWeekly() async => _load(_statsService.weekly);
  Future<void> loadMonthly() async => _load(_statsService.monthly);

  Future<void> _load(Future<StatsResponse> Function() loader) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      stats = await loader();
    } catch (e) {
      error = 'Statistiken konnten nicht geladen werden. Bitte anmelden und Internetverbindung prüfen.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

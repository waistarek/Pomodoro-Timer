import '../models/stats.dart';
import 'api_client.dart';
import 'local_storage_service.dart';

class StatsService {
  StatsService({
    required this.apiClient,
    required this.localStorage,
  });

  final ApiClient apiClient;
  final LocalStorageService localStorage;

  Future<StatsResponse> week(DateTime date) async {
    final queryDate = _formatDate(date);

    return StatsResponse.fromJson(
      await apiClient.get('/stats/week?date=$queryDate'),
    );
  }

  Future<StatsResponse> month(int year, int month) async {
    return StatsResponse.fromJson(
      await apiClient.get('/stats/month?year=$year&month=$month'),
    );
  }

  Future<StatsResponse> year(int year) async {
    return StatsResponse.fromJson(
      await apiClient.get('/stats/year?year=$year'),
    );
  }

  Future<StatsResponse> daily() async {
    return week(DateTime.now());
  }

  Future<StatsResponse> weekly() async {
    final now = DateTime.now();

    return month(now.year, now.month);
  }

  Future<StatsResponse> monthly() async {
    return year(DateTime.now().year);
  }

  Future<int> todayPomodoros({DateTime? now}) async {
    final currentDate = now ?? DateTime.now();
    final todayKey = _formatDate(currentDate);
    final localPendingPomodoros = _todayPomodorosFromLocalSessions(todayKey);

    if (localStorage.token == null) {
      return localPendingPomodoros;
    }

    try {
      final response = await week(currentDate);
      final backendPomodoros = response.items
          .where((item) => item.label == todayKey)
          .fold<int>(0, (sum, item) => sum + item.pomodoros);

      return backendPomodoros + localPendingPomodoros;
    } catch (_) {
      return localPendingPomodoros;
    }
  }

  int _todayPomodorosFromLocalSessions(String todayKey) {
    final localSessions = [
      ...localStorage.getJsonList('guest_sessions'),
      ...localStorage.getJsonList('pending_sessions'),
    ];

    final seenClientSessionIds = <String>{};
    var count = 0;

    for (final session in localSessions) {
      final clientSessionId = session['client_session_id']?.toString();

      if (clientSessionId != null &&
          !seenClientSessionIds.add(clientSessionId)) {
        continue;
      }

      final completed = session['completed'] == true;
      final phaseType = session['phase_type']?.toString();
      final endedAtRaw = session['ended_at']?.toString();
      final endedAt = endedAtRaw == null ? null : DateTime.tryParse(endedAtRaw);

      if (!completed || phaseType != 'work' || endedAt == null) {
        continue;
      }

      if (_formatDate(endedAt.toLocal()) == todayKey) {
        count++;
      }
    }

    return count;
  }

  Future<TaskStatsResponse> taskStats() async {
    if (localStorage.token != null) {
      return TaskStatsResponse.fromJson(await apiClient.get('/stats/tasks'));
    }

    final localSessions = localStorage.getJsonList('guest_sessions');

    return TaskStatsResponse.fromLocalSessions(localSessions);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}

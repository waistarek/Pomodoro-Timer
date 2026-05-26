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
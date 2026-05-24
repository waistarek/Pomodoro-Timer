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

  Future<StatsResponse> daily() async =>
      StatsResponse.fromJson(await apiClient.get('/stats/daily'));
  Future<StatsResponse> weekly() async =>
      StatsResponse.fromJson(await apiClient.get('/stats/weekly'));
  Future<StatsResponse> monthly() async =>
      StatsResponse.fromJson(await apiClient.get('/stats/monthly'));

  Future<TaskStatsResponse> taskStats() async {
    if (localStorage.token != null) {
      return TaskStatsResponse.fromJson(await apiClient.get('/stats/tasks'));
    }

    final localSessions = localStorage.getJsonList('guest_sessions');
    return TaskStatsResponse.fromLocalSessions(localSessions);
  }
}

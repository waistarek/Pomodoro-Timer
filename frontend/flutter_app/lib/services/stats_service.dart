import '../models/stats.dart';
import 'api_client.dart';

class StatsService {
  StatsService({required this.apiClient});
  final ApiClient apiClient;

  Future<StatsResponse> daily() async => StatsResponse.fromJson(await apiClient.get('/stats/daily'));
  Future<StatsResponse> weekly() async => StatsResponse.fromJson(await apiClient.get('/stats/weekly'));
  Future<StatsResponse> monthly() async => StatsResponse.fromJson(await apiClient.get('/stats/monthly'));
}

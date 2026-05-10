import '../models/app_settings.dart';
import 'api_client.dart';

class SettingsService {
  SettingsService({required this.apiClient});
  final ApiClient apiClient;

  Future<AppSettings> getSettings() async {
    final data = await apiClient.get('/settings');
    return AppSettings.fromJson(data);
  }

  Future<AppSettings> updateSettings(AppSettings settings) async {
    final data = await apiClient.put('/settings', settings.toJson());
    return AppSettings.fromJson(data);
  }
}

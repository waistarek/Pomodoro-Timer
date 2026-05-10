import '../models/pomodoro_session.dart';
import 'api_client.dart';

class SessionService {
  SessionService({required this.apiClient});
  final ApiClient apiClient;

  Future<void> createSession(PomodoroSession session) async {
    await apiClient.post('/sessions', session.toJson());
  }
}

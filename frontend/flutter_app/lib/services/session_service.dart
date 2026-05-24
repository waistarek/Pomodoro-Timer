import '../models/pomodoro_session.dart';
import 'api_client.dart';
import 'local_storage_service.dart';

class SessionService {
  SessionService({
    required this.apiClient,
    required this.localStorage,
  });

  final ApiClient apiClient;
  final LocalStorageService localStorage;

  static const String _guestSessionsKey = 'guest_sessions';

  Future<void> createSession(PomodoroSession session) async {
    if (localStorage.token != null) {
      await apiClient.post('/sessions', session.toJson());
      return;
    }

    await _saveGuestSession(session);
  }

  Future<List<PomodoroSession>> getGuestSessions() async {
    return localStorage
        .getJsonList(_guestSessionsKey)
        .map(PomodoroSession.fromJson)
        .toList();
  }

  Future<void> _saveGuestSession(PomodoroSession session) async {
    final sessions = localStorage.getJsonList(_guestSessionsKey);
    sessions.add(session.toJson());
    await localStorage.setJsonList(_guestSessionsKey, sessions);
  }
}

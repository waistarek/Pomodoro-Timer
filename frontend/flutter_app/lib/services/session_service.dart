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
  static const String _pendingSessionsKey = 'pending_sessions';

  Future<void> createSession(PomodoroSession session) async {
    if (localStorage.token == null) {
      await _saveGuestSession(session);
      return;
    }

    await syncPendingSessions();

    try {
      await apiClient.post('/sessions', session.toJson());
    } catch (error) {
      if (_shouldQueue(error)) {
        await _queuePendingSession(session);
        return;
      }

      rethrow;
    }
  }

  Future<List<PomodoroSession>> getGuestSessions() async {
    return localStorage
        .getJsonList(_guestSessionsKey)
        .map(PomodoroSession.fromJson)
        .toList();
  }

  Future<void> syncPendingSessions() async {
    if (localStorage.token == null) {
      return;
    }

    final pending = localStorage.getJsonList(_pendingSessionsKey);

    if (pending.isEmpty) {
      return;
    }

    final remaining = <Map<String, dynamic>>[];

    for (final item in pending) {
      try {
        final session = PomodoroSession.fromJson(item);
        await apiClient.post('/sessions', session.toJson());
      } catch (_) {
        remaining.add(item);
      }
    }

    await localStorage.setJsonList(_pendingSessionsKey, remaining);
  }

  Future<void> _saveGuestSession(PomodoroSession session) async {
    final sessions = localStorage.getJsonList(_guestSessionsKey);
    sessions.add(session.toJson());
    await localStorage.setJsonList(_guestSessionsKey, sessions);
  }

  Future<void> _queuePendingSession(PomodoroSession session) async {
    final pending = localStorage.getJsonList(_pendingSessionsKey);
    pending.add(session.toJson());
    await localStorage.setJsonList(_pendingSessionsKey, pending);
  }

  bool _shouldQueue(Object error) {
    if (error is ApiException) {
      final statusCode = error.statusCode;

      if (statusCode == null) {
        return true;
      }

      return statusCode >= 500;
    }

    return true;
  }
}
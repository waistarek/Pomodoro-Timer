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

  bool get canSync => localStorage.token != null;

  int get pendingSessionCount {
    return localStorage.getJsonList(_guestSessionsKey).length +
        localStorage.getJsonList(_pendingSessionsKey).length;
  }

  Future<void> createSession(PomodoroSession session) async {
    if (localStorage.token == null) {
      await _saveGuestSession(session);
      return;
    }

    await _queuePendingSession(session);
    await syncPendingSessions();
  }

  Future<List<PomodoroSession>> getGuestSessions() async {
    return localStorage
        .getJsonList(_guestSessionsKey)
        .map(PomodoroSession.fromJson)
        .toList();
  }

  Future<void> syncStoredSessions() async {
    if (localStorage.token == null) {
      return;
    }

    await _moveGuestSessionsToPending();
    await syncPendingSessions();
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
      } catch (error) {
        if (_shouldQueue(error)) {
          remaining.add(item);
        }
      }
    }

    await localStorage.setJsonList(
      _pendingSessionsKey,
      _deduplicateByClientSessionId(remaining),
    );
  }

  Future<void> _moveGuestSessionsToPending() async {
    final guestSessions = localStorage.getJsonList(_guestSessionsKey);

    if (guestSessions.isEmpty) {
      return;
    }

    var pending = localStorage.getJsonList(_pendingSessionsKey);

    for (final item in guestSessions) {
      final session = PomodoroSession.fromJson(item);
      pending = _upsertByClientSessionId(pending, session);
    }

    await localStorage.setJsonList(
      _pendingSessionsKey,
      _deduplicateByClientSessionId(pending),
    );

    await localStorage.remove(_guestSessionsKey);
  }

  Future<void> _saveGuestSession(PomodoroSession session) async {
    final sessions = localStorage.getJsonList(_guestSessionsKey);
    final updated = _upsertByClientSessionId(sessions, session);

    await localStorage.setJsonList(_guestSessionsKey, updated);
  }

  Future<void> _queuePendingSession(PomodoroSession session) async {
    final pending = localStorage.getJsonList(_pendingSessionsKey);
    final updated = _upsertByClientSessionId(pending, session);

    await localStorage.setJsonList(_pendingSessionsKey, updated);
  }

  List<Map<String, dynamic>> _upsertByClientSessionId(
    List<Map<String, dynamic>> items,
    PomodoroSession session,
  ) {
    final sessionJson = session.toJson();
    final clientSessionId = session.clientSessionId;

    if (clientSessionId == null) {
      return [...items, sessionJson];
    }

    final index = items.indexWhere(
      (item) => item['client_session_id']?.toString() == clientSessionId,
    );

    if (index == -1) {
      return [...items, sessionJson];
    }

    return [
      for (var i = 0; i < items.length; i++)
        if (i == index) sessionJson else items[i],
    ];
  }

  List<Map<String, dynamic>> _deduplicateByClientSessionId(
    List<Map<String, dynamic>> items,
  ) {
    final seen = <String>{};
    final result = <Map<String, dynamic>>[];

    for (final item in items) {
      final clientSessionId = item['client_session_id']?.toString();

      if (clientSessionId == null) {
        result.add(item);
        continue;
      }

      if (seen.contains(clientSessionId)) {
        continue;
      }

      seen.add(clientSessionId);
      result.add(item);
    }

    return result;
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

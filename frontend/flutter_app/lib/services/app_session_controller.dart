import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';
import '../providers/timer_provider.dart';

class AppSessionController {
  AppSessionController({
    required this.authProvider,
    required this.taskProvider,
    required this.settingsProvider,
    required this.statsProvider,
    required this.sessionSyncProvider,
    required this.timerProvider,
  });

  final AuthProvider authProvider;
  final TaskProvider taskProvider;
  final SettingsProvider settingsProvider;
  final StatsProvider statsProvider;
  final SessionSyncProvider sessionSyncProvider;
  final TimerProvider timerProvider;

  bool _clearingSession = false;

  Future<void> logout() async {
    await _clearSession(
      authAction: authProvider.logout,
    );
  }

  Future<void> handleUnauthorizedSession() async {
    await _clearSession(
      authAction: authProvider.handleUnauthorizedSession,
    );
  }

  Future<void> _clearSession({
    required Future<void> Function() authAction,
  }) async {
    if (_clearingSession) {
      return;
    }

    _clearingSession = true;

    try {
      await timerProvider.clearForLogout();
      await authAction();

      taskProvider.clear();
      await settingsProvider.resetLocal();
      statsProvider.clear();
      sessionSyncProvider.clear();
    } finally {
      _clearingSession = false;
    }
  }
}

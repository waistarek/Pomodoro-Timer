import 'dart:async';

import 'package:flutter/foundation.dart';

import '../services/session_service.dart';

class SessionSyncProvider extends ChangeNotifier {
  SessionSyncProvider(this._sessionService);

  final SessionService _sessionService;

  bool syncing = false;
  String? error;
  int pendingCount = 0;

  bool get canSync => _sessionService.canSync;

  bool get shouldShow {
    return syncing || pendingCount > 0 || error != null;
  }

  String get statusText {
    if (syncing) {
      if (pendingCount <= 1) {
        return 'Eine Sitzung wird mit deinem Konto synchronisiert.';
      }

      return '$pendingCount Sitzungen werden mit deinem Konto synchronisiert.';
    }

    if (!canSync && pendingCount > 0) {
      if (pendingCount == 1) {
        return 'Eine lokale Sitzung wird nach dem Login synchronisiert.';
      }

      return '$pendingCount lokale Sitzungen werden nach dem Login synchronisiert.';
    }

    if (pendingCount > 0) {
      if (pendingCount == 1) {
        return 'Eine Sitzung wartet auf Synchronisierung.';
      }

      return '$pendingCount Sitzungen warten auf Synchronisierung.';
    }

    return 'Synchronisierung abgeschlossen.';
  }

  void init() {
    refreshPendingCount();
    unawaited(syncStoredSessions());
  }

  void refreshPendingCount() {
    pendingCount = _sessionService.pendingSessionCount;
    notifyListeners();
  }

  void clear() {
    syncing = false;
    error = null;
    pendingCount = 0;
    notifyListeners();
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  Future<void> syncStoredSessions() async {
    if (syncing) {
      return;
    }

    pendingCount = _sessionService.pendingSessionCount;

    if (!_sessionService.canSync || pendingCount == 0) {
      notifyListeners();
      return;
    }

    syncing = true;
    error = null;
    notifyListeners();

    try {
      await _sessionService.syncStoredSessions();
    } catch (_) {
      error =
          'Sitzungen konnten gerade nicht synchronisiert werden. Es wird später erneut versucht.';
    } finally {
      pendingCount = _sessionService.pendingSessionCount;
      syncing = false;
      notifyListeners();
    }
  }
}

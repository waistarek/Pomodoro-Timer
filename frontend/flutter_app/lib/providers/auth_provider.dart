import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../services/api_client.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);

  final AuthService _authService;

  UserProfile? user;
  bool loading = false;
  String? error;

  bool get isLoggedIn => user != null;

  Future<void> loadLocalSession() async {
    if (!_authService.hasLocalToken) {
      _authService.useGuestScope();
      user = null;
      notifyListeners();
      return;
    }

    loading = true;
    error = null;
    notifyListeners();

    try {
      final currentUser = await _authService.me();

      _authService.useUserScope(currentUser.id);
      user = currentUser;
    } on ApiException catch (e) {
      user = null;
      _authService.useGuestScope();

      if (e.statusCode == 401 || e.statusCode == 403) {
        await _authService.clearLocalToken();
      } else {
        debugPrint('Lokale Sitzung konnte nicht geprüft werden: $e');
      }
    } catch (e, stackTrace) {
      user = null;
      _authService.useGuestScope();

      debugPrint('Lokale Sitzung konnte nicht geprüft werden: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.register(email, password);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> login(
    String email,
    String password, {
    bool rememberSession = true,
  }) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.login(
        email,
        password,
        rememberSession: rememberSession,
      );
      user = await _authService.me();
      _authService.useUserScope(user!.id);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.requestPasswordReset(email);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword(String token, String newPassword) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.resetPassword(
        token: token,
        newPassword: newPassword,
      );

      await _authService.logout();
      user = null;

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> handleUnauthorizedSession() async {
    await _authService.logout();

    user = null;
    loading = false;
    error = 'Deine Sitzung ist abgelaufen. Bitte logge dich erneut ein.';

    notifyListeners();
  }

  Future<bool> loginWithGoogleIdToken(
    String idToken, {
    required String mode,
    bool rememberSession = true,
  }) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.loginWithGoogleIdToken(
        idToken,
        mode: mode,
        rememberSession: rememberSession,
      );

      user = await _authService.me();
      _authService.useUserScope(user!.id);
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setError(String message) {
    error = message;
    loading = false;
    notifyListeners();
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _authService.useGuestScope();
    user = null;
    notifyListeners();
  }
}

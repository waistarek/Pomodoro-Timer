import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);

  final AuthService _authService;
  UserProfile? user;
  bool loading = false;
  String? error;

  bool get isLoggedIn => user != null || _authService.hasLocalToken;

  Future<void> loadLocalSession() async {
    if (!_authService.hasLocalToken) return;
    try {
      user = await _authService.me();
      notifyListeners();
    } catch (_) {
      await _authService.logout();
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

  Future<bool> login(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await _authService.login(email, password);
      user = await _authService.me();
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
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }
}

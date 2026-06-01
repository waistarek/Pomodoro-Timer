import '../models/user_profile.dart';
import 'api_client.dart';
import 'local_storage_service.dart';

class AuthService {
  AuthService({required this.apiClient, required this.localStorage});

  final ApiClient apiClient;
  final LocalStorageService localStorage;

  bool get hasLocalToken => localStorage.token != null;
  Future<void> clearLocalToken() => localStorage.clearToken();

  Future<UserProfile> register(String email, String password) async {
    final data = await apiClient.post(
        '/auth/register', {'email': email, 'password': password},
        auth: false);
    return UserProfile.fromJson(data);
  }

  Future<void> login(
    String email,
    String password, {
    bool rememberSession = true,
  }) async {
    final data = await apiClient.post(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
      auth: false,
    );

    await localStorage.setToken(
      data['access_token'],
      persist: rememberSession,
    );
  }

  Future<void> requestPasswordReset(String email) async {
    await apiClient.post(
      '/auth/request-password-reset',
      {
        'email': email.trim().toLowerCase(),
      },
      auth: false,
    );
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await apiClient.post(
      '/auth/reset-password',
      {
        'token': token,
        'new_password': newPassword,
      },
      auth: false,
    );
  }

  Future<UserProfile> me() async {
    final data = await apiClient.get('/users/me');
    return UserProfile.fromJson(data);
  }

  Future<void> logout() async {
    await localStorage.clearToken();
    await localStorage.clearUserData();
  }
}

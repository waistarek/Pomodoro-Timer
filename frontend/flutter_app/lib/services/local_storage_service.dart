import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get token => _prefs.getString('auth_token');

  Future<void> setToken(String token) => _prefs.setString('auth_token', token);

  Future<void> clearToken() => _prefs.remove('auth_token');

  Map<String, dynamic>? getJsonObject(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> setJsonObject(String key, Map<String, dynamic> value) {
    return _prefs.setString(key, jsonEncode(value));
  }

  List<Map<String, dynamic>> getJsonList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  Future<void> setJsonList(String key, List<Map<String, dynamic>> value) {
    return _prefs.setString(key, jsonEncode(value));
  }

  Future<void> remove(String key) => _prefs.remove(key);

  Future<void> clearUserData() async {
    await Future.wait([
      _prefs.remove('tasks'),
      _prefs.remove('settings'),
      _prefs.remove('guest_sessions'),
      _prefs.remove('pending_sessions'),
      _prefs.remove('last_completed_work'),
    ]);
  }
}

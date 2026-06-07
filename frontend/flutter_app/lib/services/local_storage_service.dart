import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _prefs;
  String _scope = 'guest';

  String get scope => _scope;

  void useGuestScope() {
    _scope = 'guest';
  }

  void useUserScope(int userId) {
    _scope = 'user_$userId';
  }

  String _scopedKey(String key) {
    return '$_scope:$key';
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? _memoryToken;

  String? get token => _memoryToken ?? _prefs.getString('auth_token');

  Future<void> setToken(String token, {bool persist = true}) async {
    if (persist) {
      _memoryToken = null;
      await _prefs.setString('auth_token', token);
      return;
    }

    _memoryToken = token;
    await _prefs.remove('auth_token');
  }

  Future<void> clearToken() async {
    _memoryToken = null;
    await _prefs.remove('auth_token');
  }

  String? getGlobalString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setGlobalString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<void> removeGlobal(String key) {
    return _prefs.remove(key);
  }

  Map<String, dynamic>? getJsonObject(String key) {
    final raw = _prefs.getString(_scopedKey(key));
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> setJsonObject(String key, Map<String, dynamic> value) {
    return _prefs.setString(_scopedKey(key), jsonEncode(value));
  }

  List<Map<String, dynamic>> getJsonList(String key) {
    final raw = _prefs.getString(_scopedKey(key));
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  Future<void> setJsonList(String key, List<Map<String, dynamic>> value) {
    return _prefs.setString(_scopedKey(key), jsonEncode(value));
  }

  Future<void> remove(String key) {
    return _prefs.remove(_scopedKey(key));
  }

  Future<void> clearUserData() async {
    await Future.wait([
      _prefs.remove('tasks'),
      _prefs.remove('settings'),
      _prefs.remove('guest_sessions'),
      _prefs.remove('pending_sessions'),
      _prefs.remove('last_completed_work'),
      _prefs.remove('active_timer_state'),
      _prefs.remove('selected_task_state'),
    ]);
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _prefs;
  String _scope = guestScope;

  static const String guestScope = 'guest';

  String get scope => _scope;

  bool get isGuestScope => _scope == guestScope;

  void useGuestScope() {
    _scope = guestScope;
  }

  void useUserScope(int userId) {
    _scope = 'user_$userId';
  }

  String _scopedKey(String key) {
    return scopedKeyFor(_scope, key);
  }

  String scopedKeyFor(String scope, String key) {
    return '$scope:$key';
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
    return getJsonListInScope(_scope, key);
  }

  Future<void> setJsonList(String key, List<Map<String, dynamic>> value) {
    return setJsonListInScope(_scope, key, value);
  }

  Future<void> remove(String key) {
    return removeInScope(_scope, key);
  }

  List<Map<String, dynamic>> getJsonListInScope(String scope, String key) {
    final raw = _prefs.getString(scopedKeyFor(scope, key));
    if (raw == null) return [];

    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  Future<void> setJsonListInScope(
    String scope,
    String key,
    List<Map<String, dynamic>> value,
  ) {
    return _prefs.setString(scopedKeyFor(scope, key), jsonEncode(value));
  }

  Future<void> removeInScope(String scope, String key) {
    return _prefs.remove(scopedKeyFor(scope, key));
  }

  Future<void> clearScopedData(String scope) async {
    await Future.wait([
      _prefs.remove(scopedKeyFor(scope, 'tasks')),
      _prefs.remove(scopedKeyFor(scope, 'settings')),
      _prefs.remove(scopedKeyFor(scope, 'guest_sessions')),
      _prefs.remove(scopedKeyFor(scope, 'pending_sessions')),
      _prefs.remove(scopedKeyFor(scope, 'last_completed_work')),
      _prefs.remove(scopedKeyFor(scope, 'active_timer_state')),
      _prefs.remove(scopedKeyFor(scope, 'selected_task_state')),
    ]);
  }

  Future<void> clearUserData() async {
    await clearScopedData(_scope);
  }
}

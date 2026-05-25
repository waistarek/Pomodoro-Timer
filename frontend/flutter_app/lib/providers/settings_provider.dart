import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../services/local_storage_service.dart';
import '../services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._localStorage, this._settingsService);

  final LocalStorageService _localStorage;
  final SettingsService _settingsService;

  AppSettings settings = const AppSettings();
  bool loading = false;
  String? error;

  Future<void> resetLocal() async {
    settings = const AppSettings();
    loading = false;
    error = null;
    notifyListeners();
  }

  Future<void> load() async {
    final local = _localStorage.getJsonObject('settings');
    if (local != null) {
      settings = AppSettings.fromJson(local);
      notifyListeners();
    }
  }

  Future<void> save(AppSettings newSettings, {bool sync = false}) async {
    settings = newSettings;
    error = null;

    await _localStorage.setJsonObject('settings', settings.toJson());
    notifyListeners();

    final shouldSync = sync || _localStorage.token != null;

    if (!shouldSync) {
      return;
    }

    try {
      settings = await _settingsService.updateSettings(settings);
      await _localStorage.setJsonObject('settings', settings.toJson());
    } catch (e) {
      error =
          'Einstellungen lokal gespeichert, aber noch nicht synchronisiert.';
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadRemoteSettings() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      settings = await _settingsService.getSettings();
      await _localStorage.setJsonObject('settings', settings.toJson());
    } catch (e) {
      error =
          'Einstellungen konnten nicht vom Backend geladen werden. Lokale Einstellungen werden verwendet.';
      await load();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

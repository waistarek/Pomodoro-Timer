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
    await _localStorage.setJsonObject('settings', settings.toJson());
    notifyListeners();
    if (sync) {
      try {
        settings = await _settingsService.updateSettings(settings);
        await _localStorage.setJsonObject('settings', settings.toJson());
        notifyListeners();
      } catch (e) {
        error =
            'Einstellungen lokal gespeichert, aber noch nicht synchronisiert.';
      }
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import '../services/local_storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._localStorage);

  static const String systemLocaleCode = 'system';
  static const String _storageKey = 'app_locale';

  final LocalStorageService _localStorage;

  String _localeCode = systemLocaleCode;

  String get localeCode => _localeCode;

  Locale? get locale {
    if (_localeCode == systemLocaleCode) {
      return null;
    }

    return Locale(_localeCode);
  }

  Future<void> load() async {
    final storedLocaleCode = _localStorage.getGlobalString(_storageKey);
    _localeCode = _normalizeLocaleCode(storedLocaleCode);
    notifyListeners();
  }

  Future<void> setLocaleCode(String localeCode) async {
    final nextLocaleCode = _normalizeLocaleCode(localeCode);

    if (nextLocaleCode == _localeCode) {
      return;
    }

    _localeCode = nextLocaleCode;

    if (_localeCode == systemLocaleCode) {
      await _localStorage.removeGlobal(_storageKey);
    } else {
      await _localStorage.setGlobalString(_storageKey, _localeCode);
    }

    notifyListeners();
  }

  String _normalizeLocaleCode(String? localeCode) {
    final normalized = localeCode?.trim().toLowerCase();

    if (normalized == null || normalized.isEmpty) {
      return systemLocaleCode;
    }

    if (normalized == systemLocaleCode) {
      return systemLocaleCode;
    }

    final isSupported = AppLocalizations.supportedLocales.any(
      (locale) => locale.languageCode == normalized,
    );

    if (!isSupported) {
      return systemLocaleCode;
    }

    return normalized;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppSettings? _draftSettings;
  bool _saving = false;

  bool _settingsEqual(AppSettings a, AppSettings b) {
    return a.workMinutes == b.workMinutes &&
        a.shortBreakMinutes == b.shortBreakMinutes &&
        a.longBreakMinutes == b.longBreakMinutes &&
        a.longBreakAfter == b.longBreakAfter &&
        a.autoStart == b.autoStart &&
        a.soundEnabled == b.soundEnabled &&
        a.vibrationEnabled == b.vibrationEnabled &&
        a.theme == b.theme &&
        a.colorName == b.colorName &&
        a.appLocale == b.appLocale;
  }

  void _updateDraft(AppSettings Function(AppSettings current) update) {
    final current = _draftSettings;

    if (current == null) {
      return;
    }

    setState(() {
      _draftSettings = update(current);
    });
  }

  Future<void> _changeLanguage(
    SettingsProvider provider,
    String value,
  ) async {
    final current = _draftSettings ?? provider.settings;
    final updated = current.copyWith(appLocale: value);

    setState(() {
      _draftSettings = updated;
    });

    await provider.save(updated, sync: true);

    if (!mounted) {
      return;
    }

    setState(() {
      _draftSettings = provider.settings;
    });
  }

  Future<void> _saveSettings(SettingsProvider provider) async {
    final draft = _draftSettings;

    if (draft == null || _saving) {
      return;
    }

    setState(() {
      _saving = true;
    });

    await provider.save(draft, sync: true);

    if (!mounted) {
      return;
    }

    setState(() {
      _saving = false;
      _draftSettings = provider.settings;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).settingsSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSettings),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, _) {
          _draftSettings ??= provider.settings;

          final draft = _draftSettings!;
          final hasChanges = !_settingsEqual(draft, provider.settings);
          final canSave = hasChanges && !_saving && !provider.loading;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _SettingsSection(
                    title: l10n.timerTimesTitle,
                    description: l10n.timerTimesDescription,
                    children: [
                      _NumberInputTile(
                        title: l10n.workTime,
                        value: draft.workMinutes,
                        suffix: l10n.minutes,
                        unitLabel: l10n.minutesShort,
                        min: 1,
                        max: 180,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              workMinutes: value,
                            ),
                          );
                        },
                      ),
                      _NumberInputTile(
                        title: l10n.shortBreak,
                        value: draft.shortBreakMinutes,
                        suffix: l10n.minutes,
                        unitLabel: l10n.minutesShort,
                        min: 1,
                        max: 120,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              shortBreakMinutes: value,
                            ),
                          );
                        },
                      ),
                      _NumberInputTile(
                        title: l10n.longBreak,
                        value: draft.longBreakMinutes,
                        suffix: l10n.minutes,
                        unitLabel: l10n.minutesShort,
                        min: 1,
                        max: 180,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              longBreakMinutes: value,
                            ),
                          );
                        },
                      ),
                      _NumberInputTile(
                        title: l10n.longBreakAfter,
                        value: draft.longBreakAfter,
                        suffix: l10n.pomodorosUnit,
                        unitLabel: l10n.pomodorosUnit,
                        min: 1,
                        max: 20,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              longBreakAfter: value,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SettingsSection(
                    title: l10n.behaviorTitle,
                    description: l10n.behaviorDescription,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.autoStartNextPhase),
                        value: draft.autoStart,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              autoStart: value,
                            ),
                          );
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.enableSound),
                        value: draft.soundEnabled,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              soundEnabled: value,
                            ),
                          );
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.enableVibration),
                        subtitle: Text(l10n.vibrationDescription),
                        value: draft.vibrationEnabled,
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              vibrationEnabled: value,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SettingsSection(
                    title: l10n.languageTitle,
                    description: l10n.languageDescription,
                    children: [
                      _LanguageDropdown(
                        value: draft.appLocale,
                        onChanged: (value) {
                          unawaited(_changeLanguage(provider, value));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SettingsSection(
                    title: l10n.appearanceTitle,
                    description: l10n.appearanceDescription,
                    children: [
                      DropdownButtonFormField<String>(
                        key: ValueKey('theme-${draft.theme}'),
                        initialValue: draft.theme,
                        decoration: InputDecoration(
                          labelText: l10n.appearanceLabel,
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'system',
                            child: Text(l10n.systemTheme),
                          ),
                          DropdownMenuItem(
                            value: 'light',
                            child: Text(l10n.lightMode),
                          ),
                          DropdownMenuItem(
                            value: 'dark',
                            child: Text(l10n.darkMode),
                          ),
                        ],
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              theme: value ?? 'system',
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        key: ValueKey('color-${draft.colorName}'),
                        initialValue: draft.colorName,
                        decoration: InputDecoration(
                          labelText: l10n.themeColor,
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'red',
                            child: Text(l10n.red),
                          ),
                          DropdownMenuItem(
                            value: 'blue',
                            child: Text(l10n.blue),
                          ),
                          DropdownMenuItem(
                            value: 'green',
                            child: Text(l10n.green),
                          ),
                          DropdownMenuItem(
                            value: 'purple',
                            child: Text(l10n.purple),
                          ),
                        ],
                        onChanged: (value) {
                          _updateDraft(
                            (settings) => settings.copyWith(
                              colorName: value ?? 'red',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (provider.error != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_outlined),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(_localizedSettingsError(
                                l10n,
                                provider.error!,
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  FilledButton.icon(
                    onPressed: canSave ? () => _saveSettings(provider) : null,
                    icon: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.cloud_upload),
                    label: Text(
                      hasChanges ? l10n.saveSettings : l10n.noChanges,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const String _systemLocaleCode = 'system';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final localeCodes = [
      _systemLocaleCode,
      ...AppLocalizations.supportedLocales.map(
        (locale) => locale.languageCode,
      ),
    ];

    final currentValue =
        localeCodes.contains(value) ? value : _systemLocaleCode;

    return DropdownButtonFormField<String>(
      key: ValueKey('language-$currentValue'),
      initialValue: currentValue,
      decoration: InputDecoration(
        labelText: l10n.languageLabel,
        border: const OutlineInputBorder(),
      ),
      items: localeCodes.map((localeCode) {
        return DropdownMenuItem<String>(
          value: localeCode,
          child: Text(_localizedLanguageName(l10n, localeCode)),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        onChanged(value);
      },
    );
  }
}

String _localizedLanguageName(AppLocalizations l10n, String localeCode) {
  return switch (localeCode) {
    'system' => l10n.languageSystem,
    'de' => l10n.languageGerman,
    'en' => l10n.languageEnglish,
    'ar' => l10n.languageArabic,
    'zh' => l10n.languageChinese,
    'fr' => l10n.languageFrench,
    'es' => l10n.languageSpanish,
    'hi' => l10n.languageHindi,
    'pt' => l10n.languagePortuguese,
    'ru' => l10n.languageRussian,
    'ja' => l10n.languageJapanese,
    'tr' => l10n.languageTurkish,
    'it' => l10n.languageItalian,
    'ko' => l10n.languageKorean,
    'id' => l10n.languageIndonesian,
    'fa' => l10n.languagePersian,
    _ => localeCode.toUpperCase(),
  };
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (description != null) ...[
              const SizedBox(height: 4),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _NumberInputTile extends StatefulWidget {
  const _NumberInputTile({
    required this.title,
    required this.value,
    required this.suffix,
    required this.unitLabel,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String title;
  final int value;
  final String suffix;
  final String unitLabel;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  State<_NumberInputTile> createState() => _NumberInputTileState();
}

class _NumberInputTileState extends State<_NumberInputTile> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value.toString());
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _commitInput();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _NumberInputTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value && !_focusNode.hasFocus) {
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  int _clampValue(int value) {
    return value.clamp(widget.min, widget.max).toInt();
  }

  void _changeBy(int delta) {
    final nextValue = _clampValue(widget.value + delta);

    _controller.text = nextValue.toString();
    widget.onChanged(nextValue);
  }

  void _commitInput() {
    final rawValue = _controller.text.trim();
    final parsedValue = int.tryParse(rawValue);

    if (parsedValue == null) {
      _controller.text = widget.value.toString();
      return;
    }

    final nextValue = _clampValue(parsedValue);

    _controller.text = nextValue.toString();

    if (nextValue != widget.value) {
      widget.onChanged(nextValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canDecrease = widget.value > widget.min;
    final canIncrease = widget.value < widget.max;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controls = _NumberControls(
            controller: _controller,
            focusNode: _focusNode,
            unitLabel: widget.unitLabel,
            canDecrease: canDecrease,
            canIncrease: canIncrease,
            onDecrease: () => _changeBy(-1),
            onIncrease: () => _changeBy(1),
            onSubmit: _commitInput,
          );

          if (constraints.maxWidth < 560) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text('${widget.value} ${widget.suffix}'),
                const SizedBox(height: 12),
                controls,
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(widget.title),
                  subtitle: Text('${widget.value} ${widget.suffix}'),
                ),
              ),
              controls,
            ],
          );
        },
      ),
    );
  }
}

class _NumberControls extends StatelessWidget {
  const _NumberControls({
    required this.controller,
    required this.focusNode,
    required this.unitLabel,
    required this.canDecrease,
    required this.canIncrease,
    required this.onDecrease,
    required this.onIncrease,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String unitLabel;
  final bool canDecrease;
  final bool canIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton.outlined(
              tooltip: l10n.decrease,
              onPressed: canDecrease ? onDecrease : null,
              icon: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 76,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              onSubmitted: (_) => onSubmit(),
              onTapOutside: (_) {
                focusNode.unfocus();
              },
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 86,
            child: Text(
              unitLabel,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton.outlined(
              tooltip: l10n.increase,
              onPressed: canIncrease ? onIncrease : null,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

String _localizedSettingsError(AppLocalizations l10n, String error) {
  return switch (error) {
    'Einstellungen lokal gespeichert, aber noch nicht synchronisiert.' =>
      l10n.settingsSavedButNotSynced,
    'Einstellungen konnten nicht vom Backend geladen werden. Lokale Einstellungen werden verwendet.' =>
      l10n.settingsLoadRemoteFailed,
    _ => error,
  };
}

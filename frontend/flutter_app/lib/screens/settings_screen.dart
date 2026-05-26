import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
        a.colorName == b.colorName;
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
      const SnackBar(
        content: Text('Einstellungen gespeichert.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
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
                    title: 'Timer-Zeiten',
                    description:
                        'Lege fest, wie lange Arbeitsphasen und Pausen dauern.',
                    children: [
                      _NumberInputTile(
                        title: 'Arbeitszeit',
                        value: draft.workMinutes,
                        suffix: 'Minuten',
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
                        title: 'Kurze Pause',
                        value: draft.shortBreakMinutes,
                        suffix: 'Minuten',
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
                        title: 'Lange Pause',
                        value: draft.longBreakMinutes,
                        suffix: 'Minuten',
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
                        title: 'Lange Pause nach',
                        value: draft.longBreakAfter,
                        suffix: 'Pomodoros',
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
                    title: 'Verhalten',
                    description:
                        'Passe an, wie sich der Timer während der Nutzung verhält.',
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Nächste Phase automatisch starten',
                        ),
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
                        title: const Text('Sound aktivieren'),
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
                        title: const Text('Vibration aktivieren'),
                        subtitle: const Text(
                          'Die konkrete mobile Vibration wird später über ein Plugin angebunden.',
                        ),
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
                    title: 'Darstellung',
                    description:
                        'Wähle Designmodus und Hauptfarbe der Anwendung.',
                    children: [
                      DropdownButtonFormField<String>(
                        key: ValueKey('theme-${draft.theme}'),
                        initialValue: draft.theme,
                        decoration: const InputDecoration(
                          labelText: 'Darstellung',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'system',
                            child: Text('System'),
                          ),
                          DropdownMenuItem(
                            value: 'light',
                            child: Text('Light Mode'),
                          ),
                          DropdownMenuItem(
                            value: 'dark',
                            child: Text('Dark Mode'),
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
                        decoration: const InputDecoration(
                          labelText: 'Theme-Farbe',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'red',
                            child: Text('Rot'),
                          ),
                          DropdownMenuItem(
                            value: 'blue',
                            child: Text('Blau'),
                          ),
                          DropdownMenuItem(
                            value: 'green',
                            child: Text('Grün'),
                          ),
                          DropdownMenuItem(
                            value: 'purple',
                            child: Text('Lila'),
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
                              child: Text(provider.error!),
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
                      hasChanges
                          ? 'Einstellungen speichern'
                          : 'Keine Änderungen vorhanden',
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
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String title;
  final int value;
  final String suffix;
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
            suffix: widget.suffix,
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
    required this.suffix,
    required this.canDecrease,
    required this.canIncrease,
    required this.onDecrease,
    required this.onIncrease,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String suffix;
  final bool canDecrease;
  final bool canIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final isMinutes = suffix == 'Minuten';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Verringern',
          onPressed: canDecrease ? onDecrease : null,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: isMinutes ? 110 : 150,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
              suffixText: isMinutes ? 'min' : 'Pomodoros',
            ),
            onSubmitted: (_) => onSubmit(),
            onTapOutside: (_) {
              focusNode.unfocus();
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton.outlined(
          tooltip: 'Erhöhen',
          onPressed: canIncrease ? onIncrease : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, _) {
          final settings = provider.settings;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _NumberInputTile(
                title: 'Arbeitszeit',
                value: settings.workMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 180,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(workMinutes: value),
                  );
                },
              ),
              _NumberInputTile(
                title: 'Kurze Pause',
                value: settings.shortBreakMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 120,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(shortBreakMinutes: value),
                  );
                },
              ),
              _NumberInputTile(
                title: 'Lange Pause',
                value: settings.longBreakMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 180,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(longBreakMinutes: value),
                  );
                },
              ),
              _NumberInputTile(
                title: 'Lange Pause nach',
                value: settings.longBreakAfter,
                suffix: 'Pomodoros',
                min: 1,
                max: 20,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(longBreakAfter: value),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Nächste Phase automatisch starten'),
                value: settings.autoStart,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(autoStart: value),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Sound aktivieren'),
                value: settings.soundEnabled,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(soundEnabled: value),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Vibration aktivieren'),
                subtitle: const Text(
                  'Die konkrete mobile Vibration wird später über ein Plugin angebunden.',
                ),
                value: settings.vibrationEnabled,
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(vibrationEnabled: value),
                  );
                },
              ),
              const Divider(),
              DropdownButtonFormField<String>(
                initialValue: settings.theme,
                decoration: const InputDecoration(labelText: 'Darstellung'),
                items: const [
                  DropdownMenuItem(value: 'system', child: Text('System')),
                  DropdownMenuItem(value: 'light', child: Text('Light Mode')),
                  DropdownMenuItem(value: 'dark', child: Text('Dark Mode')),
                ],
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(theme: value ?? 'system'),
                  );
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: settings.colorName,
                decoration: const InputDecoration(labelText: 'Theme-Farbe'),
                items: const [
                  DropdownMenuItem(value: 'red', child: Text('Rot')),
                  DropdownMenuItem(value: 'blue', child: Text('Blau')),
                  DropdownMenuItem(value: 'green', child: Text('Grün')),
                  DropdownMenuItem(value: 'purple', child: Text('Lila')),
                ],
                onChanged: (value) {
                  provider.save(
                    settings.copyWith(colorName: value ?? 'red'),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  provider.save(provider.settings, sync: true);
                },
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Einstellungen im Konto speichern'),
              ),
            ],
          );
        },
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
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(widget.title),
        subtitle: Text('${widget.value} ${widget.suffix}'),
        trailing: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.outlined(
                tooltip: 'Verringern',
                onPressed: canDecrease ? () => _changeBy(-1) : null,
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 90,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    suffixText: widget.suffix == 'Minuten' ? 'min' : null,
                  ),
                  onSubmitted: (_) => _commitInput(),
                  onTapOutside: (_) {
                    _focusNode.unfocus();
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                tooltip: 'Erhöhen',
                onPressed: canIncrease ? () => _changeBy(1) : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
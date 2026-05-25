import 'package:flutter/material.dart';
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
              _NumberTile(
                title: 'Arbeitszeit',
                value: settings.workMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 180,
                divisions: 179,
                onChanged: (v) =>
                    provider.save(settings.copyWith(workMinutes: v)),
              ),
              _NumberTile(
                title: 'Kurze Pause',
                value: settings.shortBreakMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 120,
                divisions: 119,
                onChanged: (v) =>
                    provider.save(settings.copyWith(shortBreakMinutes: v)),
              ),
              _NumberTile(
                title: 'Lange Pause',
                value: settings.longBreakMinutes,
                suffix: 'Minuten',
                min: 1,
                max: 180,
                divisions: 179,
                onChanged: (v) =>
                    provider.save(settings.copyWith(longBreakMinutes: v)),
              ),
              _NumberTile(
                title: 'Lange Pause nach',
                value: settings.longBreakAfter,
                suffix: 'Pomodoros',
                min: 1,
                max: 20,
                divisions: 19,
                onChanged: (v) =>
                    provider.save(settings.copyWith(longBreakAfter: v)),
              ),
              SwitchListTile(
                title: const Text('Nächste Phase automatisch starten'),
                value: settings.autoStart,
                onChanged: (v) =>
                    provider.save(settings.copyWith(autoStart: v)),
              ),
              SwitchListTile(
                title: const Text('Sound aktivieren'),
                value: settings.soundEnabled,
                onChanged: (v) =>
                    provider.save(settings.copyWith(soundEnabled: v)),
              ),
              SwitchListTile(
                title: const Text('Vibration aktivieren'),
                subtitle: const Text(
                    'Die konkrete mobile Vibration wird später über ein Plugin angebunden.'),
                value: settings.vibrationEnabled,
                onChanged: (v) =>
                    provider.save(settings.copyWith(vibrationEnabled: v)),
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
                onChanged: (value) =>
                    provider.save(settings.copyWith(theme: value ?? 'system')),
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
                onChanged: (value) =>
                    provider.save(settings.copyWith(colorName: value ?? 'red')),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => provider.save(provider.settings, sync: true),
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

class _NumberTile extends StatelessWidget {
  const _NumberTile({
    required this.title,
    required this.value,
    required this.suffix,
    required this.onChanged,
    this.min = 1,
    this.max = 120,
    this.divisions,
  });

  final String title;
  final int value;
  final String suffix;
  final ValueChanged<int> onChanged;
  final double min;
  final double max;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$value $suffix'),
      trailing: SizedBox(
        width: 160,
        child: Slider(
          value: value.clamp(min.toInt(), max.toInt()).toDouble(),
          min: min,
          max: max,
          divisions: divisions ?? (max - min).round(),
          label: value.toString(),
          onChanged: (v) => onChanged(v.round()),
        ),
      ),
    );
  }
}

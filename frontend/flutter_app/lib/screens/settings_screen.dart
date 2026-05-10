import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_settings.dart';
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
                onChanged: (v) => provider.save(settings.copyWith(workMinutes: v)),
              ),
              _NumberTile(
                title: 'Kurze Pause',
                value: settings.shortBreakMinutes,
                suffix: 'Minuten',
                onChanged: (v) => provider.save(settings.copyWith(shortBreakMinutes: v)),
              ),
              _NumberTile(
                title: 'Lange Pause',
                value: settings.longBreakMinutes,
                suffix: 'Minuten',
                onChanged: (v) => provider.save(settings.copyWith(longBreakMinutes: v)),
              ),
              _NumberTile(
                title: 'Lange Pause nach',
                value: settings.longBreakAfter,
                suffix: 'Pomodoros',
                onChanged: (v) => provider.save(settings.copyWith(longBreakAfter: v)),
              ),
              SwitchListTile(
                title: const Text('Nächste Phase automatisch starten'),
                value: settings.autoStart,
                onChanged: (v) => provider.save(settings.copyWith(autoStart: v)),
              ),
              SwitchListTile(
                title: const Text('Sound aktivieren'),
                value: settings.soundEnabled,
                onChanged: (v) => provider.save(settings.copyWith(soundEnabled: v)),
              ),
              SwitchListTile(
                title: const Text('Vibration aktivieren'),
                subtitle: const Text('Die konkrete mobile Vibration wird später über ein Plugin angebunden.'),
                value: settings.vibrationEnabled,
                onChanged: (v) => provider.save(settings.copyWith(vibrationEnabled: v)),
              ),
              const Divider(),
              DropdownButtonFormField<String>(
                value: settings.theme,
                decoration: const InputDecoration(labelText: 'Darstellung'),
                items: const [
                  DropdownMenuItem(value: 'system', child: Text('System')),
                  DropdownMenuItem(value: 'light', child: Text('Light Mode')),
                  DropdownMenuItem(value: 'dark', child: Text('Dark Mode')),
                ],
                onChanged: (value) => provider.save(settings.copyWith(theme: value ?? 'system')),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: settings.colorName,
                decoration: const InputDecoration(labelText: 'Theme-Farbe'),
                items: const [
                  DropdownMenuItem(value: 'red', child: Text('Rot')),
                  DropdownMenuItem(value: 'blue', child: Text('Blau')),
                  DropdownMenuItem(value: 'green', child: Text('Grün')),
                  DropdownMenuItem(value: 'purple', child: Text('Lila')),
                ],
                onChanged: (value) => provider.save(settings.copyWith(colorName: value ?? 'red')),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => provider.save(provider.settings, sync: true),
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Einstellungen mit Backend synchronisieren'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NumberTile extends StatelessWidget {
  const _NumberTile({required this.title, required this.value, required this.suffix, required this.onChanged});

  final String title;
  final int value;
  final String suffix;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$value $suffix'),
      trailing: SizedBox(
        width: 160,
        child: Slider(
          value: value.toDouble(),
          min: 1,
          max: 120,
          divisions: 119,
          label: value.toString(),
          onChanged: (v) => onChanged(v.round()),
        ),
      ),
    );
  }
}

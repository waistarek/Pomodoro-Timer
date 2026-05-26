import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/stats.dart';
import '../providers/stats_provider.dart';
import '../widgets/stats_chart.dart';

enum _StatsMode {
  day,
  week,
  month,
  tasks,
}

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  _StatsMode _mode = _StatsMode.day;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<StatsProvider>().loadDaily();
      }
    });
  }

  void _loadForMode(BuildContext context, _StatsMode mode) {
    final provider = context.read<StatsProvider>();

    switch (mode) {
      case _StatsMode.day:
        provider.loadDaily();
      case _StatsMode.week:
        provider.loadWeekly();
      case _StatsMode.month:
        provider.loadMonthly();
      case _StatsMode.tasks:
        provider.loadTaskStats();
    }
  }

  void _selectMode(BuildContext context, _StatsMode mode) {
    if (_mode == mode) {
      return;
    }

    setState(() {
      _mode = mode;
    });

    _loadForMode(context, mode);
  }

  bool _isLoading(StatsProvider provider) {
    if (_mode == _StatsMode.tasks) {
      return provider.taskStatsLoading;
    }

    return provider.loading;
  }

  String _chartTitle(_StatsMode mode) {
    return switch (mode) {
      _StatsMode.day => 'Fokuszeit pro Tag',
      _StatsMode.week => 'Fokuszeit pro Woche',
      _StatsMode.month => 'Fokuszeit pro Monat',
      _StatsMode.tasks => 'Fokuszeit pro Aufgabe',
    };
  }

  String _periodText(List<StatsItem> items, _StatsMode mode) {
    if (items.isEmpty) {
      return 'Zeitraum: Keine Daten vorhanden';
    }

    final first = _formatLabel(items.first.label, mode);
    final last = _formatLabel(items.last.label, mode);

    if (first == last) {
      return 'Zeitraum: $first';
    }

    return 'Zeitraum: $first – $last';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatsProvider>(
      builder: (context, provider, _) {
        final loading = _isLoading(provider);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Statistik'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton.icon(
                  onPressed: loading ? null : () => _loadForMode(context, _mode),
                  icon: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                  label: const Text('Aktualisieren'),
                ),
              ),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SegmentedButton<_StatsMode>(
                      selected: {_mode},
                      onSelectionChanged: (selection) {
                        _selectMode(context, selection.first);
                      },
                      segments: const [
                        ButtonSegment(
                          value: _StatsMode.day,
                          icon: Icon(Icons.today_outlined),
                          label: Text('Tag'),
                        ),
                        ButtonSegment(
                          value: _StatsMode.week,
                          icon: Icon(Icons.calendar_view_week_outlined),
                          label: Text('Woche'),
                        ),
                        ButtonSegment(
                          value: _StatsMode.month,
                          icon: Icon(Icons.calendar_month_outlined),
                          label: Text('Monat'),
                        ),
                        ButtonSegment(
                          value: _StatsMode.tasks,
                          icon: Icon(Icons.task_alt_outlined),
                          label: Text('Aufgaben'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_mode == _StatsMode.tasks)
                    _TaskStatsContent(provider: provider)
                  else
                    _GeneralStatsContent(
                      provider: provider,
                      mode: _mode,
                      chartTitle: _chartTitle(_mode),
                      periodText: _periodText(provider.stats.items, _mode),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GeneralStatsContent extends StatelessWidget {
  const _GeneralStatsContent({
    required this.provider,
    required this.mode,
    required this.chartTitle,
    required this.periodText,
  });

  final StatsProvider provider;
  final _StatsMode mode;
  final String chartTitle;
  final String periodText;

  @override
  Widget build(BuildContext context) {
    if (provider.loading) {
      return const _StatusCard(
        icon: Icons.hourglass_empty,
        message: 'Statistiken werden geladen ...',
        showProgress: true,
      );
    }

    if (provider.error != null) {
      return _StatusCard(
        icon: Icons.warning_amber_outlined,
        message: provider.error!,
      );
    }

    final stats = provider.stats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          periodText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _InfoCard(
              icon: Icons.check_circle_outline,
              title: 'Abgeschlossene Pomodoros',
              value: stats.totalPomodoros.toString(),
            ),
            _InfoCard(
              icon: Icons.timer_outlined,
              title: 'Fokuszeit',
              value: _formatMinutes(stats.totalFocusMinutes),
            ),
            _InfoCard(
              icon: Icons.local_fire_department_outlined,
              title: 'Serie',
              value: '${stats.currentStreakDays} Tage',
            ),
            _InfoCard(
              icon: Icons.emoji_events_outlined,
              title: 'Bester Zeitraum',
              value: stats.bestFocusDay == null
                  ? '-'
                  : _formatLabel(stats.bestFocusDay!, mode),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chartTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Y-Achse: Fokuszeit in Minuten · X-Achse: Zeitraum',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                StatsChart(
                  items: stats.items,
                  labelFormatter: (label) => _formatShortLabel(label, mode),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskStatsContent extends StatelessWidget {
  const _TaskStatsContent({required this.provider});

  final StatsProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.taskStatsLoading) {
      return const _StatusCard(
        icon: Icons.hourglass_empty,
        message: 'Aufgabenstatistik wird geladen ...',
        showProgress: true,
      );
    }

    if (provider.taskStatsError != null) {
      return _StatusCard(
        icon: Icons.warning_amber_outlined,
        message: provider.taskStatsError!,
      );
    }

    final stats = provider.taskStats;

    if (stats.items.isEmpty) {
      return const _StatusCard(
        icon: Icons.insights_outlined,
        message:
            'Noch keine Arbeitszeit pro Aufgabe vorhanden. Starte einen Pomodoro mit Aufgabe, um Daten zu sehen.',
      );
    }

    final maxFocusMinutes = stats.items
        .map((item) => item.focusMinutes)
        .fold<int>(0, (max, value) => value > max ? value : max);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _InfoCard(
              icon: Icons.check_circle_outline,
              title: 'Pomodoros',
              value: stats.totalPomodoros.toString(),
            ),
            _InfoCard(
              icon: Icons.timer_outlined,
              title: 'Fokuszeit',
              value: _formatMinutes(stats.totalFocusMinutes),
            ),
            _InfoCard(
              icon: Icons.access_time_outlined,
              title: 'Fokuszeit in Minuten',
              value: '${stats.totalFocusMinutes} min',
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fokuszeit pro Aufgabe',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Sortiert nach höchster Fokuszeit.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ...stats.items.map(
                  (item) {
                    final progress = maxFocusMinutes == 0
                        ? 0.0
                        : item.focusMinutes / maxFocusMinutes;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.task_alt_outlined, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.taskTitle,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                _formatMinutes(item.focusMinutes),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(value: progress),
                          const SizedBox(height: 4),
                          Text(
                            '${item.pomodoros} Pomodoros · ${item.focusMinutes} min',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.message,
    this.showProgress = false,
  });

  final IconData icon;
  final String message;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            if (showProgress)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(icon),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;

  if (hours == 0) {
    return '$rest min';
  }

  if (rest == 0) {
    return '$hours h';
  }

  return '$hours h $rest min';
}

String _formatLabel(String label, _StatsMode mode) {
  switch (mode) {
    case _StatsMode.day:
      final date = DateTime.tryParse(label);
      if (date == null) {
        return label;
      }

      return '${date.day.toString().padLeft(2, '0')}.'
          '${date.month.toString().padLeft(2, '0')}.'
          '${date.year}';

    case _StatsMode.week:
      final match = RegExp(r'^(\d{4})-KW(\d{2})$').firstMatch(label);
      if (match == null) {
        return label;
      }

      return 'KW ${match.group(2)}/${match.group(1)}';

    case _StatsMode.month:
      final match = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(label);
      if (match == null) {
        return label;
      }

      return '${match.group(2)}.${match.group(1)}';

    case _StatsMode.tasks:
      return label;
  }
}

String _formatShortLabel(String label, _StatsMode mode) {
  switch (mode) {
    case _StatsMode.day:
      final date = DateTime.tryParse(label);
      if (date == null) {
        return label;
      }

      return '${date.day.toString().padLeft(2, '0')}.'
          '${date.month.toString().padLeft(2, '0')}';

    case _StatsMode.week:
      final match = RegExp(r'^(\d{4})-KW(\d{2})$').firstMatch(label);
      if (match == null) {
        return label;
      }

      return 'KW${match.group(2)}';

    case _StatsMode.month:
      final match = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(label);
      if (match == null) {
        return label;
      }

      final year = match.group(1)!;
      final shortYear = year.substring(2);

      return '${match.group(2)}/$shortYear';

    case _StatsMode.tasks:
      return label;
  }
}
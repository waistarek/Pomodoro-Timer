import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/stats.dart';
import '../providers/stats_provider.dart';
import '../widgets/stats_chart.dart';

enum _StatsMode {
  week,
  month,
  year,
  tasks,
}

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  _StatsMode _mode = _StatsMode.week;
  DateTime _cursor = DateTime.now();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        _loadCurrentMode();
      }
    });
  }

  void _loadCurrentMode() {
    final provider = context.read<StatsProvider>();

    switch (_mode) {
      case _StatsMode.week:
        provider.loadWeek(_cursor);
      case _StatsMode.month:
        provider.loadMonth(_cursor.year, _cursor.month);
      case _StatsMode.year:
        provider.loadYear(_cursor.year);
      case _StatsMode.tasks:
        provider.loadTaskStats();
    }
  }

  void _selectMode(_StatsMode mode) {
    if (_mode == mode) {
      return;
    }

    setState(() {
      _mode = mode;
    });

    _loadCurrentMode();
  }

  void _changePeriod(int direction) {
    if (_mode == _StatsMode.tasks) {
      return;
    }

    setState(() {
      switch (_mode) {
        case _StatsMode.week:
          _cursor = _cursor.add(Duration(days: 7 * direction));
        case _StatsMode.month:
          _cursor = DateTime(_cursor.year, _cursor.month + direction, 1);
        case _StatsMode.year:
          _cursor = DateTime(_cursor.year + direction, 1, 1);
        case _StatsMode.tasks:
          break;
      }
    });

    _loadCurrentMode();
  }

  bool _isLoading(StatsProvider provider) {
    if (_mode == _StatsMode.tasks) {
      return provider.taskStatsLoading;
    }

    return provider.loading;
  }

  String _chartTitle() {
    return switch (_mode) {
      _StatsMode.week => 'Fokuszeit pro Tag',
      _StatsMode.month => 'Fokuszeit pro Tag',
      _StatsMode.year => 'Fokuszeit pro Monat',
      _StatsMode.tasks => 'Fokuszeit pro Aufgabe',
    };
  }

  String _xAxisText() {
    return switch (_mode) {
      _StatsMode.week => 'X-Achse: Tage der Woche',
      _StatsMode.month => 'X-Achse: Tage im Monat',
      _StatsMode.year => 'X-Achse: Monate im Jahr',
      _StatsMode.tasks => 'X-Achse: Aufgaben',
    };
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
                  onPressed: loading ? null : _loadCurrentMode,
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
                        _selectMode(selection.first);
                      },
                      segments: const [
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
                          value: _StatsMode.year,
                          icon: Icon(Icons.date_range_outlined),
                          label: Text('Jahr'),
                        ),
                        ButtonSegment(
                          value: _StatsMode.tasks,
                          icon: Icon(Icons.task_alt_outlined),
                          label: Text('Aufgabenzeit'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (_mode == _StatsMode.tasks)
                    _TaskStatsContent(provider: provider)
                  else
                   _GeneralStatsContent(
                    provider: provider,
                    mode: _mode,
                    chartTitle: _chartTitle(),
                    xAxisText: _xAxisText(),
                    onPreviousPeriod: () => _changePeriod(-1),
                    onNextPeriod: () => _changePeriod(1),
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

class _PeriodNavigator extends StatelessWidget {
  const _PeriodNavigator({
    required this.stats,
    required this.onPrevious,
    required this.onNext,
  });

  final StatsResponse stats;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final periodLabel = stats.periodLabel ?? '-';
    final periodStart = _formatIsoDate(stats.periodStart);
    final periodEnd = _formatIsoDate(stats.periodEnd);

    final periodText = periodStart == '-' || periodEnd == '-'
        ? 'Zeitraum: Keine Daten vorhanden'
        : 'Zeitraum: $periodStart – $periodEnd';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            IconButton.outlined(
              tooltip: 'Vorheriger Zeitraum',
              onPressed: onPrevious,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    periodLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    periodText,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            IconButton.outlined(
              tooltip: 'Nächster Zeitraum',
              onPressed: onNext,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}

class _GeneralStatsContent extends StatelessWidget {
  const _GeneralStatsContent({
    required this.provider,
    required this.mode,
    required this.chartTitle,
    required this.xAxisText,
    required this.onPreviousPeriod,
    required this.onNextPeriod,
  });

  final StatsProvider provider;
  final _StatsMode mode;
  final String chartTitle;
  final String xAxisText;
  final VoidCallback onPreviousPeriod;
  final VoidCallback onNextPeriod;

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
        _SummaryCards(
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
              icon: Icons.local_fire_department_outlined,
              title: 'Serie',
              value: '${stats.currentStreakDays} Tage',
            ),
            _InfoCard(
              icon: Icons.emoji_events_outlined,
              title: 'Bester Zeitraum',
              value: stats.bestFocusDay == null
                  ? '-'
                  : _formatBestLabel(stats.bestFocusDay!, mode),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _PeriodNavigator(
          stats: stats,
          onPrevious: onPreviousPeriod,
          onNext: onNextPeriod,
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
                  'Y-Achse: Fokuszeit in Stunden · $xAxisText',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                StatsChart(
                  items: stats.items,
                  labelFormatter: (label) => _formatChartLabel(label, mode),
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

    final maxFocusMinutes = stats.items.fold<int>(
      0,
      (maxValue, item) =>
          item.focusMinutes > maxValue ? item.focusMinutes : maxValue,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SummaryCards(
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: children,
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
      width: 260,
      height: 130,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall,
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

String _formatIsoDate(String? value) {
  if (value == null || value.isEmpty) {
    return '-';
  }

  final date = DateTime.tryParse(value);

  if (date == null) {
    return value;
  }

  return '${date.day.toString().padLeft(2, '0')}.'
      '${date.month.toString().padLeft(2, '0')}.'
      '${date.year}';
}

String _formatChartLabel(String label, _StatsMode mode) {
  switch (mode) {
    case _StatsMode.week:
    case _StatsMode.month:
      final date = DateTime.tryParse(label);

      if (date == null) {
        return label;
      }

      return '${date.day.toString().padLeft(2, '0')}.'
          '${date.month.toString().padLeft(2, '0')}';

    case _StatsMode.year:
      final match = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(label);

      if (match == null) {
        return label;
      }

      return '${match.group(2)}.${match.group(1)}';

    case _StatsMode.tasks:
      return label;
  }
}

String _formatBestLabel(String label, _StatsMode mode) {
  switch (mode) {
    case _StatsMode.week:
    case _StatsMode.month:
      return _formatIsoDate(label);

    case _StatsMode.year:
      final match = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(label);

      if (match == null) {
        return label;
      }

      return '${match.group(2)}.${match.group(1)}';

    case _StatsMode.tasks:
      return label;
  }
}
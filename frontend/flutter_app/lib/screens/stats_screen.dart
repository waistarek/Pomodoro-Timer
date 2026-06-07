import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
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

  String _chartTitle(AppLocalizations l10n) {
    return switch (_mode) {
      _StatsMode.week => l10n.chartFocusPerDay,
      _StatsMode.month => l10n.chartFocusPerCalendarWeek,
      _StatsMode.year => l10n.chartFocusPerMonth,
      _StatsMode.tasks => l10n.chartFocusPerTask,
    };
  }

  String _xAxisText(AppLocalizations l10n) {
    return switch (_mode) {
      _StatsMode.week => l10n.xAxisWeek,
      _StatsMode.month => l10n.xAxisMonth,
      _StatsMode.year => l10n.xAxisYear,
      _StatsMode.tasks => l10n.xAxisTasks,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Consumer<StatsProvider>(
      builder: (context, provider, _) {
        final loading = _isLoading(provider);

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.statsTitle),
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
                  label: Text(l10n.statsRefresh),
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
                      segments: [
                        ButtonSegment(
                          value: _StatsMode.week,
                          icon: const Icon(Icons.calendar_view_week_outlined),
                          label: Text(l10n.statsWeek),
                        ),
                        ButtonSegment(
                          value: _StatsMode.month,
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: Text(l10n.statsMonth),
                        ),
                        ButtonSegment(
                          value: _StatsMode.year,
                          icon: const Icon(Icons.date_range_outlined),
                          label: Text(l10n.statsYear),
                        ),
                        ButtonSegment(
                          value: _StatsMode.tasks,
                          icon: const Icon(Icons.task_alt_outlined),
                          label: Text(l10n.statsTasksTime),
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
                      chartTitle: _chartTitle(l10n),
                      xAxisText: _xAxisText(l10n),
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
    final l10n = AppLocalizations.of(context);
    final periodLabel = stats.periodLabel ?? '-';
    final periodStart = _formatIsoDate(stats.periodStart);
    final periodEnd = _formatIsoDate(stats.periodEnd);

    final periodText = periodStart == '-' || periodEnd == '-'
        ? l10n.periodNoData
        : l10n.periodRange(periodStart, periodEnd);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            IconButton.outlined(
              tooltip: l10n.previousPeriod,
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
              tooltip: l10n.nextPeriod,
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
    final l10n = AppLocalizations.of(context);

    if (provider.loading) {
      return _StatusCard(
        icon: Icons.hourglass_empty,
        message: l10n.statsLoading,
        showProgress: true,
      );
    }

    if (provider.error != null) {
      return _StatusCard(
        icon: Icons.warning_amber_outlined,
        message: _localizedStatsError(l10n, provider.error!),
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
              title: l10n.pomodoros,
              value: stats.totalPomodoros.toString(),
            ),
            _InfoCard(
              icon: Icons.timer_outlined,
              title: l10n.focusTime,
              value: _formatMinutes(stats.totalFocusMinutes),
            ),
            _InfoCard(
              icon: Icons.local_fire_department_outlined,
              title: l10n.streak,
              value: l10n.daysCount(stats.currentStreakDays),
            ),
            _InfoCard(
              icon: Icons.emoji_events_outlined,
              title: l10n.bestPeriod,
              value: stats.bestFocusDay == null
                  ? '-'
                  : _formatBestLabel(stats.bestFocusDay!, mode, l10n),
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
                  l10n.yAxisFocusHoursWithXAxis(xAxisText),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                StatsChart(
                  items: stats.items,
                  labelFormatter: (label) =>
                      _formatChartLabel(label, mode, l10n),
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
    final l10n = AppLocalizations.of(context);

    if (provider.taskStatsLoading) {
      return _StatusCard(
        icon: Icons.hourglass_empty,
        message: l10n.taskStatsLoading,
        showProgress: true,
      );
    }

    if (provider.taskStatsError != null) {
      return _StatusCard(
        icon: Icons.warning_amber_outlined,
        message: _localizedStatsError(l10n, provider.taskStatsError!),
      );
    }

    final stats = provider.taskStats;

    if (stats.items.isEmpty) {
      return _StatusCard(
        icon: Icons.insights_outlined,
        message: l10n.taskStatsEmpty,
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
              title: l10n.pomodoros,
              value: stats.totalPomodoros.toString(),
            ),
            _InfoCard(
              icon: Icons.timer_outlined,
              title: l10n.focusTime,
              value: _formatMinutes(stats.totalFocusMinutes),
            ),
            _InfoCard(
              icon: Icons.access_time_outlined,
              title: l10n.focusTimeMinutes,
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
                  l10n.chartFocusPerTask,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.sortedByHighestFocusTime,
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
                                  _localizedTaskTitle(item.taskTitle, l10n),
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
                            l10n.taskPomodoroMinutes(
                              item.pomodoros,
                              item.focusMinutes,
                            ),
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

String _formatChartLabel(
  String label,
  _StatsMode mode,
  AppLocalizations l10n,
) {
  switch (mode) {
    case _StatsMode.week:
      final date = DateTime.tryParse(label);

      if (date == null) {
        return label;
      }

      return '${date.day.toString().padLeft(2, '0')}.'
          '${date.month.toString().padLeft(2, '0')}';

    case _StatsMode.month:
      return _formatIsoWeekLabel(label, l10n);

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

String _formatBestLabel(
  String label,
  _StatsMode mode,
  AppLocalizations l10n,
) {
  switch (mode) {
    case _StatsMode.week:
      return _formatIsoDate(label);

    case _StatsMode.month:
      return _formatIsoWeekLabel(label, l10n, includeYear: true);

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

String _formatIsoWeekLabel(
  String label,
  AppLocalizations l10n, {
  bool includeYear = false,
}) {
  final match = RegExp(r'^(\d{4})-W(\d{2})$').firstMatch(label);

  if (match == null) {
    return label;
  }

  final year = match.group(1)!;
  final week = match.group(2)!;

  if (includeYear) {
    return l10n.calendarWeekWithYear(week, year);
  }

  return l10n.calendarWeekShort(week);
}

String _localizedStatsError(AppLocalizations l10n, String error) {
  return switch (error) {
    'Statistiken konnten nicht geladen werden. Bitte anmelden und Internetverbindung prüfen.' =>
      l10n.statsLoadFailed,
    'Aufgabenstatistik konnte nicht geladen werden.' =>
      l10n.taskStatsLoadFailed,
    'Die heutige Pomodoro-Anzahl konnte nicht geladen werden.' =>
      l10n.todayPomodorosLoadFailed,
    _ => error,
  };
}

String _localizedTaskTitle(String title, AppLocalizations l10n) {
  if (title == 'Ohne Aufgabe') {
    return l10n.noTaskTitle;
  }

  return title;
}

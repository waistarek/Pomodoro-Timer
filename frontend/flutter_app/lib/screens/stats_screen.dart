import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stats_provider.dart';
import '../widgets/stats_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _tabIndex = 0;

  void _loadForTab(BuildContext context, int index) {
    final provider = context.read<StatsProvider>();

    if (index == 0) {
      provider.loadDaily();
    }
    if (index == 1) {
      provider.loadWeekly();
    }
    if (index == 2) {
      provider.loadMonthly();
    }
    if (index == 3) {
      provider.loadTaskStats();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistik'),
          bottom: TabBar(
            onTap: (index) {
              setState(() => _tabIndex = index);
              _loadForTab(context, index);
            },
            tabs: const [
              Tab(text: 'Tag'),
              Tab(text: 'Woche'),
              Tab(text: 'Monat'),
              Tab(text: 'Aufgaben'),
            ],
          ),
        ),
        body: Consumer<StatsProvider>(
          builder: (context, provider, _) {
            if (_tabIndex == 3) {
              return _TaskStatsView(provider: provider);
            }

            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(provider.error!, textAlign: TextAlign.center),
                ),
              );
            }

            final stats = provider.stats;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _InfoCard(
                        title: 'Pomodoros',
                        value: stats.totalPomodoros.toString()),
                    _InfoCard(
                        title: 'Fokuszeit',
                        value: '${stats.totalFocusMinutes} min'),
                    _InfoCard(
                        title: 'Streak',
                        value: '${stats.currentStreakDays} Tage'),
                    _InfoCard(
                        title: 'Bester Tag', value: stats.bestFocusDay ?? '-'),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: StatsChart(items: stats.items),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _loadForTab(context, _tabIndex),
          icon: const Icon(Icons.refresh),
          label: const Text('Laden'),
        ),
      ),
    );
  }
}

class _TaskStatsView extends StatelessWidget {
  const _TaskStatsView({required this.provider});

  final StatsProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.taskStatsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.taskStatsError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(provider.taskStatsError!, textAlign: TextAlign.center),
        ),
      );
    }

    final stats = provider.taskStats;

    if (stats.items.isEmpty) {
      return const Center(
        child: Text('Noch keine Arbeitszeit pro Aufgabe vorhanden.'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _InfoCard(
                title: 'Pomodoros', value: stats.totalPomodoros.toString()),
            _InfoCard(
                title: 'Fokuszeit', value: '${stats.totalFocusMinutes} min'),
            _InfoCard(
              title: 'Stunden',
              value: _formatMinutes(stats.totalFocusMinutes),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...stats.items.map(
          (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.task_alt),
              title: Text(item.taskTitle),
              subtitle: Text('${item.pomodoros} Pomodoros'),
              trailing: Text(
                _formatMinutes(item.focusMinutes),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ],
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}

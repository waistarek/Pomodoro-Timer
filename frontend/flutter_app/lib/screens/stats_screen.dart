import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stats_provider.dart';
import '../widgets/stats_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistik'),
          bottom: TabBar(
            onTap: (index) {
              final provider = context.read<StatsProvider>();
              if (index == 0) provider.loadDaily();
              if (index == 1) provider.loadWeekly();
              if (index == 2) provider.loadMonthly();
            },
            tabs: const [
              Tab(text: 'Tag'),
              Tab(text: 'Woche'),
              Tab(text: 'Monat'),
            ],
          ),
        ),
        body: Consumer<StatsProvider>(
          builder: (context, provider, _) {
            if (provider.loading) return const Center(child: CircularProgressIndicator());
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
                    _InfoCard(title: 'Pomodoros', value: stats.totalPomodoros.toString()),
                    _InfoCard(title: 'Fokuszeit', value: '${stats.totalFocusMinutes} min'),
                    _InfoCard(title: 'Streak', value: '${stats.currentStreakDays} Tage'),
                    _InfoCard(title: 'Bester Tag', value: stats.bestFocusDay ?? '-'),
                  ],
                ),
                const SizedBox(height: 24),
                Card(child: Padding(padding: const EdgeInsets.all(16), child: StatsChart(items: stats.items))),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.read<StatsProvider>().loadDaily(),
          icon: const Icon(Icons.refresh),
          label: const Text('Laden'),
        ),
      ),
    );
  }
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

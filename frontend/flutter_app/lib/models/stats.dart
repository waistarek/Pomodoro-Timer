class StatsItem {
  const StatsItem({
    required this.label,
    required this.pomodoros,
    required this.focusMinutes,
    required this.completedSessions,
    required this.totalSessions,
    required this.successRate,
  });

  final String label;
  final int pomodoros;
  final int focusMinutes;
  final int completedSessions;
  final int totalSessions;
  final double successRate;

  factory StatsItem.fromJson(Map<String, dynamic> json) => StatsItem(
        label: json['label'] ?? '',
        pomodoros: json['pomodoros'] ?? 0,
        focusMinutes: json['focus_minutes'] ?? 0,
        completedSessions: json['completed_sessions'] ?? 0,
        totalSessions: json['total_sessions'] ?? 0,
        successRate: (json['success_rate'] ?? 0).toDouble(),
      );
}

class StatsResponse {
  const StatsResponse({
    required this.items,
    required this.totalPomodoros,
    required this.totalFocusMinutes,
    required this.currentStreakDays,
    this.bestFocusDay,
  });

  final List<StatsItem> items;
  final int totalPomodoros;
  final int totalFocusMinutes;
  final int currentStreakDays;
  final String? bestFocusDay;

  factory StatsResponse.empty() => const StatsResponse(
        items: [],
        totalPomodoros: 0,
        totalFocusMinutes: 0,
        currentStreakDays: 0,
      );

  factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
        items: ((json['items'] ?? []) as List).map((item) => StatsItem.fromJson(item)).toList(),
        totalPomodoros: json['total_pomodoros'] ?? 0,
        totalFocusMinutes: json['total_focus_minutes'] ?? 0,
        currentStreakDays: json['current_streak_days'] ?? 0,
        bestFocusDay: json['best_focus_day'],
      );
}

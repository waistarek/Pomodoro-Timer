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
        items: ((json['items'] ?? []) as List)
            .map((item) => StatsItem.fromJson(item))
            .toList(),
        totalPomodoros: json['total_pomodoros'] ?? 0,
        totalFocusMinutes: json['total_focus_minutes'] ?? 0,
        currentStreakDays: json['current_streak_days'] ?? 0,
        bestFocusDay: json['best_focus_day'],
      );
}

class TaskStatsItem {
  const TaskStatsItem({
    required this.taskId,
    required this.taskTitle,
    required this.pomodoros,
    required this.focusMinutes,
    required this.focusHours,
  });

  final int? taskId;
  final String taskTitle;
  final int pomodoros;
  final int focusMinutes;
  final double focusHours;

  factory TaskStatsItem.fromJson(Map<String, dynamic> json) {
    return TaskStatsItem(
      taskId: json['task_id'],
      taskTitle: json['task_title'] ?? 'Ohne Aufgabe',
      pomodoros: json['pomodoros'] ?? 0,
      focusMinutes: json['focus_minutes'] ?? 0,
      focusHours: (json['focus_hours'] ?? 0).toDouble(),
    );
  }
}

class TaskStatsResponse {
  const TaskStatsResponse({
    required this.items,
    required this.totalPomodoros,
    required this.totalFocusMinutes,
  });

  final List<TaskStatsItem> items;
  final int totalPomodoros;
  final int totalFocusMinutes;

  factory TaskStatsResponse.empty() {
    return const TaskStatsResponse(
      items: [],
      totalPomodoros: 0,
      totalFocusMinutes: 0,
    );
  }

  factory TaskStatsResponse.fromJson(Map<String, dynamic> json) {
    return TaskStatsResponse(
      items: ((json['items'] ?? []) as List)
          .map((item) => TaskStatsItem.fromJson(item))
          .toList(),
      totalPomodoros: json['total_pomodoros'] ?? 0,
      totalFocusMinutes: json['total_focus_minutes'] ?? 0,
    );
  }

  factory TaskStatsResponse.fromLocalSessions(List<dynamic> sessions) {
    final buckets = <String, _LocalTaskStatsBucket>{};

    for (final raw in sessions) {
      final json = raw as Map<String, dynamic>;

      if (json['completed'] != true || json['phase_type'] != 'work') {
        continue;
      }

      final key = json['local_task_id']?.toString() ?? 'no-task';
      final title = json['task_title']?.toString() ?? 'Ohne Aufgabe';
      final minutes = json['duration_minutes'] ?? 0;

      buckets.putIfAbsent(
        key,
        () => _LocalTaskStatsBucket(title: title),
      );

      buckets[key]!.pomodoros += 1;
      buckets[key]!.focusMinutes += minutes as int;
    }

    final items = buckets.values
        .map(
          (bucket) => TaskStatsItem(
            taskId: null,
            taskTitle: bucket.title,
            pomodoros: bucket.pomodoros,
            focusMinutes: bucket.focusMinutes,
            focusHours: bucket.focusMinutes / 60,
          ),
        )
        .toList()
      ..sort((a, b) => b.focusMinutes.compareTo(a.focusMinutes));

    return TaskStatsResponse(
      items: items,
      totalPomodoros: items.fold(0, (sum, item) => sum + item.pomodoros),
      totalFocusMinutes: items.fold(0, (sum, item) => sum + item.focusMinutes),
    );
  }
}

class _LocalTaskStatsBucket {
  _LocalTaskStatsBucket({required this.title});

  final String title;
  int pomodoros = 0;
  int focusMinutes = 0;
}

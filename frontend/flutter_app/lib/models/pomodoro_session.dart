class PomodoroSession {
  PomodoroSession({
    this.taskId,
    this.localTaskId,
    this.taskTitle,
    required this.phaseType,
    required this.durationMinutes,
    required this.completed,
    required this.startedAt,
    required this.endedAt,
  });

  final int? taskId;
  final String? localTaskId;
  final String? taskTitle;
  final String phaseType;
  final int durationMinutes;
  final bool completed;
  final DateTime startedAt;
  final DateTime endedAt;

  Map<String, dynamic> toJson() => {
        'task_id': taskId,
        'local_task_id': localTaskId,
        'task_title': taskTitle,
        'phase_type': phaseType,
        'duration_minutes': durationMinutes,
        'completed': completed,
        'started_at': startedAt.toIso8601String(),
        'ended_at': endedAt.toIso8601String(),
      };
  factory PomodoroSession.fromJson(Map<String, dynamic> json) {
    return PomodoroSession(
      taskId: json['task_id'],
      localTaskId: json['local_task_id']?.toString(),
      taskTitle: json['task_title']?.toString(),
      phaseType: json['phase_type']?.toString() ?? '',
      durationMinutes: json['duration_minutes'] ?? 0,
      completed: json['completed'] ?? false,
      startedAt: DateTime.tryParse(json['started_at']?.toString() ?? '') ??
          DateTime.now(),
      endedAt: DateTime.tryParse(json['ended_at']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

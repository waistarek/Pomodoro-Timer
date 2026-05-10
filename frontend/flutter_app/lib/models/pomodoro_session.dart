class PomodoroSession {
  PomodoroSession({
    this.taskId,
    required this.phaseType,
    required this.durationMinutes,
    required this.completed,
    required this.startedAt,
    required this.endedAt,
  });

  final int? taskId;
  final String phaseType;
  final int durationMinutes;
  final bool completed;
  final DateTime startedAt;
  final DateTime endedAt;

  Map<String, dynamic> toJson() => {
        'task_id': taskId,
        'phase_type': phaseType,
        'duration_minutes': durationMinutes,
        'completed': completed,
        'started_at': startedAt.toIso8601String(),
        'ended_at': endedAt.toIso8601String(),
      };
}

import 'package:uuid/uuid.dart';

class TaskItem {
  TaskItem({
    String? localId,
    this.remoteId,
    required this.title,
    this.description = '',
    this.priority = 'medium',
    this.tags = '',
    this.completed = false,
    this.completedPomodoros = 0,
    DateTime? createdAt,
  })  : localId = localId ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  final String localId;
  final int? remoteId;
  final String title;
  final String description;
  final String priority;
  final String tags;
  final bool completed;
  final int completedPomodoros;
  final DateTime createdAt;

  TaskItem copyWith({
    int? remoteId,
    String? title,
    String? description,
    String? priority,
    String? tags,
    bool? completed,
    int? completedPomodoros,
  }) {
    return TaskItem(
      localId: localId,
      remoteId: remoteId ?? this.remoteId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      completed: completed ?? this.completed,
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'local_id': localId,
        'remote_id': remoteId,
        'title': title,
        'description': description,
        'priority': priority,
        'tags': tags,
        'completed': completed,
        'completed_pomodoros': completedPomodoros,
        'created_at': createdAt.toIso8601String(),
      };

  Map<String, dynamic> toApiJson() => {
        'title': title,
        'description': description,
        'priority': priority,
        'tags': tags,
        'completed': completed,
      };

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      localId: json['local_id']?.toString(),
      remoteId: json['remote_id'] ?? json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? 'medium',
      tags: json['tags'] ?? '',
      completed: json['completed'] ?? false,
      completedPomodoros: json['completed_pomodoros'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}

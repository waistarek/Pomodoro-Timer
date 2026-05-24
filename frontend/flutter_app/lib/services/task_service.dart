import '../models/task_item.dart';
import 'api_client.dart';

class TaskService {
  TaskService({required this.apiClient});
  final ApiClient apiClient;

  Future<List<TaskItem>> getTasks() async {
    final data = await apiClient.get('/tasks') as List;
    return data.map((item) => TaskItem.fromJson(item)).toList();
  }

  Future<TaskItem> createTask(TaskItem task) async {
    final data = await apiClient.post('/tasks', task.toApiJson());
    return TaskItem.fromJson(data);
  }

  Future<TaskItem> updateTask(TaskItem task) async {
    if (task.remoteId == null) return task;
    final data =
        await apiClient.put('/tasks/${task.remoteId}', task.toApiJson());
    return TaskItem.fromJson(data);
  }

  Future<void> deleteTask(TaskItem task) async {
    if (task.remoteId != null) {
      await apiClient.delete('/tasks/${task.remoteId}');
    }
  }
}

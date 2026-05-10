import 'package:flutter/foundation.dart';
import '../models/task_item.dart';
import '../services/local_storage_service.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._localStorage, this._taskService);

  final LocalStorageService _localStorage;
  final TaskService _taskService;
  List<TaskItem> tasks = [];
  TaskItem? selectedTask;
  bool loading = false;
  String? error;

  Future<void> loadLocalTasks() async {
    tasks = _localStorage.getJsonList('tasks').map(TaskItem.fromJson).toList();
    if (tasks.isNotEmpty) selectedTask = tasks.firstWhere((t) => !t.completed, orElse: () => tasks.first);
    notifyListeners();
  }

  Future<void> loadRemoteTasks() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      tasks = await _taskService.getTasks();
      await _saveLocal();
    } catch (e) {
      error = 'Aufgaben konnten nicht vom Backend geladen werden. Offline-Daten werden verwendet.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(TaskItem task) async {
    tasks = [task, ...tasks];
    selectedTask ??= task;
    await _saveLocal();
    notifyListeners();
    try {
      final remote = await _taskService.createTask(task);
      tasks = tasks.map((t) => t.localId == task.localId ? t.copyWith(remoteId: remote.remoteId) : t).toList();
      await _saveLocal();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> updateTask(TaskItem task) async {
    tasks = tasks.map((t) => t.localId == task.localId ? task : t).toList();
    if (selectedTask?.localId == task.localId) selectedTask = task;
    await _saveLocal();
    notifyListeners();
    try {
      await _taskService.updateTask(task);
    } catch (_) {}
  }

  Future<void> deleteTask(TaskItem task) async {
    tasks = tasks.where((t) => t.localId != task.localId).toList();
    if (selectedTask?.localId == task.localId) selectedTask = tasks.isEmpty ? null : tasks.first;
    await _saveLocal();
    notifyListeners();
    try {
      await _taskService.deleteTask(task);
    } catch (_) {}
  }

  Future<void> selectTask(TaskItem? task) async {
    selectedTask = task;
    notifyListeners();
  }

  Future<void> incrementPomodoroForSelectedTask() async {
    final task = selectedTask;
    if (task == null) return;
    final updated = task.copyWith(completedPomodoros: task.completedPomodoros + 1);
    await updateTask(updated);
  }

  Future<void> _saveLocal() {
    return _localStorage.setJsonList('tasks', tasks.map((t) => t.toJson()).toList());
  }
}

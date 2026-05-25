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
    _applyLocalPomodoroCounts();

    if (tasks.isNotEmpty) {
      selectedTask =
          tasks.firstWhere((t) => !t.completed, orElse: () => tasks.first);
    }

    notifyListeners();
  }

  Future<void> loadRemoteTasks() async {
    loading = true;
    error = null;
    notifyListeners();

    final previousSelectedRemoteId = selectedTask?.remoteId;
    final previousSelectedLocalId = selectedTask?.localId;

    try {
      tasks = await _taskService.getTasks();

      if (tasks.isNotEmpty) {
        TaskItem? nextSelected;

        for (final task in tasks) {
          if (previousSelectedRemoteId != null &&
              task.remoteId == previousSelectedRemoteId) {
            nextSelected = task;
            break;
          }

          if (previousSelectedRemoteId == null &&
              task.localId == previousSelectedLocalId) {
            nextSelected = task;
            break;
          }
        }

        selectedTask = nextSelected ??
            tasks.firstWhere((task) => !task.completed,
                orElse: () => tasks.first);
      } else {
        selectedTask = null;
      }

      await _saveLocal();
    } catch (e) {
      error =
          'Aufgaben konnten nicht vom Backend geladen werden. Offline-Daten werden verwendet.';
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
      final updated = task.copyWith(remoteId: remote.remoteId);

      tasks =
          tasks.map((t) => t.localId == task.localId ? updated : t).toList();

      if (selectedTask?.localId == task.localId) {
        selectedTask = updated;
      }

      await _saveLocal();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> refreshTaskPomodoroCounts() async {
    if (_localStorage.token != null) {
      await loadRemoteTasks();
      return;
    }

    _applyLocalPomodoroCounts();
    await _saveLocal();
    notifyListeners();
  }

  Future<void> updateTask(TaskItem task) async {
    tasks = tasks.map((t) => t.localId == task.localId ? task : t).toList();
    if (selectedTask?.localId == task.localId) {
      selectedTask = task;
    }
    await _saveLocal();
    notifyListeners();
    try {
      await _taskService.updateTask(task);
    } catch (_) {}
  }

  Future<void> deleteTask(TaskItem task) async {
    tasks = tasks.where((t) => t.localId != task.localId).toList();
    if (selectedTask?.localId == task.localId) {
      selectedTask = tasks.isEmpty ? null : tasks.first;
    }

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

  Future<void> _saveLocal() {
    return _localStorage.setJsonList(
        'tasks', tasks.map((t) => t.toJson()).toList());
  }

  void _applyLocalPomodoroCounts() {
    final sessions = _localStorage.getJsonList('guest_sessions');
    final counts = <String, int>{};

    for (final session in sessions) {
      if (session['completed'] != true || session['phase_type'] != 'work') {
        continue;
      }

      final localTaskId = session['local_task_id']?.toString();

      if (localTaskId == null) {
        continue;
      }

      counts[localTaskId] = (counts[localTaskId] ?? 0) + 1;
    }

    tasks = tasks
        .map(
          (task) => task.copyWith(
            completedPomodoros: counts[task.localId] ?? 0,
          ),
        )
        .toList();
  }
}

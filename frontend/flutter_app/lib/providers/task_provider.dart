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
      selectedTask = tasks.firstWhere(
        (task) => !task.completed,
        orElse: () => tasks.first,
      );
    }

    notifyListeners();
  }

  void clear() {
    tasks = [];
    selectedTask = null;
    loading = false;
    error = null;

    notifyListeners();
  }

  void clearError() {
    error = null;
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
            tasks.firstWhere(
              (task) => !task.completed,
              orElse: () => tasks.first,
            );
      } else {
        selectedTask = null;
      }

      await _saveLocal();
    } catch (_) {
      error =
          'Aufgaben konnten nicht vom Backend geladen werden. Lokale Daten werden weiter angezeigt.';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(TaskItem task) async {
    error = null;
    tasks = [task, ...tasks];
    selectedTask ??= task;

    await _saveLocal();
    notifyListeners();

    try {
      final remote = await _taskService.createTask(task);
      final updated = task.copyWith(remoteId: remote.remoteId);

      tasks = tasks
          .map((current) => current.localId == task.localId ? updated : current)
          .toList();

      if (selectedTask?.localId == task.localId) {
        selectedTask = updated;
      }

      await _saveLocal();
      notifyListeners();
    } catch (_) {
      error =
          'Aufgabe wurde lokal gespeichert, konnte aber nicht mit dem Konto synchronisiert werden.';
      notifyListeners();
    }
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
    error = null;

    final oldTasks = tasks;
    final oldSelectedTask = selectedTask;

    tasks = tasks
        .map((current) => current.localId == task.localId ? task : current)
        .toList();

    if (selectedTask?.localId == task.localId) {
      selectedTask = task;
    }

    await _saveLocal();
    notifyListeners();

    try {
      final remote = await _taskService.updateTask(task);

      if (remote.remoteId != null) {
        final updated = task.copyWith(remoteId: remote.remoteId);

        tasks = tasks
            .map(
              (current) =>
                  current.localId == task.localId ? updated : current,
            )
            .toList();

        if (selectedTask?.localId == task.localId) {
          selectedTask = updated;
        }

        await _saveLocal();
        notifyListeners();
      }
    } catch (_) {
      tasks = oldTasks;
      selectedTask = oldSelectedTask;

      await _saveLocal();

      error =
          'Aufgabe konnte nicht gespeichert werden. Die letzte Änderung wurde zurückgenommen.';

      notifyListeners();
    }
  }

  Future<void> deleteTask(TaskItem task) async {
    error = null;

    final oldTasks = tasks;
    final oldSelectedTask = selectedTask;

    tasks = tasks.where((current) => current.localId != task.localId).toList();

    if (selectedTask?.localId == task.localId) {
      selectedTask = tasks.isEmpty ? null : tasks.first;
    }

    await _saveLocal();
    notifyListeners();

    try {
      await _taskService.deleteTask(task);
    } catch (_) {
      tasks = oldTasks;
      selectedTask = oldSelectedTask;

      await _saveLocal();

      error =
          'Aufgabe konnte nicht im Konto gelöscht werden. Die Aufgabe wurde wiederhergestellt.';

      notifyListeners();
    }
  }

  Future<void> selectTask(TaskItem? task) async {
    selectedTask = task;
    notifyListeners();
  }

  Future<void> _saveLocal() {
    return _localStorage.setJsonList(
      'tasks',
      tasks.map((task) => task.toJson()).toList(),
    );
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
            completedPomodoros: counts[task.localId] ?? task.completedPomodoros,
          ),
        )
        .toList();
  }
}
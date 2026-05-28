import 'package:flutter/foundation.dart';

import '../models/task_item.dart';
import '../services/local_storage_service.dart';
import '../services/task_service.dart';

const String _tasksStorageKey = 'tasks';
const String _selectedTaskStateStorageKey = 'selected_task_state';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._localStorage, this._taskService);

  final LocalStorageService _localStorage;
  final TaskService _taskService;

  List<TaskItem> tasks = [];
  TaskItem? selectedTask;

  bool loading = false;
  String? error;

  Future<void> loadLocalTasks() async {
    tasks = _localStorage
        .getJsonList(_tasksStorageKey)
        .map(TaskItem.fromJson)
        .toList();

    _applyLocalPomodoroCounts();

    selectedTask = _resolveStoredSelectedTask() ?? _firstOpenTaskOrFirst();

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

    final previousSelectedTask = selectedTask;
    final storedLocalId = _storedSelectedLocalId();
    final storedRemoteId = _storedSelectedRemoteId();

    try {
      tasks = await _taskService.getTasks();

      selectedTask = _findMatchingTask(previousSelectedTask) ??
          _findTaskByIdentity(
            localId: storedLocalId,
            remoteId: storedRemoteId,
          ) ??
          _firstOpenTaskOrFirst();

      await _saveLocal();
      await _saveSelectedTask();
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
    await _saveSelectedTask();
    notifyListeners();

    try {
      final remote = await _taskService.createTask(task);
      final updated = task.copyWith(remoteId: remote.remoteId);

      tasks = tasks
          .map((current) => current.localId == task.localId ? updated : current)
          .toList();

      if (_sameTaskIdentity(selectedTask, task)) {
        selectedTask = updated;
      }

      await _saveLocal();
      await _saveSelectedTask();
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

    if (_sameTaskIdentity(selectedTask, task)) {
      selectedTask = task;
    }

    await _saveLocal();
    await _saveSelectedTask();
    notifyListeners();

    try {
      final remote = await _taskService.updateTask(task);

      if (remote.remoteId != null) {
        final updated = task.copyWith(remoteId: remote.remoteId);

        tasks = tasks
            .map(
              (current) => current.localId == task.localId ? updated : current,
            )
            .toList();

        if (_sameTaskIdentity(selectedTask, task)) {
          selectedTask = updated;
        }

        await _saveLocal();
        await _saveSelectedTask();
        notifyListeners();
      }
    } catch (_) {
      tasks = oldTasks;
      selectedTask = oldSelectedTask;

      await _saveLocal();
      await _saveSelectedTask();

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

    if (_sameTaskIdentity(selectedTask, task)) {
      selectedTask = _firstOpenTaskOrFirst();
    }

    await _saveLocal();
    await _saveSelectedTask();
    notifyListeners();

    try {
      await _taskService.deleteTask(task);
    } catch (_) {
      tasks = oldTasks;
      selectedTask = oldSelectedTask;

      await _saveLocal();
      await _saveSelectedTask();

      error =
          'Aufgabe konnte nicht im Konto gelöscht werden. Die Aufgabe wurde wiederhergestellt.';

      notifyListeners();
    }
  }

  Future<void> selectTask(TaskItem? task) async {
    selectedTask = task;

    await _saveSelectedTask();

    notifyListeners();
  }

  Future<void> _saveLocal() {
    return _localStorage.setJsonList(
      _tasksStorageKey,
      tasks.map((task) => task.toJson()).toList(),
    );
  }

  Future<void> _saveSelectedTask() {
    final task = selectedTask;

    if (task == null) {
      return _localStorage.remove(_selectedTaskStateStorageKey);
    }

    return _localStorage.setJsonObject(_selectedTaskStateStorageKey, {
      'local_id': task.localId,
      'remote_id': task.remoteId,
    });
  }

  TaskItem? _resolveStoredSelectedTask() {
    return _findTaskByIdentity(
      localId: _storedSelectedLocalId(),
      remoteId: _storedSelectedRemoteId(),
    );
  }

  String? _storedSelectedLocalId() {
    final state = _localStorage.getJsonObject(_selectedTaskStateStorageKey);
    return state?['local_id']?.toString();
  }

  int? _storedSelectedRemoteId() {
    final state = _localStorage.getJsonObject(_selectedTaskStateStorageKey);
    final value = state?['remote_id'];

    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '');
  }

  TaskItem? _firstOpenTaskOrFirst() {
    if (tasks.isEmpty) {
      return null;
    }

    for (final task in tasks) {
      if (!task.completed) {
        return task;
      }
    }

    return tasks.first;
  }

  TaskItem? _findMatchingTask(TaskItem? reference) {
    if (reference == null) {
      return null;
    }

    return _findTaskByIdentity(
      localId: reference.localId,
      remoteId: reference.remoteId,
    );
  }

  TaskItem? _findTaskByIdentity({
    String? localId,
    int? remoteId,
  }) {
    for (final task in tasks) {
      if (remoteId != null && task.remoteId == remoteId) {
        return task;
      }

      if (localId != null && task.localId == localId) {
        return task;
      }
    }

    return null;
  }

  bool _sameTaskIdentity(TaskItem? first, TaskItem? second) {
    if (first == null || second == null) {
      return first == null && second == null;
    }

    if (first.remoteId != null && second.remoteId != null) {
      return first.remoteId == second.remoteId;
    }

    return first.localId == second.localId;
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

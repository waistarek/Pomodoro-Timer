import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/task_item.dart';
import '../providers/task_provider.dart';
import '../providers/timer_provider.dart';
import '../widgets/task_editor_dialog.dart';

enum _TaskFilter {
  all,
  open,
  completed,
}

enum _TaskSort {
  newest,
  priority,
  pomodoros,
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TextEditingController _searchController = TextEditingController();

  _TaskFilter _filter = _TaskFilter.all;
  _TaskSort _sort = _TaskSort.newest;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });

    Future.microtask(() {
      if (mounted) {
        context.read<TaskProvider>().refreshTaskPomodoroCounts();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openEditor(BuildContext context, {TaskItem? task}) async {
    final result = await showDialog<TaskItem>(
      context: context,
      builder: (_) => TaskEditorDialog(task: task),
    );

    if (result == null || !context.mounted) {
      return;
    }

    final provider = context.read<TaskProvider>();

    if (task == null) {
      await provider.addTask(result);
    } else {
      await provider.updateTask(result);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    TaskProvider provider,
    TaskItem task,
  ) async {
    final l10n = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteTaskTitle),
        content: Text(l10n.deleteTaskMessage(task.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton.tonalIcon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.delete_outline),
            label: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await provider.deleteTask(task);
    }
  }

  List<TaskItem> _visibleTasks(List<TaskItem> tasks) {
    final filtered = tasks.where((task) {
      final matchesFilter = switch (_filter) {
        _TaskFilter.all => true,
        _TaskFilter.open => !task.completed,
        _TaskFilter.completed => task.completed,
      };

      if (!matchesFilter) {
        return false;
      }

      if (_searchQuery.isEmpty) {
        return true;
      }

      final haystack = [
        task.title,
        task.description,
        task.priority,
        task.tags,
      ].join(' ').toLowerCase();

      return haystack.contains(_searchQuery);
    }).toList();

    filtered.sort((a, b) {
      return switch (_sort) {
        _TaskSort.newest => b.createdAt.compareTo(a.createdAt),
        _TaskSort.priority =>
          _priorityWeight(b.priority).compareTo(_priorityWeight(a.priority)),
        _TaskSort.pomodoros =>
          b.completedPomodoros.compareTo(a.completedPomodoros),
      };
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tasksTitle),
        actions: [
          Consumer<TaskProvider>(
            builder: (context, provider, _) {
              return IconButton(
                tooltip: l10n.tasksRefreshTooltip,
                onPressed: provider.loading
                    ? null
                    : () => provider.refreshTaskPomodoroCounts(),
                icon: provider.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sync),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: l10n.createTaskSemantics,
        onPressed: () => _openEditor(context),
        icon: const ExcludeSemantics(child: Icon(Icons.add)),
        label: Text(l10n.taskSingular),
      ),
      body: Consumer2<TaskProvider, TimerProvider>(
        builder: (context, provider, timerProvider, _) {
          final visibleTasks = _visibleTasks(provider.tasks);
          final activeTask =
              timerProvider.taskForDisplay ?? provider.selectedTask;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (provider.error != null) ...[
                    _ErrorBanner(
                      message: _localizedTaskError(l10n, provider.error!),
                      onClose: provider.clearError,
                    ),
                    const SizedBox(height: 12),
                  ],
                  _TaskToolbar(
                    searchController: _searchController,
                    filter: _filter,
                    sort: _sort,
                    onFilterChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    },
                    onSortChanged: (value) {
                      setState(() {
                        _sort = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _ActiveTaskBanner(
                    activeTask: activeTask,
                    taskSelectionLocked: !timerProvider.canChangeTask,
                    onClearSelection: timerProvider.canChangeTask
                        ? () => provider.selectTask(null)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  if (provider.loading && provider.tasks.isEmpty)
                    _StatusCard(
                      icon: Icons.hourglass_empty,
                      message: l10n.tasksLoading,
                      showProgress: true,
                    )
                  else if (provider.tasks.isEmpty)
                    _StatusCard(
                      icon: Icons.task_alt_outlined,
                      message: l10n.tasksEmpty,
                    )
                  else if (visibleTasks.isEmpty)
                    _StatusCard(
                      icon: Icons.search_off,
                      message: l10n.tasksSearchEmpty,
                    )
                  else
                    ...visibleTasks.map(
                      (task) {
                        final selected = _sameTaskIdentity(activeTask, task);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _TaskCard(
                            task: task,
                            selected: selected,
                            canSelectForTimer: timerProvider.canChangeTask,
                            onCompletedChanged: (value) {
                              provider.updateTask(
                                task.copyWith(completed: value),
                              );
                            },
                            onSelectForTimer: () {
                              provider.selectTask(task);
                            },
                            onEdit: () => _openEditor(context, task: task),
                            onDelete: () =>
                                _confirmDelete(context, provider, task),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActiveTaskBanner extends StatelessWidget {
  const _ActiveTaskBanner({
    required this.activeTask,
    required this.taskSelectionLocked,
    required this.onClearSelection,
  });

  final TaskItem? activeTask;
  final bool taskSelectionLocked;
  final VoidCallback? onClearSelection;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    final title = activeTask == null
        ? l10n.noTimerTaskSelected
        : l10n.activeTimerTask(activeTask!.title);

    final description = taskSelectionLocked
        ? l10n.taskSelectionLockedDescription
        : l10n.taskSelectionNextWorkPhaseDescription;

    return Card(
      elevation: 0,
      color: taskSelectionLocked
          ? colorScheme.surfaceContainerHighest
          : colorScheme.primaryContainer.withValues(alpha: 0.35),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              taskSelectionLocked
                  ? Icons.lock_outline
                  : Icons.play_circle_outline,
              color: taskSelectionLocked
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (activeTask != null && onClearSelection != null)
              TextButton.icon(
                onPressed: onClearSelection,
                icon: const Icon(Icons.close),
                label: Text(l10n.withoutTask),
              ),
          ],
        ),
      ),
    );
  }
}

class _TaskToolbar extends StatelessWidget {
  const _TaskToolbar({
    required this.searchController,
    required this.filter,
    required this.sort,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final TextEditingController searchController;
  final _TaskFilter filter;
  final _TaskSort sort;
  final ValueChanged<_TaskFilter> onFilterChanged;
  final ValueChanged<_TaskSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 320,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: l10n.searchTasks,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.clearSearch,
                          onPressed: searchController.clear,
                          icon: const Icon(Icons.close),
                        ),
                  border: const OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            SegmentedButton<_TaskFilter>(
              selected: {filter},
              onSelectionChanged: (selection) {
                onFilterChanged(selection.first);
              },
              segments: [
                ButtonSegment(
                  value: _TaskFilter.all,
                  label: Text(l10n.filterAll),
                ),
                ButtonSegment(
                  value: _TaskFilter.open,
                  label: Text(l10n.filterOpen),
                ),
                ButtonSegment(
                  value: _TaskFilter.completed,
                  label: Text(l10n.filterCompleted),
                ),
              ],
            ),
            DropdownMenu<_TaskSort>(
              initialSelection: sort,
              label: Text(l10n.sortLabel),
              onSelected: (value) {
                if (value != null) {
                  onSortChanged(value);
                }
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: _TaskSort.newest,
                  label: l10n.sortNewest,
                ),
                DropdownMenuEntry(
                  value: _TaskSort.priority,
                  label: l10n.sortPriority,
                ),
                DropdownMenuEntry(
                  value: _TaskSort.pomodoros,
                  label: l10n.sortPomodoros,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.selected,
    required this.canSelectForTimer,
    required this.onCompletedChanged,
    required this.onSelectForTimer,
    required this.onEdit,
    required this.onDelete,
  });

  final TaskItem task;
  final bool selected;
  final bool canSelectForTimer;
  final ValueChanged<bool> onCompletedChanged;
  final VoidCallback onSelectForTimer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final tags = _splitTags(task.tags);

    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final status = task.completed ? l10n.completed : l10n.filterOpen;
    final selectedStatus = selected ? l10n.active : l10n.no;
    final priority = _priorityLabel(task.priority, l10n);

    return Semantics(
      container: true,
      label: l10n.taskCardSemantics(
        task.title,
        status,
        priority,
        l10n.pomodoroCount(task.completedPomodoros),
        selectedStatus,
      ),
      child:  Card(
          elevation: selected ? 3 : 0,
          color: selected
              ? colorScheme.primaryContainer.withValues(alpha: 0.45)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: selected
                ? BorderSide(
                    color: colorScheme.primary,
                    width: 1.4,
                  )
                : BorderSide(
                    color: colorScheme.outlineVariant,
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 720;

                final content = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      label: l10n.taskCompletedToggleSemantics(task.title),
                      checked: task.completed,
                      child: Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          onCompletedChanged(value ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _TaskContent(
                        task: task,
                        selected: selected,
                        tags: tags,
                      ),
                    ),
                  ],
                );

                final actions = _TaskActions(
                  taskTitle: task.title,
                  selected: selected,
                  canSelectForTimer: canSelectForTimer,
                  onSelectForTimer: onSelectForTimer,
                  onEdit: onEdit,
                  onDelete: onDelete,
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content,
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: actions,
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: content),
                    const SizedBox(width: 16),
                    actions,
                  ],
                );
              },
            ),
          ),
        );
    ),
  }
}

class _TaskContent extends StatelessWidget {
  const _TaskContent({
    required this.task,
    required this.selected,
    required this.tags,
  });

  final TaskItem task;
  final bool selected;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              task.title,
              style: textTheme.titleMedium?.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            if (selected)
              Chip(
                visualDensity: VisualDensity.compact,
                avatar: const Icon(Icons.play_arrow, size: 18),
                label: Text(l10n.active),
              ),
            if (task.completed)
              Chip(
                visualDensity: VisualDensity.compact,
                avatar: const Icon(Icons.check, size: 18),
                label: Text(l10n.completed),
              ),
          ],
        ),
        if (task.description.trim().isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            task.description.trim(),
            style: textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              visualDensity: VisualDensity.compact,
              avatar: const Icon(Icons.flag_outlined, size: 18),
              label: Text(_priorityLabel(task.priority, l10n)),
            ),
            Chip(
              visualDensity: VisualDensity.compact,
              avatar: const Icon(Icons.timer_outlined, size: 18),
              label: Text(l10n.pomodoroCount(task.completedPomodoros)),
            ),
            for (final tag in tags)
              Chip(
                visualDensity: VisualDensity.compact,
                avatar: const Icon(Icons.sell_outlined, size: 18),
                label: Text(tag),
              ),
          ],
        ),
      ],
    );
  }
}

class _TaskActions extends StatelessWidget {
  const _TaskActions({
    required this.taskTitle,
    required this.selected,
    required this.canSelectForTimer,
    required this.onSelectForTimer,
    required this.onEdit,
    required this.onDelete,
  });

  final bool selected;
  final bool canSelectForTimer;
  final VoidCallback onSelectForTimer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (selected)
          FilledButton.tonalIcon(
            onPressed: null,
            icon: const ExcludeSemantics(child: Icon(Icons.check_circle)),
            label: Text(l10n.active),
          )
        else if (!canSelectForTimer)
          OutlinedButton.icon(
            onPressed: null,
            icon: const ExcludeSemantics(child: Icon(Icons.lock_outline)),
            label: Text(l10n.locked),
          )
        else
          Tooltip(
            message: l10n.selectTaskForTimerSemantics(taskTitle),
            child: OutlinedButton.icon(
              onPressed: onSelectForTimer,
              icon: const ExcludeSemantics(child: Icon(Icons.play_arrow)),
              label: Text(l10n.forTimer),
            ),
          ),
        IconButton.outlined(
          tooltip: l10n.editTaskSemantics(taskTitle),
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
        ),
        IconButton.outlined(
          tooltip: l10n.deleteTaskSemantics(taskTitle),
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({
    required this.message,
    required this.onClose,
  });

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.taskErrorSemantics(message),
      child: Card(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const ExcludeSemantics(child: Icon(Icons.warning_amber_outlined)),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
              IconButton(
                tooltip: l10n.messageClose,
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.message,
    this.showProgress = false,
  });

  final IconData icon;
  final String message;
  final bool showProgress;
  final l10n = AppLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: showProgress,
      label: l10n.taskStatusSemantics(message),
      child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (showProgress)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(icon),
                const SizedBox(width: 16),
                Expanded(child: Text(message)),
              ],
            ),
          ),
        );
    ),
  }
}

bool _sameTaskIdentity(TaskItem? first, TaskItem second) {
  if (first == null) {
    return false;
  }

  if (first.remoteId != null && second.remoteId != null) {
    return first.remoteId == second.remoteId;
  }

  return first.localId == second.localId;
}

String _priorityLabel(String priority, AppLocalizations l10n) {
  return switch (priority) {
    'low' => l10n.priorityLow,
    'medium' => l10n.priorityMedium,
    'high' => l10n.priorityHigh,
    _ => priority,
  };
}

int _priorityWeight(String priority) {
  return switch (priority) {
    'high' => 3,
    'medium' => 2,
    'low' => 1,
    _ => 0,
  };
}

List<String> _splitTags(String tags) {
  return tags
      .split(',')
      .map((tag) => tag.trim())
      .where((tag) => tag.isNotEmpty)
      .toList();
}

String _localizedTaskError(AppLocalizations l10n, String error) {
  return switch (error) {
    'Aufgaben konnten nicht vom Backend geladen werden. Lokale Daten werden weiter angezeigt.' =>
      l10n.taskLoadRemoteFailed,
    'Aufgabe wurde lokal gespeichert, konnte aber nicht mit dem Konto synchronisiert werden.' =>
      l10n.taskSavedLocallyNotSynced,
    'Aufgabe konnte nicht gespeichert werden. Die letzte Änderung wurde zurückgenommen.' =>
      l10n.taskSaveFailedRolledBack,
    'Aufgabe konnte nicht im Konto gelöscht werden. Die Aufgabe wurde wiederhergestellt.' =>
      l10n.taskDeleteFailedRestored,
    _ => error,
  };
}

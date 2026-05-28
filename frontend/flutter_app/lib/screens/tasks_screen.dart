import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_item.dart';
import '../providers/task_provider.dart';
import '../widgets/task_editor_dialog.dart';
import '../providers/timer_provider.dart';

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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Aufgabe löschen?'),
        content: Text(
          'Möchtest du die Aufgabe „${task.title}“ wirklich löschen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton.tonalIcon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Löschen'),
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
        _TaskSort.priority => _priorityWeight(b.priority)
            .compareTo(_priorityWeight(a.priority)),
        _TaskSort.pomodoros =>
          b.completedPomodoros.compareTo(a.completedPomodoros),
      };
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aufgaben'),
        actions: [
          Consumer<TaskProvider>(
            builder: (context, provider, _) {
              return IconButton(
                tooltip: 'Aufgaben aktualisieren',
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
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add),
        label: const Text('Aufgabe'),
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
                      message: provider.error!,
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
                    const _StatusCard(
                      icon: Icons.hourglass_empty,
                      message: 'Aufgaben werden geladen ...',
                      showProgress: true,
                    )
                  else if (provider.tasks.isEmpty)
                    const _StatusCard(
                      icon: Icons.task_alt_outlined,
                      message:
                          'Noch keine Aufgaben vorhanden. Erstelle deine erste Aufgabe.',
                    )
                  else if (visibleTasks.isEmpty)
                    const _StatusCard(
                      icon: Icons.search_off,
                      message:
                          'Keine Aufgaben gefunden. Passe Suche oder Filter an.',
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

    final title = activeTask == null
        ? 'Keine Timer-Aufgabe ausgewählt'
        : 'Aktive Timer-Aufgabe: ${activeTask!.title}';

    final description = taskSelectionLocked
        ? 'Eine Timer-Phase läuft oder ist pausiert. Die Aufgabe ist deshalb aktuell gesperrt.'
        : 'Diese Aufgabe wird für die nächste Arbeitsphase verwendet.';

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
                label: const Text('Ohne Aufgabe'),
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
                  labelText: 'Aufgaben suchen',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Suche löschen',
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
              segments: const [
                ButtonSegment(
                  value: _TaskFilter.all,
                  label: Text('Alle'),
                ),
                ButtonSegment(
                  value: _TaskFilter.open,
                  label: Text('Offen'),
                ),
                ButtonSegment(
                  value: _TaskFilter.completed,
                  label: Text('Erledigt'),
                ),
              ],
            ),
            DropdownMenu<_TaskSort>(
              initialSelection: sort,
              label: const Text('Sortierung'),
              onSelected: (value) {
                if (value != null) {
                  onSortChanged(value);
                }
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: _TaskSort.newest,
                  label: 'Neueste zuerst',
                ),
                DropdownMenuEntry(
                  value: _TaskSort.priority,
                  label: 'Priorität',
                ),
                DropdownMenuEntry(
                  value: _TaskSort.pomodoros,
                  label: 'Pomodoros',
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

  return Card(
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
                Checkbox(
                  value: task.completed,
                  onChanged: (value) {
                    onCompletedChanged(value ?? false);
                  },
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
                decoration:
                    task.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            if (selected)
              const Chip(
                visualDensity: VisualDensity.compact,
                avatar: Icon(Icons.play_arrow, size: 18),
                label: Text('Aktiv'),
              ),
            if (task.completed)
              const Chip(
                visualDensity: VisualDensity.compact,
                avatar: Icon(Icons.check, size: 18),
                label: Text('Erledigt'),
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
              label: Text(_priorityLabel(task.priority)),
            ),
            Chip(
              visualDensity: VisualDensity.compact,
              avatar: const Icon(Icons.timer_outlined, size: 18),
              label: Text('${task.completedPomodoros} Pomodoros'),
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
      if (selected)
        FilledButton.tonalIcon(
          onPressed: null,
          icon: const Icon(Icons.check_circle),
          label: const Text('Aktiv'),
        )
      else if (!canSelectForTimer)
        OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.lock_outline),
          label: const Text('Gesperrt'),
        )
      else
        OutlinedButton.icon(
          onPressed: onSelectForTimer,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Für Timer'),
        ),
        IconButton.outlined(
          tooltip: 'Bearbeiten',
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
        ),
        IconButton.outlined(
          tooltip: 'Löschen',
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
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_outlined),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
            IconButton(
              tooltip: 'Meldung schließen',
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Card(
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

String _priorityLabel(String priority) {
  return switch (priority) {
    'low' => 'Niedrig',
    'medium' => 'Mittel',
    'high' => 'Hoch',
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
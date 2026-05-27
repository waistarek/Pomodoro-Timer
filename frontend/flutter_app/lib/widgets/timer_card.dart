import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/task_item.dart';
import '../providers/task_provider.dart';
import '../providers/timer_provider.dart';
import '../timer/pomodoro_phase.dart';
import 'big_button.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TimerProvider, TaskProvider>(
      builder: (context, timer, taskProvider, _) {
        final phaseColor = _phaseColor(context, timer.phase);

        return _TimerKeyboardShortcuts(
          timer: timer,
          child: Card(
            elevation: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 560;
                final timerDiameter = isCompact ? 220.0 : 270.0;
                final padding = isCompact ? 16.0 : 24.0;

                return Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      _TaskSelector(
                        taskProvider: taskProvider,
                        canChangeTask: timer.canChangeTask,
                      ),
                      SizedBox(height: isCompact ? 18 : 24),
                      _TimerHeader(
                        phaseLabel: timer.phase.label,
                        statusLabel: timer.statusLabel,
                        color: phaseColor,
                      ),
                      if (timer.error != null) ...[
                        const SizedBox(height: 16),
                        _TimerErrorBanner(
                          message: timer.error!,
                          onClose: timer.clearError,
                        ),
                      ],
                      SizedBox(height: isCompact ? 18 : 24),
                      _ProgressTimer(
                        progress: timer.progress,
                        formattedTime: timer.formattedTime,
                        completedPomodoros: timer.completedPomodoros,
                        color: phaseColor,
                        diameter: timerDiameter,
                      ),
                      SizedBox(height: isCompact ? 22 : 28),
                      _TimerActions(timer: timer),
                      const SizedBox(height: 12),
                      _KeyboardShortcutHelp(
                        showSkipShortcut: timer.canSkipPause,
                        isCompact: isCompact,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _TimerKeyboardShortcuts extends StatefulWidget {
  const _TimerKeyboardShortcuts({
    required this.timer,
    required this.child,
  });

  final TimerProvider timer;
  final Widget child;

  @override
  State<_TimerKeyboardShortcuts> createState() =>
      _TimerKeyboardShortcutsState();
}

class _TimerKeyboardShortcutsState extends State<_TimerKeyboardShortcuts> {
  final FocusNode _focusNode = FocusNode(
    debugLabel: 'timer_keyboard_shortcuts',
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.space): () {
          _toggleTimer(widget.timer);
        },
        const SingleActivator(LogicalKeyboardKey.keyR): () {
          if (widget.timer.canReset) {
            unawaited(_confirmResetTimer(context, widget.timer));
          }
        },
        const SingleActivator(LogicalKeyboardKey.keyS): () {
          if (widget.timer.canSkipPause) {
            widget.timer.skipPause();
          }
        },
      },
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) {
            _focusNode.requestFocus();
          },
          child: widget.child,
        ),
      ),
    );
  }
}

void _toggleTimer(TimerProvider timer) {
  if (timer.isSaving) {
    return;
  }

  if (timer.running) {
    timer.pause();
    return;
  }

  if (timer.canStartOrResume) {
    timer.startOrResume();
  }
}

Future<void> _confirmResetTimer(
  BuildContext context,
  TimerProvider timer,
) async {
  if (!timer.canReset) {
    return;
  }

  if (timer.isReady) {
    timer.reset();
    return;
  }

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Timer zurücksetzen?'),
      content: const Text(
        'Die aktuelle Phase wird abgebrochen und nicht als abgeschlossene Sitzung gespeichert.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Abbrechen'),
        ),
        FilledButton.tonalIcon(
          onPressed: () => Navigator.pop(dialogContext, true),
          icon: const Icon(Icons.restart_alt),
          label: const Text('Zurücksetzen'),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    timer.reset();
  }
}

class _TaskSelector extends StatelessWidget {
  const _TaskSelector({
    required this.taskProvider,
    required this.canChangeTask,
  });

  final TaskProvider taskProvider;
  final bool canChangeTask;

  @override
  Widget build(BuildContext context) {
    final selected = taskProvider.selectedTask;
    final openTasks =
        taskProvider.tasks.where((task) => !task.completed).toList();

    TaskItem? selectedValue;

    if (selected != null) {
      for (final task in openTasks) {
        if (task.localId == selected.localId) {
          selectedValue = task;
          break;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.task_alt_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedValue == null
                    ? 'Keine Aufgabe ausgewählt'
                    : 'Aktuelle Aufgabe: ${selectedValue.title}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<TaskItem?>(
          key: ValueKey(selectedValue?.localId ?? 'no-task'),
          initialValue: selectedValue,
          decoration: const InputDecoration(
            labelText: 'Aufgabe für diese Arbeitsphase',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem<TaskItem?>(
              value: null,
              child: Text('Ohne Aufgabe'),
            ),
            ...openTasks.map(
              (task) => DropdownMenuItem<TaskItem?>(
                value: task,
                child: Text(task.title),
              ),
            ),
          ],
          onChanged: canChangeTask
              ? (task) {
                  taskProvider.selectTask(task);
                }
              : null,
        ),
        if (!canChangeTask) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Die Aufgabe ist für die laufende Phase gesperrt.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TimerHeader extends StatelessWidget {
  const _TimerHeader({
    required this.phaseLabel,
    required this.statusLabel,
    required this.color,
  });

  final String phaseLabel;
  final String statusLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Text(
          phaseLabel,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Chip(
          avatar: Icon(
            _statusIcon(statusLabel),
            size: 18,
            color: color,
          ),
          label: Text(statusLabel),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

class _ProgressTimer extends StatelessWidget {
  const _ProgressTimer({
    required this.progress,
    required this.formattedTime,
    required this.completedPomodoros,
    required this.color,
    required this.diameter,
  });

  final double progress;
  final String formattedTime;
  final int completedPomodoros;
  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    final isCompact = diameter < 240;

    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: isCompact ? 12 : 14,
              color: backgroundColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: isCompact ? 12 : 14,
              color: color,
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedTime,
                style: isCompact
                    ? Theme.of(context).textTheme.displayMedium
                    : Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Diese Sitzung: $completedPomodoros Pomodoros',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimerActions extends StatelessWidget {
  const _TimerActions({required this.timer});

  final TimerProvider timer;

  @override
  Widget build(BuildContext context) {
    if (timer.isSaving) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          FilledButton.icon(
            onPressed: null,
            icon: const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            label: const Text('Phase wird gespeichert ...'),
          ),
        ],
      );
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        if (timer.running)
          BigButton(
            label: 'Pause',
            icon: Icons.pause,
            onPressed: timer.pause,
          )
        else
          BigButton(
            label: timer.isPaused ? 'Fortsetzen' : 'Start',
            icon: Icons.play_arrow,
            onPressed: timer.startOrResume,
          ),
        BigButton(
          label: 'Zurücksetzen',
          icon: Icons.restart_alt,
          filled: false,
          onPressed: () => _confirmResetTimer(context, timer),
        ),
        if (timer.canSkipPause)
          BigButton(
            label: 'Pause überspringen',
            icon: Icons.skip_next,
            filled: false,
            onPressed: timer.skipPause,
          ),
      ],
    );
  }
}

class _KeyboardShortcutHelp extends StatelessWidget {
  const _KeyboardShortcutHelp({
    required this.showSkipShortcut,
    required this.isCompact,
  });

  final bool showSkipShortcut;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final shortcuts = isCompact
        ? [
            'Space: Start/Pause',
            'R: Reset',
            if (showSkipShortcut) 'S: Skip',
          ]
        : [
            'Leertaste: Start/Pause',
            'R: Zurücksetzen',
            if (showSkipShortcut) 'S: Pause überspringen',
          ];

    return Text(
      shortcuts.join(' · '),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      textAlign: TextAlign.center,
    );
  }
}

class _TimerErrorBanner extends StatelessWidget {
  const _TimerErrorBanner({
    required this.message,
    required this.onClose,
  });

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
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

Color _phaseColor(BuildContext context, PomodoroPhase phase) {
  final colorScheme = Theme.of(context).colorScheme;

  return switch (phase) {
    PomodoroPhase.work => colorScheme.primary,
    PomodoroPhase.shortBreak => colorScheme.secondary,
    PomodoroPhase.longBreak => colorScheme.tertiary,
  };
}

IconData _statusIcon(String statusLabel) {
  return switch (statusLabel) {
    'Läuft' => Icons.play_circle_outline,
    'Pausiert' => Icons.pause_circle_outline,
    'Speichern ...' => Icons.cloud_upload_outlined,
    _ => Icons.radio_button_checked,
  };
}

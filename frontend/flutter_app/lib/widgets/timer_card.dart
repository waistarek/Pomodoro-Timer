import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/task_item.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';
import '../providers/timer_provider.dart';
import '../timer/pomodoro_phase.dart';
import '../timer/timer_engine.dart';
import 'big_button.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<TimerProvider, TaskProvider, StatsProvider>(
      builder: (context, timer, taskProvider, statsProvider, _) {
        final l10n = AppLocalizations.of(context);
        final phaseColor = _phaseColor(context, timer.phase);
        final phaseLabel = _phaseLabel(timer.phase, l10n);
        final statusLabel = _timerStatusLabel(timer, l10n);
        final progressLabel = _phaseProgressLabel(timer, l10n);
        final todayPomodorosLabel = statsProvider.todayPomodorosLoading
            ? l10n.todayPomodorosLoading
            : l10n.todayPomodoros(
                l10n.pomodoroCount(statsProvider.todayPomodoros),
              );

        timer.setWorkPhaseCompletedCallback(() async {
          await Future.wait([
            taskProvider.refreshTaskPomodoroCounts(),
            statsProvider.loadTodayPomodoros(),
          ]);
        });
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
                        timer: timer,
                      ),
                      SizedBox(height: isCompact ? 18 : 24),
                      _TimerHeader(
                        phaseLabel: _phaseLabel(timer.phase, l10n),
                        statusLabel: _timerStatusLabel(timer, l10n),
                        statusIcon: _timerStatusIcon(timer),
                        phaseDescription: _phaseDescription(timer.phase, l10n),
                        nextPhaseLabel: _nextPhaseLabel(timer, l10n),
                        color: phaseColor,
                      ),
                      if (timer.isSaving) ...[
                        const SizedBox(height: 16),
                        const _TimerSavingBanner(),
                      ] else if (timer.isSessionSyncing) ...[
                        const SizedBox(height: 16),
                        _TimerBackgroundSyncBanner(
                          message: _sessionSyncLabel(timer, l10n),
                        ),
                      ] else if (timer.error != null) ...[
                        const SizedBox(height: 16),
                        _TimerErrorBanner(
                          message: _localizedTimerError(l10n, timer.error!),
                          onClose: timer.clearError,
                        ),
                      ],
                      SizedBox(height: isCompact ? 18 : 24),
                      _ProgressTimer(
                        progress: timer.progress,
                        formattedTime: timer.formattedTime,
                        phaseLabel: phaseLabel,
                        statusLabel: statusLabel,
                        progressLabel: progressLabel,
                        todayPomodorosLabel: todayPomodorosLabel,
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

  final l10n = AppLocalizations.of(context);

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.timerResetTitle),
      content: Text(l10n.timerResetMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(l10n.cancel),
        ),
        FilledButton.tonalIcon(
          onPressed: () => Navigator.pop(dialogContext, true),
          icon: const Icon(Icons.restart_alt),
          label: Text(l10n.reset),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    timer.reset();
  }
}

Widget _blockTimerShortcutsForInput(Widget child) {
  return Shortcuts(
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.space):
          DoNothingAndStopPropagationIntent(),
      SingleActivator(LogicalKeyboardKey.keyR):
          DoNothingAndStopPropagationIntent(),
      SingleActivator(LogicalKeyboardKey.keyS):
          DoNothingAndStopPropagationIntent(),
    },
    child: child,
  );
}

class _TaskSelector extends StatelessWidget {
  const _TaskSelector({
    required this.taskProvider,
    required this.timer,
  });

  final TaskProvider taskProvider;
  final TimerProvider timer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canChangeTask = timer.canChangeTask;
    final displayTask = timer.taskForDisplay ?? taskProvider.selectedTask;

    final dropdownTasks =
        taskProvider.tasks.where((task) => !task.completed).toList();

    if (displayTask != null &&
        !dropdownTasks.any((task) => _sameTaskIdentity(task, displayTask))) {
      dropdownTasks.insert(0, displayTask);
    }

    final selectedValue = displayTask == null
        ? null
        : dropdownTasks.firstWhere(
            (task) => _sameTaskIdentity(task, displayTask),
            orElse: () => displayTask,
          );

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
                    ? l10n.taskNoneSelected
                    : l10n.currentTask(selectedValue.title),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _blockTimerShortcutsForInput(
          DropdownButtonFormField<TaskItem?>(
            key: ValueKey(selectedValue?.localId ?? 'no-task'),
            initialValue: selectedValue,
            decoration: InputDecoration(
              labelText: l10n.taskForWorkPhase,
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem<TaskItem?>(
                value: null,
                child: Text(l10n.withoutTask),
              ),
              ...dropdownTasks.map(
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
                  l10n.taskLockedToPhase,
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
    required this.statusIcon,
    required this.phaseDescription,
    required this.nextPhaseLabel,
    required this.color,
  });

  final String phaseLabel;
  final String statusLabel;
  final IconData statusIcon;
  final String phaseDescription;
  final String nextPhaseLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        Wrap(
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
                statusIcon,
                size: 18,
                color: color,
              ),
              label: Text(statusLabel),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.afterNextPhase(phaseDescription, nextPhaseLabel),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ProgressTimer extends StatelessWidget {
  const _ProgressTimer({
    required this.progress,
    required this.formattedTime,
    required this.phaseLabel,
    required this.statusLabel,
    required this.progressLabel,
    required this.todayPomodorosLabel,
    required this.color,
    required this.diameter,
  });

  final double progress;
  final String formattedTime;
  final String phaseLabel;
  final String statusLabel;
  final String progressLabel;
  final String todayPomodorosLabel;
  final Color color;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final backgroundColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    final isCompact = diameter < 240;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final progressPercent = (clampedProgress * 100).round();

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.timerSemanticsLabel(
        phaseLabel,
        statusLabel,
        formattedTime,
        progressLabel,
        todayPomodorosLabel,
      ),
      value: l10n.timerProgressSemantics(progressPercent),
      child: ExcludeSemantics(
        child: SizedBox(
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
                  value: clampedProgress,
                  strokeWidth: isCompact ? 12 : 14,
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedTime,
                      style: isCompact
                          ? Theme.of(context).textTheme.displayMedium
                          : Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      progressLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      todayPomodorosLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerActions extends StatelessWidget {
  const _TimerActions({required this.timer});

  final TimerProvider timer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (timer.isSaving) {
      return const SizedBox.shrink();
    }
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        if (timer.running)
          BigButton(
            label: l10n.pause,
            icon: Icons.pause,
            semanticLabel: l10n.pauseTimerSemantics,
            tooltip: l10n.pauseTimerSemantics,
            onPressed: timer.pause,
          )
        else
          BigButton(
            label: timer.isPaused ? l10n.continueButton : l10n.start,
            icon: Icons.play_arrow,
            semanticLabel: timer.isPaused
                ? l10n.continueTimerSemantics
                : l10n.startTimerSemantics,
            tooltip: timer.isPaused
                ? l10n.continueTimerSemantics
                : l10n.startTimerSemantics,
            onPressed: timer.startOrResume,
          ),
        BigButton(
          label: l10n.reset,
          icon: Icons.restart_alt,
          filled: false,
          semanticLabel: l10n.resetTimerSemantics,
          tooltip: l10n.resetTimerSemantics,
          onPressed: () => _confirmResetTimer(context, timer),
        ),
        if (timer.canSkipPause)
          BigButton(
            label: l10n.skipPause,
            icon: Icons.skip_next,
            filled: false,
            semanticLabel: l10n.skipPauseSemantics,
            tooltip: l10n.skipPauseSemantics,
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
    final l10n = AppLocalizations.of(context);
    final shortcuts = isCompact
        ? [
            l10n.shortcutSpaceCompact,
            l10n.shortcutResetCompact,
            if (showSkipShortcut) l10n.shortcutSkipCompact,
          ]
        : [
            l10n.shortcutSpace,
            l10n.shortcutReset,
            if (showSkipShortcut) l10n.shortcutSkip,
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

class _TimerBackgroundSyncBanner extends StatelessWidget {
  const _TimerBackgroundSyncBanner({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.timerSyncSemantics(message),
      child: ExcludeSemantics(
        child: Card(
          elevation: 0,
          color: colorScheme.secondaryContainer.withValues(alpha: 0.45),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(
                  Icons.sync_outlined,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerSavingBanner extends StatelessWidget {
  const _TimerSavingBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.timerSavingSemantics,
      child: ExcludeSemantics(
        child: Card(
          elevation: 0,
          color: colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.phaseSavingTitle,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.phaseSavingDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: const LinearProgressIndicator(minHeight: 4),
                ),
              ],
            ),
          ),
        ),
      ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.timerErrorSemantics(message),
      child: Card(
        color: colorScheme.errorContainer,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.storageProblem,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: colorScheme.onErrorContainer,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onErrorContainer,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.messageClose,
                onPressed: onClose,
                icon: Icon(
                  Icons.close,
                  color: colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _sameTaskIdentity(TaskItem first, TaskItem second) {
  if (first.remoteId != null && second.remoteId != null) {
    return first.remoteId == second.remoteId;
  }

  return first.localId == second.localId;
}

Color _phaseColor(BuildContext context, PomodoroPhase phase) {
  final colorScheme = Theme.of(context).colorScheme;

  return switch (phase) {
    PomodoroPhase.work => colorScheme.primary,
    PomodoroPhase.shortBreak => colorScheme.secondary,
    PomodoroPhase.longBreak => colorScheme.tertiary,
  };
}

String _phaseLabel(PomodoroPhase phase, AppLocalizations l10n) {
  return switch (phase) {
    PomodoroPhase.work => l10n.phaseWork,
    PomodoroPhase.shortBreak => l10n.phaseShortBreak,
    PomodoroPhase.longBreak => l10n.phaseLongBreak,
  };
}

String _phaseDescription(PomodoroPhase phase, AppLocalizations l10n) {
  return switch (phase) {
    PomodoroPhase.work => l10n.phaseDescriptionWork,
    PomodoroPhase.shortBreak => l10n.phaseDescriptionShortBreak,
    PomodoroPhase.longBreak => l10n.phaseDescriptionLongBreak,
  };
}

String _timerStatusLabel(TimerProvider timer, AppLocalizations l10n) {
  if (timer.isSaving) {
    return l10n.timerStatusSaving;
  }

  if (timer.running) {
    return l10n.timerStatusRunning;
  }

  if (timer.isPaused) {
    return l10n.timerStatusPaused;
  }

  return l10n.timerStatusReady;
}

IconData _timerStatusIcon(TimerProvider timer) {
  if (timer.isSaving) {
    return Icons.cloud_upload_outlined;
  }

  if (timer.running) {
    return Icons.play_circle_outline;
  }

  if (timer.isPaused) {
    return Icons.pause_circle_outline;
  }

  return Icons.radio_button_checked;
}

String _nextPhaseLabel(TimerProvider timer, AppLocalizations l10n) {
  switch (timer.phase) {
    case PomodoroPhase.work:
      final nextCompletedPomodoros = timer.completedPomodoros + 1;
      final shouldUseLongBreak =
          nextCompletedPomodoros % timer.engine.longBreakAfter == 0;

      return shouldUseLongBreak ? l10n.phaseLongBreak : l10n.phaseShortBreak;
    case PomodoroPhase.shortBreak:
    case PomodoroPhase.longBreak:
      return l10n.phaseWork;
  }
}

String _phaseProgressLabel(TimerProvider timer, AppLocalizations l10n) {
  final totalSeconds = timer.engine.totalPhaseSeconds;
  final elapsedSeconds =
      (totalSeconds - timer.remainingSeconds).clamp(0, totalSeconds).toInt();

  return l10n.phaseProgress(
    TimerEngine.formatMMSS(elapsedSeconds),
    TimerEngine.formatMMSS(totalSeconds),
  );
}

String _sessionSyncLabel(TimerProvider timer, AppLocalizations l10n) {
  if (timer.activeSessionSyncCount <= 1) {
    return l10n.oneFinishedPhaseSavingBackground;
  }

  return l10n.manyFinishedPhasesSavingBackground(timer.activeSessionSyncCount);
}

String _localizedTimerError(AppLocalizations l10n, String error) {
  return switch (error) {
    'Die abgeschlossene Phase konnte nicht lokal gespeichert werden.' =>
      l10n.timerLocalSaveFailed,
    'Die abgeschlossene Phase wurde lokal gespeichert, aber noch nicht mit dem Backend synchronisiert.' =>
      l10n.timerBackendSyncFailed,
    _ => error,
  };
}

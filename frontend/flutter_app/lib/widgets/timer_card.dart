import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';
import '../timer/pomodoro_phase.dart';
import 'big_button.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timer, _) {
        final phaseColor = _phaseColor(context, timer.phase);

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _TimerHeader(
                  phaseLabel: timer.phase.label,
                  statusLabel: timer.statusLabel,
                  color: phaseColor,
                ),
                const SizedBox(height: 24),
                _ProgressTimer(
                  progress: timer.progress,
                  formattedTime: timer.formattedTime,
                  completedPomodoros: timer.completedPomodoros,
                  color: phaseColor,
                ),
                const SizedBox(height: 28),
                _TimerActions(timer: timer),
              ],
            ),
          ),
        );
      },
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
  });

  final double progress;
  final String formattedTime;
  final int completedPomodoros;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      width: 270,
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 14,
              color: backgroundColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 14,
              color: color,
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Diese Sitzung: $completedPomodoros Pomodoros',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
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
          onPressed: timer.reset,
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
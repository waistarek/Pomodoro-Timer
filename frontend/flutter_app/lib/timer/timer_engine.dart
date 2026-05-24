import 'pomodoro_phase.dart';

class TimerEngine {
  TimerEngine({
    required this.workSeconds,
    required this.shortBreakSeconds,
    required this.longBreakSeconds,
    required this.longBreakAfter,
    this.completedPomodoros = 0,
    this.phase = PomodoroPhase.work,
    int? remainingSeconds,
  }) : remainingSeconds = remainingSeconds ?? workSeconds;

  final int workSeconds;
  final int shortBreakSeconds;
  final int longBreakSeconds;
  final int longBreakAfter;

  int completedPomodoros;
  PomodoroPhase phase;
  int remainingSeconds;

  int get totalPhaseSeconds {
    switch (phase) {
      case PomodoroPhase.work:
        return workSeconds;
      case PomodoroPhase.shortBreak:
        return shortBreakSeconds;
      case PomodoroPhase.longBreak:
        return longBreakSeconds;
    }
  }

  double get progress {
    if (totalPhaseSeconds <= 0) return 0;
    final done = totalPhaseSeconds - remainingSeconds;
    return (done / totalPhaseSeconds).clamp(0.0, 1.0);
  }

  bool get isFinished => remainingSeconds <= 0;

  PomodoroPhase switchToNextPhase() {
    if (phase == PomodoroPhase.work) {
      completedPomodoros += 1;
      final shouldLongBreak = completedPomodoros % longBreakAfter == 0;
      phase =
          shouldLongBreak ? PomodoroPhase.longBreak : PomodoroPhase.shortBreak;
    } else {
      phase = PomodoroPhase.work;
    }
    remainingSeconds = totalPhaseSeconds;
    return phase;
  }

  void reset() {
    phase = PomodoroPhase.work;
    remainingSeconds = workSeconds;
  }

  static String formatMMSS(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

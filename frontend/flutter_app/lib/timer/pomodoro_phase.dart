enum PomodoroPhase { work, shortBreak, longBreak }

extension PomodoroPhaseLabel on PomodoroPhase {
  String get label {
    switch (this) {
      case PomodoroPhase.work:
        return 'Arbeitsphase';
      case PomodoroPhase.shortBreak:
        return 'Kurze Pause';
      case PomodoroPhase.longBreak:
        return 'Lange Pause';
    }
  }

  String get apiValue {
    switch (this) {
      case PomodoroPhase.work:
        return 'work';
      case PomodoroPhase.shortBreak:
        return 'short_break';
      case PomodoroPhase.longBreak:
        return 'long_break';
    }
  }
}

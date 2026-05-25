import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/timer/pomodoro_phase.dart';
import 'package:pomodoro_app/timer/timer_engine.dart';

void main() {
  TimerEngine createEngine({
    int completedPomodoros = 0,
    PomodoroPhase phase = PomodoroPhase.work,
    int? remainingSeconds,
  }) {
    return TimerEngine(
      workSeconds: 1500,
      shortBreakSeconds: 300,
      longBreakSeconds: 900,
      longBreakAfter: 4,
      completedPomodoros: completedPomodoros,
      phase: phase,
      remainingSeconds: remainingSeconds,
    );
  }

  test('formatMMSS formats seconds correctly', () {
    expect(TimerEngine.formatMMSS(0), '00:00');
    expect(TimerEngine.formatMMSS(65), '01:05');
    expect(TimerEngine.formatMMSS(1500), '25:00');
  });

  test('engine starts with work phase and work duration', () {
    final engine = createEngine();

    expect(engine.phase, PomodoroPhase.work);
    expect(engine.remainingSeconds, 1500);
    expect(engine.totalPhaseSeconds, 1500);
    expect(engine.completedPomodoros, 0);
  });

  test('isFinished is true when remaining seconds are zero', () {
    final engine = createEngine(remainingSeconds: 0);

    expect(engine.isFinished, true);
  });

  test('after work phase it switches to short break', () {
    final engine = createEngine();

    engine.switchToNextPhase();

    expect(engine.phase, PomodoroPhase.shortBreak);
    expect(engine.remainingSeconds, 300);
    expect(engine.completedPomodoros, 1);
  });

  test('after four work phases it switches to long break', () {
    final engine = createEngine(completedPomodoros: 3);

    engine.switchToNextPhase();

    expect(engine.phase, PomodoroPhase.longBreak);
    expect(engine.remainingSeconds, 900);
    expect(engine.completedPomodoros, 4);
  });

  test('reset restores work phase and work duration', () {
    final engine = createEngine(
      phase: PomodoroPhase.shortBreak,
      remainingSeconds: 100,
      completedPomodoros: 2,
    );

    engine.reset();

    expect(engine.phase, PomodoroPhase.work);
    expect(engine.remainingSeconds, 1500);
  });

  test('skipBreak switches short break to work without increasing pomodoros',
      () {
    final engine = createEngine(
      phase: PomodoroPhase.shortBreak,
      remainingSeconds: 120,
      completedPomodoros: 1,
    );

    engine.skipBreak();

    expect(engine.phase, PomodoroPhase.work);
    expect(engine.remainingSeconds, 1500);
    expect(engine.completedPomodoros, 1);
  });

  test('skipBreak switches long break to work without increasing pomodoros',
      () {
    final engine = createEngine(
      phase: PomodoroPhase.longBreak,
      remainingSeconds: 600,
      completedPomodoros: 4,
    );

    engine.skipBreak();

    expect(engine.phase, PomodoroPhase.work);
    expect(engine.remainingSeconds, 1500);
    expect(engine.completedPomodoros, 4);
  });
}

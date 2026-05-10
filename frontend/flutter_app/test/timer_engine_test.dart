import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/timer/pomodoro_phase.dart';
import 'package:pomodoro_app/timer/timer_engine.dart';

void main() {
  test('formatMMSS formats seconds correctly', () {
    expect(TimerEngine.formatMMSS(0), '00:00');
    expect(TimerEngine.formatMMSS(65), '01:05');
    expect(TimerEngine.formatMMSS(1500), '25:00');
  });

  test('timer ticks down', () {
    final engine = TimerEngine(workSeconds: 1500, shortBreakSeconds: 300, longBreakSeconds: 900, longBreakAfter: 4);
    engine.tickOneSecond();
    expect(engine.remainingSeconds, 1499);
  });

  test('after work phase it switches to short break', () {
    final engine = TimerEngine(workSeconds: 1, shortBreakSeconds: 300, longBreakSeconds: 900, longBreakAfter: 4);
    engine.tickOneSecond();
    expect(engine.isFinished, true);
    engine.switchToNextPhase();
    expect(engine.phase, PomodoroPhase.shortBreak);
    expect(engine.completedPomodoros, 1);
  });

  test('after four work phases it switches to long break', () {
    final engine = TimerEngine(workSeconds: 1, shortBreakSeconds: 300, longBreakSeconds: 900, longBreakAfter: 4);
    for (var i = 0; i < 3; i++) {
      engine.phase = PomodoroPhase.work;
      engine.remainingSeconds = 0;
      engine.switchToNextPhase();
    }
    engine.phase = PomodoroPhase.work;
    engine.remainingSeconds = 0;
    engine.switchToNextPhase();
    expect(engine.phase, PomodoroPhase.longBreak);
    expect(engine.completedPomodoros, 4);
  });
}

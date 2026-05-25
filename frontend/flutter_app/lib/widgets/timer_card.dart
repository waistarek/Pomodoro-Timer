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
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(timer.phase.label,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 24),
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: timer.progress,
                          strokeWidth: 14,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(timer.formattedTime,
                              style: Theme.of(context).textTheme.displayLarge),
                          const SizedBox(height: 8),
                          Text(
                              '${timer.completedPomodoros} Pomodoros abgeschlossen'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    BigButton(
                      label: timer.running ? 'Läuft' : 'Start / Fortsetzen',
                      icon: Icons.play_arrow,
                      onPressed: timer.running ? null : timer.startOrResume,
                    ),
                    BigButton(
                      label: 'Pause',
                      icon: Icons.pause,
                      filled: false,
                      onPressed: timer.running ? timer.pause : null,
                    ),
                    BigButton(
                      label: 'Reset',
                      icon: Icons.restart_alt,
                      filled: false,
                      onPressed: timer.reset,
                    ),
                    BigButton(
                      label: 'Überspringen',
                      icon: Icons.skip_next,
                      filled: false,
                      onPressed: timer.canSkipPause ? timer.skipPause : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

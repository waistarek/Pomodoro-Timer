import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final copy = _LandingCopy.forLocale(Localizations.localeOf(context));
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              children: [
                _LandingHeader(copy: copy),
                const SizedBox(height: 72),
                Wrap(
                  spacing: 48,
                  runSpacing: 40,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            copy.badge,
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            copy.title,
                            style: textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.08,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            copy.description,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              FilledButton.icon(
                                onPressed: () => context.go(AppRoutes.timer),
                                icon: const Icon(Icons.timer_outlined),
                                label: Text(copy.startButton),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => context.go(AppRoutes.account),
                                icon: const Icon(Icons.person_outline),
                                label: Text(copy.accountButton),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Card(
                        elevation: 0,
                        color: colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FeatureItem(
                                icon: Icons.timer_outlined,
                                title: copy.featureTimerTitle,
                                description: copy.featureTimerText,
                              ),
                              const SizedBox(height: 24),
                              _FeatureItem(
                                icon: Icons.checklist_outlined,
                                title: copy.featureTasksTitle,
                                description: copy.featureTasksText,
                              ),
                              const SizedBox(height: 24),
                              _FeatureItem(
                                icon: Icons.bar_chart_outlined,
                                title: copy.featureStatsTitle,
                                description: copy.featureStatsText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                _LandingFooter(copy: copy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LandingHeader extends StatelessWidget {
  const _LandingHeader({required this.copy});

  final _LandingCopy copy;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Icon(Icons.timer_outlined, size: 32),
        const SizedBox(width: 12),
        Text(
          'Time2Focus',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => context.go(AppRoutes.account),
          child: Text(copy.loginButton),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(icon),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LandingFooter extends StatelessWidget {
  const _LandingFooter({required this.copy});

  final _LandingCopy copy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      copy.footer,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class _LandingCopy {
  const _LandingCopy({
    required this.badge,
    required this.title,
    required this.description,
    required this.startButton,
    required this.accountButton,
    required this.loginButton,
    required this.featureTimerTitle,
    required this.featureTimerText,
    required this.featureTasksTitle,
    required this.featureTasksText,
    required this.featureStatsTitle,
    required this.featureStatsText,
    required this.footer,
  });

  final String badge;
  final String title;
  final String description;
  final String startButton;
  final String accountButton;
  final String loginButton;
  final String featureTimerTitle;
  final String featureTimerText;
  final String featureTasksTitle;
  final String featureTasksText;
  final String featureStatsTitle;
  final String featureStatsText;
  final String footer;

  static _LandingCopy forLocale(Locale locale) {
    if (locale.languageCode == 'de') {
      return const _LandingCopy(
        badge: 'Pomodoro Timer & Fokus-App',
        title: 'Konzentrierter arbeiten mit Time2Focus.',
        description:
            'Time2Focus hilft dir, Fokus-Sessions zu planen, Aufgaben zu strukturieren und deine Produktivität im Blick zu behalten.',
        startButton: 'App öffnen',
        accountButton: 'Einloggen',
        loginButton: 'Login',
        featureTimerTitle: 'Fokus-Sessions',
        featureTimerText:
            'Arbeite in klaren Intervallen mit Arbeitsphasen, kurzen Pausen und langen Pausen.',
        featureTasksTitle: 'Aufgabenverwaltung',
        featureTasksText:
            'Verbinde deine Pomodoro-Sessions mit Aufgaben und behalte deinen Fortschritt im Blick.',
        featureStatsTitle: 'Produktivitätsstatistiken',
        featureStatsText:
            'Analysiere deine abgeschlossenen Fokuszeiten und erkenne deine produktiven Muster.',
        footer: 'Time2Focus – entwickelt für konzentriertes Arbeiten.',
      );
    }

    return const _LandingCopy(
      badge: 'Pomodoro timer & focus app',
      title: 'Work with more focus using Time2Focus.',
      description:
          'Time2Focus helps you plan focus sessions, organize tasks and keep track of your productivity.',
      startButton: 'Open app',
      accountButton: 'Sign in',
      loginButton: 'Login',
      featureTimerTitle: 'Focus sessions',
      featureTimerText:
          'Work in clear intervals with focus phases, short breaks and long breaks.',
      featureTasksTitle: 'Task management',
      featureTasksText:
          'Connect Pomodoro sessions with tasks and keep track of your progress.',
      featureStatsTitle: 'Productivity statistics',
      featureStatsText:
          'Analyze completed focus times and understand your productive patterns.',
      footer: 'Time2Focus – built for focused work.',
    );
  }
}

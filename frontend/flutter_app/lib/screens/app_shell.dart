import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../providers/session_sync_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'tasks_screen.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index;
  int _lastHandledSessionSyncVersion = 0;

  final _screens = const [
    HomeScreen(),
    TasksScreen(),
    StatsScreen(),
    SettingsScreen(),
    LoginScreen(),
  ];

  @override
  void initState() {
    super.initState();

    final uri = Uri.base;
    final screen = uri.queryParameters['screen'];
    final emailVerificationStatus = uri.queryParameters['email_verified'];

    final shouldOpenLogin =
        screen == 'login' || emailVerificationStatus != null;

    _index = shouldOpenLogin ? 4 : widget.initialIndex.clamp(0, 4).toInt();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (emailVerificationStatus == null || !mounted) {
        return;
      }

      final message = switch (emailVerificationStatus) {
        'success' =>
          'E-Mail erfolgreich bestätigt. Du kannst dich jetzt einloggen.',
        'expired' => 'Der Bestätigungslink ist abgelaufen.',
        'invalid' => 'Der Bestätigungslink ist ungültig.',
        _ => null,
      };

      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });
  }

  void _refreshDataAfterSessionSync(BuildContext context) {
    final syncCompletedVersion = context.select(
      (SessionSyncProvider provider) => provider.syncCompletedVersion,
    );

    if (syncCompletedVersion == _lastHandledSessionSyncVersion) {
      return;
    }

    _lastHandledSessionSyncVersion = syncCompletedVersion;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      unawaited(context.read<StatsProvider>().refreshCurrent());
      unawaited(context.read<TaskProvider>().refreshTaskPomodoroCounts());
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshDataAfterSessionSync(context);

    final isWide = MediaQuery.sizeOf(context).width >= 900;

    final destinations = const [
      NavigationDestination(
        icon: Icon(Icons.timer_outlined),
        selectedIcon: Icon(Icons.timer),
        label: 'Timer',
      ),
      NavigationDestination(
        icon: Icon(Icons.checklist_outlined),
        selectedIcon: Icon(Icons.checklist),
        label: 'Aufgaben',
      ),
      NavigationDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart),
        label: 'Statistik',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Einstellungen',
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Konto',
      ),
    ];

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: (value) {
                setState(() => _index = value);
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.timer_outlined),
                  selectedIcon: Icon(Icons.timer),
                  label: Text('Timer'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.checklist_outlined),
                  selectedIcon: Icon(Icons.checklist),
                  label: Text('Aufgaben'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: Text('Statistik'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Einstellungen'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Konto'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _ShellContent(child: _screens[_index]),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: _ShellContent(child: _screens[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() => _index = value);
        },
        destinations: destinations,
      ),
    );
  }
}

class _ShellContent extends StatelessWidget {
  const _ShellContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionSyncProvider>(
      builder: (context, sessionSync, _) {
        if (!sessionSync.shouldShow) {
          return child;
        }

        return Column(
          children: [
            _SessionSyncBanner(sessionSync: sessionSync),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

class _SessionSyncBanner extends StatelessWidget {
  const _SessionSyncBanner({required this.sessionSync});

  final SessionSyncProvider sessionSync;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = sessionSync.error != null;

    return Material(
      color: hasError
          ? colorScheme.errorContainer
          : colorScheme.secondaryContainer.withValues(alpha: 0.55),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (sessionSync.syncing)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  hasError ? Icons.warning_amber_outlined : Icons.sync_outlined,
                  color: hasError
                      ? colorScheme.onErrorContainer
                      : colorScheme.secondary,
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasError ? sessionSync.error! : sessionSync.statusText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: hasError
                            ? colorScheme.onErrorContainer
                            : colorScheme.onSurface,
                      ),
                ),
              ),
              if (hasError)
                TextButton(
                  onPressed: sessionSync.clearError,
                  child: const Text('Schließen'),
                )
              else if (sessionSync.canSync &&
                  sessionSync.pendingCount > 0 &&
                  !sessionSync.syncing)
                TextButton.icon(
                  onPressed: sessionSync.syncStoredSessions,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Erneut versuchen'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

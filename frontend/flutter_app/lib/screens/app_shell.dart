import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';
import '../services/browser_url_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'tasks_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index;
  String? _lastLoadedScope;
  int _lastHandledSessionSyncVersion = 0;

  static const List<String> _screenKeys = [
    'timer',
    'tasks',
    'stats',
    'settings',
    'account',
  ];

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
    final emailVerificationStatus = uri.queryParameters['email_verified'];

    _index = _indexFromUri();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (emailVerificationStatus == null || !mounted) {
        return;
      }

      final l10n = AppLocalizations.of(context);
      final message = switch (emailVerificationStatus) {
        'success' => l10n.emailVerifiedSuccess,
        'expired' => l10n.emailVerifiedExpired,
        'invalid' => l10n.emailVerifiedInvalid,
        _ => null,
      };

      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
      clearLoginActionQueryParameters();
    });
  }

  void _loadDataForCurrentScope(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final scope =
        authProvider.user == null ? 'guest' : 'user_${authProvider.user!.id}';

    if (authProvider.loading) {
      return;
    }

    if (_lastLoadedScope == scope) {
      return;
    }

    _lastLoadedScope = scope;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final settingsProvider = context.read<SettingsProvider>();
      final taskProvider = context.read<TaskProvider>();

      if (authProvider.user == null) {
        unawaited(settingsProvider.load());
        unawaited(taskProvider.loadLocalTasks());
        return;
      }

      unawaited(settingsProvider.loadRemoteSettings());
      unawaited(taskProvider.loadRemoteTasks());
    });
  }

  int _indexFromUri() {
    final uri = Uri.base;
    final screen = uri.queryParameters['screen'];
    final emailVerificationStatus = uri.queryParameters['email_verified'];
    final resetToken =
        uri.queryParameters['reset_token'] ?? uri.queryParameters['set_token'];

    if (emailVerificationStatus != null || resetToken != null) {
      return 4;
    }

    return switch (screen) {
      'tasks' => 1,
      'stats' => 2,
      'settings' => 3,
      'account' => 4,
      _ => widget.initialIndex.clamp(0, 4).toInt(),
    };
  }

  void _selectIndex(int value) {
    setState(() {
      _index = value;
    });

    setAppScreenInUrl(_screenKeys[value]);
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
    _loadDataForCurrentScope(context);

    final l10n = AppLocalizations.of(context);
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.timer_outlined),
        selectedIcon: const Icon(Icons.timer),
        label: l10n.navTimer,
      ),
      NavigationDestination(
        icon: const Icon(Icons.checklist_outlined),
        selectedIcon: const Icon(Icons.checklist),
        label: l10n.navTasks,
      ),
      NavigationDestination(
        icon: const Icon(Icons.bar_chart_outlined),
        selectedIcon: const Icon(Icons.bar_chart),
        label: l10n.navStats,
      ),
      NavigationDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        label: l10n.navSettings,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: l10n.navAccount,
      ),
    ];

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: _selectIndex,
              labelType: NavigationRailLabelType.all,
              minWidth: 112,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.timer_outlined),
                  selectedIcon: const Icon(Icons.timer),
                  label: Text(l10n.navTimer),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.checklist_outlined),
                  selectedIcon: const Icon(Icons.checklist),
                  label: Text(l10n.navTasks),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.bar_chart_outlined),
                  selectedIcon: const Icon(Icons.bar_chart),
                  label: Text(l10n.navStats),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: Text(l10n.navSettings),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person),
                  label: Text(l10n.navAccount),
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
        onDestinationSelected: _selectIndex,
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
    final l10n = AppLocalizations.of(context);
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
                  hasError
                      ? l10n.sessionSyncFailed
                      : _sessionSyncStatusText(l10n, sessionSync),
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
                  child: Text(l10n.close),
                )
              else if (sessionSync.canSync &&
                  sessionSync.pendingCount > 0 &&
                  !sessionSync.syncing)
                TextButton.icon(
                  onPressed: sessionSync.syncStoredSessions,
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _sessionSyncStatusText(
  AppLocalizations l10n,
  SessionSyncProvider provider,
) {
  if (provider.syncing) {
    if (provider.pendingCount <= 1) {
      return l10n.sessionSyncOneWithAccount;
    }

    return l10n.sessionSyncManyWithAccount(provider.pendingCount);
  }

  if (!provider.canSync && provider.pendingCount > 0) {
    if (provider.pendingCount == 1) {
      return l10n.sessionSyncOneAfterLogin;
    }

    return l10n.sessionSyncManyAfterLogin(provider.pendingCount);
  }

  if (provider.pendingCount > 0) {
    if (provider.pendingCount == 1) {
      return l10n.sessionSyncOnePending;
    }

    return l10n.sessionSyncManyPending(provider.pendingCount);
  }

  return l10n.sessionSyncDone;
}

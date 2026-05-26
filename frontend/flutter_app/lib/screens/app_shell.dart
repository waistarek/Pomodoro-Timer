/* import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'tasks_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    TasksScreen(),
    StatsScreen(),
    SettingsScreen(),
    LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;
    final destinations = const [
      NavigationDestination(
          icon: Icon(Icons.timer_outlined),
          selectedIcon: Icon(Icons.timer),
          label: 'Timer'),
      NavigationDestination(
          icon: Icon(Icons.checklist_outlined),
          selectedIcon: Icon(Icons.checklist),
          label: 'Aufgaben'),
      NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Statistik'),
      NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Einstellungen'),
      NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Konto'),
    ];

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: (value) => setState(() => _index = value),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.timer_outlined),
                    selectedIcon: Icon(Icons.timer),
                    label: Text('Timer')),
                NavigationRailDestination(
                    icon: Icon(Icons.checklist_outlined),
                    selectedIcon: Icon(Icons.checklist),
                    label: Text('Aufgaben')),
                NavigationRailDestination(
                    icon: Icon(Icons.bar_chart_outlined),
                    selectedIcon: Icon(Icons.bar_chart),
                    label: Text('Statistik')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Einstellungen')),
                NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Konto')),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: _screens[_index]),
          ],
        ),
      );
    }

    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: destinations,
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

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

    _index = shouldOpenLogin
        ? 4
        : widget.initialIndex.clamp(0, 4).toInt();

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

  @override
  Widget build(BuildContext context) {
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
            Expanded(child: _screens[_index]),
          ],
        ),
      );
    }

    return Scaffold(
      body: _screens[_index],
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
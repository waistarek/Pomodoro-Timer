import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/session_sync_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/stats_provider.dart';
import 'providers/task_provider.dart';
import 'providers/timer_provider.dart';
import 'screens/app_shell.dart';
import 'services/api_client.dart';
import 'services/app_session_controller.dart';
import 'services/auth_service.dart';
import 'services/local_storage_service.dart';
import 'services/notification_service.dart';
import 'services/session_service.dart';
import 'services/settings_service.dart';
import 'services/sound_service.dart';
import 'services/stats_service.dart';
import 'services/task_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = LocalStorageService();
  await localStorage.init();

  final apiClient = ApiClient(localStorage: localStorage);

  final authService = AuthService(
    apiClient: apiClient,
    localStorage: localStorage,
  );

  final sessionService = SessionService(
    apiClient: apiClient,
    localStorage: localStorage,
  );

  final settingsService = SettingsService(apiClient: apiClient);
  final taskService = TaskService(apiClient: apiClient);

  final statsService = StatsService(
    apiClient: apiClient,
    localStorage: localStorage,
  );

  final soundService = SoundService();
  final notificationService = NotificationService();

  final authProvider = AuthProvider(authService);
  final sessionSyncProvider = SessionSyncProvider(sessionService);
  final settingsProvider = SettingsProvider(localStorage, settingsService);
  final taskProvider = TaskProvider(localStorage, taskService);
  final statsProvider = StatsProvider(statsService);

  final timerProvider = TimerProvider(
    localStorage,
    sessionService,
    soundService,
    notificationService,
  );

  final appSessionController = AppSessionController(
    authProvider: authProvider,
    taskProvider: taskProvider,
    settingsProvider: settingsProvider,
    statsProvider: statsProvider,
    sessionSyncProvider: sessionSyncProvider,
    timerProvider: timerProvider,
  );

  apiClient.onUnauthorized = appSessionController.handleUnauthorizedSession;

  runApp(
    MultiProvider(
      providers: [
        Provider<SessionService>.value(value: sessionService),
        Provider<AppSessionController>.value(value: appSessionController),
        ChangeNotifierProvider.value(
          value: sessionSyncProvider..init(),
        ),
        ChangeNotifierProvider.value(
          value: authProvider..loadLocalSession(),
        ),
        ChangeNotifierProvider.value(
          value: settingsProvider,
        ),
        ChangeNotifierProvider.value(
          value: taskProvider,
        ),
        ChangeNotifierProxyProvider2<SettingsProvider, TaskProvider,
            TimerProvider>(
          create: (_) => timerProvider,
          update: (_, settingsProvider, taskProvider, currentTimerProvider) {
            final provider = currentTimerProvider ?? timerProvider;

            provider.updateSettings(settingsProvider.settings);
            provider.updateSelectedTask(taskProvider.selectedTask);

            return provider;
          },
        ),
        ChangeNotifierProvider.value(value: statsProvider),
      ],
      child: const PomodoroRoot(),
    ),
  );
}

class PomodoroRoot extends StatelessWidget {
  const PomodoroRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        final settings = settingsProvider.settings;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pomodoro App',
          themeMode: settings.themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: settings.themeColor),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: settings.themeColor,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const AppShell(),
        );
      },
    );
  }
}

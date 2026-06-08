import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'services/url_strategy_service.dart';
import 'l10n/app_localizations.dart';
import 'providers/auth_provider.dart';
import 'providers/session_sync_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/stats_provider.dart';
import 'providers/task_provider.dart';
import 'providers/timer_provider.dart';
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
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();

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

class PomodoroRoot extends StatefulWidget {
  const PomodoroRoot({super.key});

  @override
  State<PomodoroRoot> createState() => _PomodoroRootState();
}

class _PomodoroRootState extends State<PomodoroRoot> {
  late final _router = createAppRouter(context.read<AuthProvider>());

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        final settings = settingsProvider.settings;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings.selectedLocale,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return supportedLocales.first;
            }

            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
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
          routerConfig: _router,
        );
      },
    );
  }
}

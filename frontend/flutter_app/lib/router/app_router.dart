import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../screens/app_shell.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/tasks_screen.dart';
import 'app_routes.dart';

// Aktuell bleibt der vorhandene Gastmodus erhalten.
// Setze diesen Wert nur auf true, wenn Timer/Aufgaben/Statistik/Einstellungen
// wirklich erst nach dem Login erreichbar sein sollen.
const bool requireLoginForMainRoutes = false;

GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: AppRoutes.timer,
    refreshListenable: authProvider,
    redirect: (BuildContext context, GoRouterState state) {
      final uri = state.uri;
      final path = uri.path.isEmpty ? AppRoutes.root : uri.path;
      final query = uri.queryParameters;

      final legacyResetToken =
          query['token'] ?? query['reset_token'] ?? query['set_token'];

      if (legacyResetToken != null && path != AppRoutes.resetPassword) {
        return Uri(
          path: AppRoutes.resetPassword,
          queryParameters: {
            'token': legacyResetToken,
            if ((query['email'] ?? '').isNotEmpty) 'email': query['email']!,
          },
        ).toString();
      }

      final emailVerificationStatus = query['email_verified'];
      if (emailVerificationStatus != null && path != AppRoutes.account) {
        return Uri(
          path: AppRoutes.account,
          queryParameters: {
            'email_verified': emailVerificationStatus,
          },
        ).toString();
      }

      final legacyScreenPath = AppRoutes.fromLegacyScreen(query['screen']);
      if (path == AppRoutes.root && legacyScreenPath != null) {
        final updatedQuery = Map<String, String>.from(query)..remove('screen');

        return Uri(
          path: legacyScreenPath,
          queryParameters: updatedQuery.isEmpty ? null : updatedQuery,
        ).toString();
      }

      if (authProvider.loading) {
        if (path == AppRoutes.root && authProvider.hasLocalToken) {
          return AppRoutes.timer;
        }

        return null;
      }

      if (path == AppRoutes.root) {
        return authProvider.isLoggedIn ? AppRoutes.timer : AppRoutes.account;
      }

      if (requireLoginForMainRoutes &&
          !authProvider.isLoggedIn &&
          AppRoutes.mainPaths.contains(path)) {
        return Uri(
          path: AppRoutes.account,
          queryParameters: {
            'from': uri.toString(),
          },
        ).toString();
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.timer,
            name: 'timer',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.tasks,
            name: 'tasks',
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: AppRoutes.statistics,
            name: 'statistics',
            builder: (context, state) => const StatsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.account,
            name: 'account',
            builder: (context, state) {
              final query = state.uri.queryParameters;

              return LoginScreen(
                key: state.pageKey,
                initialEmail: query['email'],
                emailVerificationStatus: query['email_verified'],
                oauthProvider: query['oauth_provider'],
                githubCode: query['code'],
                githubState: query['state'],
                githubError: query['error'],
                githubErrorDescription: query['error_description'],
                redirectPath: query['from'],
              );
            },
          ),
          GoRoute(
            path: AppRoutes.resetPassword,
            name: 'resetPassword',
            builder: (context, state) {
              final query = state.uri.queryParameters;

              return LoginScreen(
                key: state.pageKey,
                resetToken: query['token'] ??
                    query['reset_token'] ??
                    query['set_token'],
                initialEmail: query['email'],
              );
            },
          ),
          GoRoute(
            path: AppRoutes.githubCallback,
            name: 'githubCallback',
            builder: (context, state) {
              final query = state.uri.queryParameters;

              return LoginScreen(
                key: state.pageKey,
                oauthProvider: 'github',
                githubCode: query['code'],
                githubState: query['state'],
                githubError: query['error'],
                githubErrorDescription: query['error_description'],
              );
            },
          ),
        ],
      ),
    ],
  );
}

class AppRoutes {
  const AppRoutes._();

  static const root = '/';
  static const timer = '/timer';
  static const tasks = '/tasks';
  static const statistics = '/statistics';
  static const settings = '/settings';
  static const account = '/account';
  static const resetPassword = '/reset-password';
  static const githubCallback = '/auth/callback/github';

  static const navPaths = <String>[
    timer,
    tasks,
    statistics,
    settings,
    account,
  ];

  static const mainPaths = <String>{
    timer,
    tasks,
    statistics,
    settings,
  };

  static const accountPaths = <String>{
    account,
    resetPassword,
    githubCallback,
  };

  static int indexFromPath(String path) {
    return switch (path) {
      tasks => 1,
      statistics => 2,
      settings => 3,
      account || resetPassword || githubCallback => 4,
      _ => 0,
    };
  }

  static String pathFromIndex(int index) {
    final safeIndex = index.clamp(0, navPaths.length - 1).toInt();
    return navPaths[safeIndex];
  }

  static String? fromLegacyScreen(String? screen) {
    return switch (screen) {
      'timer' => timer,
      'tasks' => tasks,
      'stats' || 'statistics' => statistics,
      'settings' => settings,
      'account' || 'login' => account,
      _ => null,
    };
  }

  static String? safeInternalRedirect(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value.trim());

    if (uri == null || uri.hasScheme || uri.hasAuthority) {
      return null;
    }

    final path = uri.path.isEmpty ? timer : uri.path;
    final allowedPaths = <String>{
      ...navPaths,
    };

    if (!allowedPaths.contains(path)) {
      return null;
    }

    return uri.replace(path: path).toString();
  }
}

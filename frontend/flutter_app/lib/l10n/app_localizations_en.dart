// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pomodoro App';

  @override
  String get navTimer => 'Timer';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Settings';

  @override
  String get navAccount => 'Account';

  @override
  String get close => 'Close';

  @override
  String get retry => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get reset => 'Reset';

  @override
  String get refresh => 'Refresh';

  @override
  String get messageClose => 'Close message';

  @override
  String get or => 'or';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get emailVerifiedSuccess =>
      'Email confirmed successfully. You can now log in.';

  @override
  String get emailVerifiedExpired => 'The confirmation link has expired.';

  @override
  String get emailVerifiedInvalid => 'The confirmation link is invalid.';

  @override
  String get sessionSyncOneWithAccount =>
      'One session is being synced with your account.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sessions are being synced with your account.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'One local session will be synced after login.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count local sessions will be synced after login.';
  }

  @override
  String get sessionSyncOnePending => 'One session is waiting for sync.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sessions are waiting for sync.';
  }

  @override
  String get sessionSyncDone => 'Sync completed.';

  @override
  String get sessionSyncFailed =>
      'Sessions could not be synced right now. The app will try again later.';

  @override
  String get accountTitle => 'Account';

  @override
  String get loginTitle => 'Login';

  @override
  String get createAccountTitle => 'Create new account';

  @override
  String get emailPasswordLoginTitle => 'Log in with email and password';

  @override
  String get emailPasswordCreateTitle => 'Create email/password account';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Log in';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get rememberSessionTitle => 'Stay signed in on this device';

  @override
  String get rememberSessionSubtitle =>
      'When disabled, the login only stays active for the current app session.';

  @override
  String get forgotPasswordButton => 'Forgot password?';

  @override
  String get alreadyHaveAccount => 'I already have an account';

  @override
  String get googleSection => 'Google section';

  @override
  String get googleLoginButton => 'Log in with Google';

  @override
  String get googleCreateButton => 'Create account with Google';

  @override
  String get googleNotConfigured => 'Google login is not configured.';

  @override
  String get googlePreparing => 'Preparing Google login ...';

  @override
  String get googleNoIdToken => 'Google did not return a valid ID token.';

  @override
  String googlePrepareFailed(Object error) {
    return 'Google login could not be prepared: $error';
  }

  @override
  String googleLoginFailed(Object error) {
    return 'Google login failed: $error';
  }

  @override
  String get googleLoginSuccess => 'Successfully logged in with Google.';

  @override
  String get googleAccountCreated =>
      'Google account was created and you are logged in.';

  @override
  String get googleWebOnly => 'Google login is only available in the web app';

  @override
  String get githubSection => 'GitHub section';

  @override
  String get githubLoginButton => 'Log in with GitHub';

  @override
  String get githubCreateButton => 'Create account with GitHub';

  @override
  String get githubNotConfigured => 'GitHub login is not configured.';

  @override
  String get githubCancelled => 'GitHub login was cancelled or failed.';

  @override
  String get githubSecurityCancelled =>
      'GitHub login was cancelled for security reasons.';

  @override
  String get githubNoValidCode => 'GitHub did not return a valid code.';

  @override
  String get githubLoginSuccess => 'Successfully logged in with GitHub.';

  @override
  String get githubAccountCreated =>
      'GitHub account was created and you are logged in.';

  @override
  String get passwordResetTitle => 'Reset password';

  @override
  String get passwordResetDescription =>
      'Enter your email address. If an account exists, you will receive a reset link.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get setNewPasswordTitle => 'Set new password';

  @override
  String get setNewPasswordDescription =>
      'Set a new password for your account.';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get repeatNewPasswordLabel => 'Repeat new password';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get savePassword => 'Save password';

  @override
  String get registrationSuccess =>
      'Registration successful. Please confirm your email address and log in afterwards.';

  @override
  String get passwordResetRequestSuccess =>
      'If an account with this email exists, a reset link has been sent.';

  @override
  String get passwordChangedSuccess => 'Password changed. You can now log in.';

  @override
  String get passwordResetMailSent =>
      'If the account exists, a reset link has been sent.';

  @override
  String get loginSuccess => 'Successfully logged in.';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordMinLength => 'At least 8 characters';

  @override
  String get loggedInTitle => 'Account';

  @override
  String get loggedInDescription => 'You are currently logged in.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailStatus => 'Email status';

  @override
  String get emailVerified => 'Confirmed';

  @override
  String get emailNotVerified => 'Not confirmed yet';

  @override
  String get accountCreated => 'Account created';

  @override
  String get synchronization => 'Synchronization';

  @override
  String get accountInfoWarning =>
      'The app can restore your session automatically if a valid login token is stored locally. Always log out on shared devices.';

  @override
  String get changePassword => 'Change password';

  @override
  String get logout => 'Log out';

  @override
  String get syncRunning => 'Sync is running';

  @override
  String get syncOneWaiting => '1 session waiting';

  @override
  String syncManyWaiting(int count) {
    return '$count sessions waiting';
  }

  @override
  String get syncError => 'Sync error';

  @override
  String get syncAllSynced => 'Everything is synced';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get settingsSaved => 'Settings saved.';

  @override
  String get timerTimesTitle => 'Timer durations';

  @override
  String get timerTimesDescription =>
      'Define how long work phases and breaks should last.';

  @override
  String get workTime => 'Work time';

  @override
  String get shortBreak => 'Short break';

  @override
  String get longBreak => 'Long break';

  @override
  String get longBreakAfter => 'Long break after';

  @override
  String get minutes => 'Minutes';

  @override
  String get pomodorosUnit => 'Pomodoros';

  @override
  String get behaviorTitle => 'Behavior';

  @override
  String get behaviorDescription =>
      'Adjust how the timer behaves while you use it.';

  @override
  String get autoStartNextPhase => 'Start next phase automatically';

  @override
  String get enableSound => 'Enable sound';

  @override
  String get enableVibration => 'Enable vibration';

  @override
  String get vibrationDescription =>
      'The actual mobile vibration will be connected later through a plugin.';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceDescription =>
      'Choose display mode and the main app color.';

  @override
  String get appearanceLabel => 'Appearance';

  @override
  String get systemTheme => 'System';

  @override
  String get lightMode => 'Light mode';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get themeColor => 'Theme color';

  @override
  String get red => 'Red';

  @override
  String get blue => 'Blue';

  @override
  String get green => 'Green';

  @override
  String get purple => 'Purple';

  @override
  String get saveSettings => 'Save settings';

  @override
  String get noChanges => 'No changes';

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Settings were saved locally but have not been synced yet.';

  @override
  String get settingsLoadRemoteFailed =>
      'Settings could not be loaded from the backend. Local settings are used.';

  @override
  String get statsTitle => 'Stats';

  @override
  String get statsRefresh => 'Refresh';

  @override
  String get statsWeek => 'Week';

  @override
  String get statsMonth => 'Month';

  @override
  String get statsYear => 'Year';

  @override
  String get statsTasksTime => 'Task time';

  @override
  String get chartFocusPerDay => 'Focus time per day';

  @override
  String get chartFocusPerCalendarWeek => 'Focus time per calendar week';

  @override
  String get chartFocusPerMonth => 'Focus time per month';

  @override
  String get chartFocusPerTask => 'Focus time per task';

  @override
  String get xAxisWeek => 'X-axis: days of the week';

  @override
  String get xAxisMonth => 'X-axis: calendar weeks in the month';

  @override
  String get xAxisYear => 'X-axis: months in the year';

  @override
  String get xAxisTasks => 'X-axis: tasks';

  @override
  String get periodNoData => 'Period: No data available';

  @override
  String periodRange(String start, String end) {
    return 'Period: $start – $end';
  }

  @override
  String get previousPeriod => 'Previous period';

  @override
  String get nextPeriod => 'Next period';

  @override
  String get statsLoading => 'Loading statistics ...';

  @override
  String get taskStatsLoading => 'Loading task statistics ...';

  @override
  String get taskStatsEmpty =>
      'No work time per task yet. Start a Pomodoro with a task to see data.';

  @override
  String get pomodoros => 'Pomodoros';

  @override
  String get focusTime => 'Focus time';

  @override
  String get streak => 'Streak';

  @override
  String get bestPeriod => 'Best period';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y-axis: focus time in hours · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Focus time in minutes';

  @override
  String get sortedByHighestFocusTime => 'Sorted by highest focus time.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoros · $minutes min';
  }

  @override
  String get statsNoData => 'No statistics data available yet.';

  @override
  String get statsLoadFailed =>
      'Statistics could not be loaded. Please log in and check your internet connection.';

  @override
  String get taskStatsLoadFailed => 'Task statistics could not be loaded.';

  @override
  String get todayPomodorosLoadFailed =>
      'Today\'s Pomodoro count could not be loaded.';

  @override
  String get noTaskTitle => 'No task';

  @override
  String calendarWeekShort(String week) {
    return 'CW $week';
  }

  @override
  String calendarWeekWithYear(String week, String year) {
    return 'CW $week/$year';
  }

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get tasksRefreshTooltip => 'Refresh tasks';

  @override
  String get taskSingular => 'Task';

  @override
  String get deleteTaskTitle => 'Delete task?';

  @override
  String deleteTaskMessage(String title) {
    return 'Do you really want to delete the task “$title”?';
  }

  @override
  String get tasksLoading => 'Loading tasks ...';

  @override
  String get tasksEmpty => 'No tasks yet. Create your first task.';

  @override
  String get tasksSearchEmpty => 'No tasks found. Adjust search or filters.';

  @override
  String get noTimerTaskSelected => 'No timer task selected';

  @override
  String activeTimerTask(String title) {
    return 'Active timer task: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'A timer phase is running or paused. The task is currently locked.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'This task will be used for the next work phase.';

  @override
  String get withoutTask => 'No task';

  @override
  String get searchTasks => 'Search tasks';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get filterAll => 'All';

  @override
  String get filterOpen => 'Open';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get sortLabel => 'Sort';

  @override
  String get sortNewest => 'Newest first';

  @override
  String get sortPriority => 'Priority';

  @override
  String get sortPomodoros => 'Pomodoros';

  @override
  String get active => 'Active';

  @override
  String get completed => 'Completed';

  @override
  String get locked => 'Locked';

  @override
  String get forTimer => 'For timer';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get taskLoadRemoteFailed =>
      'Tasks could not be loaded from the backend. Local data remains visible.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Task was saved locally but could not be synced with your account.';

  @override
  String get taskSaveFailedRolledBack =>
      'Task could not be saved. The last change has been rolled back.';

  @override
  String get taskDeleteFailedRestored =>
      'Task could not be deleted from your account. The task has been restored.';

  @override
  String get taskCreateTitle => 'Create task';

  @override
  String get taskEditTitle => 'Edit task';

  @override
  String get taskTitleLabel => 'Title';

  @override
  String get taskTitleRequired => 'Please enter a title';

  @override
  String get taskTitleTooShort => 'The title is too short.';

  @override
  String get taskDescriptionLabel => 'Description';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get tagsLabel => 'Tags/categories';

  @override
  String get tagsHint => 'e.g. university, work, development';

  @override
  String get timerResetTitle => 'Reset timer?';

  @override
  String get timerResetMessage =>
      'The current phase will be cancelled and will not be saved as a completed session.';

  @override
  String get taskNoneSelected => 'No task selected';

  @override
  String currentTask(String title) {
    return 'Current task: $title';
  }

  @override
  String get taskForWorkPhase => 'Task for this work phase';

  @override
  String get taskLockedToPhase => 'This phase is fixed to the selected task.';

  @override
  String get phaseWork => 'Work phase';

  @override
  String get phaseShortBreak => 'Short break';

  @override
  String get phaseLongBreak => 'Long break';

  @override
  String get timerStatusSaving => 'Saving ...';

  @override
  String get timerStatusRunning => 'Running';

  @override
  String get timerStatusPaused => 'Paused';

  @override
  String get timerStatusReady => 'Ready';

  @override
  String get phaseDescriptionWork => 'Focus time';

  @override
  String get phaseDescriptionShortBreak => 'Short recovery';

  @override
  String get phaseDescriptionLongBreak => 'Longer recovery';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Next: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Today: loading ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Today: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pomodoros',
      one: '1 Pomodoro',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'Pause';

  @override
  String get continueButton => 'Continue';

  @override
  String get start => 'Start';

  @override
  String get skipPause => 'Skip break';

  @override
  String get shortcutSpaceCompact => 'Space: Start/Pause';

  @override
  String get shortcutResetCompact => 'R: Reset';

  @override
  String get shortcutSkipCompact => 'S: Skip';

  @override
  String get shortcutSpace => 'Spacebar: Start/Pause';

  @override
  String get shortcutReset => 'R: Reset';

  @override
  String get shortcutSkip => 'S: Skip break';

  @override
  String get phaseSavingTitle => 'Saving phase';

  @override
  String get phaseSavingDescription =>
      'The completed phase is being saved and the timer is being prepared.';

  @override
  String get storageProblem => 'Storage problem';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'Completed phase is being saved in the background.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count completed phases are being saved in the background.';
  }

  @override
  String get timerLocalSaveFailed =>
      'The completed phase could not be saved locally.';

  @override
  String get timerBackendSyncFailed =>
      'The completed phase was saved locally but has not been synced with the backend yet.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed of $total';
  }
}

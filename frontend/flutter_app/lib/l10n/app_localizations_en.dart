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
  String get navStats => 'Statistics';

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
      'Email successfully verified. You can now log in.';

  @override
  String get emailVerifiedExpired => 'The verification link has expired.';

  @override
  String get emailVerifiedInvalid => 'The verification link is invalid.';

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
  String get sessionSyncOnePending => 'One session is waiting to be synced.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sessions are waiting to be synced.';
  }

  @override
  String get sessionSyncDone => 'Synchronization completed.';

  @override
  String get sessionSyncFailed =>
      'Sessions could not be synced right now. The app will try again later.';

  @override
  String get accountTitle => 'User account';

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
      'If disabled, the login only stays active for the current app session.';

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
  String googlePrepareFailed(String error) {
    return 'Google login could not be prepared: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google login failed: $error';
  }

  @override
  String get googleLoginSuccess => 'Successfully signed in with Google.';

  @override
  String get googleAccountCreated =>
      'Google account was created and you are signed in.';

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
  String get githubLoginSuccess => 'Successfully signed in with GitHub.';

  @override
  String get githubAccountCreated =>
      'GitHub account was created and you are signed in.';

  @override
  String get passwordResetTitle => 'Reset password';

  @override
  String get passwordResetDescription =>
      'Enter your email address. If an account exists, you will receive a password reset link.';

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
      'Registration successful. Please verify your email address and then log in.';

  @override
  String get passwordResetRequestSuccess =>
      'If an account with this email exists, a reset link has been sent.';

  @override
  String get passwordChangedSuccess =>
      'Password has been changed. You can now log in.';

  @override
  String get passwordResetMailSent =>
      'If the account exists, a reset link has been sent.';

  @override
  String get loginSuccess => 'Successfully signed in.';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordMinLength => 'At least 8 characters';

  @override
  String get loggedInTitle => 'User account';

  @override
  String get loggedInDescription => 'You are currently signed in.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailStatus => 'Email status';

  @override
  String get emailVerified => 'Verified';

  @override
  String get emailNotVerified => 'Not verified yet';

  @override
  String get accountCreated => 'Account created';

  @override
  String get synchronization => 'Synchronization';

  @override
  String get accountInfoWarning =>
      'The app can automatically restore your session if a valid login token is stored locally. On shared devices, you should always log out.';

  @override
  String get changePassword => 'Change password';

  @override
  String get logout => 'Log out';

  @override
  String get syncRunning => 'Synchronization running';

  @override
  String get syncOneWaiting => '1 session waiting';

  @override
  String syncManyWaiting(int count) {
    return '$count sessions waiting';
  }

  @override
  String get syncError => 'Synchronization error';

  @override
  String get syncAllSynced => 'Everything synced';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get settingsSaved => 'Settings saved.';

  @override
  String get timerTimesTitle => 'Timer durations';

  @override
  String get timerTimesDescription =>
      'Define how long work sessions and breaks should last.';

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
      'Customize how the timer behaves while you use it.';

  @override
  String get autoStartNextPhase => 'Start next phase automatically';

  @override
  String get enableSound => 'Enable sound';

  @override
  String get enableVibration => 'Enable vibration';

  @override
  String get vibrationDescription =>
      'Actual mobile vibration will be connected later through a plugin.';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageDescription =>
      'Choose the app language. With “System language”, the app uses the browser or device language.';

  @override
  String get languageLabel => 'App language';

  @override
  String get languageSystem => 'System language';

  @override
  String get languageGerman => 'German';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageFrench => 'French';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageItalian => 'Italian';

  @override
  String get languageKorean => 'Korean';

  @override
  String get languageIndonesian => 'Indonesian';

  @override
  String get languagePersian => 'Persian';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceDescription =>
      'Choose the design mode and main color of the app.';

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
  String get noChanges => 'No changes available';

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Settings saved locally but not synced yet.';

  @override
  String get settingsLoadRemoteFailed =>
      'Settings could not be loaded from the backend. Local settings are being used.';

  @override
  String get statsTitle => 'Statistics';

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
      'No work time per task available yet. Start a Pomodoro with a task to see data.';

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
      'Today’s Pomodoro count could not be loaded.';

  @override
  String get noTaskTitle => 'No task';

  @override
  String calendarWeekShort(int week) {
    return 'CW $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
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
  String get tasksEmpty => 'No tasks available yet. Create your first task.';

  @override
  String get tasksSearchEmpty =>
      'No tasks found. Adjust your search or filters.';

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
  String get withoutTask => 'Without task';

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
  String get sortLabel => 'Sorting';

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
      'Tasks could not be loaded from the backend. Local data will still be shown.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Task was saved locally but could not be synced with the account.';

  @override
  String get taskSaveFailedRolledBack =>
      'Task could not be saved. The last change was rolled back.';

  @override
  String get taskDeleteFailedRestored =>
      'Task could not be deleted from the account. The task was restored.';

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
      'The current phase will be cancelled and not saved as a completed session.';

  @override
  String get taskNoneSelected => 'No task selected';

  @override
  String currentTask(String title) {
    return 'Current task: $title';
  }

  @override
  String get taskForWorkPhase => 'Task for this work phase';

  @override
  String get taskLockedToPhase => 'This phase is locked to the selected task.';

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
  String get shortcutSpace => 'Space: Start/Pause';

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

  @override
  String timerSemanticsLabel(
      Object phase, Object status, Object time, Object progress, Object today) {
    return 'Timer. Phase: $phase. Status: $status. Remaining time: $time. $progress. $today.';
  }

  @override
  String timerProgressSemantics(int percent) {
    return 'Progress: $percent percent completed.';
  }

  @override
  String timerHeaderSemantics(Object phase, Object status, Object nextPhase) {
    return 'Current timer phase: $phase. Status: $status. Next: $nextPhase.';
  }

  @override
  String timerTaskSelectorSemantics(Object task) {
    return 'Timer task selection. Currently selected: $task.';
  }

  @override
  String get startTimerSemantics => 'Start timer';

  @override
  String get pauseTimerSemantics => 'Pause timer';

  @override
  String get continueTimerSemantics => 'Continue timer';

  @override
  String get resetTimerSemantics => 'Reset timer';

  @override
  String get skipPauseSemantics => 'Skip break';

  @override
  String get timerSavingSemantics =>
      'The completed timer phase is being saved.';

  @override
  String timerSyncSemantics(Object message) {
    return 'Timer synchronization: $message';
  }

  @override
  String timerErrorSemantics(Object message) {
    return 'Timer error: $message';
  }

  @override
  String timerKeyboardShortcutsSemantics(Object shortcuts) {
    return 'Keyboard shortcuts for the timer: $shortcuts';
  }

  @override
  String sessionSyncBannerSemantics(Object message) {
    return 'Synchronization status: $message';
  }

  @override
  String get createTaskSemantics => 'Create new task';

  @override
  String activeTaskBannerSemantics(Object title, Object description) {
    return '$title. $description';
  }

  @override
  String get tasksToolbarSemantics => 'Task search, filter and sorting';

  @override
  String taskCardSemantics(Object title, Object status, Object priority,
      Object pomodoros, Object selected) {
    return 'Task: $title. Status: $status. Priority: $priority. Completed: $pomodoros. Active for timer: $selected.';
  }

  @override
  String taskCompletedToggleSemantics(Object title) {
    return 'Mark task $title as completed or open';
  }

  @override
  String selectTaskForTimerSemantics(Object title) {
    return 'Select task $title for the timer';
  }

  @override
  String editTaskSemantics(Object title) {
    return 'Edit task $title';
  }

  @override
  String deleteTaskSemantics(Object title) {
    return 'Delete task $title';
  }

  @override
  String taskErrorSemantics(Object message) {
    return 'Task error: $message';
  }

  @override
  String taskStatusSemantics(Object message) {
    return 'Task status: $message';
  }

  @override
  String get taskPrioritySelectorSemantics => 'Select task priority';

  @override
  String statsChartSemantics(Object summary) {
    return 'Statistics chart. $summary';
  }

  @override
  String statsChartWithTitleSemantics(Object title, Object summary) {
    return '$title. Statistics chart. $summary';
  }

  @override
  String statsChartItemSemantics(
      Object label, Object focusTime, Object pomodoros) {
    return '$label: $focusTime, $pomodoros';
  }

  @override
  String statsChartSummaryWithMore(Object summary, int count) {
    return '$summary; and $count more values.';
  }

  @override
  String statsInfoCardSemantics(Object title, Object value) {
    return '$title: $value';
  }

  @override
  String taskStatsProgressSemantics(Object title) {
    return 'Progress for task $title';
  }

  @override
  String settingsDurationControlSemantics(
      Object title, int value, Object unit, int min, int max) {
    return '$title: current value $value $unit. Allowed range: $min to $max.';
  }

  @override
  String settingsDecreaseValueSemantics(Object title) {
    return 'Decrease $title';
  }

  @override
  String settingsIncreaseValueSemantics(Object title) {
    return 'Increase $title';
  }

  @override
  String settingsNumberInputSemantics(Object title) {
    return 'Enter value for $title';
  }

  @override
  String settingsErrorSemantics(Object message) {
    return 'Settings error: $message';
  }

  @override
  String authErrorSemantics(Object message) {
    return 'Login error: $message';
  }

  @override
  String accountInfoRowSemantics(Object label, Object value) {
    return '$label: $value';
  }

  @override
  String get googleSignInSemantics =>
      'Sign in or create an account with Google';

  @override
  String get githubSignInSemantics =>
      'Sign in or create an account with GitHub';
}

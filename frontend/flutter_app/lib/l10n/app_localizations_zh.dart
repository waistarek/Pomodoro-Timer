// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '番茄钟应用';

  @override
  String get navTimer => '计时器';

  @override
  String get navTasks => '任务';

  @override
  String get navStats => '统计';

  @override
  String get navSettings => '设置';

  @override
  String get navAccount => '账户';

  @override
  String get close => '关闭';

  @override
  String get retry => '重试';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get save => '保存';

  @override
  String get reset => '重置';

  @override
  String get refresh => '刷新';

  @override
  String get messageClose => '关闭消息';

  @override
  String get or => '或';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get emailVerifiedSuccess => '电子邮件已成功验证。你现在可以登录。';

  @override
  String get emailVerifiedExpired => '验证链接已过期。';

  @override
  String get emailVerifiedInvalid => '验证链接无效。';

  @override
  String get sessionSyncOneWithAccount => '一个会话正在与你的账户同步。';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count 个会话正在与你的账户同步。';
  }

  @override
  String get sessionSyncOneAfterLogin => '一个本地会话将在登录后同步。';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count 个本地会话将在登录后同步。';
  }

  @override
  String get sessionSyncOnePending => '一个会话正在等待同步。';

  @override
  String sessionSyncManyPending(int count) {
    return '$count 个会话正在等待同步。';
  }

  @override
  String get sessionSyncDone => '同步已完成。';

  @override
  String get sessionSyncFailed => '当前无法同步会话。稍后会再次尝试。';

  @override
  String get accountTitle => '用户账户';

  @override
  String get loginTitle => '登录';

  @override
  String get createAccountTitle => '创建新账户';

  @override
  String get emailPasswordLoginTitle => '使用电子邮件和密码登录';

  @override
  String get emailPasswordCreateTitle => '创建电子邮件/密码账户';

  @override
  String get emailLabel => '电子邮件';

  @override
  String get passwordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get createAccountButton => '创建账户';

  @override
  String get rememberSessionTitle => '在此设备上保持登录';

  @override
  String get rememberSessionSubtitle => '如果关闭此选项，登录状态只会在当前应用会话中保持。';

  @override
  String get forgotPasswordButton => '忘记密码？';

  @override
  String get alreadyHaveAccount => '我已有账户';

  @override
  String get googleSection => 'Google 区域';

  @override
  String get googleLoginButton => '使用 Google 登录';

  @override
  String get googleCreateButton => '使用 Google 创建账户';

  @override
  String get googleNotConfigured => 'Google 登录尚未配置。';

  @override
  String get googlePreparing => '正在准备 Google 登录 ...';

  @override
  String get googleNoIdToken => 'Google 没有返回有效的 ID 令牌。';

  @override
  String googlePrepareFailed(String error) {
    return '无法准备 Google 登录：$error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google 登录失败：$error';
  }

  @override
  String get googleLoginSuccess => '已成功使用 Google 登录。';

  @override
  String get googleAccountCreated => 'Google 账户已创建，并且你已登录。';

  @override
  String get googleWebOnly => 'Google 登录仅在网页应用中可用';

  @override
  String get githubSection => 'GitHub 区域';

  @override
  String get githubLoginButton => '使用 GitHub 登录';

  @override
  String get githubCreateButton => '使用 GitHub 创建账户';

  @override
  String get githubNotConfigured => 'GitHub 登录尚未配置。';

  @override
  String get githubCancelled => 'GitHub 登录已取消或失败。';

  @override
  String get githubSecurityCancelled => 'GitHub 登录因安全原因被取消。';

  @override
  String get githubNoValidCode => 'GitHub 没有返回有效代码。';

  @override
  String get githubLoginSuccess => '已成功使用 GitHub 登录。';

  @override
  String get githubAccountCreated => 'GitHub 账户已创建，并且你已登录。';

  @override
  String get passwordResetTitle => '重置密码';

  @override
  String get passwordResetDescription => '请输入你的电子邮件地址。如果账户存在，你将收到密码重置链接。';

  @override
  String get sendResetLink => '发送重置链接';

  @override
  String get backToLogin => '返回登录';

  @override
  String get setNewPasswordTitle => '设置新密码';

  @override
  String get setNewPasswordDescription => '为你的账户设置一个新密码。';

  @override
  String get newPasswordLabel => '新密码';

  @override
  String get repeatNewPasswordLabel => '再次输入新密码';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get savePassword => '保存密码';

  @override
  String get registrationSuccess => '注册成功。请验证你的电子邮件地址，然后登录。';

  @override
  String get passwordResetRequestSuccess => '如果此电子邮件对应的账户存在，重置链接已发送。';

  @override
  String get passwordChangedSuccess => '密码已更改。你现在可以登录。';

  @override
  String get passwordResetMailSent => '如果账户存在，重置链接已发送。';

  @override
  String get loginSuccess => '登录成功。';

  @override
  String get invalidEmail => '请输入有效的电子邮件地址';

  @override
  String get passwordMinLength => '至少 8 个字符';

  @override
  String get loggedInTitle => '用户账户';

  @override
  String get loggedInDescription => '你当前已登录。';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get emailStatus => '电子邮件状态';

  @override
  String get emailVerified => '已验证';

  @override
  String get emailNotVerified => '尚未验证';

  @override
  String get accountCreated => '账户已创建';

  @override
  String get synchronization => '同步';

  @override
  String get accountInfoWarning =>
      '如果本地保存了有效的登录令牌，应用可以自动恢复你的会话。在共享设备上，你应始终退出登录。';

  @override
  String get changePassword => '更改密码';

  @override
  String get logout => '退出登录';

  @override
  String get syncRunning => '正在同步';

  @override
  String get syncOneWaiting => '1 个会话等待中';

  @override
  String syncManyWaiting(int count) {
    return '$count 个会话等待中';
  }

  @override
  String get syncError => '同步错误';

  @override
  String get syncAllSynced => '全部已同步';

  @override
  String get sessionExpired => '你的会话已过期。请重新登录。';

  @override
  String get settingsSaved => '设置已保存。';

  @override
  String get timerTimesTitle => '计时器时长';

  @override
  String get timerTimesDescription => '设置工作阶段和休息阶段的持续时间。';

  @override
  String get workTime => '工作时间';

  @override
  String get shortBreak => '短休息';

  @override
  String get longBreak => '长休息';

  @override
  String get longBreakAfter => '长休息间隔';

  @override
  String get minutes => '分钟';

  @override
  String get pomodorosUnit => '番茄钟';

  @override
  String get behaviorTitle => '行为';

  @override
  String get behaviorDescription => '调整计时器在使用过程中的行为。';

  @override
  String get autoStartNextPhase => '自动开始下一阶段';

  @override
  String get enableSound => '启用声音';

  @override
  String get enableVibration => '启用振动';

  @override
  String get vibrationDescription => '实际的移动设备振动稍后会通过插件接入。';

  @override
  String get languageTitle => '语言';

  @override
  String get languageDescription => '选择应用语言。选择“系统语言”时，应用会使用浏览器或设备语言。';

  @override
  String get languageLabel => '应用语言';

  @override
  String get languageSystem => '系统语言';

  @override
  String get languageGerman => '德语';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageArabic => '阿拉伯语';

  @override
  String get languageChinese => '中文';

  @override
  String get languageFrench => '法语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageHindi => '印地语';

  @override
  String get languagePortuguese => '葡萄牙语';

  @override
  String get languageRussian => '俄语';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageTurkish => '土耳其语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageKorean => '韩语';

  @override
  String get languageIndonesian => '印度尼西亚语';

  @override
  String get languagePersian => '波斯语';

  @override
  String get appearanceTitle => '外观';

  @override
  String get appearanceDescription => '选择应用的显示模式和主色。';

  @override
  String get appearanceLabel => '外观';

  @override
  String get systemTheme => '系统';

  @override
  String get lightMode => '浅色模式';

  @override
  String get darkMode => '深色模式';

  @override
  String get themeColor => '主题颜色';

  @override
  String get red => '红色';

  @override
  String get blue => '蓝色';

  @override
  String get green => '绿色';

  @override
  String get purple => '紫色';

  @override
  String get saveSettings => '保存设置';

  @override
  String get noChanges => '没有更改';

  @override
  String get decrease => '减少';

  @override
  String get increase => '增加';

  @override
  String get minutesShort => '分';

  @override
  String get settingsSavedButNotSynced => '设置已在本地保存，但尚未同步。';

  @override
  String get settingsLoadRemoteFailed => '无法从后端加载设置。将使用本地设置。';

  @override
  String get statsTitle => '统计';

  @override
  String get statsRefresh => '刷新';

  @override
  String get statsWeek => '周';

  @override
  String get statsMonth => '月';

  @override
  String get statsYear => '年';

  @override
  String get statsTasksTime => '任务时间';

  @override
  String get chartFocusPerDay => '每日专注时间';

  @override
  String get chartFocusPerCalendarWeek => '每个日历周的专注时间';

  @override
  String get chartFocusPerMonth => '每月专注时间';

  @override
  String get chartFocusPerTask => '每项任务的专注时间';

  @override
  String get xAxisWeek => 'X 轴：一周中的日期';

  @override
  String get xAxisMonth => 'X 轴：本月的日历周';

  @override
  String get xAxisYear => 'X 轴：一年中的月份';

  @override
  String get xAxisTasks => 'X 轴：任务';

  @override
  String get periodNoData => '时间段：暂无数据';

  @override
  String periodRange(String start, String end) {
    return '时间段：$start – $end';
  }

  @override
  String get previousPeriod => '上一个时间段';

  @override
  String get nextPeriod => '下一个时间段';

  @override
  String get statsLoading => '正在加载统计数据 ...';

  @override
  String get taskStatsLoading => '正在加载任务统计 ...';

  @override
  String get taskStatsEmpty => '尚无每项任务的工作时间。启动带任务的番茄钟后即可查看数据。';

  @override
  String get pomodoros => '番茄钟';

  @override
  String get focusTime => '专注时间';

  @override
  String get streak => '连续记录';

  @override
  String get bestPeriod => '最佳时间段';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
      one: '1 天',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y 轴：专注时间（小时） · $xAxisText';
  }

  @override
  String get focusTimeMinutes => '专注时间（分钟）';

  @override
  String get sortedByHighestFocusTime => '按最高专注时间排序。';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros 个番茄钟 · $minutes 分钟';
  }

  @override
  String get statsNoData => '尚无统计数据。';

  @override
  String get statsLoadFailed => '无法加载统计数据。请登录并检查网络连接。';

  @override
  String get taskStatsLoadFailed => '无法加载任务统计。';

  @override
  String get todayPomodorosLoadFailed => '无法加载今天的番茄钟数量。';

  @override
  String get noTaskTitle => '无任务';

  @override
  String calendarWeekShort(int week) {
    return '第 $week 周';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return '第 $week 周/$year';
  }

  @override
  String get tasksTitle => '任务';

  @override
  String get tasksRefreshTooltip => '刷新任务';

  @override
  String get taskSingular => '任务';

  @override
  String get deleteTaskTitle => '删除任务？';

  @override
  String deleteTaskMessage(String title) {
    return '你确定要删除任务“$title”吗？';
  }

  @override
  String get tasksLoading => '正在加载任务 ...';

  @override
  String get tasksEmpty => '还没有任务。创建你的第一个任务。';

  @override
  String get tasksSearchEmpty => '未找到任务。请调整搜索或筛选条件。';

  @override
  String get noTimerTaskSelected => '未选择计时器任务';

  @override
  String activeTimerTask(String title) {
    return '当前计时器任务：$title';
  }

  @override
  String get taskSelectionLockedDescription => '计时器阶段正在运行或已暂停。因此当前任务被锁定。';

  @override
  String get taskSelectionNextWorkPhaseDescription => '此任务将用于下一个工作阶段。';

  @override
  String get withoutTask => '无任务';

  @override
  String get searchTasks => '搜索任务';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get filterAll => '全部';

  @override
  String get filterOpen => '未完成';

  @override
  String get filterCompleted => '已完成';

  @override
  String get sortLabel => '排序';

  @override
  String get sortNewest => '最新优先';

  @override
  String get sortPriority => '优先级';

  @override
  String get sortPomodoros => '番茄钟';

  @override
  String get active => '活动';

  @override
  String get completed => '已完成';

  @override
  String get locked => '已锁定';

  @override
  String get forTimer => '用于计时器';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get taskLoadRemoteFailed => '无法从后端加载任务。仍将显示本地数据。';

  @override
  String get taskSavedLocallyNotSynced => '任务已在本地保存，但无法与账户同步。';

  @override
  String get taskSaveFailedRolledBack => '无法保存任务。最后的更改已回滚。';

  @override
  String get taskDeleteFailedRestored => '无法从账户中删除任务。任务已恢复。';

  @override
  String get taskCreateTitle => '创建任务';

  @override
  String get taskEditTitle => '编辑任务';

  @override
  String get taskTitleLabel => '标题';

  @override
  String get taskTitleRequired => '请输入标题';

  @override
  String get taskTitleTooShort => '标题太短。';

  @override
  String get taskDescriptionLabel => '描述';

  @override
  String get priorityLabel => '优先级';

  @override
  String get tagsLabel => '标签/分类';

  @override
  String get tagsHint => '例如：大学、工作、开发';

  @override
  String get timerResetTitle => '重置计时器？';

  @override
  String get timerResetMessage => '当前阶段将被取消，并且不会保存为已完成会话。';

  @override
  String get taskNoneSelected => '未选择任务';

  @override
  String currentTask(String title) {
    return '当前任务：$title';
  }

  @override
  String get taskForWorkPhase => '此工作阶段的任务';

  @override
  String get taskLockedToPhase => '此阶段已绑定到所选任务。';

  @override
  String get phaseWork => '工作阶段';

  @override
  String get phaseShortBreak => '短休息';

  @override
  String get phaseLongBreak => '长休息';

  @override
  String get timerStatusSaving => '正在保存 ...';

  @override
  String get timerStatusRunning => '运行中';

  @override
  String get timerStatusPaused => '已暂停';

  @override
  String get timerStatusReady => '就绪';

  @override
  String get phaseDescriptionWork => '专注时间';

  @override
  String get phaseDescriptionShortBreak => '短暂恢复';

  @override
  String get phaseDescriptionLongBreak => '较长恢复';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · 接下来：$nextPhase';
  }

  @override
  String get todayPomodorosLoading => '今天：正在加载 ...';

  @override
  String todayPomodoros(String pomodoros) {
    return '今天：$pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个番茄钟',
      one: '1 个番茄钟',
    );
    return '$_temp0';
  }

  @override
  String get pause => '暂停';

  @override
  String get continueButton => '继续';

  @override
  String get start => '开始';

  @override
  String get skipPause => '跳过休息';

  @override
  String get shortcutSpaceCompact => '空格：开始/暂停';

  @override
  String get shortcutResetCompact => 'R：重置';

  @override
  String get shortcutSkipCompact => 'S：跳过';

  @override
  String get shortcutSpace => '空格键：开始/暂停';

  @override
  String get shortcutReset => 'R：重置';

  @override
  String get shortcutSkip => 'S：跳过休息';

  @override
  String get phaseSavingTitle => '正在保存阶段';

  @override
  String get phaseSavingDescription => '已完成的阶段正在保存，计时器正在准备。';

  @override
  String get storageProblem => '存储问题';

  @override
  String get oneFinishedPhaseSavingBackground => '已完成的阶段正在后台保存。';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count 个已完成阶段正在后台保存。';
  }

  @override
  String get timerLocalSaveFailed => '无法在本地保存已完成阶段。';

  @override
  String get timerBackendSyncFailed => '已完成阶段已在本地保存，但尚未与后端同步。';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed / $total';
  }

  @override
  String timerSemanticsLabel(
      Object phase, Object status, Object time, Object progress, Object today) {
    return 'Timer. Phase: $phase. Status: $status. Verbleibende Zeit: $time. $progress. $today.';
  }

  @override
  String timerProgressSemantics(int percent) {
    return 'Fortschritt: $percent Prozent abgeschlossen.';
  }

  @override
  String timerHeaderSemantics(Object phase, Object status, Object nextPhase) {
    return 'Aktuelle Timer-Phase: $phase. Status: $status. Danach folgt: $nextPhase.';
  }

  @override
  String timerTaskSelectorSemantics(Object task) {
    return 'Aufgabenauswahl für den Timer. Aktuell ausgewählt: $task.';
  }

  @override
  String get startTimerSemantics => 'Timer starten';

  @override
  String get pauseTimerSemantics => 'Timer pausieren';

  @override
  String get continueTimerSemantics => 'Timer fortsetzen';

  @override
  String get resetTimerSemantics => 'Timer zurücksetzen';

  @override
  String get skipPauseSemantics => 'Pause überspringen';

  @override
  String get timerSavingSemantics =>
      'Die abgeschlossene Timer-Phase wird gespeichert.';

  @override
  String timerSyncSemantics(Object message) {
    return 'Timer-Synchronisierung: $message';
  }

  @override
  String timerErrorSemantics(Object message) {
    return 'Timer-Fehler: $message';
  }

  @override
  String timerKeyboardShortcutsSemantics(Object shortcuts) {
    return 'Tastaturkürzel für den Timer: $shortcuts';
  }

  @override
  String sessionSyncBannerSemantics(Object message) {
    return 'Synchronisierungsstatus: $message';
  }

  @override
  String get createTaskSemantics => 'Neue Aufgabe erstellen';

  @override
  String activeTaskBannerSemantics(Object title, Object description) {
    return '$title. $description';
  }

  @override
  String get tasksToolbarSemantics => 'Aufgaben-Suche, Filter und Sortierung';

  @override
  String taskCardSemantics(Object title, Object status, Object priority,
      Object pomodoros, Object selected) {
    return 'Aufgabe: $title. Status: $status. Priorität: $priority. Abgeschlossen: $pomodoros. Für Timer aktiv: $selected.';
  }

  @override
  String taskCompletedToggleSemantics(Object title) {
    return 'Aufgabe $title als erledigt oder offen markieren';
  }

  @override
  String selectTaskForTimerSemantics(Object title) {
    return 'Aufgabe $title für den Timer auswählen';
  }

  @override
  String editTaskSemantics(Object title) {
    return 'Aufgabe $title bearbeiten';
  }

  @override
  String deleteTaskSemantics(Object title) {
    return 'Aufgabe $title löschen';
  }

  @override
  String taskErrorSemantics(Object message) {
    return 'Aufgaben-Fehler: $message';
  }

  @override
  String taskStatusSemantics(Object message) {
    return 'Aufgaben-Status: $message';
  }

  @override
  String get taskPrioritySelectorSemantics => 'Priorität der Aufgabe auswählen';

  @override
  String statsChartSemantics(Object summary) {
    return 'Statistikdiagramm. $summary';
  }

  @override
  String statsChartWithTitleSemantics(Object title, Object summary) {
    return '$title. Statistikdiagramm. $summary';
  }

  @override
  String statsChartItemSemantics(
      Object label, Object focusTime, Object pomodoros) {
    return '$label: $focusTime, $pomodoros';
  }

  @override
  String statsChartSummaryWithMore(Object summary, int count) {
    return '$summary; und $count weitere Werte.';
  }

  @override
  String statsInfoCardSemantics(Object title, Object value) {
    return '$title: $value';
  }

  @override
  String taskStatsProgressSemantics(Object title) {
    return 'Fortschritt für Aufgabe $title';
  }

  @override
  String settingsDurationControlSemantics(
      Object title, int value, Object unit, int min, int max) {
    return '$title: aktueller Wert $value $unit. Erlaubter Bereich: $min bis $max.';
  }

  @override
  String settingsDecreaseValueSemantics(Object title) {
    return '$title verringern';
  }

  @override
  String settingsIncreaseValueSemantics(Object title) {
    return '$title erhöhen';
  }

  @override
  String settingsNumberInputSemantics(Object title) {
    return 'Wert für $title eingeben';
  }

  @override
  String settingsErrorSemantics(Object message) {
    return 'Einstellungsfehler: $message';
  }

  @override
  String authErrorSemantics(Object message) {
    return 'Anmeldefehler: $message';
  }

  @override
  String accountInfoRowSemantics(Object label, Object value) {
    return '$label: $value';
  }

  @override
  String get googleSignInSemantics =>
      'Mit Google anmelden oder Konto erstellen';

  @override
  String get githubSignInSemantics =>
      'Mit GitHub anmelden oder Konto erstellen';
}

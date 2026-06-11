// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Time2Focus';

  @override
  String get navTimer => 'タイマー';

  @override
  String get navTasks => 'タスク';

  @override
  String get navStats => '統計';

  @override
  String get navSettings => '設定';

  @override
  String get navAccount => 'アカウント';

  @override
  String get close => '閉じる';

  @override
  String get retry => '再試行';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get save => '保存';

  @override
  String get reset => 'リセット';

  @override
  String get refresh => '更新';

  @override
  String get messageClose => 'メッセージを閉じる';

  @override
  String get or => 'または';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get emailVerifiedSuccess => 'メールアドレスが正常に確認されました。これでログインできます。';

  @override
  String get emailVerifiedExpired => '確認リンクの有効期限が切れています。';

  @override
  String get emailVerifiedInvalid => '確認リンクが無効です。';

  @override
  String get sessionSyncOneWithAccount => '1件のセッションをアカウントと同期しています。';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count件のセッションをアカウントと同期しています。';
  }

  @override
  String get sessionSyncOneAfterLogin => 'ログイン後、1件のローカルセッションが同期されます。';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return 'ログイン後、$count件のローカルセッションが同期されます。';
  }

  @override
  String get sessionSyncOnePending => '1件のセッションが同期を待っています。';

  @override
  String sessionSyncManyPending(int count) {
    return '$count件のセッションが同期を待っています。';
  }

  @override
  String get sessionSyncDone => '同期が完了しました。';

  @override
  String get sessionSyncFailed => '現在セッションを同期できませんでした。後でもう一度試行します。';

  @override
  String get accountTitle => 'ユーザーアカウント';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get createAccountTitle => '新しいアカウントを作成';

  @override
  String get emailPasswordLoginTitle => 'メールアドレスとパスワードでログイン';

  @override
  String get emailPasswordCreateTitle => 'メールアドレス/パスワードのアカウントを作成';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get createAccountButton => 'アカウントを作成';

  @override
  String get rememberSessionTitle => 'このデバイスでログイン状態を保持する';

  @override
  String get rememberSessionSubtitle => '無効にすると、ログインは現在のアプリセッション中のみ有効です。';

  @override
  String get forgotPasswordButton => 'パスワードをお忘れですか？';

  @override
  String get alreadyHaveAccount => 'すでにアカウントを持っています';

  @override
  String get googleSection => 'Googleセクション';

  @override
  String get googleLoginButton => 'Googleでログイン';

  @override
  String get googleCreateButton => 'Googleでアカウントを作成';

  @override
  String get googleNotConfigured => 'Googleログインが設定されていません。';

  @override
  String get googlePreparing => 'Googleログインを準備しています ...';

  @override
  String get googleNoIdToken => 'Googleから有効なIDトークンが返されませんでした。';

  @override
  String googlePrepareFailed(String error) {
    return 'Googleログインを準備できませんでした: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Googleログインに失敗しました: $error';
  }

  @override
  String get googleLoginSuccess => 'Googleで正常にログインしました。';

  @override
  String get googleAccountCreated => 'Googleアカウントが作成され、ログインしました。';

  @override
  String get googleWebOnly => 'GoogleログインはWebアプリでのみ利用できます';

  @override
  String get githubSection => 'GitHubセクション';

  @override
  String get githubLoginButton => 'GitHubでログイン';

  @override
  String get githubCreateButton => 'GitHubでアカウントを作成';

  @override
  String get githubNotConfigured => 'GitHubログインが設定されていません。';

  @override
  String get githubCancelled => 'GitHubログインがキャンセルされたか失敗しました。';

  @override
  String get githubSecurityCancelled => 'セキュリティ上の理由によりGitHubログインがキャンセルされました。';

  @override
  String get githubNoValidCode => 'GitHubから有効なコードが返されませんでした。';

  @override
  String get githubLoginSuccess => 'GitHubで正常にログインしました。';

  @override
  String get githubAccountCreated => 'GitHubアカウントが作成され、ログインしました。';

  @override
  String get passwordResetTitle => 'パスワードをリセット';

  @override
  String get passwordResetDescription =>
      'メールアドレスを入力してください。アカウントが存在する場合、パスワードリセット用リンクが届きます。';

  @override
  String get sendResetLink => 'リセットリンクを送信';

  @override
  String get backToLogin => 'ログインに戻る';

  @override
  String get setNewPasswordTitle => '新しいパスワードを設定';

  @override
  String get setNewPasswordDescription => 'アカウント用の新しいパスワードを設定してください。';

  @override
  String get newPasswordLabel => '新しいパスワード';

  @override
  String get repeatNewPasswordLabel => '新しいパスワードを再入力';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get savePassword => 'パスワードを保存';

  @override
  String get registrationSuccess => '登録が完了しました。メールアドレスを確認してからログインしてください。';

  @override
  String get passwordResetRequestSuccess =>
      'このメールアドレスのアカウントが存在する場合、リセットリンクが送信されました。';

  @override
  String get passwordChangedSuccess => 'パスワードが変更されました。これでログインできます。';

  @override
  String get passwordResetMailSent => 'アカウントが存在する場合、リセットリンクが送信されました。';

  @override
  String get loginSuccess => '正常にログインしました。';

  @override
  String get invalidEmail => '有効なメールアドレスを入力してください';

  @override
  String get passwordMinLength => '8文字以上';

  @override
  String get loggedInTitle => 'ユーザーアカウント';

  @override
  String get loggedInDescription => '現在ログイン中です。';

  @override
  String get emailAddress => 'メールアドレス';

  @override
  String get emailStatus => 'メールの状態';

  @override
  String get emailVerified => '確認済み';

  @override
  String get emailNotVerified => '未確認';

  @override
  String get accountCreated => 'アカウント作成日';

  @override
  String get synchronization => '同期';

  @override
  String get accountInfoWarning =>
      '有効なログイントークンがローカルに保存されている場合、アプリはセッションを自動的に復元できます。共有デバイスでは必ずログアウトしてください。';

  @override
  String get changePassword => 'パスワードを変更';

  @override
  String get logout => 'ログアウト';

  @override
  String get syncRunning => '同期中';

  @override
  String get syncOneWaiting => '1件のセッションが待機中';

  @override
  String syncManyWaiting(int count) {
    return '$count件のセッションが待機中';
  }

  @override
  String get syncError => '同期エラー';

  @override
  String get syncAllSynced => 'すべて同期済み';

  @override
  String get sessionExpired => 'セッションの有効期限が切れました。もう一度ログインしてください。';

  @override
  String get settingsSaved => '設定を保存しました。';

  @override
  String get timerTimesTitle => 'タイマー時間';

  @override
  String get timerTimesDescription => '作業フェーズと休憩の長さを設定します。';

  @override
  String get workTime => '作業時間';

  @override
  String get shortBreak => '短い休憩';

  @override
  String get longBreak => '長い休憩';

  @override
  String get longBreakAfter => '長い休憩まで';

  @override
  String get minutes => '分';

  @override
  String get pomodorosUnit => 'ポモドーロ';

  @override
  String get behaviorTitle => '動作';

  @override
  String get behaviorDescription => '利用中のタイマーの動作を調整します。';

  @override
  String get autoStartNextPhase => '次のフェーズを自動開始';

  @override
  String get enableSound => 'サウンドを有効にする';

  @override
  String get enableVibration => 'バイブレーションを有効にする';

  @override
  String get vibrationDescription => '実際のモバイルバイブレーションは後でプラグイン経由で接続されます。';

  @override
  String get languageTitle => '言語';

  @override
  String get languageDescription =>
      'アプリの言語を選択します。「システム言語」では、ブラウザまたはデバイスの言語を使用します。';

  @override
  String get languageLabel => 'アプリの言語';

  @override
  String get languageSystem => 'システム言語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageArabic => 'アラビア語';

  @override
  String get languageChinese => '中国語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get languageHindi => 'ヒンディー語';

  @override
  String get languagePortuguese => 'ポルトガル語';

  @override
  String get languageRussian => 'ロシア語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageTurkish => 'トルコ語';

  @override
  String get languageItalian => 'イタリア語';

  @override
  String get languageKorean => '韓国語';

  @override
  String get languageIndonesian => 'インドネシア語';

  @override
  String get languagePersian => 'ペルシア語';

  @override
  String get appearanceTitle => '表示';

  @override
  String get appearanceDescription => 'アプリの表示モードとメインカラーを選択します。';

  @override
  String get appearanceLabel => '表示';

  @override
  String get systemTheme => 'システム';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get themeColor => 'テーマカラー';

  @override
  String get red => '赤';

  @override
  String get blue => '青';

  @override
  String get green => '緑';

  @override
  String get purple => '紫';

  @override
  String get saveSettings => '設定を保存';

  @override
  String get noChanges => '変更はありません';

  @override
  String get decrease => '減らす';

  @override
  String get increase => '増やす';

  @override
  String get minutesShort => '分';

  @override
  String get settingsSavedButNotSynced => '設定はローカルに保存されましたが、まだ同期されていません。';

  @override
  String get settingsLoadRemoteFailed => 'バックエンドから設定を読み込めませんでした。ローカル設定を使用します。';

  @override
  String get statsTitle => '統計';

  @override
  String get statsRefresh => '更新';

  @override
  String get statsWeek => '週';

  @override
  String get statsMonth => '月';

  @override
  String get statsYear => '年';

  @override
  String get statsTasksTime => 'タスク時間';

  @override
  String get chartFocusPerDay => '日ごとの集中時間';

  @override
  String get chartFocusPerCalendarWeek => '暦週ごとの集中時間';

  @override
  String get chartFocusPerMonth => '月ごとの集中時間';

  @override
  String get chartFocusPerTask => 'タスクごとの集中時間';

  @override
  String get xAxisWeek => 'X軸: 週の日';

  @override
  String get xAxisMonth => 'X軸: 月内の暦週';

  @override
  String get xAxisYear => 'X軸: 年内の月';

  @override
  String get xAxisTasks => 'X軸: タスク';

  @override
  String get periodNoData => '期間: データがありません';

  @override
  String periodRange(String start, String end) {
    return '期間: $start – $end';
  }

  @override
  String get previousPeriod => '前の期間';

  @override
  String get nextPeriod => '次の期間';

  @override
  String get statsLoading => '統計を読み込み中 ...';

  @override
  String get taskStatsLoading => 'タスク統計を読み込み中 ...';

  @override
  String get taskStatsEmpty =>
      'タスクごとの作業時間はまだありません。データを見るには、タスク付きでポモドーロを開始してください。';

  @override
  String get pomodoros => 'ポモドーロ';

  @override
  String get focusTime => '集中時間';

  @override
  String get streak => '連続記録';

  @override
  String get bestPeriod => '最良期間';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日',
      one: '1日',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y軸: 集中時間（時間） · $xAxisText';
  }

  @override
  String get focusTimeMinutes => '集中時間（分）';

  @override
  String get sortedByHighestFocusTime => '集中時間が長い順に並べ替えられています。';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros ポモドーロ · $minutes 分';
  }

  @override
  String get statsNoData => '統計データはまだありません。';

  @override
  String get statsLoadFailed => '統計を読み込めませんでした。ログインしてインターネット接続を確認してください。';

  @override
  String get taskStatsLoadFailed => 'タスク統計を読み込めませんでした。';

  @override
  String get todayPomodorosLoadFailed => '今日のポモドーロ数を読み込めませんでした。';

  @override
  String get noTaskTitle => 'タスクなし';

  @override
  String calendarWeekShort(int week) {
    return '第$week週';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return '第$week週/$year';
  }

  @override
  String get tasksTitle => 'タスク';

  @override
  String get tasksRefreshTooltip => 'タスクを更新';

  @override
  String get taskSingular => 'タスク';

  @override
  String get deleteTaskTitle => 'タスクを削除しますか？';

  @override
  String deleteTaskMessage(String title) {
    return 'タスク「$title」を本当に削除しますか？';
  }

  @override
  String get tasksLoading => 'タスクを読み込み中 ...';

  @override
  String get tasksEmpty => 'タスクはまだありません。最初のタスクを作成してください。';

  @override
  String get tasksSearchEmpty => 'タスクが見つかりません。検索またはフィルターを調整してください。';

  @override
  String get noTimerTaskSelected => 'タイマー用タスクが選択されていません';

  @override
  String activeTimerTask(String title) {
    return 'アクティブなタイマータスク: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'タイマーフェーズが実行中または一時停止中です。そのため現在タスクはロックされています。';

  @override
  String get taskSelectionNextWorkPhaseDescription => 'このタスクは次の作業フェーズで使用されます。';

  @override
  String get withoutTask => 'タスクなし';

  @override
  String get searchTasks => 'タスクを検索';

  @override
  String get clearSearch => '検索をクリア';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterOpen => '未完了';

  @override
  String get filterCompleted => '完了';

  @override
  String get sortLabel => '並べ替え';

  @override
  String get sortNewest => '新しい順';

  @override
  String get sortPriority => '優先度';

  @override
  String get sortPomodoros => 'ポモドーロ';

  @override
  String get active => 'アクティブ';

  @override
  String get completed => '完了';

  @override
  String get locked => 'ロック中';

  @override
  String get forTimer => 'タイマー用';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get taskLoadRemoteFailed =>
      'バックエンドからタスクを読み込めませんでした。ローカルデータは引き続き表示されます。';

  @override
  String get taskSavedLocallyNotSynced => 'タスクはローカルに保存されましたが、アカウントと同期できませんでした。';

  @override
  String get taskSaveFailedRolledBack => 'タスクを保存できませんでした。最後の変更は取り消されました。';

  @override
  String get taskDeleteFailedRestored => 'アカウントからタスクを削除できませんでした。タスクは復元されました。';

  @override
  String get taskCreateTitle => 'タスクを作成';

  @override
  String get taskEditTitle => 'タスクを編集';

  @override
  String get taskTitleLabel => 'タイトル';

  @override
  String get taskTitleRequired => 'タイトルを入力してください';

  @override
  String get taskTitleTooShort => 'タイトルが短すぎます。';

  @override
  String get taskDescriptionLabel => '説明';

  @override
  String get priorityLabel => '優先度';

  @override
  String get tagsLabel => 'タグ/カテゴリ';

  @override
  String get tagsHint => '例: 大学、仕事、開発';

  @override
  String get timerResetTitle => 'タイマーをリセットしますか？';

  @override
  String get timerResetMessage => '現在のフェーズはキャンセルされ、完了セッションとして保存されません。';

  @override
  String get taskNoneSelected => 'タスクが選択されていません';

  @override
  String currentTask(String title) {
    return '現在のタスク: $title';
  }

  @override
  String get taskForWorkPhase => 'この作業フェーズのタスク';

  @override
  String get taskLockedToPhase => 'このフェーズは選択したタスクに固定されています。';

  @override
  String get phaseWork => '作業フェーズ';

  @override
  String get phaseShortBreak => '短い休憩';

  @override
  String get phaseLongBreak => '長い休憩';

  @override
  String get timerStatusSaving => '保存中 ...';

  @override
  String get timerStatusRunning => '実行中';

  @override
  String get timerStatusPaused => '一時停止中';

  @override
  String get timerStatusReady => '準備完了';

  @override
  String get phaseDescriptionWork => '集中時間';

  @override
  String get phaseDescriptionShortBreak => '短い回復';

  @override
  String get phaseDescriptionLongBreak => '長めの回復';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · 次: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => '今日: 読み込み中 ...';

  @override
  String todayPomodoros(String pomodoros) {
    return '今日: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countポモドーロ',
      one: '1ポモドーロ',
    );
    return '$_temp0';
  }

  @override
  String get pause => '一時停止';

  @override
  String get continueButton => '続行';

  @override
  String get start => '開始';

  @override
  String get skipPause => '休憩をスキップ';

  @override
  String get shortcutSpaceCompact => 'Space: 開始/一時停止';

  @override
  String get shortcutResetCompact => 'R: リセット';

  @override
  String get shortcutSkipCompact => 'S: スキップ';

  @override
  String get shortcutSpace => 'スペースキー: 開始/一時停止';

  @override
  String get shortcutReset => 'R: リセット';

  @override
  String get shortcutSkip => 'S: 休憩をスキップ';

  @override
  String get phaseSavingTitle => 'フェーズを保存中';

  @override
  String get phaseSavingDescription => '完了したフェーズを保存し、タイマーを準備しています。';

  @override
  String get storageProblem => '保存の問題';

  @override
  String get oneFinishedPhaseSavingBackground => '完了したフェーズをバックグラウンドで保存しています。';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count件の完了フェーズをバックグラウンドで保存しています。';
  }

  @override
  String get timerLocalSaveFailed => '完了したフェーズをローカルに保存できませんでした。';

  @override
  String get timerBackendSyncFailed =>
      '完了したフェーズはローカルに保存されましたが、まだバックエンドと同期されていません。';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed / $total';
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

  @override
  String get landingLogoSemantics => 'Time2Focusのロゴと開始エリア';

  @override
  String get landingLoginButton => 'ログイン';

  @override
  String get landingHeroBadge => 'ポモドーロタイマーと集中アプリ';

  @override
  String get landingHeroTitle => 'Time2Focusでより集中して作業する';

  @override
  String get landingHeroDescription =>
      'Time2Focusは、集中セッション、タスク管理、生産性向上のためのポモドーロタイマーアプリです。集中して作業する時間を計画し、休憩を意識しながら、進捗をわかりやすく確認できます。';

  @override
  String get landingPrimaryCta => 'ポモドーロタイマーを開始';

  @override
  String get landingSecondaryCta => 'アカウント作成またはログイン';

  @override
  String get landingHeroHint =>
      'ブラウザからすぐに利用できます。インストール不要で開始でき、必要に応じてアカウントと同期できます。';

  @override
  String get landingPreviewSemantics => 'タイマー、タスク、統計機能を含むTime2Focusアプリのプレビュー';

  @override
  String get landingPreviewLabel => 'アプリプレビュー';

  @override
  String get landingPreviewTitle => '次の集中セッション';

  @override
  String get landingPreviewPhase => '集中時間';

  @override
  String get landingPreviewTask => 'タスクを関連付ける';

  @override
  String get landingPreviewBreak => '休憩を計画';

  @override
  String get landingPreviewStats => '進捗を見る';

  @override
  String get landingFeaturesSectionTitle => '集中して作業するために必要な機能';

  @override
  String get landingFeaturesSectionSubtitle =>
      'Time2Focusは、ポモドーロタイマー、タスク、生産性統計を、不要な気が散る要素のないシンプルなWebアプリにまとめています。';

  @override
  String get landingFeatureTimerTitle => '明確な集中セッションのためのポモドーロタイマー';

  @override
  String get landingFeatureTimerText =>
      '集中時間、短い休憩、長い休憩を含む決まった間隔で作業できます。集中を計画しやすくなり、作業日をより整理できます。';

  @override
  String get landingFeatureTasksTitle => '作業のためのタスク管理';

  @override
  String get landingFeatureTasksText =>
      '集中セッションを具体的なタスクと関連付けられます。あとから、集中した作業時間を何に使ったかをより明確に確認できます。';

  @override
  String get landingFeatureStatsTitle => 'わかりやすい生産性統計';

  @override
  String get landingFeatureStatsText =>
      '完了した集中時間、ポモドーロ、タスク時間を分析できます。進捗、習慣、生産的な作業パターンを理解するのに役立ちます。';

  @override
  String get landingHowItWorksTitle => 'Time2Focusの使い方';

  @override
  String get landingHowItWorksSubtitle =>
      '流れは意図的にシンプルです。タスクを選び、集中セッションを開始し、作業後に進捗を確認します。';

  @override
  String get landingStepOneTitle => 'タスクを準備する';

  @override
  String get landingStepOneText =>
      'タスクを作成することも、タスクなしで直接開始することもできます。Time2Focusは両方の作業方法に対応しています。';

  @override
  String get landingStepTwoTitle => '集中セッションを開始する';

  @override
  String get landingStepTwoText =>
      'ポモドーロタイマーを開始し、次の休憩まで集中して作業します。アプリが作業時間と休憩時間の流れを案内します。';

  @override
  String get landingStepThreeTitle => '進捗を確認する';

  @override
  String get landingStepThreeText => '統計を使って、集中時間、完了したポモドーロ、タスク時間をよりよく理解できます。';

  @override
  String get landingFaqTitle => 'よくある質問';

  @override
  String get landingFaqSubtitle => 'まずTime2Focusを試したい新しいユーザー向けの短い回答です。';

  @override
  String get landingFaqOneQuestion => 'Time2Focusはアカウントなしで使えますか？';

  @override
  String get landingFaqOneAnswer =>
      'はい。タイマーはブラウザから直接使用できます。後でデータを同期したり、複数のデバイスで使ったりしたい場合は、アカウントが便利です。';

  @override
  String get landingFaqTwoQuestion => 'Time2Focusは単なるポモドーロタイマーですか？';

  @override
  String get landingFaqTwoAnswer =>
      'いいえ。Time2Focusは、ポモドーロタイマー、集中セッション、タスク管理、統計を組み合わせ、作業と進捗をより明確に結び付けます。';

  @override
  String get landingFaqThreeQuestion => 'Time2Focusはスマートフォンで使えますか？';

  @override
  String get landingFaqThreeAnswer =>
      'はい。このWebアプリはレスポンシブ対応で、デスクトップ、タブレット、スマートフォンのブラウザで利用できます。';

  @override
  String get landingFooter => 'Time2Focus – 集中して作業するためのポモドーロタイマーと集中アプリ。';
}

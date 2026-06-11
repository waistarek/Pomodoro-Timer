// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Приложение Pomodoro';

  @override
  String get navTimer => 'Таймер';

  @override
  String get navTasks => 'Задачи';

  @override
  String get navStats => 'Статистика';

  @override
  String get navSettings => 'Настройки';

  @override
  String get navAccount => 'Аккаунт';

  @override
  String get close => 'Закрыть';

  @override
  String get retry => 'Повторить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get save => 'Сохранить';

  @override
  String get reset => 'Сбросить';

  @override
  String get refresh => 'Обновить';

  @override
  String get messageClose => 'Закрыть сообщение';

  @override
  String get or => 'или';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get emailVerifiedSuccess =>
      'Электронная почта успешно подтверждена. Теперь можно войти.';

  @override
  String get emailVerifiedExpired =>
      'Срок действия ссылки подтверждения истёк.';

  @override
  String get emailVerifiedInvalid => 'Ссылка подтверждения недействительна.';

  @override
  String get sessionSyncOneWithAccount =>
      'Одна сессия синхронизируется с вашим аккаунтом.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count сессий синхронизируются с вашим аккаунтом.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Одна локальная сессия будет синхронизирована после входа.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count локальных сессий будут синхронизированы после входа.';
  }

  @override
  String get sessionSyncOnePending => 'Одна сессия ожидает синхронизации.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count сессий ожидают синхронизации.';
  }

  @override
  String get sessionSyncDone => 'Синхронизация завершена.';

  @override
  String get sessionSyncFailed =>
      'Сессии сейчас не удалось синхронизировать. Повторная попытка будет выполнена позже.';

  @override
  String get accountTitle => 'Аккаунт пользователя';

  @override
  String get loginTitle => 'Вход';

  @override
  String get createAccountTitle => 'Создать новый аккаунт';

  @override
  String get emailPasswordLoginTitle =>
      'Войти с помощью электронной почты и пароля';

  @override
  String get emailPasswordCreateTitle =>
      'Создать аккаунт с электронной почтой и паролем';

  @override
  String get emailLabel => 'Электронная почта';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get createAccountButton => 'Создать аккаунт';

  @override
  String get rememberSessionTitle => 'Оставаться в системе на этом устройстве';

  @override
  String get rememberSessionSubtitle =>
      'Если отключено, вход будет активен только в текущей сессии приложения.';

  @override
  String get forgotPasswordButton => 'Забыли пароль?';

  @override
  String get alreadyHaveAccount => 'У меня уже есть аккаунт';

  @override
  String get googleSection => 'Раздел Google';

  @override
  String get googleLoginButton => 'Войти через Google';

  @override
  String get googleCreateButton => 'Создать аккаунт через Google';

  @override
  String get googleNotConfigured => 'Вход через Google не настроен.';

  @override
  String get googlePreparing => 'Подготовка входа через Google ...';

  @override
  String get googleNoIdToken => 'Google не вернул действительный ID-токен.';

  @override
  String googlePrepareFailed(String error) {
    return 'Не удалось подготовить вход через Google: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Ошибка входа через Google: $error';
  }

  @override
  String get googleLoginSuccess => 'Вход через Google выполнен успешно.';

  @override
  String get googleAccountCreated =>
      'Аккаунт Google создан, и вы вошли в систему.';

  @override
  String get googleWebOnly =>
      'Вход через Google доступен только в веб-приложении';

  @override
  String get githubSection => 'Раздел GitHub';

  @override
  String get githubLoginButton => 'Войти через GitHub';

  @override
  String get githubCreateButton => 'Создать аккаунт через GitHub';

  @override
  String get githubNotConfigured => 'Вход через GitHub не настроен.';

  @override
  String get githubCancelled =>
      'Вход через GitHub был отменён или завершился ошибкой.';

  @override
  String get githubSecurityCancelled =>
      'Вход через GitHub был отменён по соображениям безопасности.';

  @override
  String get githubNoValidCode => 'GitHub не вернул действительный код.';

  @override
  String get githubLoginSuccess => 'Вход через GitHub выполнен успешно.';

  @override
  String get githubAccountCreated =>
      'Аккаунт GitHub создан, и вы вошли в систему.';

  @override
  String get passwordResetTitle => 'Сброс пароля';

  @override
  String get passwordResetDescription =>
      'Введите адрес электронной почты. Если аккаунт существует, вы получите ссылку для сброса пароля.';

  @override
  String get sendResetLink => 'Отправить ссылку для сброса';

  @override
  String get backToLogin => 'Вернуться ко входу';

  @override
  String get setNewPasswordTitle => 'Установить новый пароль';

  @override
  String get setNewPasswordDescription =>
      'Установите новый пароль для вашего аккаунта.';

  @override
  String get newPasswordLabel => 'Новый пароль';

  @override
  String get repeatNewPasswordLabel => 'Повторите новый пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get savePassword => 'Сохранить пароль';

  @override
  String get registrationSuccess =>
      'Регистрация прошла успешно. Подтвердите адрес электронной почты, затем войдите.';

  @override
  String get passwordResetRequestSuccess =>
      'Если аккаунт с этой электронной почтой существует, ссылка для сброса отправлена.';

  @override
  String get passwordChangedSuccess => 'Пароль изменён. Теперь можно войти.';

  @override
  String get passwordResetMailSent =>
      'Если аккаунт существует, ссылка для сброса отправлена.';

  @override
  String get loginSuccess => 'Вход выполнен успешно.';

  @override
  String get invalidEmail => 'Введите действительный адрес электронной почты';

  @override
  String get passwordMinLength => 'Минимум 8 символов';

  @override
  String get loggedInTitle => 'Аккаунт пользователя';

  @override
  String get loggedInDescription => 'Вы сейчас вошли в систему.';

  @override
  String get emailAddress => 'Адрес электронной почты';

  @override
  String get emailStatus => 'Статус электронной почты';

  @override
  String get emailVerified => 'Подтверждена';

  @override
  String get emailNotVerified => 'Ещё не подтверждена';

  @override
  String get accountCreated => 'Аккаунт создан';

  @override
  String get synchronization => 'Синхронизация';

  @override
  String get accountInfoWarning =>
      'Приложение может автоматически восстановить вашу сессию, если локально сохранён действительный токен входа. На общих устройствах всегда выходите из аккаунта.';

  @override
  String get changePassword => 'Изменить пароль';

  @override
  String get logout => 'Выйти';

  @override
  String get syncRunning => 'Синхронизация выполняется';

  @override
  String get syncOneWaiting => '1 сессия ожидает';

  @override
  String syncManyWaiting(int count) {
    return '$count сессий ожидают';
  }

  @override
  String get syncError => 'Ошибка синхронизации';

  @override
  String get syncAllSynced => 'Всё синхронизировано';

  @override
  String get sessionExpired =>
      'Срок действия вашей сессии истёк. Войдите снова.';

  @override
  String get settingsSaved => 'Настройки сохранены.';

  @override
  String get timerTimesTitle => 'Длительности таймера';

  @override
  String get timerTimesDescription =>
      'Задайте длительность рабочих фаз и перерывов.';

  @override
  String get workTime => 'Рабочее время';

  @override
  String get shortBreak => 'Короткий перерыв';

  @override
  String get longBreak => 'Длинный перерыв';

  @override
  String get longBreakAfter => 'Длинный перерыв после';

  @override
  String get minutes => 'Минуты';

  @override
  String get pomodorosUnit => 'Pomodoro';

  @override
  String get behaviorTitle => 'Поведение';

  @override
  String get behaviorDescription =>
      'Настройте поведение таймера во время использования.';

  @override
  String get autoStartNextPhase => 'Автоматически запускать следующую фазу';

  @override
  String get enableSound => 'Включить звук';

  @override
  String get enableVibration => 'Включить вибрацию';

  @override
  String get vibrationDescription =>
      'Реальная мобильная вибрация будет подключена позже через плагин.';

  @override
  String get languageTitle => 'Язык';

  @override
  String get languageDescription =>
      'Выберите язык приложения. При выборе «Системный язык» приложение использует язык браузера или устройства.';

  @override
  String get languageLabel => 'Язык приложения';

  @override
  String get languageSystem => 'Системный язык';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageArabic => 'Арабский';

  @override
  String get languageChinese => 'Китайский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageHindi => 'Хинди';

  @override
  String get languagePortuguese => 'Португальский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageJapanese => 'Японский';

  @override
  String get languageTurkish => 'Турецкий';

  @override
  String get languageItalian => 'Итальянский';

  @override
  String get languageKorean => 'Корейский';

  @override
  String get languageIndonesian => 'Индонезийский';

  @override
  String get languagePersian => 'Персидский';

  @override
  String get appearanceTitle => 'Внешний вид';

  @override
  String get appearanceDescription =>
      'Выберите режим оформления и основной цвет приложения.';

  @override
  String get appearanceLabel => 'Внешний вид';

  @override
  String get systemTheme => 'Система';

  @override
  String get lightMode => 'Светлый режим';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get themeColor => 'Цвет темы';

  @override
  String get red => 'Красный';

  @override
  String get blue => 'Синий';

  @override
  String get green => 'Зелёный';

  @override
  String get purple => 'Фиолетовый';

  @override
  String get saveSettings => 'Сохранить настройки';

  @override
  String get noChanges => 'Нет изменений';

  @override
  String get decrease => 'Уменьшить';

  @override
  String get increase => 'Увеличить';

  @override
  String get minutesShort => 'мин';

  @override
  String get settingsSavedButNotSynced =>
      'Настройки сохранены локально, но ещё не синхронизированы.';

  @override
  String get settingsLoadRemoteFailed =>
      'Не удалось загрузить настройки с backend. Используются локальные настройки.';

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsRefresh => 'Обновить';

  @override
  String get statsWeek => 'Неделя';

  @override
  String get statsMonth => 'Месяц';

  @override
  String get statsYear => 'Год';

  @override
  String get statsTasksTime => 'Время по задачам';

  @override
  String get chartFocusPerDay => 'Время фокуса по дням';

  @override
  String get chartFocusPerCalendarWeek => 'Время фокуса по календарным неделям';

  @override
  String get chartFocusPerMonth => 'Время фокуса по месяцам';

  @override
  String get chartFocusPerTask => 'Время фокуса по задачам';

  @override
  String get xAxisWeek => 'Ось X: дни недели';

  @override
  String get xAxisMonth => 'Ось X: календарные недели месяца';

  @override
  String get xAxisYear => 'Ось X: месяцы года';

  @override
  String get xAxisTasks => 'Ось X: задачи';

  @override
  String get periodNoData => 'Период: данные отсутствуют';

  @override
  String periodRange(String start, String end) {
    return 'Период: $start – $end';
  }

  @override
  String get previousPeriod => 'Предыдущий период';

  @override
  String get nextPeriod => 'Следующий период';

  @override
  String get statsLoading => 'Загрузка статистики ...';

  @override
  String get taskStatsLoading => 'Загрузка статистики задач ...';

  @override
  String get taskStatsEmpty =>
      'Пока нет рабочего времени по задачам. Запустите Pomodoro с задачей, чтобы увидеть данные.';

  @override
  String get pomodoros => 'Pomodoro';

  @override
  String get focusTime => 'Время фокуса';

  @override
  String get streak => 'Серия';

  @override
  String get bestPeriod => 'Лучший период';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '1 день',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Ось Y: время фокуса в часах · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Время фокуса в минутах';

  @override
  String get sortedByHighestFocusTime =>
      'Отсортировано по наибольшему времени фокуса.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoro · $minutes мин';
  }

  @override
  String get statsNoData => 'Статистические данные пока отсутствуют.';

  @override
  String get statsLoadFailed =>
      'Не удалось загрузить статистику. Войдите в систему и проверьте подключение к интернету.';

  @override
  String get taskStatsLoadFailed => 'Не удалось загрузить статистику задач.';

  @override
  String get todayPomodorosLoadFailed =>
      'Не удалось загрузить количество Pomodoro за сегодня.';

  @override
  String get noTaskTitle => 'Без задачи';

  @override
  String calendarWeekShort(int week) {
    return 'КН $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'КН $week/$year';
  }

  @override
  String get tasksTitle => 'Задачи';

  @override
  String get tasksRefreshTooltip => 'Обновить задачи';

  @override
  String get taskSingular => 'Задача';

  @override
  String get deleteTaskTitle => 'Удалить задачу?';

  @override
  String deleteTaskMessage(String title) {
    return 'Вы действительно хотите удалить задачу «$title»?';
  }

  @override
  String get tasksLoading => 'Загрузка задач ...';

  @override
  String get tasksEmpty => 'Задач пока нет. Создайте первую задачу.';

  @override
  String get tasksSearchEmpty =>
      'Задачи не найдены. Измените поиск или фильтры.';

  @override
  String get noTimerTaskSelected => 'Задача для таймера не выбрана';

  @override
  String activeTimerTask(String title) {
    return 'Активная задача таймера: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Фаза таймера выполняется или приостановлена. Поэтому задача сейчас заблокирована.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Эта задача будет использована для следующей рабочей фазы.';

  @override
  String get withoutTask => 'Без задачи';

  @override
  String get searchTasks => 'Искать задачи';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String get filterAll => 'Все';

  @override
  String get filterOpen => 'Открытые';

  @override
  String get filterCompleted => 'Завершённые';

  @override
  String get sortLabel => 'Сортировка';

  @override
  String get sortNewest => 'Сначала новые';

  @override
  String get sortPriority => 'Приоритет';

  @override
  String get sortPomodoros => 'Pomodoro';

  @override
  String get active => 'Активна';

  @override
  String get completed => 'Завершена';

  @override
  String get locked => 'Заблокирована';

  @override
  String get forTimer => 'Для таймера';

  @override
  String get priorityLow => 'Низкий';

  @override
  String get priorityMedium => 'Средний';

  @override
  String get priorityHigh => 'Высокий';

  @override
  String get taskLoadRemoteFailed =>
      'Не удалось загрузить задачи с backend. Локальные данные будут отображаться дальше.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Задача сохранена локально, но не синхронизирована с аккаунтом.';

  @override
  String get taskSaveFailedRolledBack =>
      'Не удалось сохранить задачу. Последнее изменение было отменено.';

  @override
  String get taskDeleteFailedRestored =>
      'Не удалось удалить задачу из аккаунта. Задача была восстановлена.';

  @override
  String get taskCreateTitle => 'Создать задачу';

  @override
  String get taskEditTitle => 'Редактировать задачу';

  @override
  String get taskTitleLabel => 'Название';

  @override
  String get taskTitleRequired => 'Введите название';

  @override
  String get taskTitleTooShort => 'Название слишком короткое.';

  @override
  String get taskDescriptionLabel => 'Описание';

  @override
  String get priorityLabel => 'Приоритет';

  @override
  String get tagsLabel => 'Теги/категории';

  @override
  String get tagsHint => 'например: университет, работа, разработка';

  @override
  String get timerResetTitle => 'Сбросить таймер?';

  @override
  String get timerResetMessage =>
      'Текущая фаза будет отменена и не будет сохранена как завершённая сессия.';

  @override
  String get taskNoneSelected => 'Задача не выбрана';

  @override
  String currentTask(String title) {
    return 'Текущая задача: $title';
  }

  @override
  String get taskForWorkPhase => 'Задача для этой рабочей фазы';

  @override
  String get taskLockedToPhase => 'Эта фаза привязана к выбранной задаче.';

  @override
  String get phaseWork => 'Рабочая фаза';

  @override
  String get phaseShortBreak => 'Короткий перерыв';

  @override
  String get phaseLongBreak => 'Длинный перерыв';

  @override
  String get timerStatusSaving => 'Сохранение ...';

  @override
  String get timerStatusRunning => 'Выполняется';

  @override
  String get timerStatusPaused => 'Пауза';

  @override
  String get timerStatusReady => 'Готово';

  @override
  String get phaseDescriptionWork => 'Время фокуса';

  @override
  String get phaseDescriptionShortBreak => 'Короткое восстановление';

  @override
  String get phaseDescriptionLongBreak => 'Более длинное восстановление';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Далее: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Сегодня: загрузка ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Сегодня: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pomodoro',
      one: '1 Pomodoro',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'Пауза';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get start => 'Старт';

  @override
  String get skipPause => 'Пропустить перерыв';

  @override
  String get shortcutSpaceCompact => 'Пробел: старт/пауза';

  @override
  String get shortcutResetCompact => 'R: сброс';

  @override
  String get shortcutSkipCompact => 'S: пропустить';

  @override
  String get shortcutSpace => 'Пробел: старт/пауза';

  @override
  String get shortcutReset => 'R: сброс';

  @override
  String get shortcutSkip => 'S: пропустить перерыв';

  @override
  String get phaseSavingTitle => 'Сохранение фазы';

  @override
  String get phaseSavingDescription =>
      'Завершённая фаза сохраняется, и таймер подготавливается.';

  @override
  String get storageProblem => 'Проблема хранения';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'Завершённая фаза сохраняется в фоновом режиме.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count завершённых фаз сохраняются в фоновом режиме.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Не удалось сохранить завершённую фазу локально.';

  @override
  String get timerBackendSyncFailed =>
      'Завершённая фаза сохранена локально, но ещё не синхронизирована с backend.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed из $total';
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

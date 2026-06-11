// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Pomodoro App';

  @override
  String get navTimer => 'Timer';

  @override
  String get navTasks => 'Aufgaben';

  @override
  String get navStats => 'Statistik';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get navAccount => 'Konto';

  @override
  String get close => 'Schließen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get messageClose => 'Meldung schließen';

  @override
  String get or => 'oder';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get emailVerifiedSuccess =>
      'E-Mail erfolgreich bestätigt. Du kannst dich jetzt einloggen.';

  @override
  String get emailVerifiedExpired => 'Der Bestätigungslink ist abgelaufen.';

  @override
  String get emailVerifiedInvalid => 'Der Bestätigungslink ist ungültig.';

  @override
  String get sessionSyncOneWithAccount =>
      'Eine Sitzung wird mit deinem Konto synchronisiert.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count Sitzungen werden mit deinem Konto synchronisiert.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Eine lokale Sitzung wird nach dem Login synchronisiert.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count lokale Sitzungen werden nach dem Login synchronisiert.';
  }

  @override
  String get sessionSyncOnePending =>
      'Eine Sitzung wartet auf Synchronisierung.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count Sitzungen warten auf Synchronisierung.';
  }

  @override
  String get sessionSyncDone => 'Synchronisierung abgeschlossen.';

  @override
  String get sessionSyncFailed =>
      'Sitzungen konnten gerade nicht synchronisiert werden. Es wird später erneut versucht.';

  @override
  String get accountTitle => 'Benutzerkonto';

  @override
  String get loginTitle => 'Login';

  @override
  String get createAccountTitle => 'Neues Konto erstellen';

  @override
  String get emailPasswordLoginTitle => 'Mit E-Mail und Passwort einloggen';

  @override
  String get emailPasswordCreateTitle => 'E-Mail/Passwort-Konto erstellen';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get loginButton => 'Einloggen';

  @override
  String get createAccountButton => 'Konto erstellen';

  @override
  String get rememberSessionTitle => 'Auf diesem Gerät angemeldet bleiben';

  @override
  String get rememberSessionSubtitle =>
      'Wenn deaktiviert, bleibt die Anmeldung nur für die aktuelle App-Sitzung aktiv.';

  @override
  String get forgotPasswordButton => 'Passwort vergessen?';

  @override
  String get alreadyHaveAccount => 'Ich habe bereits ein Konto';

  @override
  String get googleSection => 'Google-Bereich';

  @override
  String get googleLoginButton => 'Mit Google einloggen';

  @override
  String get googleCreateButton => 'Mit Google Konto erstellen';

  @override
  String get googleNotConfigured => 'Google Login ist nicht konfiguriert.';

  @override
  String get googlePreparing => 'Google Login wird vorbereitet ...';

  @override
  String get googleNoIdToken =>
      'Google hat keinen gültigen ID-Token zurückgegeben.';

  @override
  String googlePrepareFailed(String error) {
    return 'Google Login konnte nicht vorbereitet werden: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google Login fehlgeschlagen: $error';
  }

  @override
  String get googleLoginSuccess => 'Erfolgreich mit Google angemeldet.';

  @override
  String get googleAccountCreated =>
      'Google-Konto wurde erstellt und du bist angemeldet.';

  @override
  String get googleWebOnly => 'Google Login ist nur in der Web-App verfügbar';

  @override
  String get githubSection => 'GitHub-Bereich';

  @override
  String get githubLoginButton => 'Mit GitHub einloggen';

  @override
  String get githubCreateButton => 'Mit GitHub Konto erstellen';

  @override
  String get githubNotConfigured => 'GitHub Login ist nicht konfiguriert.';

  @override
  String get githubCancelled =>
      'GitHub Login wurde abgebrochen oder ist fehlgeschlagen.';

  @override
  String get githubSecurityCancelled =>
      'GitHub Login wurde aus Sicherheitsgründen abgebrochen.';

  @override
  String get githubNoValidCode =>
      'GitHub hat keinen gültigen Code zurückgegeben.';

  @override
  String get githubLoginSuccess => 'Erfolgreich mit GitHub angemeldet.';

  @override
  String get githubAccountCreated =>
      'GitHub-Konto wurde erstellt und du bist angemeldet.';

  @override
  String get passwordResetTitle => 'Passwort zurücksetzen';

  @override
  String get passwordResetDescription =>
      'Gib deine E-Mail-Adresse ein. Wenn ein Konto existiert, bekommst du einen Link zum Zurücksetzen.';

  @override
  String get sendResetLink => 'Reset-Link senden';

  @override
  String get backToLogin => 'Zurück zum Login';

  @override
  String get setNewPasswordTitle => 'Neues Passwort setzen';

  @override
  String get setNewPasswordDescription =>
      'Lege ein neues Passwort für dein Konto fest.';

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get repeatNewPasswordLabel => 'Neues Passwort wiederholen';

  @override
  String get passwordsDoNotMatch => 'Die Passwörter stimmen nicht überein';

  @override
  String get savePassword => 'Passwort speichern';

  @override
  String get registrationSuccess =>
      'Registrierung erfolgreich. Bitte bestätige deine E-Mail-Adresse und logge dich danach ein.';

  @override
  String get passwordResetRequestSuccess =>
      'Wenn ein Konto mit dieser E-Mail existiert, wurde ein Reset-Link gesendet.';

  @override
  String get passwordChangedSuccess =>
      'Passwort wurde geändert. Du kannst dich jetzt einloggen.';

  @override
  String get passwordResetMailSent =>
      'Wenn das Konto existiert, wurde ein Link zum Zurücksetzen gesendet.';

  @override
  String get loginSuccess => 'Erfolgreich angemeldet.';

  @override
  String get invalidEmail => 'Bitte gültige E-Mail eingeben';

  @override
  String get passwordMinLength => 'Mindestens 8 Zeichen';

  @override
  String get loggedInTitle => 'Benutzerkonto';

  @override
  String get loggedInDescription => 'Du bist aktuell angemeldet.';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get emailStatus => 'E-Mail-Status';

  @override
  String get emailVerified => 'Bestätigt';

  @override
  String get emailNotVerified => 'Noch nicht bestätigt';

  @override
  String get accountCreated => 'Konto erstellt';

  @override
  String get synchronization => 'Synchronisierung';

  @override
  String get accountInfoWarning =>
      'Die App kann deine Sitzung automatisch wiederherstellen, wenn ein gültiger Anmeldetoken lokal gespeichert ist. Auf fremden Geräten solltest du dich immer ausloggen.';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get logout => 'Ausloggen';

  @override
  String get syncRunning => 'Synchronisierung läuft';

  @override
  String get syncOneWaiting => '1 Sitzung wartet';

  @override
  String syncManyWaiting(int count) {
    return '$count Sitzungen warten';
  }

  @override
  String get syncError => 'Fehler bei der Synchronisierung';

  @override
  String get syncAllSynced => 'Alles synchronisiert';

  @override
  String get sessionExpired =>
      'Deine Sitzung ist abgelaufen. Bitte logge dich erneut ein.';

  @override
  String get settingsSaved => 'Einstellungen gespeichert.';

  @override
  String get timerTimesTitle => 'Timer-Zeiten';

  @override
  String get timerTimesDescription =>
      'Lege fest, wie lange Arbeitsphasen und Pausen dauern.';

  @override
  String get workTime => 'Arbeitszeit';

  @override
  String get shortBreak => 'Kurze Pause';

  @override
  String get longBreak => 'Lange Pause';

  @override
  String get longBreakAfter => 'Lange Pause nach';

  @override
  String get minutes => 'Minuten';

  @override
  String get pomodorosUnit => 'Pomodoros';

  @override
  String get behaviorTitle => 'Verhalten';

  @override
  String get behaviorDescription =>
      'Passe an, wie sich der Timer während der Nutzung verhält.';

  @override
  String get autoStartNextPhase => 'Nächste Phase automatisch starten';

  @override
  String get enableSound => 'Sound aktivieren';

  @override
  String get enableVibration => 'Vibration aktivieren';

  @override
  String get vibrationDescription =>
      'Die konkrete mobile Vibration wird später über ein Plugin angebunden.';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get languageDescription =>
      'Wähle die Sprache der App. Mit „Systemsprache“ verwendet die App die Sprache des Browsers oder Geräts.';

  @override
  String get languageLabel => 'App-Sprache';

  @override
  String get languageSystem => 'Systemsprache';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageArabic => 'Arabisch';

  @override
  String get languageChinese => 'Chinesisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portugiesisch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get languageTurkish => 'Türkisch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get languageKorean => 'Koreanisch';

  @override
  String get languageIndonesian => 'Indonesisch';

  @override
  String get languagePersian => 'Persisch';

  @override
  String get appearanceTitle => 'Darstellung';

  @override
  String get appearanceDescription =>
      'Wähle Designmodus und Hauptfarbe der Anwendung.';

  @override
  String get appearanceLabel => 'Darstellung';

  @override
  String get systemTheme => 'System';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get themeColor => 'Theme-Farbe';

  @override
  String get red => 'Rot';

  @override
  String get blue => 'Blau';

  @override
  String get green => 'Grün';

  @override
  String get purple => 'Lila';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String get noChanges => 'Keine Änderungen vorhanden';

  @override
  String get decrease => 'Verringern';

  @override
  String get increase => 'Erhöhen';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Einstellungen lokal gespeichert, aber noch nicht synchronisiert.';

  @override
  String get settingsLoadRemoteFailed =>
      'Einstellungen konnten nicht vom Backend geladen werden. Lokale Einstellungen werden verwendet.';

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsRefresh => 'Aktualisieren';

  @override
  String get statsWeek => 'Woche';

  @override
  String get statsMonth => 'Monat';

  @override
  String get statsYear => 'Jahr';

  @override
  String get statsTasksTime => 'Aufgabenzeit';

  @override
  String get chartFocusPerDay => 'Fokuszeit pro Tag';

  @override
  String get chartFocusPerCalendarWeek => 'Fokuszeit pro KW';

  @override
  String get chartFocusPerMonth => 'Fokuszeit pro Monat';

  @override
  String get chartFocusPerTask => 'Fokuszeit pro Aufgabe';

  @override
  String get xAxisWeek => 'X-Achse: Tage der Woche';

  @override
  String get xAxisMonth => 'X-Achse: Kalenderwochen im Monat';

  @override
  String get xAxisYear => 'X-Achse: Monate im Jahr';

  @override
  String get xAxisTasks => 'X-Achse: Aufgaben';

  @override
  String get periodNoData => 'Zeitraum: Keine Daten vorhanden';

  @override
  String periodRange(String start, String end) {
    return 'Zeitraum: $start – $end';
  }

  @override
  String get previousPeriod => 'Vorheriger Zeitraum';

  @override
  String get nextPeriod => 'Nächster Zeitraum';

  @override
  String get statsLoading => 'Statistiken werden geladen ...';

  @override
  String get taskStatsLoading => 'Aufgabenstatistik wird geladen ...';

  @override
  String get taskStatsEmpty =>
      'Noch keine Arbeitszeit pro Aufgabe vorhanden. Starte einen Pomodoro mit Aufgabe, um Daten zu sehen.';

  @override
  String get pomodoros => 'Pomodoros';

  @override
  String get focusTime => 'Fokuszeit';

  @override
  String get streak => 'Serie';

  @override
  String get bestPeriod => 'Bester Zeitraum';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y-Achse: Fokuszeit in Stunden · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Fokuszeit in Minuten';

  @override
  String get sortedByHighestFocusTime => 'Sortiert nach höchster Fokuszeit.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoros · $minutes min';
  }

  @override
  String get statsNoData => 'Noch keine Statistikdaten vorhanden.';

  @override
  String get statsLoadFailed =>
      'Statistiken konnten nicht geladen werden. Bitte anmelden und Internetverbindung prüfen.';

  @override
  String get taskStatsLoadFailed =>
      'Aufgabenstatistik konnte nicht geladen werden.';

  @override
  String get todayPomodorosLoadFailed =>
      'Die heutige Pomodoro-Anzahl konnte nicht geladen werden.';

  @override
  String get noTaskTitle => 'Ohne Aufgabe';

  @override
  String calendarWeekShort(int week) {
    return 'KW $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'KW $week/$year';
  }

  @override
  String get tasksTitle => 'Aufgaben';

  @override
  String get tasksRefreshTooltip => 'Aufgaben aktualisieren';

  @override
  String get taskSingular => 'Aufgabe';

  @override
  String get deleteTaskTitle => 'Aufgabe löschen?';

  @override
  String deleteTaskMessage(String title) {
    return 'Möchtest du die Aufgabe „$title“ wirklich löschen?';
  }

  @override
  String get tasksLoading => 'Aufgaben werden geladen ...';

  @override
  String get tasksEmpty =>
      'Noch keine Aufgaben vorhanden. Erstelle deine erste Aufgabe.';

  @override
  String get tasksSearchEmpty =>
      'Keine Aufgaben gefunden. Passe Suche oder Filter an.';

  @override
  String get noTimerTaskSelected => 'Keine Timer-Aufgabe ausgewählt';

  @override
  String activeTimerTask(String title) {
    return 'Aktive Timer-Aufgabe: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Eine Timer-Phase läuft oder ist pausiert. Die Aufgabe ist deshalb aktuell gesperrt.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Diese Aufgabe wird für die nächste Arbeitsphase verwendet.';

  @override
  String get withoutTask => 'Ohne Aufgabe';

  @override
  String get searchTasks => 'Aufgaben suchen';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterOpen => 'Offen';

  @override
  String get filterCompleted => 'Erledigt';

  @override
  String get sortLabel => 'Sortierung';

  @override
  String get sortNewest => 'Neueste zuerst';

  @override
  String get sortPriority => 'Priorität';

  @override
  String get sortPomodoros => 'Pomodoros';

  @override
  String get active => 'Aktiv';

  @override
  String get completed => 'Erledigt';

  @override
  String get locked => 'Gesperrt';

  @override
  String get forTimer => 'Für Timer';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get priorityMedium => 'Mittel';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get taskLoadRemoteFailed =>
      'Aufgaben konnten nicht vom Backend geladen werden. Lokale Daten werden weiter angezeigt.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Aufgabe wurde lokal gespeichert, konnte aber nicht mit dem Konto synchronisiert werden.';

  @override
  String get taskSaveFailedRolledBack =>
      'Aufgabe konnte nicht gespeichert werden. Die letzte Änderung wurde zurückgenommen.';

  @override
  String get taskDeleteFailedRestored =>
      'Aufgabe konnte nicht im Konto gelöscht werden. Die Aufgabe wurde wiederhergestellt.';

  @override
  String get taskCreateTitle => 'Aufgabe erstellen';

  @override
  String get taskEditTitle => 'Aufgabe bearbeiten';

  @override
  String get taskTitleLabel => 'Titel';

  @override
  String get taskTitleRequired => 'Bitte Titel eingeben';

  @override
  String get taskTitleTooShort => 'Der Titel ist zu kurz.';

  @override
  String get taskDescriptionLabel => 'Beschreibung';

  @override
  String get priorityLabel => 'Priorität';

  @override
  String get tagsLabel => 'Tags/Kategorien';

  @override
  String get tagsHint => 'z. B. Uni, Arbeit, Entwicklung';

  @override
  String get timerResetTitle => 'Timer zurücksetzen?';

  @override
  String get timerResetMessage =>
      'Die aktuelle Phase wird abgebrochen und nicht als abgeschlossene Sitzung gespeichert.';

  @override
  String get taskNoneSelected => 'Keine Aufgabe ausgewählt';

  @override
  String currentTask(String title) {
    return 'Aktuelle Aufgabe: $title';
  }

  @override
  String get taskForWorkPhase => 'Aufgabe für diese Arbeitsphase';

  @override
  String get taskLockedToPhase =>
      'Diese Phase ist fest mit der ausgewählten Aufgabe verbunden.';

  @override
  String get phaseWork => 'Arbeitsphase';

  @override
  String get phaseShortBreak => 'Kurze Pause';

  @override
  String get phaseLongBreak => 'Lange Pause';

  @override
  String get timerStatusSaving => 'Speichern ...';

  @override
  String get timerStatusRunning => 'Läuft';

  @override
  String get timerStatusPaused => 'Pausiert';

  @override
  String get timerStatusReady => 'Bereit';

  @override
  String get phaseDescriptionWork => 'Fokuszeit';

  @override
  String get phaseDescriptionShortBreak => 'Kurze Erholung';

  @override
  String get phaseDescriptionLongBreak => 'Längere Erholung';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Danach: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Heute: wird geladen ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Heute: $pomodoros';
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
  String get continueButton => 'Fortsetzen';

  @override
  String get start => 'Start';

  @override
  String get skipPause => 'Pause überspringen';

  @override
  String get shortcutSpaceCompact => 'Space: Start/Pause';

  @override
  String get shortcutResetCompact => 'R: Reset';

  @override
  String get shortcutSkipCompact => 'S: Skip';

  @override
  String get shortcutSpace => 'Leertaste: Start/Pause';

  @override
  String get shortcutReset => 'R: Zurücksetzen';

  @override
  String get shortcutSkip => 'S: Pause überspringen';

  @override
  String get phaseSavingTitle => 'Phase wird gespeichert';

  @override
  String get phaseSavingDescription =>
      'Die abgeschlossene Phase wird gespeichert und der Timer wird vorbereitet.';

  @override
  String get storageProblem => 'Speicherproblem';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'Abgeschlossene Phase wird im Hintergrund gespeichert.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count abgeschlossene Phasen werden im Hintergrund gespeichert.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Die abgeschlossene Phase konnte nicht lokal gespeichert werden.';

  @override
  String get timerBackendSyncFailed =>
      'Die abgeschlossene Phase wurde lokal gespeichert, aber noch nicht mit dem Backend synchronisiert.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed von $total';
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

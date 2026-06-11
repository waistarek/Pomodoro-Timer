// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Time2Focus';

  @override
  String get navTimer => 'Timer';

  @override
  String get navTasks => 'Attività';

  @override
  String get navStats => 'Statistiche';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get navAccount => 'Account';

  @override
  String get close => 'Chiudi';

  @override
  String get retry => 'Riprova';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get edit => 'Modifica';

  @override
  String get save => 'Salva';

  @override
  String get reset => 'Reimposta';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get messageClose => 'Chiudi messaggio';

  @override
  String get or => 'oppure';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get emailVerifiedSuccess =>
      'E-mail verificata con successo. Ora puoi accedere.';

  @override
  String get emailVerifiedExpired => 'Il link di verifica è scaduto.';

  @override
  String get emailVerifiedInvalid => 'Il link di verifica non è valido.';

  @override
  String get sessionSyncOneWithAccount =>
      'Una sessione viene sincronizzata con il tuo account.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sessioni vengono sincronizzate con il tuo account.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Una sessione locale verrà sincronizzata dopo l’accesso.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count sessioni locali verranno sincronizzate dopo l’accesso.';
  }

  @override
  String get sessionSyncOnePending =>
      'Una sessione è in attesa di sincronizzazione.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sessioni sono in attesa di sincronizzazione.';
  }

  @override
  String get sessionSyncDone => 'Sincronizzazione completata.';

  @override
  String get sessionSyncFailed =>
      'Al momento non è stato possibile sincronizzare le sessioni. L’app riproverà più tardi.';

  @override
  String get accountTitle => 'Account utente';

  @override
  String get loginTitle => 'Accesso';

  @override
  String get createAccountTitle => 'Crea nuovo account';

  @override
  String get emailPasswordLoginTitle => 'Accedi con e-mail e password';

  @override
  String get emailPasswordCreateTitle => 'Crea account con e-mail e password';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Accedi';

  @override
  String get createAccountButton => 'Crea account';

  @override
  String get rememberSessionTitle => 'Rimani connesso su questo dispositivo';

  @override
  String get rememberSessionSubtitle =>
      'Se disattivato, l’accesso resta attivo solo per la sessione corrente dell’app.';

  @override
  String get forgotPasswordButton => 'Password dimenticata?';

  @override
  String get alreadyHaveAccount => 'Ho già un account';

  @override
  String get googleSection => 'Sezione Google';

  @override
  String get googleLoginButton => 'Accedi con Google';

  @override
  String get googleCreateButton => 'Crea account con Google';

  @override
  String get googleNotConfigured => 'L’accesso con Google non è configurato.';

  @override
  String get googlePreparing => 'Preparazione dell’accesso con Google ...';

  @override
  String get googleNoIdToken => 'Google non ha restituito un token ID valido.';

  @override
  String googlePrepareFailed(String error) {
    return 'Non è stato possibile preparare l’accesso con Google: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Accesso con Google non riuscito: $error';
  }

  @override
  String get googleLoginSuccess => 'Accesso con Google riuscito.';

  @override
  String get googleAccountCreated =>
      'L’account Google è stato creato e hai effettuato l’accesso.';

  @override
  String get googleWebOnly =>
      'L’accesso con Google è disponibile solo nell’app web';

  @override
  String get githubSection => 'Sezione GitHub';

  @override
  String get githubLoginButton => 'Accedi con GitHub';

  @override
  String get githubCreateButton => 'Crea account con GitHub';

  @override
  String get githubNotConfigured => 'L’accesso con GitHub non è configurato.';

  @override
  String get githubCancelled =>
      'L’accesso con GitHub è stato annullato o non è riuscito.';

  @override
  String get githubSecurityCancelled =>
      'L’accesso con GitHub è stato annullato per motivi di sicurezza.';

  @override
  String get githubNoValidCode => 'GitHub non ha restituito un codice valido.';

  @override
  String get githubLoginSuccess => 'Accesso con GitHub riuscito.';

  @override
  String get githubAccountCreated =>
      'L’account GitHub è stato creato e hai effettuato l’accesso.';

  @override
  String get passwordResetTitle => 'Reimposta password';

  @override
  String get passwordResetDescription =>
      'Inserisci il tuo indirizzo e-mail. Se esiste un account, riceverai un link per reimpostare la password.';

  @override
  String get sendResetLink => 'Invia link di reimpostazione';

  @override
  String get backToLogin => 'Torna all’accesso';

  @override
  String get setNewPasswordTitle => 'Imposta nuova password';

  @override
  String get setNewPasswordDescription =>
      'Imposta una nuova password per il tuo account.';

  @override
  String get newPasswordLabel => 'Nuova password';

  @override
  String get repeatNewPasswordLabel => 'Ripeti nuova password';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get savePassword => 'Salva password';

  @override
  String get registrationSuccess =>
      'Registrazione riuscita. Verifica il tuo indirizzo e-mail e poi accedi.';

  @override
  String get passwordResetRequestSuccess =>
      'Se esiste un account con questa e-mail, è stato inviato un link di reimpostazione.';

  @override
  String get passwordChangedSuccess =>
      'La password è stata modificata. Ora puoi accedere.';

  @override
  String get passwordResetMailSent =>
      'Se l’account esiste, è stato inviato un link di reimpostazione.';

  @override
  String get loginSuccess => 'Accesso riuscito.';

  @override
  String get invalidEmail => 'Inserisci un indirizzo e-mail valido';

  @override
  String get passwordMinLength => 'Almeno 8 caratteri';

  @override
  String get loggedInTitle => 'Account utente';

  @override
  String get loggedInDescription => 'Al momento hai effettuato l’accesso.';

  @override
  String get emailAddress => 'Indirizzo e-mail';

  @override
  String get emailStatus => 'Stato e-mail';

  @override
  String get emailVerified => 'Verificata';

  @override
  String get emailNotVerified => 'Non ancora verificata';

  @override
  String get accountCreated => 'Account creato';

  @override
  String get synchronization => 'Sincronizzazione';

  @override
  String get accountInfoWarning =>
      'L’app può ripristinare automaticamente la tua sessione se un token di accesso valido è salvato localmente. Su dispositivi condivisi dovresti sempre disconnetterti.';

  @override
  String get changePassword => 'Cambia password';

  @override
  String get logout => 'Esci';

  @override
  String get syncRunning => 'Sincronizzazione in corso';

  @override
  String get syncOneWaiting => '1 sessione in attesa';

  @override
  String syncManyWaiting(int count) {
    return '$count sessioni in attesa';
  }

  @override
  String get syncError => 'Errore di sincronizzazione';

  @override
  String get syncAllSynced => 'Tutto sincronizzato';

  @override
  String get sessionExpired => 'La tua sessione è scaduta. Accedi di nuovo.';

  @override
  String get settingsSaved => 'Impostazioni salvate.';

  @override
  String get timerTimesTitle => 'Durate del timer';

  @override
  String get timerTimesDescription =>
      'Definisci la durata delle fasi di lavoro e delle pause.';

  @override
  String get workTime => 'Tempo di lavoro';

  @override
  String get shortBreak => 'Pausa breve';

  @override
  String get longBreak => 'Pausa lunga';

  @override
  String get longBreakAfter => 'Pausa lunga dopo';

  @override
  String get minutes => 'Minuti';

  @override
  String get pomodorosUnit => 'Pomodori';

  @override
  String get behaviorTitle => 'Comportamento';

  @override
  String get behaviorDescription =>
      'Personalizza il comportamento del timer durante l’utilizzo.';

  @override
  String get autoStartNextPhase => 'Avvia automaticamente la fase successiva';

  @override
  String get enableSound => 'Attiva suono';

  @override
  String get enableVibration => 'Attiva vibrazione';

  @override
  String get vibrationDescription =>
      'La vibrazione mobile effettiva verrà collegata più avanti tramite un plugin.';

  @override
  String get languageTitle => 'Lingua';

  @override
  String get languageDescription =>
      'Scegli la lingua dell’app. Con “Lingua di sistema”, l’app usa la lingua del browser o del dispositivo.';

  @override
  String get languageLabel => 'Lingua dell’app';

  @override
  String get languageSystem => 'Lingua di sistema';

  @override
  String get languageGerman => 'Tedesco';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageArabic => 'Arabo';

  @override
  String get languageChinese => 'Cinese';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portoghese';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageJapanese => 'Giapponese';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageIndonesian => 'Indonesiano';

  @override
  String get languagePersian => 'Persiano';

  @override
  String get appearanceTitle => 'Aspetto';

  @override
  String get appearanceDescription =>
      'Scegli la modalità di visualizzazione e il colore principale dell’app.';

  @override
  String get appearanceLabel => 'Aspetto';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightMode => 'Modalità chiara';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get themeColor => 'Colore tema';

  @override
  String get red => 'Rosso';

  @override
  String get blue => 'Blu';

  @override
  String get green => 'Verde';

  @override
  String get purple => 'Viola';

  @override
  String get saveSettings => 'Salva impostazioni';

  @override
  String get noChanges => 'Nessuna modifica disponibile';

  @override
  String get decrease => 'Diminuisci';

  @override
  String get increase => 'Aumenta';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Impostazioni salvate localmente, ma non ancora sincronizzate.';

  @override
  String get settingsLoadRemoteFailed =>
      'Non è stato possibile caricare le impostazioni dal backend. Verranno usate le impostazioni locali.';

  @override
  String get statsTitle => 'Statistiche';

  @override
  String get statsRefresh => 'Aggiorna';

  @override
  String get statsWeek => 'Settimana';

  @override
  String get statsMonth => 'Mese';

  @override
  String get statsYear => 'Anno';

  @override
  String get statsTasksTime => 'Tempo per attività';

  @override
  String get chartFocusPerDay => 'Tempo di concentrazione per giorno';

  @override
  String get chartFocusPerCalendarWeek =>
      'Tempo di concentrazione per settimana di calendario';

  @override
  String get chartFocusPerMonth => 'Tempo di concentrazione per mese';

  @override
  String get chartFocusPerTask => 'Tempo di concentrazione per attività';

  @override
  String get xAxisWeek => 'Asse X: giorni della settimana';

  @override
  String get xAxisMonth => 'Asse X: settimane di calendario nel mese';

  @override
  String get xAxisYear => 'Asse X: mesi dell’anno';

  @override
  String get xAxisTasks => 'Asse X: attività';

  @override
  String get periodNoData => 'Periodo: nessun dato disponibile';

  @override
  String periodRange(String start, String end) {
    return 'Periodo: $start – $end';
  }

  @override
  String get previousPeriod => 'Periodo precedente';

  @override
  String get nextPeriod => 'Periodo successivo';

  @override
  String get statsLoading => 'Caricamento statistiche ...';

  @override
  String get taskStatsLoading => 'Caricamento statistiche attività ...';

  @override
  String get taskStatsEmpty =>
      'Non è ancora disponibile tempo di lavoro per attività. Avvia un Pomodoro con un’attività per vedere i dati.';

  @override
  String get pomodoros => 'Pomodori';

  @override
  String get focusTime => 'Tempo di concentrazione';

  @override
  String get streak => 'Serie';

  @override
  String get bestPeriod => 'Periodo migliore';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Asse Y: tempo di concentrazione in ore · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Tempo di concentrazione in minuti';

  @override
  String get sortedByHighestFocusTime =>
      'Ordinato per tempo di concentrazione più alto.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodori · $minutes min';
  }

  @override
  String get statsNoData => 'Non sono ancora disponibili dati statistici.';

  @override
  String get statsLoadFailed =>
      'Non è stato possibile caricare le statistiche. Accedi e controlla la connessione Internet.';

  @override
  String get taskStatsLoadFailed =>
      'Non è stato possibile caricare le statistiche delle attività.';

  @override
  String get todayPomodorosLoadFailed =>
      'Non è stato possibile caricare il numero di Pomodori di oggi.';

  @override
  String get noTaskTitle => 'Senza attività';

  @override
  String calendarWeekShort(int week) {
    return 'Sett. $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'Sett. $week/$year';
  }

  @override
  String get tasksTitle => 'Attività';

  @override
  String get tasksRefreshTooltip => 'Aggiorna attività';

  @override
  String get taskSingular => 'Attività';

  @override
  String get deleteTaskTitle => 'Eliminare attività?';

  @override
  String deleteTaskMessage(String title) {
    return 'Vuoi davvero eliminare l’attività “$title”?';
  }

  @override
  String get tasksLoading => 'Caricamento attività ...';

  @override
  String get tasksEmpty =>
      'Non ci sono ancora attività. Crea la tua prima attività.';

  @override
  String get tasksSearchEmpty =>
      'Nessuna attività trovata. Modifica la ricerca o i filtri.';

  @override
  String get noTimerTaskSelected => 'Nessuna attività selezionata per il timer';

  @override
  String activeTimerTask(String title) {
    return 'Attività attiva del timer: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Una fase del timer è in corso o in pausa. L’attività è quindi attualmente bloccata.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Questa attività verrà usata per la prossima fase di lavoro.';

  @override
  String get withoutTask => 'Senza attività';

  @override
  String get searchTasks => 'Cerca attività';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get filterAll => 'Tutte';

  @override
  String get filterOpen => 'Aperte';

  @override
  String get filterCompleted => 'Completate';

  @override
  String get sortLabel => 'Ordinamento';

  @override
  String get sortNewest => 'Più recenti prima';

  @override
  String get sortPriority => 'Priorità';

  @override
  String get sortPomodoros => 'Pomodori';

  @override
  String get active => 'Attiva';

  @override
  String get completed => 'Completata';

  @override
  String get locked => 'Bloccata';

  @override
  String get forTimer => 'Per il timer';

  @override
  String get priorityLow => 'Bassa';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get taskLoadRemoteFailed =>
      'Non è stato possibile caricare le attività dal backend. I dati locali continueranno a essere mostrati.';

  @override
  String get taskSavedLocallyNotSynced =>
      'L’attività è stata salvata localmente, ma non è stato possibile sincronizzarla con l’account.';

  @override
  String get taskSaveFailedRolledBack =>
      'Non è stato possibile salvare l’attività. L’ultima modifica è stata annullata.';

  @override
  String get taskDeleteFailedRestored =>
      'Non è stato possibile eliminare l’attività dall’account. L’attività è stata ripristinata.';

  @override
  String get taskCreateTitle => 'Crea attività';

  @override
  String get taskEditTitle => 'Modifica attività';

  @override
  String get taskTitleLabel => 'Titolo';

  @override
  String get taskTitleRequired => 'Inserisci un titolo';

  @override
  String get taskTitleTooShort => 'Il titolo è troppo breve.';

  @override
  String get taskDescriptionLabel => 'Descrizione';

  @override
  String get priorityLabel => 'Priorità';

  @override
  String get tagsLabel => 'Tag/categorie';

  @override
  String get tagsHint => 'ad es. università, lavoro, sviluppo';

  @override
  String get timerResetTitle => 'Reimpostare il timer?';

  @override
  String get timerResetMessage =>
      'La fase corrente verrà annullata e non verrà salvata come sessione completata.';

  @override
  String get taskNoneSelected => 'Nessuna attività selezionata';

  @override
  String currentTask(String title) {
    return 'Attività corrente: $title';
  }

  @override
  String get taskForWorkPhase => 'Attività per questa fase di lavoro';

  @override
  String get taskLockedToPhase =>
      'Questa fase è collegata all’attività selezionata.';

  @override
  String get phaseWork => 'Fase di lavoro';

  @override
  String get phaseShortBreak => 'Pausa breve';

  @override
  String get phaseLongBreak => 'Pausa lunga';

  @override
  String get timerStatusSaving => 'Salvataggio ...';

  @override
  String get timerStatusRunning => 'In esecuzione';

  @override
  String get timerStatusPaused => 'In pausa';

  @override
  String get timerStatusReady => 'Pronto';

  @override
  String get phaseDescriptionWork => 'Tempo di concentrazione';

  @override
  String get phaseDescriptionShortBreak => 'Recupero breve';

  @override
  String get phaseDescriptionLongBreak => 'Recupero più lungo';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Dopo: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Oggi: caricamento ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Oggi: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pomodori',
      one: '1 Pomodoro',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'Pausa';

  @override
  String get continueButton => 'Continua';

  @override
  String get start => 'Avvia';

  @override
  String get skipPause => 'Salta pausa';

  @override
  String get shortcutSpaceCompact => 'Spazio: avvia/pausa';

  @override
  String get shortcutResetCompact => 'R: reimposta';

  @override
  String get shortcutSkipCompact => 'S: salta';

  @override
  String get shortcutSpace => 'Barra spaziatrice: avvia/pausa';

  @override
  String get shortcutReset => 'R: reimposta';

  @override
  String get shortcutSkip => 'S: salta pausa';

  @override
  String get phaseSavingTitle => 'Salvataggio fase';

  @override
  String get phaseSavingDescription =>
      'La fase completata viene salvata e il timer viene preparato.';

  @override
  String get storageProblem => 'Problema di archiviazione';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'La fase completata viene salvata in background.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count fasi completate vengono salvate in background.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Non è stato possibile salvare localmente la fase completata.';

  @override
  String get timerBackendSyncFailed =>
      'La fase completata è stata salvata localmente, ma non è ancora stata sincronizzata con il backend.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed di $total';
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
  String get landingLogoSemantics => 'Logo Time2Focus e area iniziale';

  @override
  String get landingLoginButton => 'Accedi';

  @override
  String get landingHeroBadge => 'Timer Pomodoro e app per la concentrazione';

  @override
  String get landingHeroTitle =>
      'Lavora con più concentrazione usando Time2Focus';

  @override
  String get landingHeroDescription =>
      'Time2Focus è un\'app timer Pomodoro per sessioni di concentrazione, gestione delle attività e maggiore produttività. Pianifica periodi di lavoro concentrato, rispetta le pause e tieni sotto controllo i tuoi progressi.';

  @override
  String get landingPrimaryCta => 'Avvia timer Pomodoro';

  @override
  String get landingSecondaryCta => 'Crea account o accedi';

  @override
  String get landingHeroHint =>
      'Usalo direttamente nel browser. Inizia senza installazione e sincronizza i dati con il tuo account quando necessario.';

  @override
  String get landingPreviewSemantics =>
      'Anteprima dell\'app Time2Focus con timer, attività e statistiche';

  @override
  String get landingPreviewLabel => 'Anteprima app';

  @override
  String get landingPreviewTitle =>
      'La tua prossima sessione di concentrazione';

  @override
  String get landingPreviewPhase => 'Tempo di concentrazione';

  @override
  String get landingPreviewTask => 'Collega attività';

  @override
  String get landingPreviewBreak => 'Pianifica pause';

  @override
  String get landingPreviewStats => 'Vedi progressi';

  @override
  String get landingFeaturesSectionTitle =>
      'Tutto ciò che serve per lavorare con concentrazione';

  @override
  String get landingFeaturesSectionSubtitle =>
      'Time2Focus combina timer Pomodoro, attività e statistiche di produttività in una web app chiara e senza distrazioni inutili.';

  @override
  String get landingFeatureTimerTitle =>
      'Timer Pomodoro per sessioni di concentrazione chiare';

  @override
  String get landingFeatureTimerText =>
      'Lavora a intervalli definiti con fasi di concentrazione, pause brevi e pause lunghe. Così puoi pianificare meglio il focus e strutturare la giornata lavorativa.';

  @override
  String get landingFeatureTasksTitle =>
      'Gestione delle attività per il tuo lavoro';

  @override
  String get landingFeatureTasksText =>
      'Collega le sessioni di concentrazione ad attività specifiche. In seguito potrai vedere più chiaramente come hai usato il tuo tempo di lavoro concentrato.';

  @override
  String get landingFeatureStatsTitle => 'Statistiche di produttività chiare';

  @override
  String get landingFeatureStatsText =>
      'Analizza il tempo di concentrazione completato, i Pomodoro e il tempo dedicato alle attività. Questo ti aiuta a riconoscere progressi, routine e schemi di lavoro produttivi.';

  @override
  String get landingHowItWorksTitle => 'Come funziona Time2Focus';

  @override
  String get landingHowItWorksSubtitle =>
      'Il flusso rimane volutamente semplice: scegli un\'attività, avvia una sessione di concentrazione e controlla i progressi dopo il lavoro.';

  @override
  String get landingStepOneTitle => 'Prepara un\'attività';

  @override
  String get landingStepOneText =>
      'Crea un\'attività o inizia direttamente senza attività. Time2Focus supporta entrambi i modi di lavorare.';

  @override
  String get landingStepTwoTitle => 'Avvia una sessione di concentrazione';

  @override
  String get landingStepTwoText =>
      'Avvia il timer Pomodoro e lavora con concentrazione fino alla pausa successiva. L\'app ti guida attraverso le fasi di lavoro e pausa.';

  @override
  String get landingStepThreeTitle => 'Controlla i progressi';

  @override
  String get landingStepThreeText =>
      'Usa le statistiche per comprendere meglio il tempo di concentrazione, i Pomodoro completati e il tempo dedicato alle attività.';

  @override
  String get landingFaqTitle => 'Domande frequenti';

  @override
  String get landingFaqSubtitle =>
      'Risposte brevi per i nuovi utenti che vogliono provare prima Time2Focus.';

  @override
  String get landingFaqOneQuestion => 'Posso usare Time2Focus senza account?';

  @override
  String get landingFaqOneAnswer =>
      'Sì. Puoi usare il timer direttamente nel browser. Un account è utile se vuoi sincronizzare i dati in seguito e usarli su più dispositivi.';

  @override
  String get landingFaqTwoQuestion => 'Time2Focus è solo un timer Pomodoro?';

  @override
  String get landingFaqTwoAnswer =>
      'No. Time2Focus combina timer Pomodoro, sessioni di concentrazione, gestione delle attività e statistiche, così puoi collegare meglio lavoro e progressi.';

  @override
  String get landingFaqThreeQuestion => 'Time2Focus funziona su smartphone?';

  @override
  String get landingFaqThreeAnswer =>
      'Sì. La web app è responsive e può essere usata nel browser su desktop, tablet e smartphone.';

  @override
  String get landingFooter =>
      'Time2Focus – timer Pomodoro e app per la concentrazione per lavorare con più focus.';
}

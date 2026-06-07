// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'App Pomodoro';

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
}

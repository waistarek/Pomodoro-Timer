// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application Pomodoro';

  @override
  String get navTimer => 'Minuteur';

  @override
  String get navTasks => 'Tâches';

  @override
  String get navStats => 'Statistiques';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navAccount => 'Compte';

  @override
  String get close => 'Fermer';

  @override
  String get retry => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get save => 'Enregistrer';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get refresh => 'Actualiser';

  @override
  String get messageClose => 'Fermer le message';

  @override
  String get or => 'ou';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get emailVerifiedSuccess =>
      'E-mail confirmé avec succès. Tu peux maintenant te connecter.';

  @override
  String get emailVerifiedExpired => 'Le lien de confirmation a expiré.';

  @override
  String get emailVerifiedInvalid => 'Le lien de confirmation est invalide.';

  @override
  String get sessionSyncOneWithAccount =>
      'Une session est synchronisée avec ton compte.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sessions sont synchronisées avec ton compte.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Une session locale sera synchronisée après la connexion.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count sessions locales seront synchronisées après la connexion.';
  }

  @override
  String get sessionSyncOnePending => 'Une session attend la synchronisation.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sessions attendent la synchronisation.';
  }

  @override
  String get sessionSyncDone => 'Synchronisation terminée.';

  @override
  String get sessionSyncFailed =>
      'Les sessions n’ont pas pu être synchronisées pour le moment. Une nouvelle tentative aura lieu plus tard.';

  @override
  String get accountTitle => 'Compte utilisateur';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get createAccountTitle => 'Créer un nouveau compte';

  @override
  String get emailPasswordLoginTitle =>
      'Se connecter avec e-mail et mot de passe';

  @override
  String get emailPasswordCreateTitle => 'Créer un compte e-mail/mot de passe';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get createAccountButton => 'Créer un compte';

  @override
  String get rememberSessionTitle => 'Rester connecté sur cet appareil';

  @override
  String get rememberSessionSubtitle =>
      'Si cette option est désactivée, la connexion reste active uniquement pour la session actuelle de l’application.';

  @override
  String get forgotPasswordButton => 'Mot de passe oublié ?';

  @override
  String get alreadyHaveAccount => 'J’ai déjà un compte';

  @override
  String get googleSection => 'Section Google';

  @override
  String get googleLoginButton => 'Se connecter avec Google';

  @override
  String get googleCreateButton => 'Créer un compte avec Google';

  @override
  String get googleNotConfigured => 'La connexion Google n’est pas configurée.';

  @override
  String get googlePreparing => 'Préparation de la connexion Google ...';

  @override
  String get googleNoIdToken => 'Google n’a pas renvoyé de jeton ID valide.';

  @override
  String googlePrepareFailed(String error) {
    return 'La connexion Google n’a pas pu être préparée : $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Échec de la connexion Google : $error';
  }

  @override
  String get googleLoginSuccess => 'Connexion avec Google réussie.';

  @override
  String get googleAccountCreated =>
      'Le compte Google a été créé et tu es connecté.';

  @override
  String get googleWebOnly =>
      'La connexion Google est disponible uniquement dans l’application web';

  @override
  String get githubSection => 'Section GitHub';

  @override
  String get githubLoginButton => 'Se connecter avec GitHub';

  @override
  String get githubCreateButton => 'Créer un compte avec GitHub';

  @override
  String get githubNotConfigured => 'La connexion GitHub n’est pas configurée.';

  @override
  String get githubCancelled =>
      'La connexion GitHub a été annulée ou a échoué.';

  @override
  String get githubSecurityCancelled =>
      'La connexion GitHub a été annulée pour des raisons de sécurité.';

  @override
  String get githubNoValidCode => 'GitHub n’a pas renvoyé de code valide.';

  @override
  String get githubLoginSuccess => 'Connexion avec GitHub réussie.';

  @override
  String get githubAccountCreated =>
      'Le compte GitHub a été créé et tu es connecté.';

  @override
  String get passwordResetTitle => 'Réinitialiser le mot de passe';

  @override
  String get passwordResetDescription =>
      'Saisis ton adresse e-mail. Si un compte existe, tu recevras un lien de réinitialisation.';

  @override
  String get sendResetLink => 'Envoyer le lien de réinitialisation';

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get setNewPasswordTitle => 'Définir un nouveau mot de passe';

  @override
  String get setNewPasswordDescription =>
      'Définis un nouveau mot de passe pour ton compte.';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get repeatNewPasswordLabel => 'Répéter le nouveau mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get savePassword => 'Enregistrer le mot de passe';

  @override
  String get registrationSuccess =>
      'Inscription réussie. Confirme ton adresse e-mail, puis connecte-toi.';

  @override
  String get passwordResetRequestSuccess =>
      'Si un compte avec cet e-mail existe, un lien de réinitialisation a été envoyé.';

  @override
  String get passwordChangedSuccess =>
      'Le mot de passe a été modifié. Tu peux maintenant te connecter.';

  @override
  String get passwordResetMailSent =>
      'Si le compte existe, un lien de réinitialisation a été envoyé.';

  @override
  String get loginSuccess => 'Connexion réussie.';

  @override
  String get invalidEmail => 'Veuillez saisir une adresse e-mail valide';

  @override
  String get passwordMinLength => 'Au moins 8 caractères';

  @override
  String get loggedInTitle => 'Compte utilisateur';

  @override
  String get loggedInDescription => 'Tu es actuellement connecté.';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get emailStatus => 'Statut de l’e-mail';

  @override
  String get emailVerified => 'Confirmé';

  @override
  String get emailNotVerified => 'Pas encore confirmé';

  @override
  String get accountCreated => 'Compte créé';

  @override
  String get synchronization => 'Synchronisation';

  @override
  String get accountInfoWarning =>
      'L’application peut restaurer automatiquement ta session si un jeton de connexion valide est stocké localement. Sur les appareils partagés, tu dois toujours te déconnecter.';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get syncRunning => 'Synchronisation en cours';

  @override
  String get syncOneWaiting => '1 session en attente';

  @override
  String syncManyWaiting(int count) {
    return '$count sessions en attente';
  }

  @override
  String get syncError => 'Erreur de synchronisation';

  @override
  String get syncAllSynced => 'Tout est synchronisé';

  @override
  String get sessionExpired => 'Ta session a expiré. Connecte-toi à nouveau.';

  @override
  String get settingsSaved => 'Paramètres enregistrés.';

  @override
  String get timerTimesTitle => 'Durées du minuteur';

  @override
  String get timerTimesDescription =>
      'Définis la durée des phases de travail et des pauses.';

  @override
  String get workTime => 'Temps de travail';

  @override
  String get shortBreak => 'Courte pause';

  @override
  String get longBreak => 'Longue pause';

  @override
  String get longBreakAfter => 'Longue pause après';

  @override
  String get minutes => 'Minutes';

  @override
  String get pomodorosUnit => 'Pomodoros';

  @override
  String get behaviorTitle => 'Comportement';

  @override
  String get behaviorDescription =>
      'Personnalise le comportement du minuteur pendant l’utilisation.';

  @override
  String get autoStartNextPhase => 'Démarrer automatiquement la phase suivante';

  @override
  String get enableSound => 'Activer le son';

  @override
  String get enableVibration => 'Activer la vibration';

  @override
  String get vibrationDescription =>
      'La vibration mobile réelle sera ajoutée plus tard via un plugin.';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageDescription =>
      'Choisis la langue de l’application. Avec « Langue du système », l’application utilise la langue du navigateur ou de l’appareil.';

  @override
  String get languageLabel => 'Langue de l’application';

  @override
  String get languageSystem => 'Langue du système';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageArabic => 'Arabe';

  @override
  String get languageChinese => 'Chinois';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portugais';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageKorean => 'Coréen';

  @override
  String get languageIndonesian => 'Indonésien';

  @override
  String get languagePersian => 'Persan';

  @override
  String get appearanceTitle => 'Apparence';

  @override
  String get appearanceDescription =>
      'Choisis le mode d’affichage et la couleur principale de l’application.';

  @override
  String get appearanceLabel => 'Apparence';

  @override
  String get systemTheme => 'Système';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get themeColor => 'Couleur du thème';

  @override
  String get red => 'Rouge';

  @override
  String get blue => 'Bleu';

  @override
  String get green => 'Vert';

  @override
  String get purple => 'Violet';

  @override
  String get saveSettings => 'Enregistrer les paramètres';

  @override
  String get noChanges => 'Aucune modification disponible';

  @override
  String get decrease => 'Diminuer';

  @override
  String get increase => 'Augmenter';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Paramètres enregistrés localement, mais pas encore synchronisés.';

  @override
  String get settingsLoadRemoteFailed =>
      'Les paramètres n’ont pas pu être chargés depuis le backend. Les paramètres locaux sont utilisés.';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get statsRefresh => 'Actualiser';

  @override
  String get statsWeek => 'Semaine';

  @override
  String get statsMonth => 'Mois';

  @override
  String get statsYear => 'Année';

  @override
  String get statsTasksTime => 'Temps par tâche';

  @override
  String get chartFocusPerDay => 'Temps de concentration par jour';

  @override
  String get chartFocusPerCalendarWeek =>
      'Temps de concentration par semaine calendaire';

  @override
  String get chartFocusPerMonth => 'Temps de concentration par mois';

  @override
  String get chartFocusPerTask => 'Temps de concentration par tâche';

  @override
  String get xAxisWeek => 'Axe X : jours de la semaine';

  @override
  String get xAxisMonth => 'Axe X : semaines calendaires du mois';

  @override
  String get xAxisYear => 'Axe X : mois de l’année';

  @override
  String get xAxisTasks => 'Axe X : tâches';

  @override
  String get periodNoData => 'Période : aucune donnée disponible';

  @override
  String periodRange(String start, String end) {
    return 'Période : $start – $end';
  }

  @override
  String get previousPeriod => 'Période précédente';

  @override
  String get nextPeriod => 'Période suivante';

  @override
  String get statsLoading => 'Chargement des statistiques ...';

  @override
  String get taskStatsLoading => 'Chargement des statistiques des tâches ...';

  @override
  String get taskStatsEmpty =>
      'Aucun temps de travail par tâche disponible pour le moment. Lance un Pomodoro avec une tâche pour voir des données.';

  @override
  String get pomodoros => 'Pomodoros';

  @override
  String get focusTime => 'Temps de concentration';

  @override
  String get streak => 'Série';

  @override
  String get bestPeriod => 'Meilleure période';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Axe Y : temps de concentration en heures · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Temps de concentration en minutes';

  @override
  String get sortedByHighestFocusTime =>
      'Trié par temps de concentration le plus élevé.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoros · $minutes min';
  }

  @override
  String get statsNoData =>
      'Aucune donnée statistique disponible pour le moment.';

  @override
  String get statsLoadFailed =>
      'Les statistiques n’ont pas pu être chargées. Connecte-toi et vérifie ta connexion Internet.';

  @override
  String get taskStatsLoadFailed =>
      'Les statistiques des tâches n’ont pas pu être chargées.';

  @override
  String get todayPomodorosLoadFailed =>
      'Le nombre de Pomodoros d’aujourd’hui n’a pas pu être chargé.';

  @override
  String get noTaskTitle => 'Sans tâche';

  @override
  String calendarWeekShort(int week) {
    return 'SC $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'SC $week/$year';
  }

  @override
  String get tasksTitle => 'Tâches';

  @override
  String get tasksRefreshTooltip => 'Actualiser les tâches';

  @override
  String get taskSingular => 'Tâche';

  @override
  String get deleteTaskTitle => 'Supprimer la tâche ?';

  @override
  String deleteTaskMessage(String title) {
    return 'Veux-tu vraiment supprimer la tâche « $title » ?';
  }

  @override
  String get tasksLoading => 'Chargement des tâches ...';

  @override
  String get tasksEmpty =>
      'Aucune tâche disponible pour le moment. Crée ta première tâche.';

  @override
  String get tasksSearchEmpty =>
      'Aucune tâche trouvée. Ajuste la recherche ou les filtres.';

  @override
  String get noTimerTaskSelected =>
      'Aucune tâche sélectionnée pour le minuteur';

  @override
  String activeTimerTask(String title) {
    return 'Tâche active du minuteur : $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Une phase du minuteur est en cours ou en pause. La tâche est donc actuellement verrouillée.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Cette tâche sera utilisée pour la prochaine phase de travail.';

  @override
  String get withoutTask => 'Sans tâche';

  @override
  String get searchTasks => 'Rechercher des tâches';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get filterAll => 'Toutes';

  @override
  String get filterOpen => 'Ouvertes';

  @override
  String get filterCompleted => 'Terminées';

  @override
  String get sortLabel => 'Tri';

  @override
  String get sortNewest => 'Les plus récentes d’abord';

  @override
  String get sortPriority => 'Priorité';

  @override
  String get sortPomodoros => 'Pomodoros';

  @override
  String get active => 'Active';

  @override
  String get completed => 'Terminée';

  @override
  String get locked => 'Verrouillée';

  @override
  String get forTimer => 'Pour le minuteur';

  @override
  String get priorityLow => 'Faible';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityHigh => 'Élevée';

  @override
  String get taskLoadRemoteFailed =>
      'Les tâches n’ont pas pu être chargées depuis le backend. Les données locales restent affichées.';

  @override
  String get taskSavedLocallyNotSynced =>
      'La tâche a été enregistrée localement, mais n’a pas pu être synchronisée avec le compte.';

  @override
  String get taskSaveFailedRolledBack =>
      'La tâche n’a pas pu être enregistrée. La dernière modification a été annulée.';

  @override
  String get taskDeleteFailedRestored =>
      'La tâche n’a pas pu être supprimée du compte. Elle a été restaurée.';

  @override
  String get taskCreateTitle => 'Créer une tâche';

  @override
  String get taskEditTitle => 'Modifier la tâche';

  @override
  String get taskTitleLabel => 'Titre';

  @override
  String get taskTitleRequired => 'Veuillez saisir un titre';

  @override
  String get taskTitleTooShort => 'Le titre est trop court.';

  @override
  String get taskDescriptionLabel => 'Description';

  @override
  String get priorityLabel => 'Priorité';

  @override
  String get tagsLabel => 'Tags/catégories';

  @override
  String get tagsHint => 'p. ex. université, travail, développement';

  @override
  String get timerResetTitle => 'Réinitialiser le minuteur ?';

  @override
  String get timerResetMessage =>
      'La phase actuelle sera annulée et ne sera pas enregistrée comme session terminée.';

  @override
  String get taskNoneSelected => 'Aucune tâche sélectionnée';

  @override
  String currentTask(String title) {
    return 'Tâche actuelle : $title';
  }

  @override
  String get taskForWorkPhase => 'Tâche pour cette phase de travail';

  @override
  String get taskLockedToPhase =>
      'Cette phase est liée à la tâche sélectionnée.';

  @override
  String get phaseWork => 'Phase de travail';

  @override
  String get phaseShortBreak => 'Courte pause';

  @override
  String get phaseLongBreak => 'Longue pause';

  @override
  String get timerStatusSaving => 'Enregistrement ...';

  @override
  String get timerStatusRunning => 'En cours';

  @override
  String get timerStatusPaused => 'En pause';

  @override
  String get timerStatusReady => 'Prêt';

  @override
  String get phaseDescriptionWork => 'Temps de concentration';

  @override
  String get phaseDescriptionShortBreak => 'Courte récupération';

  @override
  String get phaseDescriptionLongBreak => 'Récupération plus longue';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Ensuite : $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Aujourd’hui : chargement ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Aujourd’hui : $pomodoros';
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
  String get continueButton => 'Continuer';

  @override
  String get start => 'Démarrer';

  @override
  String get skipPause => 'Passer la pause';

  @override
  String get shortcutSpaceCompact => 'Espace : démarrer/pause';

  @override
  String get shortcutResetCompact => 'R : réinitialiser';

  @override
  String get shortcutSkipCompact => 'S : passer';

  @override
  String get shortcutSpace => 'Barre d’espace : démarrer/pause';

  @override
  String get shortcutReset => 'R : réinitialiser';

  @override
  String get shortcutSkip => 'S : passer la pause';

  @override
  String get phaseSavingTitle => 'Enregistrement de la phase';

  @override
  String get phaseSavingDescription =>
      'La phase terminée est enregistrée et le minuteur est préparé.';

  @override
  String get storageProblem => 'Problème de stockage';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'La phase terminée est enregistrée en arrière-plan.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count phases terminées sont enregistrées en arrière-plan.';
  }

  @override
  String get timerLocalSaveFailed =>
      'La phase terminée n’a pas pu être enregistrée localement.';

  @override
  String get timerBackendSyncFailed =>
      'La phase terminée a été enregistrée localement, mais n’a pas encore été synchronisée avec le backend.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed sur $total';
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

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Aplicativo Pomodoro';

  @override
  String get navTimer => 'Temporizador';

  @override
  String get navTasks => 'Tarefas';

  @override
  String get navStats => 'Estatísticas';

  @override
  String get navSettings => 'Configurações';

  @override
  String get navAccount => 'Conta';

  @override
  String get close => 'Fechar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get save => 'Salvar';

  @override
  String get reset => 'Redefinir';

  @override
  String get refresh => 'Atualizar';

  @override
  String get messageClose => 'Fechar mensagem';

  @override
  String get or => 'ou';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get emailVerifiedSuccess =>
      'E-mail verificado com sucesso. Agora você pode entrar.';

  @override
  String get emailVerifiedExpired => 'O link de verificação expirou.';

  @override
  String get emailVerifiedInvalid => 'O link de verificação é inválido.';

  @override
  String get sessionSyncOneWithAccount =>
      'Uma sessão está sendo sincronizada com sua conta.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sessões estão sendo sincronizadas com sua conta.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Uma sessão local será sincronizada após o login.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count sessões locais serão sincronizadas após o login.';
  }

  @override
  String get sessionSyncOnePending =>
      'Uma sessão está aguardando sincronização.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sessões estão aguardando sincronização.';
  }

  @override
  String get sessionSyncDone => 'Sincronização concluída.';

  @override
  String get sessionSyncFailed =>
      'As sessões não puderam ser sincronizadas no momento. O aplicativo tentará novamente mais tarde.';

  @override
  String get accountTitle => 'Conta de usuário';

  @override
  String get loginTitle => 'Login';

  @override
  String get createAccountTitle => 'Criar nova conta';

  @override
  String get emailPasswordLoginTitle => 'Entrar com e-mail e senha';

  @override
  String get emailPasswordCreateTitle => 'Criar conta com e-mail e senha';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get loginButton => 'Entrar';

  @override
  String get createAccountButton => 'Criar conta';

  @override
  String get rememberSessionTitle => 'Manter login neste dispositivo';

  @override
  String get rememberSessionSubtitle =>
      'Se desativado, o login permanecerá ativo apenas durante a sessão atual do aplicativo.';

  @override
  String get forgotPasswordButton => 'Esqueceu a senha?';

  @override
  String get alreadyHaveAccount => 'Já tenho uma conta';

  @override
  String get googleSection => 'Área do Google';

  @override
  String get googleLoginButton => 'Entrar com Google';

  @override
  String get googleCreateButton => 'Criar conta com Google';

  @override
  String get googleNotConfigured => 'O login com Google não está configurado.';

  @override
  String get googlePreparing => 'Preparando login com Google ...';

  @override
  String get googleNoIdToken => 'O Google não retornou um token de ID válido.';

  @override
  String googlePrepareFailed(String error) {
    return 'Não foi possível preparar o login com Google: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Falha no login com Google: $error';
  }

  @override
  String get googleLoginSuccess => 'Login com Google realizado com sucesso.';

  @override
  String get googleAccountCreated =>
      'A conta do Google foi criada e você está conectado.';

  @override
  String get googleWebOnly =>
      'O login com Google está disponível apenas no aplicativo web';

  @override
  String get githubSection => 'Área do GitHub';

  @override
  String get githubLoginButton => 'Entrar com GitHub';

  @override
  String get githubCreateButton => 'Criar conta com GitHub';

  @override
  String get githubNotConfigured => 'O login com GitHub não está configurado.';

  @override
  String get githubCancelled => 'O login com GitHub foi cancelado ou falhou.';

  @override
  String get githubSecurityCancelled =>
      'O login com GitHub foi cancelado por motivos de segurança.';

  @override
  String get githubNoValidCode => 'O GitHub não retornou um código válido.';

  @override
  String get githubLoginSuccess => 'Login com GitHub realizado com sucesso.';

  @override
  String get githubAccountCreated =>
      'A conta do GitHub foi criada e você está conectado.';

  @override
  String get passwordResetTitle => 'Redefinir senha';

  @override
  String get passwordResetDescription =>
      'Digite seu endereço de e-mail. Se uma conta existir, você receberá um link para redefinir a senha.';

  @override
  String get sendResetLink => 'Enviar link de redefinição';

  @override
  String get backToLogin => 'Voltar ao login';

  @override
  String get setNewPasswordTitle => 'Definir nova senha';

  @override
  String get setNewPasswordDescription =>
      'Defina uma nova senha para sua conta.';

  @override
  String get newPasswordLabel => 'Nova senha';

  @override
  String get repeatNewPasswordLabel => 'Repetir nova senha';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get savePassword => 'Salvar senha';

  @override
  String get registrationSuccess =>
      'Registro realizado com sucesso. Verifique seu endereço de e-mail e depois faça login.';

  @override
  String get passwordResetRequestSuccess =>
      'Se existir uma conta com este e-mail, um link de redefinição foi enviado.';

  @override
  String get passwordChangedSuccess =>
      'A senha foi alterada. Agora você pode entrar.';

  @override
  String get passwordResetMailSent =>
      'Se a conta existir, um link de redefinição foi enviado.';

  @override
  String get loginSuccess => 'Login realizado com sucesso.';

  @override
  String get invalidEmail => 'Digite um endereço de e-mail válido';

  @override
  String get passwordMinLength => 'Pelo menos 8 caracteres';

  @override
  String get loggedInTitle => 'Conta de usuário';

  @override
  String get loggedInDescription => 'Você está conectado no momento.';

  @override
  String get emailAddress => 'Endereço de e-mail';

  @override
  String get emailStatus => 'Status do e-mail';

  @override
  String get emailVerified => 'Verificado';

  @override
  String get emailNotVerified => 'Ainda não verificado';

  @override
  String get accountCreated => 'Conta criada';

  @override
  String get synchronization => 'Sincronização';

  @override
  String get accountInfoWarning =>
      'O aplicativo pode restaurar automaticamente sua sessão se um token de login válido estiver armazenado localmente. Em dispositivos compartilhados, você deve sempre sair da conta.';

  @override
  String get changePassword => 'Alterar senha';

  @override
  String get logout => 'Sair';

  @override
  String get syncRunning => 'Sincronização em andamento';

  @override
  String get syncOneWaiting => '1 sessão aguardando';

  @override
  String syncManyWaiting(int count) {
    return '$count sessões aguardando';
  }

  @override
  String get syncError => 'Erro de sincronização';

  @override
  String get syncAllSynced => 'Tudo sincronizado';

  @override
  String get sessionExpired => 'Sua sessão expirou. Faça login novamente.';

  @override
  String get settingsSaved => 'Configurações salvas.';

  @override
  String get timerTimesTitle => 'Durações do temporizador';

  @override
  String get timerTimesDescription =>
      'Defina quanto tempo duram as fases de trabalho e as pausas.';

  @override
  String get workTime => 'Tempo de trabalho';

  @override
  String get shortBreak => 'Pausa curta';

  @override
  String get longBreak => 'Pausa longa';

  @override
  String get longBreakAfter => 'Pausa longa após';

  @override
  String get minutes => 'Minutos';

  @override
  String get pomodorosUnit => 'Pomodoros';

  @override
  String get behaviorTitle => 'Comportamento';

  @override
  String get behaviorDescription =>
      'Ajuste como o temporizador se comporta durante o uso.';

  @override
  String get autoStartNextPhase => 'Iniciar automaticamente a próxima fase';

  @override
  String get enableSound => 'Ativar som';

  @override
  String get enableVibration => 'Ativar vibração';

  @override
  String get vibrationDescription =>
      'A vibração móvel real será conectada posteriormente por meio de um plugin.';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageDescription =>
      'Escolha o idioma do aplicativo. Com “Idioma do sistema”, o aplicativo usa o idioma do navegador ou do dispositivo.';

  @override
  String get languageLabel => 'Idioma do aplicativo';

  @override
  String get languageSystem => 'Idioma do sistema';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageArabic => 'Árabe';

  @override
  String get languageChinese => 'Chinês';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageJapanese => 'Japonês';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageIndonesian => 'Indonésio';

  @override
  String get languagePersian => 'Persa';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get appearanceDescription =>
      'Escolha o modo de exibição e a cor principal do aplicativo.';

  @override
  String get appearanceLabel => 'Aparência';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get themeColor => 'Cor do tema';

  @override
  String get red => 'Vermelho';

  @override
  String get blue => 'Azul';

  @override
  String get green => 'Verde';

  @override
  String get purple => 'Roxo';

  @override
  String get saveSettings => 'Salvar configurações';

  @override
  String get noChanges => 'Nenhuma alteração disponível';

  @override
  String get decrease => 'Diminuir';

  @override
  String get increase => 'Aumentar';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Configurações salvas localmente, mas ainda não sincronizadas.';

  @override
  String get settingsLoadRemoteFailed =>
      'Não foi possível carregar as configurações do backend. As configurações locais serão usadas.';

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get statsRefresh => 'Atualizar';

  @override
  String get statsWeek => 'Semana';

  @override
  String get statsMonth => 'Mês';

  @override
  String get statsYear => 'Ano';

  @override
  String get statsTasksTime => 'Tempo por tarefa';

  @override
  String get chartFocusPerDay => 'Tempo de foco por dia';

  @override
  String get chartFocusPerCalendarWeek =>
      'Tempo de foco por semana do calendário';

  @override
  String get chartFocusPerMonth => 'Tempo de foco por mês';

  @override
  String get chartFocusPerTask => 'Tempo de foco por tarefa';

  @override
  String get xAxisWeek => 'Eixo X: dias da semana';

  @override
  String get xAxisMonth => 'Eixo X: semanas do calendário no mês';

  @override
  String get xAxisYear => 'Eixo X: meses do ano';

  @override
  String get xAxisTasks => 'Eixo X: tarefas';

  @override
  String get periodNoData => 'Período: nenhum dado disponível';

  @override
  String periodRange(String start, String end) {
    return 'Período: $start – $end';
  }

  @override
  String get previousPeriod => 'Período anterior';

  @override
  String get nextPeriod => 'Próximo período';

  @override
  String get statsLoading => 'Carregando estatísticas ...';

  @override
  String get taskStatsLoading => 'Carregando estatísticas de tarefas ...';

  @override
  String get taskStatsEmpty =>
      'Ainda não há tempo de trabalho por tarefa. Inicie um Pomodoro com uma tarefa para ver dados.';

  @override
  String get pomodoros => 'Pomodoros';

  @override
  String get focusTime => 'Tempo de foco';

  @override
  String get streak => 'Sequência';

  @override
  String get bestPeriod => 'Melhor período';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Eixo Y: tempo de foco em horas · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Tempo de foco em minutos';

  @override
  String get sortedByHighestFocusTime => 'Ordenado pelo maior tempo de foco.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoros · $minutes min';
  }

  @override
  String get statsNoData => 'Ainda não há dados estatísticos disponíveis.';

  @override
  String get statsLoadFailed =>
      'Não foi possível carregar as estatísticas. Faça login e verifique sua conexão com a Internet.';

  @override
  String get taskStatsLoadFailed =>
      'Não foi possível carregar as estatísticas de tarefas.';

  @override
  String get todayPomodorosLoadFailed =>
      'Não foi possível carregar a contagem de Pomodoros de hoje.';

  @override
  String get noTaskTitle => 'Sem tarefa';

  @override
  String calendarWeekShort(int week) {
    return 'SC $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'SC $week/$year';
  }

  @override
  String get tasksTitle => 'Tarefas';

  @override
  String get tasksRefreshTooltip => 'Atualizar tarefas';

  @override
  String get taskSingular => 'Tarefa';

  @override
  String get deleteTaskTitle => 'Excluir tarefa?';

  @override
  String deleteTaskMessage(String title) {
    return 'Você realmente deseja excluir a tarefa “$title”?';
  }

  @override
  String get tasksLoading => 'Carregando tarefas ...';

  @override
  String get tasksEmpty => 'Ainda não há tarefas. Crie sua primeira tarefa.';

  @override
  String get tasksSearchEmpty =>
      'Nenhuma tarefa encontrada. Ajuste a busca ou os filtros.';

  @override
  String get noTimerTaskSelected =>
      'Nenhuma tarefa selecionada para o temporizador';

  @override
  String activeTimerTask(String title) {
    return 'Tarefa ativa do temporizador: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Uma fase do temporizador está em execução ou pausada. A tarefa está bloqueada no momento.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Esta tarefa será usada na próxima fase de trabalho.';

  @override
  String get withoutTask => 'Sem tarefa';

  @override
  String get searchTasks => 'Buscar tarefas';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterOpen => 'Abertas';

  @override
  String get filterCompleted => 'Concluídas';

  @override
  String get sortLabel => 'Ordenação';

  @override
  String get sortNewest => 'Mais recentes primeiro';

  @override
  String get sortPriority => 'Prioridade';

  @override
  String get sortPomodoros => 'Pomodoros';

  @override
  String get active => 'Ativa';

  @override
  String get completed => 'Concluída';

  @override
  String get locked => 'Bloqueada';

  @override
  String get forTimer => 'Para o temporizador';

  @override
  String get priorityLow => 'Baixa';

  @override
  String get priorityMedium => 'Média';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get taskLoadRemoteFailed =>
      'Não foi possível carregar as tarefas do backend. Os dados locais continuarão sendo exibidos.';

  @override
  String get taskSavedLocallyNotSynced =>
      'A tarefa foi salva localmente, mas não pôde ser sincronizada com a conta.';

  @override
  String get taskSaveFailedRolledBack =>
      'Não foi possível salvar a tarefa. A última alteração foi revertida.';

  @override
  String get taskDeleteFailedRestored =>
      'Não foi possível excluir a tarefa da conta. A tarefa foi restaurada.';

  @override
  String get taskCreateTitle => 'Criar tarefa';

  @override
  String get taskEditTitle => 'Editar tarefa';

  @override
  String get taskTitleLabel => 'Título';

  @override
  String get taskTitleRequired => 'Digite um título';

  @override
  String get taskTitleTooShort => 'O título é muito curto.';

  @override
  String get taskDescriptionLabel => 'Descrição';

  @override
  String get priorityLabel => 'Prioridade';

  @override
  String get tagsLabel => 'Tags/categorias';

  @override
  String get tagsHint => 'por exemplo, universidade, trabalho, desenvolvimento';

  @override
  String get timerResetTitle => 'Redefinir temporizador?';

  @override
  String get timerResetMessage =>
      'A fase atual será cancelada e não será salva como uma sessão concluída.';

  @override
  String get taskNoneSelected => 'Nenhuma tarefa selecionada';

  @override
  String currentTask(String title) {
    return 'Tarefa atual: $title';
  }

  @override
  String get taskForWorkPhase => 'Tarefa para esta fase de trabalho';

  @override
  String get taskLockedToPhase =>
      'Esta fase está vinculada à tarefa selecionada.';

  @override
  String get phaseWork => 'Fase de trabalho';

  @override
  String get phaseShortBreak => 'Pausa curta';

  @override
  String get phaseLongBreak => 'Pausa longa';

  @override
  String get timerStatusSaving => 'Salvando ...';

  @override
  String get timerStatusRunning => 'Em execução';

  @override
  String get timerStatusPaused => 'Pausado';

  @override
  String get timerStatusReady => 'Pronto';

  @override
  String get phaseDescriptionWork => 'Tempo de foco';

  @override
  String get phaseDescriptionShortBreak => 'Recuperação curta';

  @override
  String get phaseDescriptionLongBreak => 'Recuperação mais longa';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Depois: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Hoje: carregando ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Hoje: $pomodoros';
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
  String get pause => 'Pausar';

  @override
  String get continueButton => 'Continuar';

  @override
  String get start => 'Iniciar';

  @override
  String get skipPause => 'Pular pausa';

  @override
  String get shortcutSpaceCompact => 'Espaço: iniciar/pausar';

  @override
  String get shortcutResetCompact => 'R: redefinir';

  @override
  String get shortcutSkipCompact => 'S: pular';

  @override
  String get shortcutSpace => 'Barra de espaço: iniciar/pausar';

  @override
  String get shortcutReset => 'R: redefinir';

  @override
  String get shortcutSkip => 'S: pular pausa';

  @override
  String get phaseSavingTitle => 'Salvando fase';

  @override
  String get phaseSavingDescription =>
      'A fase concluída está sendo salva e o temporizador está sendo preparado.';

  @override
  String get storageProblem => 'Problema de armazenamento';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'A fase concluída está sendo salva em segundo plano.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count fases concluídas estão sendo salvas em segundo plano.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Não foi possível salvar localmente a fase concluída.';

  @override
  String get timerBackendSyncFailed =>
      'A fase concluída foi salva localmente, mas ainda não foi sincronizada com o backend.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed de $total';
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

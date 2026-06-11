// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación Pomodoro';

  @override
  String get navTimer => 'Temporizador';

  @override
  String get navTasks => 'Tareas';

  @override
  String get navStats => 'Estadísticas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get navAccount => 'Cuenta';

  @override
  String get close => 'Cerrar';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get save => 'Guardar';

  @override
  String get reset => 'Restablecer';

  @override
  String get refresh => 'Actualizar';

  @override
  String get messageClose => 'Cerrar mensaje';

  @override
  String get or => 'o';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get emailVerifiedSuccess =>
      'Correo electrónico verificado correctamente. Ahora puedes iniciar sesión.';

  @override
  String get emailVerifiedExpired => 'El enlace de verificación ha caducado.';

  @override
  String get emailVerifiedInvalid => 'El enlace de verificación no es válido.';

  @override
  String get sessionSyncOneWithAccount =>
      'Una sesión se está sincronizando con tu cuenta.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sesiones se están sincronizando con tu cuenta.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Una sesión local se sincronizará después de iniciar sesión.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count sesiones locales se sincronizarán después de iniciar sesión.';
  }

  @override
  String get sessionSyncOnePending =>
      'Una sesión está esperando la sincronización.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sesiones están esperando la sincronización.';
  }

  @override
  String get sessionSyncDone => 'Sincronización completada.';

  @override
  String get sessionSyncFailed =>
      'Las sesiones no se pudieron sincronizar en este momento. Se intentará de nuevo más tarde.';

  @override
  String get accountTitle => 'Cuenta de usuario';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get createAccountTitle => 'Crear nueva cuenta';

  @override
  String get emailPasswordLoginTitle =>
      'Iniciar sesión con correo electrónico y contraseña';

  @override
  String get emailPasswordCreateTitle =>
      'Crear cuenta con correo electrónico y contraseña';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get createAccountButton => 'Crear cuenta';

  @override
  String get rememberSessionTitle =>
      'Mantener sesión iniciada en este dispositivo';

  @override
  String get rememberSessionSubtitle =>
      'Si está desactivado, la sesión solo permanecerá activa durante la sesión actual de la aplicación.';

  @override
  String get forgotPasswordButton => '¿Olvidaste tu contraseña?';

  @override
  String get alreadyHaveAccount => 'Ya tengo una cuenta';

  @override
  String get googleSection => 'Sección de Google';

  @override
  String get googleLoginButton => 'Iniciar sesión con Google';

  @override
  String get googleCreateButton => 'Crear cuenta con Google';

  @override
  String get googleNotConfigured =>
      'El inicio de sesión con Google no está configurado.';

  @override
  String get googlePreparing => 'Preparando inicio de sesión con Google ...';

  @override
  String get googleNoIdToken => 'Google no devolvió un token de ID válido.';

  @override
  String googlePrepareFailed(String error) {
    return 'No se pudo preparar el inicio de sesión con Google: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Error al iniciar sesión con Google: $error';
  }

  @override
  String get googleLoginSuccess => 'Sesión iniciada correctamente con Google.';

  @override
  String get googleAccountCreated =>
      'La cuenta de Google se creó y has iniciado sesión.';

  @override
  String get googleWebOnly =>
      'El inicio de sesión con Google solo está disponible en la aplicación web';

  @override
  String get githubSection => 'Sección de GitHub';

  @override
  String get githubLoginButton => 'Iniciar sesión con GitHub';

  @override
  String get githubCreateButton => 'Crear cuenta con GitHub';

  @override
  String get githubNotConfigured =>
      'El inicio de sesión con GitHub no está configurado.';

  @override
  String get githubCancelled =>
      'El inicio de sesión con GitHub fue cancelado o falló.';

  @override
  String get githubSecurityCancelled =>
      'El inicio de sesión con GitHub fue cancelado por motivos de seguridad.';

  @override
  String get githubNoValidCode => 'GitHub no devolvió un código válido.';

  @override
  String get githubLoginSuccess => 'Sesión iniciada correctamente con GitHub.';

  @override
  String get githubAccountCreated =>
      'La cuenta de GitHub se creó y has iniciado sesión.';

  @override
  String get passwordResetTitle => 'Restablecer contraseña';

  @override
  String get passwordResetDescription =>
      'Introduce tu dirección de correo electrónico. Si existe una cuenta, recibirás un enlace para restablecer la contraseña.';

  @override
  String get sendResetLink => 'Enviar enlace de restablecimiento';

  @override
  String get backToLogin => 'Volver al inicio de sesión';

  @override
  String get setNewPasswordTitle => 'Establecer nueva contraseña';

  @override
  String get setNewPasswordDescription =>
      'Establece una nueva contraseña para tu cuenta.';

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get repeatNewPasswordLabel => 'Repetir nueva contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get savePassword => 'Guardar contraseña';

  @override
  String get registrationSuccess =>
      'Registro completado correctamente. Verifica tu dirección de correo electrónico y luego inicia sesión.';

  @override
  String get passwordResetRequestSuccess =>
      'Si existe una cuenta con este correo electrónico, se ha enviado un enlace de restablecimiento.';

  @override
  String get passwordChangedSuccess =>
      'La contraseña ha sido cambiada. Ahora puedes iniciar sesión.';

  @override
  String get passwordResetMailSent =>
      'Si la cuenta existe, se ha enviado un enlace de restablecimiento.';

  @override
  String get loginSuccess => 'Sesión iniciada correctamente.';

  @override
  String get invalidEmail =>
      'Introduce una dirección de correo electrónico válida';

  @override
  String get passwordMinLength => 'Al menos 8 caracteres';

  @override
  String get loggedInTitle => 'Cuenta de usuario';

  @override
  String get loggedInDescription => 'Actualmente has iniciado sesión.';

  @override
  String get emailAddress => 'Dirección de correo electrónico';

  @override
  String get emailStatus => 'Estado del correo electrónico';

  @override
  String get emailVerified => 'Verificado';

  @override
  String get emailNotVerified => 'Aún no verificado';

  @override
  String get accountCreated => 'Cuenta creada';

  @override
  String get synchronization => 'Sincronización';

  @override
  String get accountInfoWarning =>
      'La aplicación puede restaurar automáticamente tu sesión si hay un token de inicio de sesión válido guardado localmente. En dispositivos compartidos, siempre deberías cerrar sesión.';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get syncRunning => 'Sincronización en curso';

  @override
  String get syncOneWaiting => '1 sesión en espera';

  @override
  String syncManyWaiting(int count) {
    return '$count sesiones en espera';
  }

  @override
  String get syncError => 'Error de sincronización';

  @override
  String get syncAllSynced => 'Todo sincronizado';

  @override
  String get sessionExpired => 'Tu sesión ha caducado. Inicia sesión de nuevo.';

  @override
  String get settingsSaved => 'Ajustes guardados.';

  @override
  String get timerTimesTitle => 'Duraciones del temporizador';

  @override
  String get timerTimesDescription =>
      'Define cuánto duran las fases de trabajo y los descansos.';

  @override
  String get workTime => 'Tiempo de trabajo';

  @override
  String get shortBreak => 'Descanso corto';

  @override
  String get longBreak => 'Descanso largo';

  @override
  String get longBreakAfter => 'Descanso largo después de';

  @override
  String get minutes => 'Minutos';

  @override
  String get pomodorosUnit => 'Pomodoros';

  @override
  String get behaviorTitle => 'Comportamiento';

  @override
  String get behaviorDescription =>
      'Ajusta cómo se comporta el temporizador durante el uso.';

  @override
  String get autoStartNextPhase => 'Iniciar automáticamente la siguiente fase';

  @override
  String get enableSound => 'Activar sonido';

  @override
  String get enableVibration => 'Activar vibración';

  @override
  String get vibrationDescription =>
      'La vibración móvil real se conectará más adelante mediante un plugin.';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageDescription =>
      'Elige el idioma de la aplicación. Con “Idioma del sistema”, la aplicación usa el idioma del navegador o del dispositivo.';

  @override
  String get languageLabel => 'Idioma de la aplicación';

  @override
  String get languageSystem => 'Idioma del sistema';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageArabic => 'Árabe';

  @override
  String get languageChinese => 'Chino';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portugués';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageJapanese => 'Japonés';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageIndonesian => 'Indonesio';

  @override
  String get languagePersian => 'Persa';

  @override
  String get appearanceTitle => 'Apariencia';

  @override
  String get appearanceDescription =>
      'Elige el modo de diseño y el color principal de la aplicación.';

  @override
  String get appearanceLabel => 'Apariencia';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get red => 'Rojo';

  @override
  String get blue => 'Azul';

  @override
  String get green => 'Verde';

  @override
  String get purple => 'Morado';

  @override
  String get saveSettings => 'Guardar ajustes';

  @override
  String get noChanges => 'No hay cambios';

  @override
  String get decrease => 'Disminuir';

  @override
  String get increase => 'Aumentar';

  @override
  String get minutesShort => 'min';

  @override
  String get settingsSavedButNotSynced =>
      'Ajustes guardados localmente, pero aún no sincronizados.';

  @override
  String get settingsLoadRemoteFailed =>
      'No se pudieron cargar los ajustes desde el backend. Se usarán los ajustes locales.';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsRefresh => 'Actualizar';

  @override
  String get statsWeek => 'Semana';

  @override
  String get statsMonth => 'Mes';

  @override
  String get statsYear => 'Año';

  @override
  String get statsTasksTime => 'Tiempo por tarea';

  @override
  String get chartFocusPerDay => 'Tiempo de concentración por día';

  @override
  String get chartFocusPerCalendarWeek =>
      'Tiempo de concentración por semana natural';

  @override
  String get chartFocusPerMonth => 'Tiempo de concentración por mes';

  @override
  String get chartFocusPerTask => 'Tiempo de concentración por tarea';

  @override
  String get xAxisWeek => 'Eje X: días de la semana';

  @override
  String get xAxisMonth => 'Eje X: semanas naturales del mes';

  @override
  String get xAxisYear => 'Eje X: meses del año';

  @override
  String get xAxisTasks => 'Eje X: tareas';

  @override
  String get periodNoData => 'Periodo: no hay datos disponibles';

  @override
  String periodRange(String start, String end) {
    return 'Periodo: $start – $end';
  }

  @override
  String get previousPeriod => 'Periodo anterior';

  @override
  String get nextPeriod => 'Periodo siguiente';

  @override
  String get statsLoading => 'Cargando estadísticas ...';

  @override
  String get taskStatsLoading => 'Cargando estadísticas de tareas ...';

  @override
  String get taskStatsEmpty =>
      'Aún no hay tiempo de trabajo por tarea. Inicia un Pomodoro con una tarea para ver datos.';

  @override
  String get pomodoros => 'Pomodoros';

  @override
  String get focusTime => 'Tiempo de concentración';

  @override
  String get streak => 'Racha';

  @override
  String get bestPeriod => 'Mejor periodo';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Eje Y: tiempo de concentración en horas · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Tiempo de concentración en minutos';

  @override
  String get sortedByHighestFocusTime =>
      'Ordenado por mayor tiempo de concentración.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoros · $minutes min';
  }

  @override
  String get statsNoData => 'Aún no hay datos estadísticos disponibles.';

  @override
  String get statsLoadFailed =>
      'No se pudieron cargar las estadísticas. Inicia sesión y comprueba tu conexión a Internet.';

  @override
  String get taskStatsLoadFailed =>
      'No se pudieron cargar las estadísticas de tareas.';

  @override
  String get todayPomodorosLoadFailed =>
      'No se pudo cargar el número de Pomodoros de hoy.';

  @override
  String get noTaskTitle => 'Sin tarea';

  @override
  String calendarWeekShort(int week) {
    return 'SN $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'SN $week/$year';
  }

  @override
  String get tasksTitle => 'Tareas';

  @override
  String get tasksRefreshTooltip => 'Actualizar tareas';

  @override
  String get taskSingular => 'Tarea';

  @override
  String get deleteTaskTitle => '¿Eliminar tarea?';

  @override
  String deleteTaskMessage(String title) {
    return '¿Realmente quieres eliminar la tarea “$title”?';
  }

  @override
  String get tasksLoading => 'Cargando tareas ...';

  @override
  String get tasksEmpty => 'Aún no hay tareas. Crea tu primera tarea.';

  @override
  String get tasksSearchEmpty =>
      'No se encontraron tareas. Ajusta la búsqueda o los filtros.';

  @override
  String get noTimerTaskSelected =>
      'No se ha seleccionado ninguna tarea para el temporizador';

  @override
  String activeTimerTask(String title) {
    return 'Tarea activa del temporizador: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Una fase del temporizador está en curso o en pausa. Por eso la tarea está bloqueada actualmente.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Esta tarea se usará para la siguiente fase de trabajo.';

  @override
  String get withoutTask => 'Sin tarea';

  @override
  String get searchTasks => 'Buscar tareas';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterOpen => 'Abiertas';

  @override
  String get filterCompleted => 'Completadas';

  @override
  String get sortLabel => 'Ordenación';

  @override
  String get sortNewest => 'Más recientes primero';

  @override
  String get sortPriority => 'Prioridad';

  @override
  String get sortPomodoros => 'Pomodoros';

  @override
  String get active => 'Activa';

  @override
  String get completed => 'Completada';

  @override
  String get locked => 'Bloqueada';

  @override
  String get forTimer => 'Para el temporizador';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get taskLoadRemoteFailed =>
      'No se pudieron cargar las tareas desde el backend. Se seguirán mostrando los datos locales.';

  @override
  String get taskSavedLocallyNotSynced =>
      'La tarea se guardó localmente, pero no se pudo sincronizar con la cuenta.';

  @override
  String get taskSaveFailedRolledBack =>
      'No se pudo guardar la tarea. El último cambio fue revertido.';

  @override
  String get taskDeleteFailedRestored =>
      'No se pudo eliminar la tarea de la cuenta. La tarea fue restaurada.';

  @override
  String get taskCreateTitle => 'Crear tarea';

  @override
  String get taskEditTitle => 'Editar tarea';

  @override
  String get taskTitleLabel => 'Título';

  @override
  String get taskTitleRequired => 'Introduce un título';

  @override
  String get taskTitleTooShort => 'El título es demasiado corto.';

  @override
  String get taskDescriptionLabel => 'Descripción';

  @override
  String get priorityLabel => 'Prioridad';

  @override
  String get tagsLabel => 'Etiquetas/categorías';

  @override
  String get tagsHint => 'p. ej. universidad, trabajo, desarrollo';

  @override
  String get timerResetTitle => '¿Restablecer temporizador?';

  @override
  String get timerResetMessage =>
      'La fase actual se cancelará y no se guardará como sesión completada.';

  @override
  String get taskNoneSelected => 'Ninguna tarea seleccionada';

  @override
  String currentTask(String title) {
    return 'Tarea actual: $title';
  }

  @override
  String get taskForWorkPhase => 'Tarea para esta fase de trabajo';

  @override
  String get taskLockedToPhase =>
      'Esta fase está vinculada a la tarea seleccionada.';

  @override
  String get phaseWork => 'Fase de trabajo';

  @override
  String get phaseShortBreak => 'Descanso corto';

  @override
  String get phaseLongBreak => 'Descanso largo';

  @override
  String get timerStatusSaving => 'Guardando ...';

  @override
  String get timerStatusRunning => 'En ejecución';

  @override
  String get timerStatusPaused => 'En pausa';

  @override
  String get timerStatusReady => 'Listo';

  @override
  String get phaseDescriptionWork => 'Tiempo de concentración';

  @override
  String get phaseDescriptionShortBreak => 'Recuperación corta';

  @override
  String get phaseDescriptionLongBreak => 'Recuperación más larga';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Después: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Hoy: cargando ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Hoy: $pomodoros';
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
  String get pause => 'Pausa';

  @override
  String get continueButton => 'Continuar';

  @override
  String get start => 'Iniciar';

  @override
  String get skipPause => 'Saltar descanso';

  @override
  String get shortcutSpaceCompact => 'Espacio: iniciar/pausar';

  @override
  String get shortcutResetCompact => 'R: restablecer';

  @override
  String get shortcutSkipCompact => 'S: saltar';

  @override
  String get shortcutSpace => 'Barra espaciadora: iniciar/pausar';

  @override
  String get shortcutReset => 'R: restablecer';

  @override
  String get shortcutSkip => 'S: saltar descanso';

  @override
  String get phaseSavingTitle => 'Guardando fase';

  @override
  String get phaseSavingDescription =>
      'La fase completada se está guardando y el temporizador se está preparando.';

  @override
  String get storageProblem => 'Problema de almacenamiento';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'La fase completada se está guardando en segundo plano.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count fases completadas se están guardando en segundo plano.';
  }

  @override
  String get timerLocalSaveFailed =>
      'No se pudo guardar localmente la fase completada.';

  @override
  String get timerBackendSyncFailed =>
      'La fase completada se guardó localmente, pero aún no se ha sincronizado con el backend.';

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

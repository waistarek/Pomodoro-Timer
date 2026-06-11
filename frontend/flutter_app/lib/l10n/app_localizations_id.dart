// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Aplikasi Pomodoro';

  @override
  String get navTimer => 'Timer';

  @override
  String get navTasks => 'Tugas';

  @override
  String get navStats => 'Statistik';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get navAccount => 'Akun';

  @override
  String get close => 'Tutup';

  @override
  String get retry => 'Coba lagi';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Simpan';

  @override
  String get reset => 'Reset';

  @override
  String get refresh => 'Muat ulang';

  @override
  String get messageClose => 'Tutup pesan';

  @override
  String get or => 'atau';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get emailVerifiedSuccess =>
      'Email berhasil diverifikasi. Sekarang kamu dapat masuk.';

  @override
  String get emailVerifiedExpired => 'Tautan verifikasi sudah kedaluwarsa.';

  @override
  String get emailVerifiedInvalid => 'Tautan verifikasi tidak valid.';

  @override
  String get sessionSyncOneWithAccount =>
      'Satu sesi sedang disinkronkan dengan akunmu.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count sesi sedang disinkronkan dengan akunmu.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Satu sesi lokal akan disinkronkan setelah masuk.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count sesi lokal akan disinkronkan setelah masuk.';
  }

  @override
  String get sessionSyncOnePending => 'Satu sesi menunggu sinkronisasi.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count sesi menunggu sinkronisasi.';
  }

  @override
  String get sessionSyncDone => 'Sinkronisasi selesai.';

  @override
  String get sessionSyncFailed =>
      'Sesi belum dapat disinkronkan saat ini. Aplikasi akan mencoba lagi nanti.';

  @override
  String get accountTitle => 'Akun pengguna';

  @override
  String get loginTitle => 'Masuk';

  @override
  String get createAccountTitle => 'Buat akun baru';

  @override
  String get emailPasswordLoginTitle => 'Masuk dengan email dan kata sandi';

  @override
  String get emailPasswordCreateTitle => 'Buat akun email/kata sandi';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Kata sandi';

  @override
  String get loginButton => 'Masuk';

  @override
  String get createAccountButton => 'Buat akun';

  @override
  String get rememberSessionTitle => 'Tetap masuk di perangkat ini';

  @override
  String get rememberSessionSubtitle =>
      'Jika dinonaktifkan, login hanya aktif selama sesi aplikasi saat ini.';

  @override
  String get forgotPasswordButton => 'Lupa kata sandi?';

  @override
  String get alreadyHaveAccount => 'Saya sudah punya akun';

  @override
  String get googleSection => 'Bagian Google';

  @override
  String get googleLoginButton => 'Masuk dengan Google';

  @override
  String get googleCreateButton => 'Buat akun dengan Google';

  @override
  String get googleNotConfigured => 'Login Google belum dikonfigurasi.';

  @override
  String get googlePreparing => 'Menyiapkan login Google ...';

  @override
  String get googleNoIdToken =>
      'Google tidak mengembalikan ID token yang valid.';

  @override
  String googlePrepareFailed(String error) {
    return 'Login Google tidak dapat disiapkan: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Login Google gagal: $error';
  }

  @override
  String get googleLoginSuccess => 'Berhasil masuk dengan Google.';

  @override
  String get googleAccountCreated => 'Akun Google dibuat dan kamu sudah masuk.';

  @override
  String get googleWebOnly => 'Login Google hanya tersedia di aplikasi web';

  @override
  String get githubSection => 'Bagian GitHub';

  @override
  String get githubLoginButton => 'Masuk dengan GitHub';

  @override
  String get githubCreateButton => 'Buat akun dengan GitHub';

  @override
  String get githubNotConfigured => 'Login GitHub belum dikonfigurasi.';

  @override
  String get githubCancelled => 'Login GitHub dibatalkan atau gagal.';

  @override
  String get githubSecurityCancelled =>
      'Login GitHub dibatalkan karena alasan keamanan.';

  @override
  String get githubNoValidCode => 'GitHub tidak mengembalikan kode yang valid.';

  @override
  String get githubLoginSuccess => 'Berhasil masuk dengan GitHub.';

  @override
  String get githubAccountCreated => 'Akun GitHub dibuat dan kamu sudah masuk.';

  @override
  String get passwordResetTitle => 'Reset kata sandi';

  @override
  String get passwordResetDescription =>
      'Masukkan alamat emailmu. Jika akun ada, kamu akan menerima tautan untuk mereset kata sandi.';

  @override
  String get sendResetLink => 'Kirim tautan reset';

  @override
  String get backToLogin => 'Kembali ke login';

  @override
  String get setNewPasswordTitle => 'Atur kata sandi baru';

  @override
  String get setNewPasswordDescription => 'Atur kata sandi baru untuk akunmu.';

  @override
  String get newPasswordLabel => 'Kata sandi baru';

  @override
  String get repeatNewPasswordLabel => 'Ulangi kata sandi baru';

  @override
  String get passwordsDoNotMatch => 'Kata sandi tidak cocok';

  @override
  String get savePassword => 'Simpan kata sandi';

  @override
  String get registrationSuccess =>
      'Registrasi berhasil. Harap verifikasi alamat emailmu lalu masuk.';

  @override
  String get passwordResetRequestSuccess =>
      'Jika akun dengan email ini ada, tautan reset telah dikirim.';

  @override
  String get passwordChangedSuccess =>
      'Kata sandi telah diubah. Sekarang kamu dapat masuk.';

  @override
  String get passwordResetMailSent =>
      'Jika akun ada, tautan reset telah dikirim.';

  @override
  String get loginSuccess => 'Berhasil masuk.';

  @override
  String get invalidEmail => 'Masukkan alamat email yang valid';

  @override
  String get passwordMinLength => 'Minimal 8 karakter';

  @override
  String get loggedInTitle => 'Akun pengguna';

  @override
  String get loggedInDescription => 'Kamu sedang masuk.';

  @override
  String get emailAddress => 'Alamat email';

  @override
  String get emailStatus => 'Status email';

  @override
  String get emailVerified => 'Terverifikasi';

  @override
  String get emailNotVerified => 'Belum diverifikasi';

  @override
  String get accountCreated => 'Akun dibuat';

  @override
  String get synchronization => 'Sinkronisasi';

  @override
  String get accountInfoWarning =>
      'Aplikasi dapat memulihkan sesimu secara otomatis jika token login yang valid tersimpan secara lokal. Di perangkat bersama, kamu harus selalu keluar.';

  @override
  String get changePassword => 'Ubah kata sandi';

  @override
  String get logout => 'Keluar';

  @override
  String get syncRunning => 'Sinkronisasi berjalan';

  @override
  String get syncOneWaiting => '1 sesi menunggu';

  @override
  String syncManyWaiting(int count) {
    return '$count sesi menunggu';
  }

  @override
  String get syncError => 'Kesalahan sinkronisasi';

  @override
  String get syncAllSynced => 'Semuanya tersinkronisasi';

  @override
  String get sessionExpired => 'Sesimu telah kedaluwarsa. Harap masuk lagi.';

  @override
  String get settingsSaved => 'Pengaturan disimpan.';

  @override
  String get timerTimesTitle => 'Durasi timer';

  @override
  String get timerTimesDescription =>
      'Tentukan berapa lama fase kerja dan istirahat berlangsung.';

  @override
  String get workTime => 'Waktu kerja';

  @override
  String get shortBreak => 'Istirahat pendek';

  @override
  String get longBreak => 'Istirahat panjang';

  @override
  String get longBreakAfter => 'Istirahat panjang setelah';

  @override
  String get minutes => 'Menit';

  @override
  String get pomodorosUnit => 'Pomodoro';

  @override
  String get behaviorTitle => 'Perilaku';

  @override
  String get behaviorDescription =>
      'Sesuaikan cara timer berperilaku saat digunakan.';

  @override
  String get autoStartNextPhase => 'Mulai fase berikutnya secara otomatis';

  @override
  String get enableSound => 'Aktifkan suara';

  @override
  String get enableVibration => 'Aktifkan getaran';

  @override
  String get vibrationDescription =>
      'Getaran mobile sebenarnya akan dihubungkan nanti melalui plugin.';

  @override
  String get languageTitle => 'Bahasa';

  @override
  String get languageDescription =>
      'Pilih bahasa aplikasi. Dengan “Bahasa sistem”, aplikasi menggunakan bahasa browser atau perangkat.';

  @override
  String get languageLabel => 'Bahasa aplikasi';

  @override
  String get languageSystem => 'Bahasa sistem';

  @override
  String get languageGerman => 'Jerman';

  @override
  String get languageEnglish => 'Inggris';

  @override
  String get languageArabic => 'Arab';

  @override
  String get languageChinese => 'Tionghoa';

  @override
  String get languageFrench => 'Prancis';

  @override
  String get languageSpanish => 'Spanyol';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languagePortuguese => 'Portugis';

  @override
  String get languageRussian => 'Rusia';

  @override
  String get languageJapanese => 'Jepang';

  @override
  String get languageTurkish => 'Turki';

  @override
  String get languageItalian => 'Italia';

  @override
  String get languageKorean => 'Korea';

  @override
  String get languageIndonesian => 'Indonesia';

  @override
  String get languagePersian => 'Persia';

  @override
  String get appearanceTitle => 'Tampilan';

  @override
  String get appearanceDescription =>
      'Pilih mode tampilan dan warna utama aplikasi.';

  @override
  String get appearanceLabel => 'Tampilan';

  @override
  String get systemTheme => 'Sistem';

  @override
  String get lightMode => 'Mode terang';

  @override
  String get darkMode => 'Mode gelap';

  @override
  String get themeColor => 'Warna tema';

  @override
  String get red => 'Merah';

  @override
  String get blue => 'Biru';

  @override
  String get green => 'Hijau';

  @override
  String get purple => 'Ungu';

  @override
  String get saveSettings => 'Simpan pengaturan';

  @override
  String get noChanges => 'Tidak ada perubahan';

  @override
  String get decrease => 'Kurangi';

  @override
  String get increase => 'Tambah';

  @override
  String get minutesShort => 'mnt';

  @override
  String get settingsSavedButNotSynced =>
      'Pengaturan disimpan secara lokal, tetapi belum disinkronkan.';

  @override
  String get settingsLoadRemoteFailed =>
      'Pengaturan tidak dapat dimuat dari backend. Pengaturan lokal akan digunakan.';

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsRefresh => 'Muat ulang';

  @override
  String get statsWeek => 'Minggu';

  @override
  String get statsMonth => 'Bulan';

  @override
  String get statsYear => 'Tahun';

  @override
  String get statsTasksTime => 'Waktu tugas';

  @override
  String get chartFocusPerDay => 'Waktu fokus per hari';

  @override
  String get chartFocusPerCalendarWeek => 'Waktu fokus per minggu kalender';

  @override
  String get chartFocusPerMonth => 'Waktu fokus per bulan';

  @override
  String get chartFocusPerTask => 'Waktu fokus per tugas';

  @override
  String get xAxisWeek => 'Sumbu X: hari dalam minggu';

  @override
  String get xAxisMonth => 'Sumbu X: minggu kalender dalam bulan';

  @override
  String get xAxisYear => 'Sumbu X: bulan dalam tahun';

  @override
  String get xAxisTasks => 'Sumbu X: tugas';

  @override
  String get periodNoData => 'Periode: Tidak ada data';

  @override
  String periodRange(String start, String end) {
    return 'Periode: $start – $end';
  }

  @override
  String get previousPeriod => 'Periode sebelumnya';

  @override
  String get nextPeriod => 'Periode berikutnya';

  @override
  String get statsLoading => 'Memuat statistik ...';

  @override
  String get taskStatsLoading => 'Memuat statistik tugas ...';

  @override
  String get taskStatsEmpty =>
      'Belum ada waktu kerja per tugas. Mulai Pomodoro dengan tugas untuk melihat data.';

  @override
  String get pomodoros => 'Pomodoro';

  @override
  String get focusTime => 'Waktu fokus';

  @override
  String get streak => 'Rangkaian';

  @override
  String get bestPeriod => 'Periode terbaik';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
      one: '1 hari',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Sumbu Y: waktu fokus dalam jam · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Waktu fokus dalam menit';

  @override
  String get sortedByHighestFocusTime =>
      'Diurutkan berdasarkan waktu fokus tertinggi.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoro · $minutes mnt';
  }

  @override
  String get statsNoData => 'Belum ada data statistik.';

  @override
  String get statsLoadFailed =>
      'Statistik tidak dapat dimuat. Harap masuk dan periksa koneksi internet.';

  @override
  String get taskStatsLoadFailed => 'Statistik tugas tidak dapat dimuat.';

  @override
  String get todayPomodorosLoadFailed =>
      'Jumlah Pomodoro hari ini tidak dapat dimuat.';

  @override
  String get noTaskTitle => 'Tanpa tugas';

  @override
  String calendarWeekShort(int week) {
    return 'MG $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'MG $week/$year';
  }

  @override
  String get tasksTitle => 'Tugas';

  @override
  String get tasksRefreshTooltip => 'Muat ulang tugas';

  @override
  String get taskSingular => 'Tugas';

  @override
  String get deleteTaskTitle => 'Hapus tugas?';

  @override
  String deleteTaskMessage(String title) {
    return 'Apakah kamu yakin ingin menghapus tugas “$title”?';
  }

  @override
  String get tasksLoading => 'Memuat tugas ...';

  @override
  String get tasksEmpty => 'Belum ada tugas. Buat tugas pertamamu.';

  @override
  String get tasksSearchEmpty =>
      'Tidak ada tugas yang ditemukan. Sesuaikan pencarian atau filter.';

  @override
  String get noTimerTaskSelected => 'Tidak ada tugas timer yang dipilih';

  @override
  String activeTimerTask(String title) {
    return 'Tugas timer aktif: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Fase timer sedang berjalan atau dijeda. Karena itu tugas saat ini terkunci.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Tugas ini akan digunakan untuk fase kerja berikutnya.';

  @override
  String get withoutTask => 'Tanpa tugas';

  @override
  String get searchTasks => 'Cari tugas';

  @override
  String get clearSearch => 'Bersihkan pencarian';

  @override
  String get filterAll => 'Semua';

  @override
  String get filterOpen => 'Terbuka';

  @override
  String get filterCompleted => 'Selesai';

  @override
  String get sortLabel => 'Urutan';

  @override
  String get sortNewest => 'Terbaru dulu';

  @override
  String get sortPriority => 'Prioritas';

  @override
  String get sortPomodoros => 'Pomodoro';

  @override
  String get active => 'Aktif';

  @override
  String get completed => 'Selesai';

  @override
  String get locked => 'Terkunci';

  @override
  String get forTimer => 'Untuk timer';

  @override
  String get priorityLow => 'Rendah';

  @override
  String get priorityMedium => 'Sedang';

  @override
  String get priorityHigh => 'Tinggi';

  @override
  String get taskLoadRemoteFailed =>
      'Tugas tidak dapat dimuat dari backend. Data lokal tetap ditampilkan.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Tugas disimpan secara lokal, tetapi tidak dapat disinkronkan dengan akun.';

  @override
  String get taskSaveFailedRolledBack =>
      'Tugas tidak dapat disimpan. Perubahan terakhir dibatalkan.';

  @override
  String get taskDeleteFailedRestored =>
      'Tugas tidak dapat dihapus dari akun. Tugas telah dipulihkan.';

  @override
  String get taskCreateTitle => 'Buat tugas';

  @override
  String get taskEditTitle => 'Edit tugas';

  @override
  String get taskTitleLabel => 'Judul';

  @override
  String get taskTitleRequired => 'Harap masukkan judul';

  @override
  String get taskTitleTooShort => 'Judul terlalu pendek.';

  @override
  String get taskDescriptionLabel => 'Deskripsi';

  @override
  String get priorityLabel => 'Prioritas';

  @override
  String get tagsLabel => 'Tag/kategori';

  @override
  String get tagsHint => 'mis. kuliah, kerja, pengembangan';

  @override
  String get timerResetTitle => 'Reset timer?';

  @override
  String get timerResetMessage =>
      'Fase saat ini akan dibatalkan dan tidak disimpan sebagai sesi yang selesai.';

  @override
  String get taskNoneSelected => 'Tidak ada tugas yang dipilih';

  @override
  String currentTask(String title) {
    return 'Tugas saat ini: $title';
  }

  @override
  String get taskForWorkPhase => 'Tugas untuk fase kerja ini';

  @override
  String get taskLockedToPhase => 'Fase ini terkunci pada tugas yang dipilih.';

  @override
  String get phaseWork => 'Fase kerja';

  @override
  String get phaseShortBreak => 'Istirahat pendek';

  @override
  String get phaseLongBreak => 'Istirahat panjang';

  @override
  String get timerStatusSaving => 'Menyimpan ...';

  @override
  String get timerStatusRunning => 'Berjalan';

  @override
  String get timerStatusPaused => 'Dijeda';

  @override
  String get timerStatusReady => 'Siap';

  @override
  String get phaseDescriptionWork => 'Waktu fokus';

  @override
  String get phaseDescriptionShortBreak => 'Pemulihan singkat';

  @override
  String get phaseDescriptionLongBreak => 'Pemulihan lebih lama';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Berikutnya: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Hari ini: memuat ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Hari ini: $pomodoros';
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
  String get pause => 'Jeda';

  @override
  String get continueButton => 'Lanjutkan';

  @override
  String get start => 'Mulai';

  @override
  String get skipPause => 'Lewati istirahat';

  @override
  String get shortcutSpaceCompact => 'Space: Mulai/Jeda';

  @override
  String get shortcutResetCompact => 'R: Reset';

  @override
  String get shortcutSkipCompact => 'S: Lewati';

  @override
  String get shortcutSpace => 'Spasi: Mulai/Jeda';

  @override
  String get shortcutReset => 'R: Reset';

  @override
  String get shortcutSkip => 'S: Lewati istirahat';

  @override
  String get phaseSavingTitle => 'Menyimpan fase';

  @override
  String get phaseSavingDescription =>
      'Fase yang selesai sedang disimpan dan timer sedang disiapkan.';

  @override
  String get storageProblem => 'Masalah penyimpanan';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'Fase yang selesai sedang disimpan di latar belakang.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count fase yang selesai sedang disimpan di latar belakang.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Fase yang selesai tidak dapat disimpan secara lokal.';

  @override
  String get timerBackendSyncFailed =>
      'Fase yang selesai telah disimpan secara lokal, tetapi belum disinkronkan dengan backend.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed dari $total';
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

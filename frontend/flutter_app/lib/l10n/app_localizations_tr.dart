// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Pomodoro Uygulaması';

  @override
  String get navTimer => 'Zamanlayıcı';

  @override
  String get navTasks => 'Görevler';

  @override
  String get navStats => 'İstatistikler';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get navAccount => 'Hesap';

  @override
  String get close => 'Kapat';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get save => 'Kaydet';

  @override
  String get reset => 'Sıfırla';

  @override
  String get refresh => 'Yenile';

  @override
  String get messageClose => 'Mesajı kapat';

  @override
  String get or => 'veya';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get emailVerifiedSuccess =>
      'E-posta başarıyla doğrulandı. Artık giriş yapabilirsiniz.';

  @override
  String get emailVerifiedExpired => 'Doğrulama bağlantısının süresi doldu.';

  @override
  String get emailVerifiedInvalid => 'Doğrulama bağlantısı geçersiz.';

  @override
  String get sessionSyncOneWithAccount =>
      'Bir oturum hesabınızla senkronize ediliyor.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count oturum hesabınızla senkronize ediliyor.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'Bir yerel oturum giriş yaptıktan sonra senkronize edilecek.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count yerel oturum giriş yaptıktan sonra senkronize edilecek.';
  }

  @override
  String get sessionSyncOnePending => 'Bir oturum senkronizasyon bekliyor.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count oturum senkronizasyon bekliyor.';
  }

  @override
  String get sessionSyncDone => 'Senkronizasyon tamamlandı.';

  @override
  String get sessionSyncFailed =>
      'Oturumlar şu anda senkronize edilemedi. Daha sonra tekrar denenecek.';

  @override
  String get accountTitle => 'Kullanıcı hesabı';

  @override
  String get loginTitle => 'Giriş';

  @override
  String get createAccountTitle => 'Yeni hesap oluştur';

  @override
  String get emailPasswordLoginTitle => 'E-posta ve şifre ile giriş yap';

  @override
  String get emailPasswordCreateTitle => 'E-posta/şifre hesabı oluştur';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get loginButton => 'Giriş yap';

  @override
  String get createAccountButton => 'Hesap oluştur';

  @override
  String get rememberSessionTitle => 'Bu cihazda oturumu açık tut';

  @override
  String get rememberSessionSubtitle =>
      'Devre dışı bırakılırsa giriş yalnızca mevcut uygulama oturumu için aktif kalır.';

  @override
  String get forgotPasswordButton => 'Şifrenizi mi unuttunuz?';

  @override
  String get alreadyHaveAccount => 'Zaten bir hesabım var';

  @override
  String get googleSection => 'Google bölümü';

  @override
  String get googleLoginButton => 'Google ile giriş yap';

  @override
  String get googleCreateButton => 'Google ile hesap oluştur';

  @override
  String get googleNotConfigured => 'Google girişi yapılandırılmamış.';

  @override
  String get googlePreparing => 'Google girişi hazırlanıyor ...';

  @override
  String get googleNoIdToken => 'Google geçerli bir ID token döndürmedi.';

  @override
  String googlePrepareFailed(String error) {
    return 'Google girişi hazırlanamadı: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google girişi başarısız oldu: $error';
  }

  @override
  String get googleLoginSuccess => 'Google ile başarıyla giriş yapıldı.';

  @override
  String get googleAccountCreated =>
      'Google hesabı oluşturuldu ve giriş yaptınız.';

  @override
  String get googleWebOnly =>
      'Google girişi yalnızca web uygulamasında kullanılabilir';

  @override
  String get githubSection => 'GitHub bölümü';

  @override
  String get githubLoginButton => 'GitHub ile giriş yap';

  @override
  String get githubCreateButton => 'GitHub ile hesap oluştur';

  @override
  String get githubNotConfigured => 'GitHub girişi yapılandırılmamış.';

  @override
  String get githubCancelled =>
      'GitHub girişi iptal edildi veya başarısız oldu.';

  @override
  String get githubSecurityCancelled =>
      'GitHub girişi güvenlik nedeniyle iptal edildi.';

  @override
  String get githubNoValidCode => 'GitHub geçerli bir kod döndürmedi.';

  @override
  String get githubLoginSuccess => 'GitHub ile başarıyla giriş yapıldı.';

  @override
  String get githubAccountCreated =>
      'GitHub hesabı oluşturuldu ve giriş yaptınız.';

  @override
  String get passwordResetTitle => 'Şifreyi sıfırla';

  @override
  String get passwordResetDescription =>
      'E-posta adresinizi girin. Bir hesap varsa şifre sıfırlama bağlantısı alırsınız.';

  @override
  String get sendResetLink => 'Sıfırlama bağlantısı gönder';

  @override
  String get backToLogin => 'Girişe geri dön';

  @override
  String get setNewPasswordTitle => 'Yeni şifre belirle';

  @override
  String get setNewPasswordDescription =>
      'Hesabınız için yeni bir şifre belirleyin.';

  @override
  String get newPasswordLabel => 'Yeni şifre';

  @override
  String get repeatNewPasswordLabel => 'Yeni şifreyi tekrarla';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get savePassword => 'Şifreyi kaydet';

  @override
  String get registrationSuccess =>
      'Kayıt başarılı. Lütfen e-posta adresinizi doğrulayın ve ardından giriş yapın.';

  @override
  String get passwordResetRequestSuccess =>
      'Bu e-posta ile bir hesap varsa sıfırlama bağlantısı gönderildi.';

  @override
  String get passwordChangedSuccess =>
      'Şifre değiştirildi. Artık giriş yapabilirsiniz.';

  @override
  String get passwordResetMailSent =>
      'Hesap varsa sıfırlama bağlantısı gönderildi.';

  @override
  String get loginSuccess => 'Başarıyla giriş yapıldı.';

  @override
  String get invalidEmail => 'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get passwordMinLength => 'En az 8 karakter';

  @override
  String get loggedInTitle => 'Kullanıcı hesabı';

  @override
  String get loggedInDescription => 'Şu anda giriş yapmış durumdasınız.';

  @override
  String get emailAddress => 'E-posta adresi';

  @override
  String get emailStatus => 'E-posta durumu';

  @override
  String get emailVerified => 'Doğrulandı';

  @override
  String get emailNotVerified => 'Henüz doğrulanmadı';

  @override
  String get accountCreated => 'Hesap oluşturuldu';

  @override
  String get synchronization => 'Senkronizasyon';

  @override
  String get accountInfoWarning =>
      'Geçerli bir giriş token’ı yerel olarak kaydedildiyse uygulama oturumunuzu otomatik olarak geri yükleyebilir. Ortak cihazlarda her zaman çıkış yapmalısınız.';

  @override
  String get changePassword => 'Şifreyi değiştir';

  @override
  String get logout => 'Çıkış yap';

  @override
  String get syncRunning => 'Senkronizasyon çalışıyor';

  @override
  String get syncOneWaiting => '1 oturum bekliyor';

  @override
  String syncManyWaiting(int count) {
    return '$count oturum bekliyor';
  }

  @override
  String get syncError => 'Senkronizasyon hatası';

  @override
  String get syncAllSynced => 'Her şey senkronize edildi';

  @override
  String get sessionExpired =>
      'Oturumunuzun süresi doldu. Lütfen tekrar giriş yapın.';

  @override
  String get settingsSaved => 'Ayarlar kaydedildi.';

  @override
  String get timerTimesTitle => 'Zamanlayıcı süreleri';

  @override
  String get timerTimesDescription =>
      'Çalışma aşamalarının ve molaların ne kadar süreceğini belirleyin.';

  @override
  String get workTime => 'Çalışma süresi';

  @override
  String get shortBreak => 'Kısa mola';

  @override
  String get longBreak => 'Uzun mola';

  @override
  String get longBreakAfter => 'Uzun mola şu sayıdan sonra';

  @override
  String get minutes => 'Dakika';

  @override
  String get pomodorosUnit => 'Pomodoro';

  @override
  String get behaviorTitle => 'Davranış';

  @override
  String get behaviorDescription =>
      'Zamanlayıcının kullanım sırasında nasıl davranacağını ayarlayın.';

  @override
  String get autoStartNextPhase => 'Sonraki aşamayı otomatik başlat';

  @override
  String get enableSound => 'Sesi etkinleştir';

  @override
  String get enableVibration => 'Titreşimi etkinleştir';

  @override
  String get vibrationDescription =>
      'Gerçek mobil titreşim daha sonra bir eklenti üzerinden bağlanacak.';

  @override
  String get languageTitle => 'Dil';

  @override
  String get languageDescription =>
      'Uygulama dilini seçin. “Sistem dili” seçildiğinde uygulama tarayıcı veya cihaz dilini kullanır.';

  @override
  String get languageLabel => 'Uygulama dili';

  @override
  String get languageSystem => 'Sistem dili';

  @override
  String get languageGerman => 'Almanca';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageArabic => 'Arapça';

  @override
  String get languageChinese => 'Çince';

  @override
  String get languageFrench => 'Fransızca';

  @override
  String get languageSpanish => 'İspanyolca';

  @override
  String get languageHindi => 'Hintçe';

  @override
  String get languagePortuguese => 'Portekizce';

  @override
  String get languageRussian => 'Rusça';

  @override
  String get languageJapanese => 'Japonca';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageItalian => 'İtalyanca';

  @override
  String get languageKorean => 'Korece';

  @override
  String get languageIndonesian => 'Endonezce';

  @override
  String get languagePersian => 'Farsça';

  @override
  String get appearanceTitle => 'Görünüm';

  @override
  String get appearanceDescription =>
      'Uygulamanın tasarım modunu ve ana rengini seçin.';

  @override
  String get appearanceLabel => 'Görünüm';

  @override
  String get systemTheme => 'Sistem';

  @override
  String get lightMode => 'Açık mod';

  @override
  String get darkMode => 'Koyu mod';

  @override
  String get themeColor => 'Tema rengi';

  @override
  String get red => 'Kırmızı';

  @override
  String get blue => 'Mavi';

  @override
  String get green => 'Yeşil';

  @override
  String get purple => 'Mor';

  @override
  String get saveSettings => 'Ayarları kaydet';

  @override
  String get noChanges => 'Değişiklik yok';

  @override
  String get decrease => 'Azalt';

  @override
  String get increase => 'Artır';

  @override
  String get minutesShort => 'dk';

  @override
  String get settingsSavedButNotSynced =>
      'Ayarlar yerel olarak kaydedildi, ancak henüz senkronize edilmedi.';

  @override
  String get settingsLoadRemoteFailed =>
      'Ayarlar backend’den yüklenemedi. Yerel ayarlar kullanılacak.';

  @override
  String get statsTitle => 'İstatistikler';

  @override
  String get statsRefresh => 'Yenile';

  @override
  String get statsWeek => 'Hafta';

  @override
  String get statsMonth => 'Ay';

  @override
  String get statsYear => 'Yıl';

  @override
  String get statsTasksTime => 'Görev süresi';

  @override
  String get chartFocusPerDay => 'Günlük odak süresi';

  @override
  String get chartFocusPerCalendarWeek => 'Takvim haftasına göre odak süresi';

  @override
  String get chartFocusPerMonth => 'Aylık odak süresi';

  @override
  String get chartFocusPerTask => 'Göreve göre odak süresi';

  @override
  String get xAxisWeek => 'X ekseni: haftanın günleri';

  @override
  String get xAxisMonth => 'X ekseni: ay içindeki takvim haftaları';

  @override
  String get xAxisYear => 'X ekseni: yılın ayları';

  @override
  String get xAxisTasks => 'X ekseni: görevler';

  @override
  String get periodNoData => 'Dönem: Veri yok';

  @override
  String periodRange(String start, String end) {
    return 'Dönem: $start – $end';
  }

  @override
  String get previousPeriod => 'Önceki dönem';

  @override
  String get nextPeriod => 'Sonraki dönem';

  @override
  String get statsLoading => 'İstatistikler yükleniyor ...';

  @override
  String get taskStatsLoading => 'Görev istatistikleri yükleniyor ...';

  @override
  String get taskStatsEmpty =>
      'Henüz görev başına çalışma süresi yok. Verileri görmek için bir görevle Pomodoro başlatın.';

  @override
  String get pomodoros => 'Pomodoro';

  @override
  String get focusTime => 'Odak süresi';

  @override
  String get streak => 'Seri';

  @override
  String get bestPeriod => 'En iyi dönem';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün',
      one: '1 gün',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y ekseni: saat cinsinden odak süresi · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'Dakika cinsinden odak süresi';

  @override
  String get sortedByHighestFocusTime =>
      'En yüksek odak süresine göre sıralandı.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoro · $minutes dk';
  }

  @override
  String get statsNoData => 'Henüz istatistik verisi yok.';

  @override
  String get statsLoadFailed =>
      'İstatistikler yüklenemedi. Lütfen giriş yapın ve internet bağlantınızı kontrol edin.';

  @override
  String get taskStatsLoadFailed => 'Görev istatistikleri yüklenemedi.';

  @override
  String get todayPomodorosLoadFailed => 'Bugünkü Pomodoro sayısı yüklenemedi.';

  @override
  String get noTaskTitle => 'Görev yok';

  @override
  String calendarWeekShort(int week) {
    return 'TH $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'TH $week/$year';
  }

  @override
  String get tasksTitle => 'Görevler';

  @override
  String get tasksRefreshTooltip => 'Görevleri yenile';

  @override
  String get taskSingular => 'Görev';

  @override
  String get deleteTaskTitle => 'Görev silinsin mi?';

  @override
  String deleteTaskMessage(String title) {
    return '“$title” görevini gerçekten silmek istiyor musunuz?';
  }

  @override
  String get tasksLoading => 'Görevler yükleniyor ...';

  @override
  String get tasksEmpty => 'Henüz görev yok. İlk görevinizi oluşturun.';

  @override
  String get tasksSearchEmpty =>
      'Görev bulunamadı. Aramayı veya filtreleri değiştirin.';

  @override
  String get noTimerTaskSelected => 'Zamanlayıcı için görev seçilmedi';

  @override
  String activeTimerTask(String title) {
    return 'Aktif zamanlayıcı görevi: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'Bir zamanlayıcı aşaması çalışıyor veya duraklatılmış. Bu nedenle görev şu anda kilitli.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'Bu görev bir sonraki çalışma aşaması için kullanılacak.';

  @override
  String get withoutTask => 'Görevsiz';

  @override
  String get searchTasks => 'Görev ara';

  @override
  String get clearSearch => 'Aramayı temizle';

  @override
  String get filterAll => 'Tümü';

  @override
  String get filterOpen => 'Açık';

  @override
  String get filterCompleted => 'Tamamlandı';

  @override
  String get sortLabel => 'Sıralama';

  @override
  String get sortNewest => 'Önce en yeni';

  @override
  String get sortPriority => 'Öncelik';

  @override
  String get sortPomodoros => 'Pomodoro';

  @override
  String get active => 'Aktif';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get locked => 'Kilitli';

  @override
  String get forTimer => 'Zamanlayıcı için';

  @override
  String get priorityLow => 'Düşük';

  @override
  String get priorityMedium => 'Orta';

  @override
  String get priorityHigh => 'Yüksek';

  @override
  String get taskLoadRemoteFailed =>
      'Görevler backend’den yüklenemedi. Yerel veriler gösterilmeye devam edecek.';

  @override
  String get taskSavedLocallyNotSynced =>
      'Görev yerel olarak kaydedildi, ancak hesapla senkronize edilemedi.';

  @override
  String get taskSaveFailedRolledBack =>
      'Görev kaydedilemedi. Son değişiklik geri alındı.';

  @override
  String get taskDeleteFailedRestored =>
      'Görev hesaptan silinemedi. Görev geri yüklendi.';

  @override
  String get taskCreateTitle => 'Görev oluştur';

  @override
  String get taskEditTitle => 'Görevi düzenle';

  @override
  String get taskTitleLabel => 'Başlık';

  @override
  String get taskTitleRequired => 'Lütfen başlık girin';

  @override
  String get taskTitleTooShort => 'Başlık çok kısa.';

  @override
  String get taskDescriptionLabel => 'Açıklama';

  @override
  String get priorityLabel => 'Öncelik';

  @override
  String get tagsLabel => 'Etiketler/kategoriler';

  @override
  String get tagsHint => 'örn. üniversite, iş, geliştirme';

  @override
  String get timerResetTitle => 'Zamanlayıcı sıfırlansın mı?';

  @override
  String get timerResetMessage =>
      'Mevcut aşama iptal edilecek ve tamamlanmış oturum olarak kaydedilmeyecek.';

  @override
  String get taskNoneSelected => 'Görev seçilmedi';

  @override
  String currentTask(String title) {
    return 'Mevcut görev: $title';
  }

  @override
  String get taskForWorkPhase => 'Bu çalışma aşaması için görev';

  @override
  String get taskLockedToPhase => 'Bu aşama seçilen göreve bağlıdır.';

  @override
  String get phaseWork => 'Çalışma aşaması';

  @override
  String get phaseShortBreak => 'Kısa mola';

  @override
  String get phaseLongBreak => 'Uzun mola';

  @override
  String get timerStatusSaving => 'Kaydediliyor ...';

  @override
  String get timerStatusRunning => 'Çalışıyor';

  @override
  String get timerStatusPaused => 'Duraklatıldı';

  @override
  String get timerStatusReady => 'Hazır';

  @override
  String get phaseDescriptionWork => 'Odak süresi';

  @override
  String get phaseDescriptionShortBreak => 'Kısa dinlenme';

  @override
  String get phaseDescriptionLongBreak => 'Daha uzun dinlenme';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · Sonra: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'Bugün: yükleniyor ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'Bugün: $pomodoros';
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
  String get pause => 'Duraklat';

  @override
  String get continueButton => 'Devam et';

  @override
  String get start => 'Başlat';

  @override
  String get skipPause => 'Molayı atla';

  @override
  String get shortcutSpaceCompact => 'Boşluk: Başlat/Duraklat';

  @override
  String get shortcutResetCompact => 'R: Sıfırla';

  @override
  String get shortcutSkipCompact => 'S: Atla';

  @override
  String get shortcutSpace => 'Boşluk tuşu: Başlat/Duraklat';

  @override
  String get shortcutReset => 'R: Sıfırla';

  @override
  String get shortcutSkip => 'S: Molayı atla';

  @override
  String get phaseSavingTitle => 'Aşama kaydediliyor';

  @override
  String get phaseSavingDescription =>
      'Tamamlanan aşama kaydediliyor ve zamanlayıcı hazırlanıyor.';

  @override
  String get storageProblem => 'Depolama sorunu';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'Tamamlanan aşama arka planda kaydediliyor.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count tamamlanan aşama arka planda kaydediliyor.';
  }

  @override
  String get timerLocalSaveFailed =>
      'Tamamlanan aşama yerel olarak kaydedilemedi.';

  @override
  String get timerBackendSyncFailed =>
      'Tamamlanan aşama yerel olarak kaydedildi, ancak henüz backend ile senkronize edilmedi.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed / $total';
  }
}

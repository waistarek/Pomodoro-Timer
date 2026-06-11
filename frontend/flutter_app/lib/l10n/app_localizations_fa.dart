// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'برنامه پومودورو';

  @override
  String get navTimer => 'تایمر';

  @override
  String get navTasks => 'وظایف';

  @override
  String get navStats => 'آمار';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get navAccount => 'حساب';

  @override
  String get close => 'بستن';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ویرایش';

  @override
  String get save => 'ذخیره';

  @override
  String get reset => 'بازنشانی';

  @override
  String get refresh => 'به‌روزرسانی';

  @override
  String get messageClose => 'بستن پیام';

  @override
  String get or => 'یا';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get emailVerifiedSuccess =>
      'ایمیل با موفقیت تأیید شد. اکنون می‌توانید وارد شوید.';

  @override
  String get emailVerifiedExpired => 'لینک تأیید منقضی شده است.';

  @override
  String get emailVerifiedInvalid => 'لینک تأیید نامعتبر است.';

  @override
  String get sessionSyncOneWithAccount =>
      'یک جلسه با حساب شما همگام‌سازی می‌شود.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count جلسه با حساب شما همگام‌سازی می‌شوند.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'یک جلسه محلی پس از ورود همگام‌سازی می‌شود.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '$count جلسه محلی پس از ورود همگام‌سازی می‌شوند.';
  }

  @override
  String get sessionSyncOnePending => 'یک جلسه در انتظار همگام‌سازی است.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count جلسه در انتظار همگام‌سازی هستند.';
  }

  @override
  String get sessionSyncDone => 'همگام‌سازی کامل شد.';

  @override
  String get sessionSyncFailed =>
      'جلسه‌ها در حال حاضر همگام‌سازی نشدند. بعداً دوباره تلاش می‌شود.';

  @override
  String get accountTitle => 'حساب کاربری';

  @override
  String get loginTitle => 'ورود';

  @override
  String get createAccountTitle => 'ایجاد حساب جدید';

  @override
  String get emailPasswordLoginTitle => 'ورود با ایمیل و رمز عبور';

  @override
  String get emailPasswordCreateTitle => 'ایجاد حساب با ایمیل و رمز عبور';

  @override
  String get emailLabel => 'ایمیل';

  @override
  String get passwordLabel => 'رمز عبور';

  @override
  String get loginButton => 'ورود';

  @override
  String get createAccountButton => 'ایجاد حساب';

  @override
  String get rememberSessionTitle => 'در این دستگاه وارد بمان';

  @override
  String get rememberSessionSubtitle =>
      'اگر غیرفعال باشد، ورود فقط برای جلسه فعلی برنامه فعال می‌ماند.';

  @override
  String get forgotPasswordButton => 'رمز عبور را فراموش کرده‌اید؟';

  @override
  String get alreadyHaveAccount => 'من قبلاً حساب دارم';

  @override
  String get googleSection => 'بخش Google';

  @override
  String get googleLoginButton => 'ورود با Google';

  @override
  String get googleCreateButton => 'ایجاد حساب با Google';

  @override
  String get googleNotConfigured => 'ورود با Google پیکربندی نشده است.';

  @override
  String get googlePreparing => 'در حال آماده‌سازی ورود با Google ...';

  @override
  String get googleNoIdToken => 'Google توکن شناسه معتبر برنگرداند.';

  @override
  String googlePrepareFailed(String error) {
    return 'آماده‌سازی ورود با Google ممکن نشد: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'ورود با Google ناموفق بود: $error';
  }

  @override
  String get googleLoginSuccess => 'ورود با Google با موفقیت انجام شد.';

  @override
  String get googleAccountCreated => 'حساب Google ایجاد شد و شما وارد شدید.';

  @override
  String get googleWebOnly => 'ورود با Google فقط در برنامه وب در دسترس است';

  @override
  String get githubSection => 'بخش GitHub';

  @override
  String get githubLoginButton => 'ورود با GitHub';

  @override
  String get githubCreateButton => 'ایجاد حساب با GitHub';

  @override
  String get githubNotConfigured => 'ورود با GitHub پیکربندی نشده است.';

  @override
  String get githubCancelled => 'ورود با GitHub لغو شد یا ناموفق بود.';

  @override
  String get githubSecurityCancelled =>
      'ورود با GitHub به دلایل امنیتی لغو شد.';

  @override
  String get githubNoValidCode => 'GitHub کد معتبر برنگرداند.';

  @override
  String get githubLoginSuccess => 'ورود با GitHub با موفقیت انجام شد.';

  @override
  String get githubAccountCreated => 'حساب GitHub ایجاد شد و شما وارد شدید.';

  @override
  String get passwordResetTitle => 'بازنشانی رمز عبور';

  @override
  String get passwordResetDescription =>
      'آدرس ایمیل خود را وارد کنید. اگر حسابی وجود داشته باشد، لینک بازنشانی رمز عبور را دریافت می‌کنید.';

  @override
  String get sendResetLink => 'ارسال لینک بازنشانی';

  @override
  String get backToLogin => 'بازگشت به ورود';

  @override
  String get setNewPasswordTitle => 'تنظیم رمز عبور جدید';

  @override
  String get setNewPasswordDescription =>
      'برای حساب خود یک رمز عبور جدید تعیین کنید.';

  @override
  String get newPasswordLabel => 'رمز عبور جدید';

  @override
  String get repeatNewPasswordLabel => 'تکرار رمز عبور جدید';

  @override
  String get passwordsDoNotMatch => 'رمزهای عبور مطابقت ندارند';

  @override
  String get savePassword => 'ذخیره رمز عبور';

  @override
  String get registrationSuccess =>
      'ثبت‌نام با موفقیت انجام شد. لطفاً ایمیل خود را تأیید کنید و سپس وارد شوید.';

  @override
  String get passwordResetRequestSuccess =>
      'اگر حسابی با این ایمیل وجود داشته باشد، لینک بازنشانی ارسال شده است.';

  @override
  String get passwordChangedSuccess =>
      'رمز عبور تغییر کرد. اکنون می‌توانید وارد شوید.';

  @override
  String get passwordResetMailSent =>
      'اگر حساب وجود داشته باشد، لینک بازنشانی ارسال شده است.';

  @override
  String get loginSuccess => 'ورود با موفقیت انجام شد.';

  @override
  String get invalidEmail => 'لطفاً یک ایمیل معتبر وارد کنید';

  @override
  String get passwordMinLength => 'حداقل ۸ کاراکتر';

  @override
  String get loggedInTitle => 'حساب کاربری';

  @override
  String get loggedInDescription => 'شما در حال حاضر وارد شده‌اید.';

  @override
  String get emailAddress => 'آدرس ایمیل';

  @override
  String get emailStatus => 'وضعیت ایمیل';

  @override
  String get emailVerified => 'تأیید شده';

  @override
  String get emailNotVerified => 'هنوز تأیید نشده';

  @override
  String get accountCreated => 'حساب ایجاد شد';

  @override
  String get synchronization => 'همگام‌سازی';

  @override
  String get accountInfoWarning =>
      'اگر یک توکن ورود معتبر به‌صورت محلی ذخیره شده باشد، برنامه می‌تواند جلسه شما را به‌صورت خودکار بازیابی کند. در دستگاه‌های مشترک همیشه باید خارج شوید.';

  @override
  String get changePassword => 'تغییر رمز عبور';

  @override
  String get logout => 'خروج';

  @override
  String get syncRunning => 'همگام‌سازی در حال اجراست';

  @override
  String get syncOneWaiting => '۱ جلسه در انتظار است';

  @override
  String syncManyWaiting(int count) {
    return '$count جلسه در انتظار هستند';
  }

  @override
  String get syncError => 'خطای همگام‌سازی';

  @override
  String get syncAllSynced => 'همه چیز همگام‌سازی شد';

  @override
  String get sessionExpired =>
      'جلسه شما منقضی شده است. لطفاً دوباره وارد شوید.';

  @override
  String get settingsSaved => 'تنظیمات ذخیره شد.';

  @override
  String get timerTimesTitle => 'مدت‌های تایمر';

  @override
  String get timerTimesDescription =>
      'مدت مرحله‌های کار و استراحت را تعیین کنید.';

  @override
  String get workTime => 'زمان کار';

  @override
  String get shortBreak => 'استراحت کوتاه';

  @override
  String get longBreak => 'استراحت طولانی';

  @override
  String get longBreakAfter => 'استراحت طولانی پس از';

  @override
  String get minutes => 'دقیقه';

  @override
  String get pomodorosUnit => 'پومودورو';

  @override
  String get behaviorTitle => 'رفتار';

  @override
  String get behaviorDescription =>
      'نحوه رفتار تایمر هنگام استفاده را تنظیم کنید.';

  @override
  String get autoStartNextPhase => 'شروع خودکار مرحله بعدی';

  @override
  String get enableSound => 'فعال‌سازی صدا';

  @override
  String get enableVibration => 'فعال‌سازی لرزش';

  @override
  String get vibrationDescription =>
      'لرزش واقعی موبایل بعداً از طریق یک افزونه متصل می‌شود.';

  @override
  String get languageTitle => 'زبان';

  @override
  String get languageDescription =>
      'زبان برنامه را انتخاب کنید. با «زبان سیستم»، برنامه از زبان مرورگر یا دستگاه استفاده می‌کند.';

  @override
  String get languageLabel => 'زبان برنامه';

  @override
  String get languageSystem => 'زبان سیستم';

  @override
  String get languageGerman => 'آلمانی';

  @override
  String get languageEnglish => 'انگلیسی';

  @override
  String get languageArabic => 'عربی';

  @override
  String get languageChinese => 'چینی';

  @override
  String get languageFrench => 'فرانسوی';

  @override
  String get languageSpanish => 'اسپانیایی';

  @override
  String get languageHindi => 'هندی';

  @override
  String get languagePortuguese => 'پرتغالی';

  @override
  String get languageRussian => 'روسی';

  @override
  String get languageJapanese => 'ژاپنی';

  @override
  String get languageTurkish => 'ترکی';

  @override
  String get languageItalian => 'ایتالیایی';

  @override
  String get languageKorean => 'کره‌ای';

  @override
  String get languageIndonesian => 'اندونزیایی';

  @override
  String get languagePersian => 'فارسی';

  @override
  String get appearanceTitle => 'ظاهر';

  @override
  String get appearanceDescription =>
      'حالت نمایش و رنگ اصلی برنامه را انتخاب کنید.';

  @override
  String get appearanceLabel => 'ظاهر';

  @override
  String get systemTheme => 'سیستم';

  @override
  String get lightMode => 'حالت روشن';

  @override
  String get darkMode => 'حالت تاریک';

  @override
  String get themeColor => 'رنگ پوسته';

  @override
  String get red => 'قرمز';

  @override
  String get blue => 'آبی';

  @override
  String get green => 'سبز';

  @override
  String get purple => 'بنفش';

  @override
  String get saveSettings => 'ذخیره تنظیمات';

  @override
  String get noChanges => 'تغییری وجود ندارد';

  @override
  String get decrease => 'کاهش';

  @override
  String get increase => 'افزایش';

  @override
  String get minutesShort => 'دقیقه';

  @override
  String get settingsSavedButNotSynced =>
      'تنظیمات به‌صورت محلی ذخیره شد، اما هنوز همگام‌سازی نشده است.';

  @override
  String get settingsLoadRemoteFailed =>
      'تنظیمات از بک‌اند بارگذاری نشد. تنظیمات محلی استفاده می‌شود.';

  @override
  String get statsTitle => 'آمار';

  @override
  String get statsRefresh => 'به‌روزرسانی';

  @override
  String get statsWeek => 'هفته';

  @override
  String get statsMonth => 'ماه';

  @override
  String get statsYear => 'سال';

  @override
  String get statsTasksTime => 'زمان وظایف';

  @override
  String get chartFocusPerDay => 'زمان تمرکز در هر روز';

  @override
  String get chartFocusPerCalendarWeek => 'زمان تمرکز در هر هفته تقویمی';

  @override
  String get chartFocusPerMonth => 'زمان تمرکز در هر ماه';

  @override
  String get chartFocusPerTask => 'زمان تمرکز برای هر وظیفه';

  @override
  String get xAxisWeek => 'محور X: روزهای هفته';

  @override
  String get xAxisMonth => 'محور X: هفته‌های تقویمی در ماه';

  @override
  String get xAxisYear => 'محور X: ماه‌های سال';

  @override
  String get xAxisTasks => 'محور X: وظایف';

  @override
  String get periodNoData => 'بازه: داده‌ای موجود نیست';

  @override
  String periodRange(String start, String end) {
    return 'بازه: $start – $end';
  }

  @override
  String get previousPeriod => 'بازه قبلی';

  @override
  String get nextPeriod => 'بازه بعدی';

  @override
  String get statsLoading => 'در حال بارگذاری آمار ...';

  @override
  String get taskStatsLoading => 'در حال بارگذاری آمار وظایف ...';

  @override
  String get taskStatsEmpty =>
      'هنوز زمان کار برای هر وظیفه وجود ندارد. برای دیدن داده‌ها، یک پومودورو را با وظیفه شروع کنید.';

  @override
  String get pomodoros => 'پومودورو';

  @override
  String get focusTime => 'زمان تمرکز';

  @override
  String get streak => 'روند پیوسته';

  @override
  String get bestPeriod => 'بهترین بازه';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز',
      one: '۱ روز',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'محور Y: زمان تمرکز بر حسب ساعت · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'زمان تمرکز بر حسب دقیقه';

  @override
  String get sortedByHighestFocusTime => 'مرتب‌شده بر اساس بیشترین زمان تمرکز.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros پومودورو · $minutes دقیقه';
  }

  @override
  String get statsNoData => 'هنوز داده آماری وجود ندارد.';

  @override
  String get statsLoadFailed =>
      'آمار بارگذاری نشد. لطفاً وارد شوید و اتصال اینترنت را بررسی کنید.';

  @override
  String get taskStatsLoadFailed => 'آمار وظایف بارگذاری نشد.';

  @override
  String get todayPomodorosLoadFailed =>
      'تعداد پومودوروهای امروز بارگذاری نشد.';

  @override
  String get noTaskTitle => 'بدون وظیفه';

  @override
  String calendarWeekShort(int week) {
    return 'هفته $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'هفته $week/$year';
  }

  @override
  String get tasksTitle => 'وظایف';

  @override
  String get tasksRefreshTooltip => 'به‌روزرسانی وظایف';

  @override
  String get taskSingular => 'وظیفه';

  @override
  String get deleteTaskTitle => 'وظیفه حذف شود؟';

  @override
  String deleteTaskMessage(String title) {
    return 'آیا واقعاً می‌خواهید وظیفه «$title» را حذف کنید؟';
  }

  @override
  String get tasksLoading => 'در حال بارگذاری وظایف ...';

  @override
  String get tasksEmpty =>
      'هنوز وظیفه‌ای وجود ندارد. اولین وظیفه خود را ایجاد کنید.';

  @override
  String get tasksSearchEmpty =>
      'وظیفه‌ای پیدا نشد. جستجو یا فیلترها را تغییر دهید.';

  @override
  String get noTimerTaskSelected => 'هیچ وظیفه‌ای برای تایمر انتخاب نشده است';

  @override
  String activeTimerTask(String title) {
    return 'وظیفه فعال تایمر: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'یک مرحله تایمر در حال اجرا یا متوقف‌شده است. بنابراین وظیفه در حال حاضر قفل است.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'این وظیفه برای مرحله کاری بعدی استفاده می‌شود.';

  @override
  String get withoutTask => 'بدون وظیفه';

  @override
  String get searchTasks => 'جستجوی وظایف';

  @override
  String get clearSearch => 'پاک‌کردن جستجو';

  @override
  String get filterAll => 'همه';

  @override
  String get filterOpen => 'باز';

  @override
  String get filterCompleted => 'انجام‌شده';

  @override
  String get sortLabel => 'مرتب‌سازی';

  @override
  String get sortNewest => 'جدیدترین‌ها ابتدا';

  @override
  String get sortPriority => 'اولویت';

  @override
  String get sortPomodoros => 'پومودورو';

  @override
  String get active => 'فعال';

  @override
  String get completed => 'انجام‌شده';

  @override
  String get locked => 'قفل‌شده';

  @override
  String get forTimer => 'برای تایمر';

  @override
  String get priorityLow => 'کم';

  @override
  String get priorityMedium => 'متوسط';

  @override
  String get priorityHigh => 'زیاد';

  @override
  String get taskLoadRemoteFailed =>
      'وظایف از بک‌اند بارگذاری نشدند. داده‌های محلی همچنان نمایش داده می‌شوند.';

  @override
  String get taskSavedLocallyNotSynced =>
      'وظیفه به‌صورت محلی ذخیره شد، اما با حساب همگام‌سازی نشد.';

  @override
  String get taskSaveFailedRolledBack =>
      'وظیفه ذخیره نشد. آخرین تغییر برگردانده شد.';

  @override
  String get taskDeleteFailedRestored =>
      'وظیفه از حساب حذف نشد. وظیفه بازیابی شد.';

  @override
  String get taskCreateTitle => 'ایجاد وظیفه';

  @override
  String get taskEditTitle => 'ویرایش وظیفه';

  @override
  String get taskTitleLabel => 'عنوان';

  @override
  String get taskTitleRequired => 'لطفاً عنوان را وارد کنید';

  @override
  String get taskTitleTooShort => 'عنوان خیلی کوتاه است.';

  @override
  String get taskDescriptionLabel => 'توضیح';

  @override
  String get priorityLabel => 'اولویت';

  @override
  String get tagsLabel => 'برچسب‌ها/دسته‌ها';

  @override
  String get tagsHint => 'مثلاً دانشگاه، کار، توسعه';

  @override
  String get timerResetTitle => 'تایمر بازنشانی شود؟';

  @override
  String get timerResetMessage =>
      'مرحله فعلی لغو می‌شود و به‌عنوان جلسه کامل‌شده ذخیره نمی‌شود.';

  @override
  String get taskNoneSelected => 'هیچ وظیفه‌ای انتخاب نشده است';

  @override
  String currentTask(String title) {
    return 'وظیفه فعلی: $title';
  }

  @override
  String get taskForWorkPhase => 'وظیفه برای این مرحله کاری';

  @override
  String get taskLockedToPhase => 'این مرحله به وظیفه انتخاب‌شده متصل است.';

  @override
  String get phaseWork => 'مرحله کار';

  @override
  String get phaseShortBreak => 'استراحت کوتاه';

  @override
  String get phaseLongBreak => 'استراحت طولانی';

  @override
  String get timerStatusSaving => 'در حال ذخیره ...';

  @override
  String get timerStatusRunning => 'در حال اجرا';

  @override
  String get timerStatusPaused => 'متوقف';

  @override
  String get timerStatusReady => 'آماده';

  @override
  String get phaseDescriptionWork => 'زمان تمرکز';

  @override
  String get phaseDescriptionShortBreak => 'استراحت کوتاه';

  @override
  String get phaseDescriptionLongBreak => 'استراحت طولانی‌تر';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · بعدی: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'امروز: در حال بارگذاری ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'امروز: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count پومودورو',
      one: '۱ پومودورو',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'توقف';

  @override
  String get continueButton => 'ادامه';

  @override
  String get start => 'شروع';

  @override
  String get skipPause => 'رد کردن استراحت';

  @override
  String get shortcutSpaceCompact => 'Space: شروع/توقف';

  @override
  String get shortcutResetCompact => 'R: بازنشانی';

  @override
  String get shortcutSkipCompact => 'S: رد کردن';

  @override
  String get shortcutSpace => 'کلید فاصله: شروع/توقف';

  @override
  String get shortcutReset => 'R: بازنشانی';

  @override
  String get shortcutSkip => 'S: رد کردن استراحت';

  @override
  String get phaseSavingTitle => 'در حال ذخیره مرحله';

  @override
  String get phaseSavingDescription =>
      'مرحله کامل‌شده ذخیره می‌شود و تایمر آماده می‌شود.';

  @override
  String get storageProblem => 'مشکل ذخیره‌سازی';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'مرحله کامل‌شده در پس‌زمینه ذخیره می‌شود.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count مرحله کامل‌شده در پس‌زمینه ذخیره می‌شوند.';
  }

  @override
  String get timerLocalSaveFailed => 'مرحله کامل‌شده به‌صورت محلی ذخیره نشد.';

  @override
  String get timerBackendSyncFailed =>
      'مرحله کامل‌شده به‌صورت محلی ذخیره شد، اما هنوز با بک‌اند همگام‌سازی نشده است.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed از $total';
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

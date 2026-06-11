// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق بومودورو';

  @override
  String get navTimer => 'المؤقت';

  @override
  String get navTasks => 'المهام';

  @override
  String get navStats => 'الإحصائيات';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navAccount => 'الحساب';

  @override
  String get close => 'إغلاق';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get reset => 'إعادة التعيين';

  @override
  String get refresh => 'تحديث';

  @override
  String get messageClose => 'إغلاق الرسالة';

  @override
  String get or => 'أو';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get emailVerifiedSuccess =>
      'تم تأكيد البريد الإلكتروني بنجاح. يمكنك الآن تسجيل الدخول.';

  @override
  String get emailVerifiedExpired => 'انتهت صلاحية رابط التأكيد.';

  @override
  String get emailVerifiedInvalid => 'رابط التأكيد غير صالح.';

  @override
  String get sessionSyncOneWithAccount => 'تتم مزامنة جلسة واحدة مع حسابك.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return 'تتم مزامنة $count جلسات مع حسابك.';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'ستتم مزامنة جلسة محلية واحدة بعد تسجيل الدخول.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return 'ستتم مزامنة $count جلسات محلية بعد تسجيل الدخول.';
  }

  @override
  String get sessionSyncOnePending => 'جلسة واحدة بانتظار المزامنة.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count جلسات بانتظار المزامنة.';
  }

  @override
  String get sessionSyncDone => 'اكتملت المزامنة.';

  @override
  String get sessionSyncFailed =>
      'تعذرت مزامنة الجلسات الآن. ستتم المحاولة مرة أخرى لاحقًا.';

  @override
  String get accountTitle => 'حساب المستخدم';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get createAccountTitle => 'إنشاء حساب جديد';

  @override
  String get emailPasswordLoginTitle =>
      'تسجيل الدخول بالبريد الإلكتروني وكلمة المرور';

  @override
  String get emailPasswordCreateTitle =>
      'إنشاء حساب بالبريد الإلكتروني وكلمة المرور';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get createAccountButton => 'إنشاء حساب';

  @override
  String get rememberSessionTitle => 'البقاء مسجلًا على هذا الجهاز';

  @override
  String get rememberSessionSubtitle =>
      'إذا تم تعطيل هذا الخيار، سيبقى تسجيل الدخول نشطًا فقط خلال جلسة التطبيق الحالية.';

  @override
  String get forgotPasswordButton => 'هل نسيت كلمة المرور؟';

  @override
  String get alreadyHaveAccount => 'لدي حساب بالفعل';

  @override
  String get googleSection => 'قسم Google';

  @override
  String get googleLoginButton => 'تسجيل الدخول باستخدام Google';

  @override
  String get googleCreateButton => 'إنشاء حساب باستخدام Google';

  @override
  String get googleNotConfigured => 'تسجيل الدخول باستخدام Google غير مهيأ.';

  @override
  String get googlePreparing => 'يتم تجهيز تسجيل الدخول باستخدام Google ...';

  @override
  String get googleNoIdToken => 'لم يُرجع Google رمز معرف صالحًا.';

  @override
  String googlePrepareFailed(String error) {
    return 'تعذر تجهيز تسجيل الدخول باستخدام Google: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'فشل تسجيل الدخول باستخدام Google: $error';
  }

  @override
  String get googleLoginSuccess => 'تم تسجيل الدخول باستخدام Google بنجاح.';

  @override
  String get googleAccountCreated => 'تم إنشاء حساب Google وتم تسجيل دخولك.';

  @override
  String get googleWebOnly =>
      'تسجيل الدخول باستخدام Google متاح فقط في تطبيق الويب';

  @override
  String get githubSection => 'قسم GitHub';

  @override
  String get githubLoginButton => 'تسجيل الدخول باستخدام GitHub';

  @override
  String get githubCreateButton => 'إنشاء حساب باستخدام GitHub';

  @override
  String get githubNotConfigured => 'تسجيل الدخول باستخدام GitHub غير مهيأ.';

  @override
  String get githubCancelled => 'تم إلغاء تسجيل الدخول باستخدام GitHub أو فشل.';

  @override
  String get githubSecurityCancelled =>
      'تم إلغاء تسجيل الدخول باستخدام GitHub لأسباب أمنية.';

  @override
  String get githubNoValidCode => 'لم يُرجع GitHub رمزًا صالحًا.';

  @override
  String get githubLoginSuccess => 'تم تسجيل الدخول باستخدام GitHub بنجاح.';

  @override
  String get githubAccountCreated => 'تم إنشاء حساب GitHub وتم تسجيل دخولك.';

  @override
  String get passwordResetTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get passwordResetDescription =>
      'أدخل بريدك الإلكتروني. إذا كان الحساب موجودًا، فستتلقى رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get backToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get setNewPasswordTitle => 'تعيين كلمة مرور جديدة';

  @override
  String get setNewPasswordDescription => 'عيّن كلمة مرور جديدة لحسابك.';

  @override
  String get newPasswordLabel => 'كلمة مرور جديدة';

  @override
  String get repeatNewPasswordLabel => 'تكرار كلمة المرور الجديدة';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get savePassword => 'حفظ كلمة المرور';

  @override
  String get registrationSuccess =>
      'تم التسجيل بنجاح. يرجى تأكيد بريدك الإلكتروني ثم تسجيل الدخول.';

  @override
  String get passwordResetRequestSuccess =>
      'إذا كان هناك حساب بهذا البريد الإلكتروني، فقد تم إرسال رابط إعادة التعيين.';

  @override
  String get passwordChangedSuccess =>
      'تم تغيير كلمة المرور. يمكنك الآن تسجيل الدخول.';

  @override
  String get passwordResetMailSent =>
      'إذا كان الحساب موجودًا، فقد تم إرسال رابط إعادة التعيين.';

  @override
  String get loginSuccess => 'تم تسجيل الدخول بنجاح.';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get passwordMinLength => '8 أحرف على الأقل';

  @override
  String get loggedInTitle => 'حساب المستخدم';

  @override
  String get loggedInDescription => 'أنت مسجل الدخول حاليًا.';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get emailStatus => 'حالة البريد الإلكتروني';

  @override
  String get emailVerified => 'مؤكد';

  @override
  String get emailNotVerified => 'لم يتم التأكيد بعد';

  @override
  String get accountCreated => 'تم إنشاء الحساب';

  @override
  String get synchronization => 'المزامنة';

  @override
  String get accountInfoWarning =>
      'يمكن للتطبيق استعادة جلستك تلقائيًا إذا كان رمز تسجيل دخول صالح مخزنًا محليًا. على الأجهزة المشتركة، يجب عليك دائمًا تسجيل الخروج.';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get syncRunning => 'المزامنة قيد التشغيل';

  @override
  String get syncOneWaiting => 'جلسة واحدة بانتظار المزامنة';

  @override
  String syncManyWaiting(int count) {
    return '$count جلسات بانتظار المزامنة';
  }

  @override
  String get syncError => 'خطأ في المزامنة';

  @override
  String get syncAllSynced => 'تمت مزامنة كل شيء';

  @override
  String get sessionExpired =>
      'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get settingsSaved => 'تم حفظ الإعدادات.';

  @override
  String get timerTimesTitle => 'مدد المؤقت';

  @override
  String get timerTimesDescription => 'حدد مدة مراحل العمل والاستراحات.';

  @override
  String get workTime => 'وقت العمل';

  @override
  String get shortBreak => 'استراحة قصيرة';

  @override
  String get longBreak => 'استراحة طويلة';

  @override
  String get longBreakAfter => 'استراحة طويلة بعد';

  @override
  String get minutes => 'دقائق';

  @override
  String get pomodorosUnit => 'بومودورو';

  @override
  String get behaviorTitle => 'السلوك';

  @override
  String get behaviorDescription => 'خصص طريقة عمل المؤقت أثناء الاستخدام.';

  @override
  String get autoStartNextPhase => 'بدء المرحلة التالية تلقائيًا';

  @override
  String get enableSound => 'تفعيل الصوت';

  @override
  String get enableVibration => 'تفعيل الاهتزاز';

  @override
  String get vibrationDescription =>
      'سيتم ربط الاهتزاز الفعلي على الهاتف لاحقًا عبر إضافة.';

  @override
  String get languageTitle => 'اللغة';

  @override
  String get languageDescription =>
      'اختر لغة التطبيق. عند اختيار “لغة النظام”، يستخدم التطبيق لغة المتصفح أو الجهاز.';

  @override
  String get languageLabel => 'لغة التطبيق';

  @override
  String get languageSystem => 'لغة النظام';

  @override
  String get languageGerman => 'الألمانية';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageChinese => 'الصينية';

  @override
  String get languageFrench => 'الفرنسية';

  @override
  String get languageSpanish => 'الإسبانية';

  @override
  String get languageHindi => 'الهندية';

  @override
  String get languagePortuguese => 'البرتغالية';

  @override
  String get languageRussian => 'الروسية';

  @override
  String get languageJapanese => 'اليابانية';

  @override
  String get languageTurkish => 'التركية';

  @override
  String get languageItalian => 'الإيطالية';

  @override
  String get languageKorean => 'الكورية';

  @override
  String get languageIndonesian => 'الإندونيسية';

  @override
  String get languagePersian => 'الفارسية';

  @override
  String get appearanceTitle => 'المظهر';

  @override
  String get appearanceDescription => 'اختر وضع العرض واللون الرئيسي للتطبيق.';

  @override
  String get appearanceLabel => 'المظهر';

  @override
  String get systemTheme => 'النظام';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get themeColor => 'لون السمة';

  @override
  String get red => 'أحمر';

  @override
  String get blue => 'أزرق';

  @override
  String get green => 'أخضر';

  @override
  String get purple => 'بنفسجي';

  @override
  String get saveSettings => 'حفظ الإعدادات';

  @override
  String get noChanges => 'لا توجد تغييرات';

  @override
  String get decrease => 'تقليل';

  @override
  String get increase => 'زيادة';

  @override
  String get minutesShort => 'د';

  @override
  String get settingsSavedButNotSynced =>
      'تم حفظ الإعدادات محليًا، لكنها لم تتم مزامنتها بعد.';

  @override
  String get settingsLoadRemoteFailed =>
      'تعذر تحميل الإعدادات من الخادم الخلفي. سيتم استخدام الإعدادات المحلية.';

  @override
  String get statsTitle => 'الإحصائيات';

  @override
  String get statsRefresh => 'تحديث';

  @override
  String get statsWeek => 'أسبوع';

  @override
  String get statsMonth => 'شهر';

  @override
  String get statsYear => 'سنة';

  @override
  String get statsTasksTime => 'وقت المهام';

  @override
  String get chartFocusPerDay => 'وقت التركيز لكل يوم';

  @override
  String get chartFocusPerCalendarWeek => 'وقت التركيز لكل أسبوع تقويمي';

  @override
  String get chartFocusPerMonth => 'وقت التركيز لكل شهر';

  @override
  String get chartFocusPerTask => 'وقت التركيز لكل مهمة';

  @override
  String get xAxisWeek => 'المحور X: أيام الأسبوع';

  @override
  String get xAxisMonth => 'المحور X: الأسابيع التقويمية في الشهر';

  @override
  String get xAxisYear => 'المحور X: أشهر السنة';

  @override
  String get xAxisTasks => 'المحور X: المهام';

  @override
  String get periodNoData => 'الفترة: لا توجد بيانات';

  @override
  String periodRange(String start, String end) {
    return 'الفترة: $start – $end';
  }

  @override
  String get previousPeriod => 'الفترة السابقة';

  @override
  String get nextPeriod => 'الفترة التالية';

  @override
  String get statsLoading => 'يتم تحميل الإحصائيات ...';

  @override
  String get taskStatsLoading => 'يتم تحميل إحصائيات المهام ...';

  @override
  String get taskStatsEmpty =>
      'لا يوجد وقت عمل لكل مهمة حتى الآن. ابدأ بومودورو مع مهمة لعرض البيانات.';

  @override
  String get pomodoros => 'بومودورو';

  @override
  String get focusTime => 'وقت التركيز';

  @override
  String get streak => 'السلسلة';

  @override
  String get bestPeriod => 'أفضل فترة';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'المحور Y: وقت التركيز بالساعات · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'وقت التركيز بالدقائق';

  @override
  String get sortedByHighestFocusTime => 'مرتبة حسب أعلى وقت تركيز.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros بومودورو · $minutes د';
  }

  @override
  String get statsNoData => 'لا توجد بيانات إحصائية حتى الآن.';

  @override
  String get statsLoadFailed =>
      'تعذر تحميل الإحصائيات. يرجى تسجيل الدخول والتحقق من اتصال الإنترنت.';

  @override
  String get taskStatsLoadFailed => 'تعذر تحميل إحصائيات المهام.';

  @override
  String get todayPomodorosLoadFailed => 'تعذر تحميل عدد بومودورو اليوم.';

  @override
  String get noTaskTitle => 'بدون مهمة';

  @override
  String calendarWeekShort(int week) {
    return 'أسبوع $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'أسبوع $week/$year';
  }

  @override
  String get tasksTitle => 'المهام';

  @override
  String get tasksRefreshTooltip => 'تحديث المهام';

  @override
  String get taskSingular => 'مهمة';

  @override
  String get deleteTaskTitle => 'حذف المهمة؟';

  @override
  String deleteTaskMessage(String title) {
    return 'هل تريد حقًا حذف المهمة “$title”؟';
  }

  @override
  String get tasksLoading => 'يتم تحميل المهام ...';

  @override
  String get tasksEmpty => 'لا توجد مهام حتى الآن. أنشئ أول مهمة لك.';

  @override
  String get tasksSearchEmpty =>
      'لم يتم العثور على مهام. غيّر البحث أو الفلاتر.';

  @override
  String get noTimerTaskSelected => 'لم يتم اختيار مهمة للمؤقت';

  @override
  String activeTimerTask(String title) {
    return 'مهمة المؤقت النشطة: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'هناك مرحلة مؤقت قيد التشغيل أو متوقفة مؤقتًا. لذلك المهمة مقفلة حاليًا.';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'سيتم استخدام هذه المهمة في مرحلة العمل التالية.';

  @override
  String get withoutTask => 'بدون مهمة';

  @override
  String get searchTasks => 'بحث في المهام';

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterOpen => 'مفتوحة';

  @override
  String get filterCompleted => 'مكتملة';

  @override
  String get sortLabel => 'الترتيب';

  @override
  String get sortNewest => 'الأحدث أولًا';

  @override
  String get sortPriority => 'الأولوية';

  @override
  String get sortPomodoros => 'بومودورو';

  @override
  String get active => 'نشطة';

  @override
  String get completed => 'مكتملة';

  @override
  String get locked => 'مقفلة';

  @override
  String get forTimer => 'للمؤقت';

  @override
  String get priorityLow => 'منخفضة';

  @override
  String get priorityMedium => 'متوسطة';

  @override
  String get priorityHigh => 'عالية';

  @override
  String get taskLoadRemoteFailed =>
      'تعذر تحميل المهام من الخادم الخلفي. ستظل البيانات المحلية معروضة.';

  @override
  String get taskSavedLocallyNotSynced =>
      'تم حفظ المهمة محليًا، لكن تعذرت مزامنتها مع الحساب.';

  @override
  String get taskSaveFailedRolledBack =>
      'تعذر حفظ المهمة. تم التراجع عن آخر تغيير.';

  @override
  String get taskDeleteFailedRestored =>
      'تعذر حذف المهمة من الحساب. تمت استعادة المهمة.';

  @override
  String get taskCreateTitle => 'إنشاء مهمة';

  @override
  String get taskEditTitle => 'تعديل المهمة';

  @override
  String get taskTitleLabel => 'العنوان';

  @override
  String get taskTitleRequired => 'يرجى إدخال عنوان';

  @override
  String get taskTitleTooShort => 'العنوان قصير جدًا.';

  @override
  String get taskDescriptionLabel => 'الوصف';

  @override
  String get priorityLabel => 'الأولوية';

  @override
  String get tagsLabel => 'الوسوم/الفئات';

  @override
  String get tagsHint => 'مثال: جامعة، عمل، تطوير';

  @override
  String get timerResetTitle => 'إعادة تعيين المؤقت؟';

  @override
  String get timerResetMessage =>
      'سيتم إلغاء المرحلة الحالية ولن يتم حفظها كجلسة مكتملة.';

  @override
  String get taskNoneSelected => 'لم يتم اختيار مهمة';

  @override
  String currentTask(String title) {
    return 'المهمة الحالية: $title';
  }

  @override
  String get taskForWorkPhase => 'مهمة هذه مرحلة العمل';

  @override
  String get taskLockedToPhase => 'هذه المرحلة مرتبطة بالمهمة المختارة.';

  @override
  String get phaseWork => 'مرحلة العمل';

  @override
  String get phaseShortBreak => 'استراحة قصيرة';

  @override
  String get phaseLongBreak => 'استراحة طويلة';

  @override
  String get timerStatusSaving => 'يتم الحفظ ...';

  @override
  String get timerStatusRunning => 'قيد التشغيل';

  @override
  String get timerStatusPaused => 'متوقف مؤقتًا';

  @override
  String get timerStatusReady => 'جاهز';

  @override
  String get phaseDescriptionWork => 'وقت التركيز';

  @override
  String get phaseDescriptionShortBreak => 'راحة قصيرة';

  @override
  String get phaseDescriptionLongBreak => 'راحة أطول';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · بعد ذلك: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'اليوم: يتم التحميل ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'اليوم: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بومودورو',
      one: 'بومودورو واحد',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get continueButton => 'متابعة';

  @override
  String get start => 'بدء';

  @override
  String get skipPause => 'تخطي الاستراحة';

  @override
  String get shortcutSpaceCompact => 'مسافة: بدء/إيقاف مؤقت';

  @override
  String get shortcutResetCompact => 'R: إعادة تعيين';

  @override
  String get shortcutSkipCompact => 'S: تخطي';

  @override
  String get shortcutSpace => 'مفتاح المسافة: بدء/إيقاف مؤقت';

  @override
  String get shortcutReset => 'R: إعادة تعيين';

  @override
  String get shortcutSkip => 'S: تخطي الاستراحة';

  @override
  String get phaseSavingTitle => 'يتم حفظ المرحلة';

  @override
  String get phaseSavingDescription =>
      'يتم حفظ المرحلة المكتملة وتجهيز المؤقت.';

  @override
  String get storageProblem => 'مشكلة في التخزين';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'يتم حفظ المرحلة المكتملة في الخلفية.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return 'يتم حفظ $count مراحل مكتملة في الخلفية.';
  }

  @override
  String get timerLocalSaveFailed => 'تعذر حفظ المرحلة المكتملة محليًا.';

  @override
  String get timerBackendSyncFailed =>
      'تم حفظ المرحلة المكتملة محليًا، لكنها لم تتم مزامنتها مع الخادم الخلفي بعد.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed من $total';
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
}

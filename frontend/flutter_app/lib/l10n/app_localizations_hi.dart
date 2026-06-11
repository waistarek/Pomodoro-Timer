// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'पोमोडोरो ऐप';

  @override
  String get navTimer => 'टाइमर';

  @override
  String get navTasks => 'कार्य';

  @override
  String get navStats => 'आँकड़े';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get navAccount => 'खाता';

  @override
  String get close => 'बंद करें';

  @override
  String get retry => 'फिर से प्रयास करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get edit => 'संपादित करें';

  @override
  String get save => 'सहेजें';

  @override
  String get reset => 'रीसेट करें';

  @override
  String get refresh => 'रीफ्रेश करें';

  @override
  String get messageClose => 'संदेश बंद करें';

  @override
  String get or => 'या';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get emailVerifiedSuccess =>
      'ई-मेल सफलतापूर्वक सत्यापित हो गया। अब आप लॉग इन कर सकते हैं।';

  @override
  String get emailVerifiedExpired => 'सत्यापन लिंक समाप्त हो चुका है।';

  @override
  String get emailVerifiedInvalid => 'सत्यापन लिंक अमान्य है।';

  @override
  String get sessionSyncOneWithAccount =>
      'एक सत्र आपके खाते के साथ सिंक हो रहा है।';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count सत्र आपके खाते के साथ सिंक हो रहे हैं।';
  }

  @override
  String get sessionSyncOneAfterLogin =>
      'लॉगिन के बाद एक स्थानीय सत्र सिंक किया जाएगा।';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return 'लॉगिन के बाद $count स्थानीय सत्र सिंक किए जाएँगे।';
  }

  @override
  String get sessionSyncOnePending => 'एक सत्र सिंक की प्रतीक्षा कर रहा है।';

  @override
  String sessionSyncManyPending(int count) {
    return '$count सत्र सिंक की प्रतीक्षा कर रहे हैं।';
  }

  @override
  String get sessionSyncDone => 'सिंक पूरा हो गया।';

  @override
  String get sessionSyncFailed =>
      'सत्र अभी सिंक नहीं किए जा सके। बाद में फिर से प्रयास किया जाएगा।';

  @override
  String get accountTitle => 'उपयोगकर्ता खाता';

  @override
  String get loginTitle => 'लॉगिन';

  @override
  String get createAccountTitle => 'नया खाता बनाएँ';

  @override
  String get emailPasswordLoginTitle => 'ई-मेल और पासवर्ड से लॉगिन करें';

  @override
  String get emailPasswordCreateTitle => 'ई-मेल/पासवर्ड खाता बनाएँ';

  @override
  String get emailLabel => 'ई-मेल';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get loginButton => 'लॉगिन करें';

  @override
  String get createAccountButton => 'खाता बनाएँ';

  @override
  String get rememberSessionTitle => 'इस डिवाइस पर लॉगिन बनाए रखें';

  @override
  String get rememberSessionSubtitle =>
      'यदि यह बंद है, तो लॉगिन केवल वर्तमान ऐप सत्र के लिए सक्रिय रहेगा।';

  @override
  String get forgotPasswordButton => 'पासवर्ड भूल गए?';

  @override
  String get alreadyHaveAccount => 'मेरे पास पहले से खाता है';

  @override
  String get googleSection => 'Google क्षेत्र';

  @override
  String get googleLoginButton => 'Google से लॉगिन करें';

  @override
  String get googleCreateButton => 'Google से खाता बनाएँ';

  @override
  String get googleNotConfigured => 'Google लॉगिन कॉन्फ़िगर नहीं है।';

  @override
  String get googlePreparing => 'Google लॉगिन तैयार किया जा रहा है ...';

  @override
  String get googleNoIdToken => 'Google ने कोई मान्य ID टोकन वापस नहीं किया।';

  @override
  String googlePrepareFailed(String error) {
    return 'Google लॉगिन तैयार नहीं किया जा सका: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google लॉगिन विफल रहा: $error';
  }

  @override
  String get googleLoginSuccess => 'Google से सफलतापूर्वक लॉगिन किया गया।';

  @override
  String get googleAccountCreated => 'Google खाता बनाया गया और आप लॉग इन हैं।';

  @override
  String get googleWebOnly => 'Google लॉगिन केवल वेब ऐप में उपलब्ध है';

  @override
  String get githubSection => 'GitHub क्षेत्र';

  @override
  String get githubLoginButton => 'GitHub से लॉगिन करें';

  @override
  String get githubCreateButton => 'GitHub से खाता बनाएँ';

  @override
  String get githubNotConfigured => 'GitHub लॉगिन कॉन्फ़िगर नहीं है।';

  @override
  String get githubCancelled => 'GitHub लॉगिन रद्द हो गया या विफल रहा।';

  @override
  String get githubSecurityCancelled =>
      'सुरक्षा कारणों से GitHub लॉगिन रद्द कर दिया गया।';

  @override
  String get githubNoValidCode => 'GitHub ने कोई मान्य कोड वापस नहीं किया।';

  @override
  String get githubLoginSuccess => 'GitHub से सफलतापूर्वक लॉगिन किया गया।';

  @override
  String get githubAccountCreated => 'GitHub खाता बनाया गया और आप लॉग इन हैं।';

  @override
  String get passwordResetTitle => 'पासवर्ड रीसेट करें';

  @override
  String get passwordResetDescription =>
      'अपना ई-मेल पता दर्ज करें। यदि कोई खाता मौजूद है, तो आपको पासवर्ड रीसेट लिंक मिलेगा।';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get backToLogin => 'लॉगिन पर वापस जाएँ';

  @override
  String get setNewPasswordTitle => 'नया पासवर्ड सेट करें';

  @override
  String get setNewPasswordDescription =>
      'अपने खाते के लिए नया पासवर्ड सेट करें।';

  @override
  String get newPasswordLabel => 'नया पासवर्ड';

  @override
  String get repeatNewPasswordLabel => 'नया पासवर्ड दोहराएँ';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get savePassword => 'पासवर्ड सहेजें';

  @override
  String get registrationSuccess =>
      'पंजीकरण सफल रहा। कृपया अपना ई-मेल पता सत्यापित करें और फिर लॉगिन करें।';

  @override
  String get passwordResetRequestSuccess =>
      'यदि इस ई-मेल से कोई खाता मौजूद है, तो रीसेट लिंक भेज दिया गया है।';

  @override
  String get passwordChangedSuccess =>
      'पासवर्ड बदल दिया गया है। अब आप लॉगिन कर सकते हैं।';

  @override
  String get passwordResetMailSent =>
      'यदि खाता मौजूद है, तो रीसेट लिंक भेज दिया गया है।';

  @override
  String get loginSuccess => 'सफलतापूर्वक लॉगिन किया गया।';

  @override
  String get invalidEmail => 'कृपया मान्य ई-मेल दर्ज करें';

  @override
  String get passwordMinLength => 'कम से कम 8 अक्षर';

  @override
  String get loggedInTitle => 'उपयोगकर्ता खाता';

  @override
  String get loggedInDescription => 'आप अभी लॉग इन हैं।';

  @override
  String get emailAddress => 'ई-मेल पता';

  @override
  String get emailStatus => 'ई-मेल स्थिति';

  @override
  String get emailVerified => 'सत्यापित';

  @override
  String get emailNotVerified => 'अभी सत्यापित नहीं';

  @override
  String get accountCreated => 'खाता बनाया गया';

  @override
  String get synchronization => 'सिंक';

  @override
  String get accountInfoWarning =>
      'यदि कोई मान्य लॉगिन टोकन स्थानीय रूप से सहेजा गया है, तो ऐप आपका सत्र अपने आप पुनर्स्थापित कर सकता है। साझा डिवाइस पर आपको हमेशा लॉग आउट करना चाहिए।';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get syncRunning => 'सिंक चल रहा है';

  @override
  String get syncOneWaiting => '1 सत्र प्रतीक्षा कर रहा है';

  @override
  String syncManyWaiting(int count) {
    return '$count सत्र प्रतीक्षा कर रहे हैं';
  }

  @override
  String get syncError => 'सिंक त्रुटि';

  @override
  String get syncAllSynced => 'सब कुछ सिंक हो गया';

  @override
  String get sessionExpired =>
      'आपका सत्र समाप्त हो गया है। कृपया फिर से लॉगिन करें।';

  @override
  String get settingsSaved => 'सेटिंग्स सहेज दी गईं।';

  @override
  String get timerTimesTitle => 'टाइमर अवधि';

  @override
  String get timerTimesDescription => 'कार्य चरणों और ब्रेक की अवधि तय करें।';

  @override
  String get workTime => 'कार्य समय';

  @override
  String get shortBreak => 'छोटा ब्रेक';

  @override
  String get longBreak => 'लंबा ब्रेक';

  @override
  String get longBreakAfter => 'लंबा ब्रेक इसके बाद';

  @override
  String get minutes => 'मिनट';

  @override
  String get pomodorosUnit => 'पोमोडोरो';

  @override
  String get behaviorTitle => 'व्यवहार';

  @override
  String get behaviorDescription =>
      'उपयोग के दौरान टाइमर के व्यवहार को अनुकूलित करें।';

  @override
  String get autoStartNextPhase => 'अगला चरण अपने आप शुरू करें';

  @override
  String get enableSound => 'ध्वनि चालू करें';

  @override
  String get enableVibration => 'वाइब्रेशन चालू करें';

  @override
  String get vibrationDescription =>
      'वास्तविक मोबाइल वाइब्रेशन बाद में एक प्लगइन के माध्यम से जोड़ा जाएगा।';

  @override
  String get languageTitle => 'भाषा';

  @override
  String get languageDescription =>
      'ऐप की भाषा चुनें। “सिस्टम भाषा” चुनने पर ऐप ब्राउज़र या डिवाइस की भाषा का उपयोग करता है।';

  @override
  String get languageLabel => 'ऐप भाषा';

  @override
  String get languageSystem => 'सिस्टम भाषा';

  @override
  String get languageGerman => 'जर्मन';

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get languageArabic => 'अरबी';

  @override
  String get languageChinese => 'चीनी';

  @override
  String get languageFrench => 'फ़्रेंच';

  @override
  String get languageSpanish => 'स्पेनिश';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get languagePortuguese => 'पुर्तगाली';

  @override
  String get languageRussian => 'रूसी';

  @override
  String get languageJapanese => 'जापानी';

  @override
  String get languageTurkish => 'तुर्की';

  @override
  String get languageItalian => 'इतालवी';

  @override
  String get languageKorean => 'कोरियाई';

  @override
  String get languageIndonesian => 'इंडोनेशियाई';

  @override
  String get languagePersian => 'फ़ारसी';

  @override
  String get appearanceTitle => 'दिखावट';

  @override
  String get appearanceDescription => 'ऐप का डिज़ाइन मोड और मुख्य रंग चुनें।';

  @override
  String get appearanceLabel => 'दिखावट';

  @override
  String get systemTheme => 'सिस्टम';

  @override
  String get lightMode => 'लाइट मोड';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get themeColor => 'थीम रंग';

  @override
  String get red => 'लाल';

  @override
  String get blue => 'नीला';

  @override
  String get green => 'हरा';

  @override
  String get purple => 'बैंगनी';

  @override
  String get saveSettings => 'सेटिंग्स सहेजें';

  @override
  String get noChanges => 'कोई बदलाव नहीं';

  @override
  String get decrease => 'घटाएँ';

  @override
  String get increase => 'बढ़ाएँ';

  @override
  String get minutesShort => 'मि';

  @override
  String get settingsSavedButNotSynced =>
      'सेटिंग्स स्थानीय रूप से सहेज दी गईं, लेकिन अभी सिंक नहीं हुईं।';

  @override
  String get settingsLoadRemoteFailed =>
      'सेटिंग्स बैकएंड से लोड नहीं की जा सकीं। स्थानीय सेटिंग्स का उपयोग किया जाएगा।';

  @override
  String get statsTitle => 'आँकड़े';

  @override
  String get statsRefresh => 'रीफ्रेश करें';

  @override
  String get statsWeek => 'सप्ताह';

  @override
  String get statsMonth => 'माह';

  @override
  String get statsYear => 'वर्ष';

  @override
  String get statsTasksTime => 'कार्य समय';

  @override
  String get chartFocusPerDay => 'प्रति दिन फ़ोकस समय';

  @override
  String get chartFocusPerCalendarWeek => 'प्रति कैलेंडर सप्ताह फ़ोकस समय';

  @override
  String get chartFocusPerMonth => 'प्रति माह फ़ोकस समय';

  @override
  String get chartFocusPerTask => 'प्रति कार्य फ़ोकस समय';

  @override
  String get xAxisWeek => 'X-अक्ष: सप्ताह के दिन';

  @override
  String get xAxisMonth => 'X-अक्ष: महीने के कैलेंडर सप्ताह';

  @override
  String get xAxisYear => 'X-अक्ष: वर्ष के महीने';

  @override
  String get xAxisTasks => 'X-अक्ष: कार्य';

  @override
  String get periodNoData => 'अवधि: कोई डेटा उपलब्ध नहीं';

  @override
  String periodRange(String start, String end) {
    return 'अवधि: $start – $end';
  }

  @override
  String get previousPeriod => 'पिछली अवधि';

  @override
  String get nextPeriod => 'अगली अवधि';

  @override
  String get statsLoading => 'आँकड़े लोड हो रहे हैं ...';

  @override
  String get taskStatsLoading => 'कार्य आँकड़े लोड हो रहे हैं ...';

  @override
  String get taskStatsEmpty =>
      'अभी प्रति कार्य कोई कार्य समय उपलब्ध नहीं है। डेटा देखने के लिए किसी कार्य के साथ पोमोडोरो शुरू करें।';

  @override
  String get pomodoros => 'पोमोडोरो';

  @override
  String get focusTime => 'फ़ोकस समय';

  @override
  String get streak => 'श्रृंखला';

  @override
  String get bestPeriod => 'सर्वश्रेष्ठ अवधि';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '1 दिन',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y-अक्ष: घंटों में फ़ोकस समय · $xAxisText';
  }

  @override
  String get focusTimeMinutes => 'मिनटों में फ़ोकस समय';

  @override
  String get sortedByHighestFocusTime =>
      'सबसे अधिक फ़ोकस समय के अनुसार क्रमबद्ध।';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros पोमोडोरो · $minutes मि';
  }

  @override
  String get statsNoData => 'अभी कोई आँकड़ा उपलब्ध नहीं है।';

  @override
  String get statsLoadFailed =>
      'आँकड़े लोड नहीं किए जा सके। कृपया लॉगिन करें और इंटरनेट कनेक्शन जाँचें।';

  @override
  String get taskStatsLoadFailed => 'कार्य आँकड़े लोड नहीं किए जा सके।';

  @override
  String get todayPomodorosLoadFailed =>
      'आज की पोमोडोरो संख्या लोड नहीं की जा सकी।';

  @override
  String get noTaskTitle => 'बिना कार्य';

  @override
  String calendarWeekShort(int week) {
    return 'CW $week';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return 'CW $week/$year';
  }

  @override
  String get tasksTitle => 'कार्य';

  @override
  String get tasksRefreshTooltip => 'कार्य रीफ्रेश करें';

  @override
  String get taskSingular => 'कार्य';

  @override
  String get deleteTaskTitle => 'कार्य हटाएँ?';

  @override
  String deleteTaskMessage(String title) {
    return 'क्या आप वाकई “$title” कार्य हटाना चाहते हैं?';
  }

  @override
  String get tasksLoading => 'कार्य लोड हो रहे हैं ...';

  @override
  String get tasksEmpty => 'अभी कोई कार्य नहीं है। अपना पहला कार्य बनाएँ।';

  @override
  String get tasksSearchEmpty => 'कोई कार्य नहीं मिला। खोज या फ़िल्टर बदलें।';

  @override
  String get noTimerTaskSelected => 'टाइमर के लिए कोई कार्य चयनित नहीं';

  @override
  String activeTimerTask(String title) {
    return 'सक्रिय टाइमर कार्य: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      'टाइमर चरण चल रहा है या रुका हुआ है। इसलिए कार्य अभी लॉक है।';

  @override
  String get taskSelectionNextWorkPhaseDescription =>
      'यह कार्य अगले कार्य चरण के लिए उपयोग किया जाएगा।';

  @override
  String get withoutTask => 'बिना कार्य';

  @override
  String get searchTasks => 'कार्य खोजें';

  @override
  String get clearSearch => 'खोज साफ़ करें';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterOpen => 'खुले';

  @override
  String get filterCompleted => 'पूर्ण';

  @override
  String get sortLabel => 'क्रमबद्ध करें';

  @override
  String get sortNewest => 'नवीनतम पहले';

  @override
  String get sortPriority => 'प्राथमिकता';

  @override
  String get sortPomodoros => 'पोमोडोरो';

  @override
  String get active => 'सक्रिय';

  @override
  String get completed => 'पूर्ण';

  @override
  String get locked => 'लॉक';

  @override
  String get forTimer => 'टाइमर के लिए';

  @override
  String get priorityLow => 'कम';

  @override
  String get priorityMedium => 'मध्यम';

  @override
  String get priorityHigh => 'उच्च';

  @override
  String get taskLoadRemoteFailed =>
      'कार्य बैकएंड से लोड नहीं किए जा सके। स्थानीय डेटा दिखता रहेगा।';

  @override
  String get taskSavedLocallyNotSynced =>
      'कार्य स्थानीय रूप से सहेजा गया, लेकिन खाते के साथ सिंक नहीं किया जा सका।';

  @override
  String get taskSaveFailedRolledBack =>
      'कार्य सहेजा नहीं जा सका। अंतिम बदलाव वापस कर दिया गया।';

  @override
  String get taskDeleteFailedRestored =>
      'कार्य खाते से हटाया नहीं जा सका। कार्य पुनर्स्थापित कर दिया गया।';

  @override
  String get taskCreateTitle => 'कार्य बनाएँ';

  @override
  String get taskEditTitle => 'कार्य संपादित करें';

  @override
  String get taskTitleLabel => 'शीर्षक';

  @override
  String get taskTitleRequired => 'कृपया शीर्षक दर्ज करें';

  @override
  String get taskTitleTooShort => 'शीर्षक बहुत छोटा है।';

  @override
  String get taskDescriptionLabel => 'विवरण';

  @override
  String get priorityLabel => 'प्राथमिकता';

  @override
  String get tagsLabel => 'टैग/श्रेणियाँ';

  @override
  String get tagsHint => 'जैसे विश्वविद्यालय, काम, विकास';

  @override
  String get timerResetTitle => 'टाइमर रीसेट करें?';

  @override
  String get timerResetMessage =>
      'वर्तमान चरण रद्द कर दिया जाएगा और पूर्ण सत्र के रूप में सहेजा नहीं जाएगा।';

  @override
  String get taskNoneSelected => 'कोई कार्य चयनित नहीं';

  @override
  String currentTask(String title) {
    return 'वर्तमान कार्य: $title';
  }

  @override
  String get taskForWorkPhase => 'इस कार्य चरण के लिए कार्य';

  @override
  String get taskLockedToPhase => 'यह चरण चयनित कार्य से जुड़ा है।';

  @override
  String get phaseWork => 'कार्य चरण';

  @override
  String get phaseShortBreak => 'छोटा ब्रेक';

  @override
  String get phaseLongBreak => 'लंबा ब्रेक';

  @override
  String get timerStatusSaving => 'सहेजा जा रहा है ...';

  @override
  String get timerStatusRunning => 'चल रहा है';

  @override
  String get timerStatusPaused => 'रुका हुआ';

  @override
  String get timerStatusReady => 'तैयार';

  @override
  String get phaseDescriptionWork => 'फ़ोकस समय';

  @override
  String get phaseDescriptionShortBreak => 'छोटी विश्रांति';

  @override
  String get phaseDescriptionLongBreak => 'लंबी विश्रांति';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · अगला: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => 'आज: लोड हो रहा है ...';

  @override
  String todayPomodoros(String pomodoros) {
    return 'आज: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पोमोडोरो',
      one: '1 पोमोडोरो',
    );
    return '$_temp0';
  }

  @override
  String get pause => 'रोकें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get start => 'शुरू करें';

  @override
  String get skipPause => 'ब्रेक छोड़ें';

  @override
  String get shortcutSpaceCompact => 'Space: शुरू/रोकें';

  @override
  String get shortcutResetCompact => 'R: रीसेट';

  @override
  String get shortcutSkipCompact => 'S: छोड़ें';

  @override
  String get shortcutSpace => 'स्पेसबार: शुरू/रोकें';

  @override
  String get shortcutReset => 'R: रीसेट';

  @override
  String get shortcutSkip => 'S: ब्रेक छोड़ें';

  @override
  String get phaseSavingTitle => 'चरण सहेजा जा रहा है';

  @override
  String get phaseSavingDescription =>
      'पूर्ण चरण सहेजा जा रहा है और टाइमर तैयार किया जा रहा है।';

  @override
  String get storageProblem => 'संग्रहण समस्या';

  @override
  String get oneFinishedPhaseSavingBackground =>
      'पूर्ण चरण पृष्ठभूमि में सहेजा जा रहा है।';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count पूर्ण चरण पृष्ठभूमि में सहेजे जा रहे हैं।';
  }

  @override
  String get timerLocalSaveFailed =>
      'पूर्ण चरण स्थानीय रूप से सहेजा नहीं जा सका।';

  @override
  String get timerBackendSyncFailed =>
      'पूर्ण चरण स्थानीय रूप से सहेजा गया, लेकिन अभी बैकएंड से सिंक नहीं हुआ।';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed में से $total';
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

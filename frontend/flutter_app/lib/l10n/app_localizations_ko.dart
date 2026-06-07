// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Pomodoro 앱';

  @override
  String get navTimer => '타이머';

  @override
  String get navTasks => '작업';

  @override
  String get navStats => '통계';

  @override
  String get navSettings => '설정';

  @override
  String get navAccount => '계정';

  @override
  String get close => '닫기';

  @override
  String get retry => '다시 시도';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get edit => '편집';

  @override
  String get save => '저장';

  @override
  String get reset => '초기화';

  @override
  String get refresh => '새로고침';

  @override
  String get messageClose => '메시지 닫기';

  @override
  String get or => '또는';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get emailVerifiedSuccess => '이메일이 성공적으로 확인되었습니다. 이제 로그인할 수 있습니다.';

  @override
  String get emailVerifiedExpired => '확인 링크가 만료되었습니다.';

  @override
  String get emailVerifiedInvalid => '확인 링크가 유효하지 않습니다.';

  @override
  String get sessionSyncOneWithAccount => '세션 1개가 계정과 동기화되고 있습니다.';

  @override
  String sessionSyncManyWithAccount(int count) {
    return '$count개의 세션이 계정과 동기화되고 있습니다.';
  }

  @override
  String get sessionSyncOneAfterLogin => '로그인 후 로컬 세션 1개가 동기화됩니다.';

  @override
  String sessionSyncManyAfterLogin(int count) {
    return '로그인 후 $count개의 로컬 세션이 동기화됩니다.';
  }

  @override
  String get sessionSyncOnePending => '세션 1개가 동기화를 기다리고 있습니다.';

  @override
  String sessionSyncManyPending(int count) {
    return '$count개의 세션이 동기화를 기다리고 있습니다.';
  }

  @override
  String get sessionSyncDone => '동기화가 완료되었습니다.';

  @override
  String get sessionSyncFailed => '현재 세션을 동기화할 수 없습니다. 나중에 다시 시도합니다.';

  @override
  String get accountTitle => '사용자 계정';

  @override
  String get loginTitle => '로그인';

  @override
  String get createAccountTitle => '새 계정 만들기';

  @override
  String get emailPasswordLoginTitle => '이메일과 비밀번호로 로그인';

  @override
  String get emailPasswordCreateTitle => '이메일/비밀번호 계정 만들기';

  @override
  String get emailLabel => '이메일';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get createAccountButton => '계정 만들기';

  @override
  String get rememberSessionTitle => '이 기기에서 로그인 상태 유지';

  @override
  String get rememberSessionSubtitle => '비활성화하면 로그인은 현재 앱 세션 동안만 유지됩니다.';

  @override
  String get forgotPasswordButton => '비밀번호를 잊으셨나요?';

  @override
  String get alreadyHaveAccount => '이미 계정이 있습니다';

  @override
  String get googleSection => 'Google 영역';

  @override
  String get googleLoginButton => 'Google로 로그인';

  @override
  String get googleCreateButton => 'Google로 계정 만들기';

  @override
  String get googleNotConfigured => 'Google 로그인이 설정되어 있지 않습니다.';

  @override
  String get googlePreparing => 'Google 로그인을 준비하는 중 ...';

  @override
  String get googleNoIdToken => 'Google에서 유효한 ID 토큰을 반환하지 않았습니다.';

  @override
  String googlePrepareFailed(String error) {
    return 'Google 로그인을 준비할 수 없습니다: $error';
  }

  @override
  String googleLoginFailed(String error) {
    return 'Google 로그인 실패: $error';
  }

  @override
  String get googleLoginSuccess => 'Google로 성공적으로 로그인했습니다.';

  @override
  String get googleAccountCreated => 'Google 계정이 생성되었고 로그인되었습니다.';

  @override
  String get googleWebOnly => 'Google 로그인은 웹 앱에서만 사용할 수 있습니다';

  @override
  String get githubSection => 'GitHub 영역';

  @override
  String get githubLoginButton => 'GitHub로 로그인';

  @override
  String get githubCreateButton => 'GitHub로 계정 만들기';

  @override
  String get githubNotConfigured => 'GitHub 로그인이 설정되어 있지 않습니다.';

  @override
  String get githubCancelled => 'GitHub 로그인이 취소되었거나 실패했습니다.';

  @override
  String get githubSecurityCancelled => '보안상의 이유로 GitHub 로그인이 취소되었습니다.';

  @override
  String get githubNoValidCode => 'GitHub에서 유효한 코드를 반환하지 않았습니다.';

  @override
  String get githubLoginSuccess => 'GitHub로 성공적으로 로그인했습니다.';

  @override
  String get githubAccountCreated => 'GitHub 계정이 생성되었고 로그인되었습니다.';

  @override
  String get passwordResetTitle => '비밀번호 재설정';

  @override
  String get passwordResetDescription =>
      '이메일 주소를 입력하세요. 계정이 존재하면 비밀번호 재설정 링크를 받게 됩니다.';

  @override
  String get sendResetLink => '재설정 링크 보내기';

  @override
  String get backToLogin => '로그인으로 돌아가기';

  @override
  String get setNewPasswordTitle => '새 비밀번호 설정';

  @override
  String get setNewPasswordDescription => '계정에 사용할 새 비밀번호를 설정하세요.';

  @override
  String get newPasswordLabel => '새 비밀번호';

  @override
  String get repeatNewPasswordLabel => '새 비밀번호 다시 입력';

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get savePassword => '비밀번호 저장';

  @override
  String get registrationSuccess => '회원가입이 완료되었습니다. 이메일 주소를 확인한 후 로그인하세요.';

  @override
  String get passwordResetRequestSuccess =>
      '이 이메일에 해당하는 계정이 존재하면 재설정 링크가 전송되었습니다.';

  @override
  String get passwordChangedSuccess => '비밀번호가 변경되었습니다. 이제 로그인할 수 있습니다.';

  @override
  String get passwordResetMailSent => '계정이 존재하면 재설정 링크가 전송되었습니다.';

  @override
  String get loginSuccess => '성공적으로 로그인했습니다.';

  @override
  String get invalidEmail => '유효한 이메일 주소를 입력하세요';

  @override
  String get passwordMinLength => '최소 8자';

  @override
  String get loggedInTitle => '사용자 계정';

  @override
  String get loggedInDescription => '현재 로그인되어 있습니다.';

  @override
  String get emailAddress => '이메일 주소';

  @override
  String get emailStatus => '이메일 상태';

  @override
  String get emailVerified => '확인됨';

  @override
  String get emailNotVerified => '아직 확인되지 않음';

  @override
  String get accountCreated => '계정 생성됨';

  @override
  String get synchronization => '동기화';

  @override
  String get accountInfoWarning =>
      '유효한 로그인 토큰이 로컬에 저장되어 있으면 앱이 세션을 자동으로 복원할 수 있습니다. 공유 기기에서는 항상 로그아웃해야 합니다.';

  @override
  String get changePassword => '비밀번호 변경';

  @override
  String get logout => '로그아웃';

  @override
  String get syncRunning => '동기화 실행 중';

  @override
  String get syncOneWaiting => '세션 1개 대기 중';

  @override
  String syncManyWaiting(int count) {
    return '$count개의 세션 대기 중';
  }

  @override
  String get syncError => '동기화 오류';

  @override
  String get syncAllSynced => '모두 동기화됨';

  @override
  String get sessionExpired => '세션이 만료되었습니다. 다시 로그인하세요.';

  @override
  String get settingsSaved => '설정이 저장되었습니다.';

  @override
  String get timerTimesTitle => '타이머 시간';

  @override
  String get timerTimesDescription => '작업 단계와 휴식 시간이 얼마나 지속될지 설정하세요.';

  @override
  String get workTime => '작업 시간';

  @override
  String get shortBreak => '짧은 휴식';

  @override
  String get longBreak => '긴 휴식';

  @override
  String get longBreakAfter => '긴 휴식 기준';

  @override
  String get minutes => '분';

  @override
  String get pomodorosUnit => 'Pomodoro';

  @override
  String get behaviorTitle => '동작';

  @override
  String get behaviorDescription => '사용 중 타이머가 어떻게 동작할지 조정하세요.';

  @override
  String get autoStartNextPhase => '다음 단계 자동 시작';

  @override
  String get enableSound => '소리 활성화';

  @override
  String get enableVibration => '진동 활성화';

  @override
  String get vibrationDescription => '실제 모바일 진동은 나중에 플러그인을 통해 연결됩니다.';

  @override
  String get languageTitle => '언어';

  @override
  String get languageDescription =>
      '앱 언어를 선택하세요. “시스템 언어”를 선택하면 앱이 브라우저 또는 기기 언어를 사용합니다.';

  @override
  String get languageLabel => '앱 언어';

  @override
  String get languageSystem => '시스템 언어';

  @override
  String get languageGerman => '독일어';

  @override
  String get languageEnglish => '영어';

  @override
  String get languageArabic => '아랍어';

  @override
  String get languageChinese => '중국어';

  @override
  String get languageFrench => '프랑스어';

  @override
  String get languageSpanish => '스페인어';

  @override
  String get languageHindi => '힌디어';

  @override
  String get languagePortuguese => '포르투갈어';

  @override
  String get languageRussian => '러시아어';

  @override
  String get languageJapanese => '일본어';

  @override
  String get languageTurkish => '터키어';

  @override
  String get languageItalian => '이탈리아어';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageIndonesian => '인도네시아어';

  @override
  String get languagePersian => '페르시아어';

  @override
  String get appearanceTitle => '화면 표시';

  @override
  String get appearanceDescription => '앱의 표시 모드와 기본 색상을 선택하세요.';

  @override
  String get appearanceLabel => '화면 표시';

  @override
  String get systemTheme => '시스템';

  @override
  String get lightMode => '라이트 모드';

  @override
  String get darkMode => '다크 모드';

  @override
  String get themeColor => '테마 색상';

  @override
  String get red => '빨간색';

  @override
  String get blue => '파란색';

  @override
  String get green => '초록색';

  @override
  String get purple => '보라색';

  @override
  String get saveSettings => '설정 저장';

  @override
  String get noChanges => '변경 사항 없음';

  @override
  String get decrease => '줄이기';

  @override
  String get increase => '늘리기';

  @override
  String get minutesShort => '분';

  @override
  String get settingsSavedButNotSynced => '설정이 로컬에 저장되었지만 아직 동기화되지 않았습니다.';

  @override
  String get settingsLoadRemoteFailed => '백엔드에서 설정을 불러올 수 없습니다. 로컬 설정을 사용합니다.';

  @override
  String get statsTitle => '통계';

  @override
  String get statsRefresh => '새로고침';

  @override
  String get statsWeek => '주';

  @override
  String get statsMonth => '월';

  @override
  String get statsYear => '년';

  @override
  String get statsTasksTime => '작업 시간';

  @override
  String get chartFocusPerDay => '일별 집중 시간';

  @override
  String get chartFocusPerCalendarWeek => '달력 주별 집중 시간';

  @override
  String get chartFocusPerMonth => '월별 집중 시간';

  @override
  String get chartFocusPerTask => '작업별 집중 시간';

  @override
  String get xAxisWeek => 'X축: 요일';

  @override
  String get xAxisMonth => 'X축: 월의 달력 주';

  @override
  String get xAxisYear => 'X축: 연도의 월';

  @override
  String get xAxisTasks => 'X축: 작업';

  @override
  String get periodNoData => '기간: 데이터 없음';

  @override
  String periodRange(String start, String end) {
    return '기간: $start – $end';
  }

  @override
  String get previousPeriod => '이전 기간';

  @override
  String get nextPeriod => '다음 기간';

  @override
  String get statsLoading => '통계를 불러오는 중 ...';

  @override
  String get taskStatsLoading => '작업 통계를 불러오는 중 ...';

  @override
  String get taskStatsEmpty =>
      '아직 작업별 작업 시간이 없습니다. 데이터를 보려면 작업과 함께 Pomodoro를 시작하세요.';

  @override
  String get pomodoros => 'Pomodoro';

  @override
  String get focusTime => '집중 시간';

  @override
  String get streak => '연속 기록';

  @override
  String get bestPeriod => '최고 기간';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
      one: '1일',
    );
    return '$_temp0';
  }

  @override
  String yAxisFocusHoursWithXAxis(String xAxisText) {
    return 'Y축: 시간 단위 집중 시간 · $xAxisText';
  }

  @override
  String get focusTimeMinutes => '분 단위 집중 시간';

  @override
  String get sortedByHighestFocusTime => '집중 시간이 높은 순서로 정렬됨.';

  @override
  String taskPomodoroMinutes(int pomodoros, int minutes) {
    return '$pomodoros Pomodoro · $minutes분';
  }

  @override
  String get statsNoData => '아직 통계 데이터가 없습니다.';

  @override
  String get statsLoadFailed => '통계를 불러올 수 없습니다. 로그인하고 인터넷 연결을 확인하세요.';

  @override
  String get taskStatsLoadFailed => '작업 통계를 불러올 수 없습니다.';

  @override
  String get todayPomodorosLoadFailed => '오늘의 Pomodoro 수를 불러올 수 없습니다.';

  @override
  String get noTaskTitle => '작업 없음';

  @override
  String calendarWeekShort(int week) {
    return '$week주차';
  }

  @override
  String calendarWeekWithYear(int week, int year) {
    return '$year년 $week주차';
  }

  @override
  String get tasksTitle => '작업';

  @override
  String get tasksRefreshTooltip => '작업 새로고침';

  @override
  String get taskSingular => '작업';

  @override
  String get deleteTaskTitle => '작업을 삭제할까요?';

  @override
  String deleteTaskMessage(String title) {
    return '“$title” 작업을 정말 삭제하시겠습니까?';
  }

  @override
  String get tasksLoading => '작업을 불러오는 중 ...';

  @override
  String get tasksEmpty => '아직 작업이 없습니다. 첫 번째 작업을 만들어 보세요.';

  @override
  String get tasksSearchEmpty => '작업을 찾을 수 없습니다. 검색어나 필터를 조정하세요.';

  @override
  String get noTimerTaskSelected => '타이머 작업이 선택되지 않았습니다';

  @override
  String activeTimerTask(String title) {
    return '활성 타이머 작업: $title';
  }

  @override
  String get taskSelectionLockedDescription =>
      '타이머 단계가 실행 중이거나 일시 중지되었습니다. 그래서 현재 작업이 잠겨 있습니다.';

  @override
  String get taskSelectionNextWorkPhaseDescription => '이 작업은 다음 작업 단계에 사용됩니다.';

  @override
  String get withoutTask => '작업 없이';

  @override
  String get searchTasks => '작업 검색';

  @override
  String get clearSearch => '검색 지우기';

  @override
  String get filterAll => '전체';

  @override
  String get filterOpen => '열림';

  @override
  String get filterCompleted => '완료됨';

  @override
  String get sortLabel => '정렬';

  @override
  String get sortNewest => '최신순';

  @override
  String get sortPriority => '우선순위';

  @override
  String get sortPomodoros => 'Pomodoro';

  @override
  String get active => '활성';

  @override
  String get completed => '완료됨';

  @override
  String get locked => '잠김';

  @override
  String get forTimer => '타이머용';

  @override
  String get priorityLow => '낮음';

  @override
  String get priorityMedium => '중간';

  @override
  String get priorityHigh => '높음';

  @override
  String get taskLoadRemoteFailed => '백엔드에서 작업을 불러올 수 없습니다. 로컬 데이터는 계속 표시됩니다.';

  @override
  String get taskSavedLocallyNotSynced => '작업이 로컬에 저장되었지만 계정과 동기화할 수 없습니다.';

  @override
  String get taskSaveFailedRolledBack => '작업을 저장할 수 없습니다. 마지막 변경 사항이 되돌려졌습니다.';

  @override
  String get taskDeleteFailedRestored => '계정에서 작업을 삭제할 수 없습니다. 작업이 복원되었습니다.';

  @override
  String get taskCreateTitle => '작업 만들기';

  @override
  String get taskEditTitle => '작업 편집';

  @override
  String get taskTitleLabel => '제목';

  @override
  String get taskTitleRequired => '제목을 입력하세요';

  @override
  String get taskTitleTooShort => '제목이 너무 짧습니다.';

  @override
  String get taskDescriptionLabel => '설명';

  @override
  String get priorityLabel => '우선순위';

  @override
  String get tagsLabel => '태그/카테고리';

  @override
  String get tagsHint => '예: 대학, 업무, 개발';

  @override
  String get timerResetTitle => '타이머를 초기화할까요?';

  @override
  String get timerResetMessage => '현재 단계가 취소되며 완료된 세션으로 저장되지 않습니다.';

  @override
  String get taskNoneSelected => '선택된 작업 없음';

  @override
  String currentTask(String title) {
    return '현재 작업: $title';
  }

  @override
  String get taskForWorkPhase => '이 작업 단계의 작업';

  @override
  String get taskLockedToPhase => '이 단계는 선택한 작업에 고정되어 있습니다.';

  @override
  String get phaseWork => '작업 단계';

  @override
  String get phaseShortBreak => '짧은 휴식';

  @override
  String get phaseLongBreak => '긴 휴식';

  @override
  String get timerStatusSaving => '저장 중 ...';

  @override
  String get timerStatusRunning => '실행 중';

  @override
  String get timerStatusPaused => '일시 중지됨';

  @override
  String get timerStatusReady => '준비됨';

  @override
  String get phaseDescriptionWork => '집중 시간';

  @override
  String get phaseDescriptionShortBreak => '짧은 회복';

  @override
  String get phaseDescriptionLongBreak => '긴 회복';

  @override
  String afterNextPhase(String phaseDescription, String nextPhase) {
    return '$phaseDescription · 다음: $nextPhase';
  }

  @override
  String get todayPomodorosLoading => '오늘: 불러오는 중 ...';

  @override
  String todayPomodoros(String pomodoros) {
    return '오늘: $pomodoros';
  }

  @override
  String pomodoroCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pomodoro $count개',
      one: 'Pomodoro 1개',
    );
    return '$_temp0';
  }

  @override
  String get pause => '일시 중지';

  @override
  String get continueButton => '계속';

  @override
  String get start => '시작';

  @override
  String get skipPause => '휴식 건너뛰기';

  @override
  String get shortcutSpaceCompact => 'Space: 시작/일시 중지';

  @override
  String get shortcutResetCompact => 'R: 초기화';

  @override
  String get shortcutSkipCompact => 'S: 건너뛰기';

  @override
  String get shortcutSpace => '스페이스바: 시작/일시 중지';

  @override
  String get shortcutReset => 'R: 초기화';

  @override
  String get shortcutSkip => 'S: 휴식 건너뛰기';

  @override
  String get phaseSavingTitle => '단계 저장 중';

  @override
  String get phaseSavingDescription => '완료된 단계가 저장되고 타이머가 준비됩니다.';

  @override
  String get storageProblem => '저장소 문제';

  @override
  String get oneFinishedPhaseSavingBackground => '완료된 단계가 백그라운드에서 저장되고 있습니다.';

  @override
  String manyFinishedPhasesSavingBackground(int count) {
    return '$count개의 완료된 단계가 백그라운드에서 저장되고 있습니다.';
  }

  @override
  String get timerLocalSaveFailed => '완료된 단계를 로컬에 저장할 수 없습니다.';

  @override
  String get timerBackendSyncFailed =>
      '완료된 단계가 로컬에 저장되었지만 아직 백엔드와 동기화되지 않았습니다.';

  @override
  String phaseProgress(String elapsed, String total) {
    return '$elapsed / $total';
  }
}

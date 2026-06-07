import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Pomodoro App'**
  String get appTitle;

  /// No description provided for @navTimer.
  ///
  /// In de, this message translates to:
  /// **'Timer'**
  String get navTimer;

  /// No description provided for @navTasks.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben'**
  String get navTasks;

  /// No description provided for @navStats.
  ///
  /// In de, this message translates to:
  /// **'Statistik'**
  String get navStats;

  /// No description provided for @navSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get navSettings;

  /// No description provided for @navAccount.
  ///
  /// In de, this message translates to:
  /// **'Konto'**
  String get navAccount;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @retry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @reset.
  ///
  /// In de, this message translates to:
  /// **'Zurücksetzen'**
  String get reset;

  /// No description provided for @refresh.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get refresh;

  /// No description provided for @messageClose.
  ///
  /// In de, this message translates to:
  /// **'Meldung schließen'**
  String get messageClose;

  /// No description provided for @or.
  ///
  /// In de, this message translates to:
  /// **'oder'**
  String get or;

  /// No description provided for @yes.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get no;

  /// No description provided for @emailVerifiedSuccess.
  ///
  /// In de, this message translates to:
  /// **'E-Mail erfolgreich bestätigt. Du kannst dich jetzt einloggen.'**
  String get emailVerifiedSuccess;

  /// No description provided for @emailVerifiedExpired.
  ///
  /// In de, this message translates to:
  /// **'Der Bestätigungslink ist abgelaufen.'**
  String get emailVerifiedExpired;

  /// No description provided for @emailVerifiedInvalid.
  ///
  /// In de, this message translates to:
  /// **'Der Bestätigungslink ist ungültig.'**
  String get emailVerifiedInvalid;

  /// No description provided for @sessionSyncOneWithAccount.
  ///
  /// In de, this message translates to:
  /// **'Eine Sitzung wird mit deinem Konto synchronisiert.'**
  String get sessionSyncOneWithAccount;

  /// No description provided for @sessionSyncManyWithAccount.
  ///
  /// In de, this message translates to:
  /// **'{count} Sitzungen werden mit deinem Konto synchronisiert.'**
  String sessionSyncManyWithAccount(int count);

  /// No description provided for @sessionSyncOneAfterLogin.
  ///
  /// In de, this message translates to:
  /// **'Eine lokale Sitzung wird nach dem Login synchronisiert.'**
  String get sessionSyncOneAfterLogin;

  /// No description provided for @sessionSyncManyAfterLogin.
  ///
  /// In de, this message translates to:
  /// **'{count} lokale Sitzungen werden nach dem Login synchronisiert.'**
  String sessionSyncManyAfterLogin(int count);

  /// No description provided for @sessionSyncOnePending.
  ///
  /// In de, this message translates to:
  /// **'Eine Sitzung wartet auf Synchronisierung.'**
  String get sessionSyncOnePending;

  /// No description provided for @sessionSyncManyPending.
  ///
  /// In de, this message translates to:
  /// **'{count} Sitzungen warten auf Synchronisierung.'**
  String sessionSyncManyPending(int count);

  /// No description provided for @sessionSyncDone.
  ///
  /// In de, this message translates to:
  /// **'Synchronisierung abgeschlossen.'**
  String get sessionSyncDone;

  /// No description provided for @sessionSyncFailed.
  ///
  /// In de, this message translates to:
  /// **'Sitzungen konnten gerade nicht synchronisiert werden. Es wird später erneut versucht.'**
  String get sessionSyncFailed;

  /// No description provided for @accountTitle.
  ///
  /// In de, this message translates to:
  /// **'Benutzerkonto'**
  String get accountTitle;

  /// No description provided for @loginTitle.
  ///
  /// In de, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @createAccountTitle.
  ///
  /// In de, this message translates to:
  /// **'Neues Konto erstellen'**
  String get createAccountTitle;

  /// No description provided for @emailPasswordLoginTitle.
  ///
  /// In de, this message translates to:
  /// **'Mit E-Mail und Passwort einloggen'**
  String get emailPasswordLoginTitle;

  /// No description provided for @emailPasswordCreateTitle.
  ///
  /// In de, this message translates to:
  /// **'E-Mail/Passwort-Konto erstellen'**
  String get emailPasswordCreateTitle;

  /// No description provided for @emailLabel.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In de, this message translates to:
  /// **'Einloggen'**
  String get loginButton;

  /// No description provided for @createAccountButton.
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get createAccountButton;

  /// No description provided for @rememberSessionTitle.
  ///
  /// In de, this message translates to:
  /// **'Auf diesem Gerät angemeldet bleiben'**
  String get rememberSessionTitle;

  /// No description provided for @rememberSessionSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Wenn deaktiviert, bleibt die Anmeldung nur für die aktuelle App-Sitzung aktiv.'**
  String get rememberSessionSubtitle;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen?'**
  String get forgotPasswordButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In de, this message translates to:
  /// **'Ich habe bereits ein Konto'**
  String get alreadyHaveAccount;

  /// No description provided for @googleSection.
  ///
  /// In de, this message translates to:
  /// **'Google-Bereich'**
  String get googleSection;

  /// No description provided for @googleLoginButton.
  ///
  /// In de, this message translates to:
  /// **'Mit Google einloggen'**
  String get googleLoginButton;

  /// No description provided for @googleCreateButton.
  ///
  /// In de, this message translates to:
  /// **'Mit Google Konto erstellen'**
  String get googleCreateButton;

  /// No description provided for @googleNotConfigured.
  ///
  /// In de, this message translates to:
  /// **'Google Login ist nicht konfiguriert.'**
  String get googleNotConfigured;

  /// No description provided for @googlePreparing.
  ///
  /// In de, this message translates to:
  /// **'Google Login wird vorbereitet ...'**
  String get googlePreparing;

  /// No description provided for @googleNoIdToken.
  ///
  /// In de, this message translates to:
  /// **'Google hat keinen gültigen ID-Token zurückgegeben.'**
  String get googleNoIdToken;

  /// No description provided for @googlePrepareFailed.
  ///
  /// In de, this message translates to:
  /// **'Google Login konnte nicht vorbereitet werden: {error}'**
  String googlePrepareFailed(Object error);

  /// No description provided for @googleLoginFailed.
  ///
  /// In de, this message translates to:
  /// **'Google Login fehlgeschlagen: {error}'**
  String googleLoginFailed(Object error);

  /// No description provided for @googleLoginSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich mit Google angemeldet.'**
  String get googleLoginSuccess;

  /// No description provided for @googleAccountCreated.
  ///
  /// In de, this message translates to:
  /// **'Google-Konto wurde erstellt und du bist angemeldet.'**
  String get googleAccountCreated;

  /// No description provided for @googleWebOnly.
  ///
  /// In de, this message translates to:
  /// **'Google Login ist nur in der Web-App verfügbar'**
  String get googleWebOnly;

  /// No description provided for @githubSection.
  ///
  /// In de, this message translates to:
  /// **'GitHub-Bereich'**
  String get githubSection;

  /// No description provided for @githubLoginButton.
  ///
  /// In de, this message translates to:
  /// **'Mit GitHub einloggen'**
  String get githubLoginButton;

  /// No description provided for @githubCreateButton.
  ///
  /// In de, this message translates to:
  /// **'Mit GitHub Konto erstellen'**
  String get githubCreateButton;

  /// No description provided for @githubNotConfigured.
  ///
  /// In de, this message translates to:
  /// **'GitHub Login ist nicht konfiguriert.'**
  String get githubNotConfigured;

  /// No description provided for @githubCancelled.
  ///
  /// In de, this message translates to:
  /// **'GitHub Login wurde abgebrochen oder ist fehlgeschlagen.'**
  String get githubCancelled;

  /// No description provided for @githubSecurityCancelled.
  ///
  /// In de, this message translates to:
  /// **'GitHub Login wurde aus Sicherheitsgründen abgebrochen.'**
  String get githubSecurityCancelled;

  /// No description provided for @githubNoValidCode.
  ///
  /// In de, this message translates to:
  /// **'GitHub hat keinen gültigen Code zurückgegeben.'**
  String get githubNoValidCode;

  /// No description provided for @githubLoginSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich mit GitHub angemeldet.'**
  String get githubLoginSuccess;

  /// No description provided for @githubAccountCreated.
  ///
  /// In de, this message translates to:
  /// **'GitHub-Konto wurde erstellt und du bist angemeldet.'**
  String get githubAccountCreated;

  /// No description provided for @passwordResetTitle.
  ///
  /// In de, this message translates to:
  /// **'Passwort zurücksetzen'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetDescription.
  ///
  /// In de, this message translates to:
  /// **'Gib deine E-Mail-Adresse ein. Wenn ein Konto existiert, bekommst du einen Link zum Zurücksetzen.'**
  String get passwordResetDescription;

  /// No description provided for @sendResetLink.
  ///
  /// In de, this message translates to:
  /// **'Reset-Link senden'**
  String get sendResetLink;

  /// No description provided for @backToLogin.
  ///
  /// In de, this message translates to:
  /// **'Zurück zum Login'**
  String get backToLogin;

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort setzen'**
  String get setNewPasswordTitle;

  /// No description provided for @setNewPasswordDescription.
  ///
  /// In de, this message translates to:
  /// **'Lege ein neues Passwort für dein Konto fest.'**
  String get setNewPasswordDescription;

  /// No description provided for @newPasswordLabel.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPasswordLabel;

  /// No description provided for @repeatNewPasswordLabel.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort wiederholen'**
  String get repeatNewPasswordLabel;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In de, this message translates to:
  /// **'Die Passwörter stimmen nicht überein'**
  String get passwordsDoNotMatch;

  /// No description provided for @savePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort speichern'**
  String get savePassword;

  /// No description provided for @registrationSuccess.
  ///
  /// In de, this message translates to:
  /// **'Registrierung erfolgreich. Bitte bestätige deine E-Mail-Adresse und logge dich danach ein.'**
  String get registrationSuccess;

  /// No description provided for @passwordResetRequestSuccess.
  ///
  /// In de, this message translates to:
  /// **'Wenn ein Konto mit dieser E-Mail existiert, wurde ein Reset-Link gesendet.'**
  String get passwordResetRequestSuccess;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort wurde geändert. Du kannst dich jetzt einloggen.'**
  String get passwordChangedSuccess;

  /// No description provided for @passwordResetMailSent.
  ///
  /// In de, this message translates to:
  /// **'Wenn das Konto existiert, wurde ein Link zum Zurücksetzen gesendet.'**
  String get passwordResetMailSent;

  /// No description provided for @loginSuccess.
  ///
  /// In de, this message translates to:
  /// **'Erfolgreich angemeldet.'**
  String get loginSuccess;

  /// No description provided for @invalidEmail.
  ///
  /// In de, this message translates to:
  /// **'Bitte gültige E-Mail eingeben'**
  String get invalidEmail;

  /// No description provided for @passwordMinLength.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 8 Zeichen'**
  String get passwordMinLength;

  /// No description provided for @loggedInTitle.
  ///
  /// In de, this message translates to:
  /// **'Benutzerkonto'**
  String get loggedInTitle;

  /// No description provided for @loggedInDescription.
  ///
  /// In de, this message translates to:
  /// **'Du bist aktuell angemeldet.'**
  String get loggedInDescription;

  /// No description provided for @emailAddress.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get emailAddress;

  /// No description provided for @emailStatus.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Status'**
  String get emailStatus;

  /// No description provided for @emailVerified.
  ///
  /// In de, this message translates to:
  /// **'Bestätigt'**
  String get emailVerified;

  /// No description provided for @emailNotVerified.
  ///
  /// In de, this message translates to:
  /// **'Noch nicht bestätigt'**
  String get emailNotVerified;

  /// No description provided for @accountCreated.
  ///
  /// In de, this message translates to:
  /// **'Konto erstellt'**
  String get accountCreated;

  /// No description provided for @synchronization.
  ///
  /// In de, this message translates to:
  /// **'Synchronisierung'**
  String get synchronization;

  /// No description provided for @accountInfoWarning.
  ///
  /// In de, this message translates to:
  /// **'Die App kann deine Sitzung automatisch wiederherstellen, wenn ein gültiger Anmeldetoken lokal gespeichert ist. Auf fremden Geräten solltest du dich immer ausloggen.'**
  String get accountInfoWarning;

  /// No description provided for @changePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePassword;

  /// No description provided for @logout.
  ///
  /// In de, this message translates to:
  /// **'Ausloggen'**
  String get logout;

  /// No description provided for @syncRunning.
  ///
  /// In de, this message translates to:
  /// **'Synchronisierung läuft'**
  String get syncRunning;

  /// No description provided for @syncOneWaiting.
  ///
  /// In de, this message translates to:
  /// **'1 Sitzung wartet'**
  String get syncOneWaiting;

  /// No description provided for @syncManyWaiting.
  ///
  /// In de, this message translates to:
  /// **'{count} Sitzungen warten'**
  String syncManyWaiting(int count);

  /// No description provided for @syncError.
  ///
  /// In de, this message translates to:
  /// **'Fehler bei der Synchronisierung'**
  String get syncError;

  /// No description provided for @syncAllSynced.
  ///
  /// In de, this message translates to:
  /// **'Alles synchronisiert'**
  String get syncAllSynced;

  /// No description provided for @sessionExpired.
  ///
  /// In de, this message translates to:
  /// **'Deine Sitzung ist abgelaufen. Bitte logge dich erneut ein.'**
  String get sessionExpired;

  /// No description provided for @settingsSaved.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen gespeichert.'**
  String get settingsSaved;

  /// No description provided for @timerTimesTitle.
  ///
  /// In de, this message translates to:
  /// **'Timer-Zeiten'**
  String get timerTimesTitle;

  /// No description provided for @timerTimesDescription.
  ///
  /// In de, this message translates to:
  /// **'Lege fest, wie lange Arbeitsphasen und Pausen dauern.'**
  String get timerTimesDescription;

  /// No description provided for @workTime.
  ///
  /// In de, this message translates to:
  /// **'Arbeitszeit'**
  String get workTime;

  /// No description provided for @shortBreak.
  ///
  /// In de, this message translates to:
  /// **'Kurze Pause'**
  String get shortBreak;

  /// No description provided for @longBreak.
  ///
  /// In de, this message translates to:
  /// **'Lange Pause'**
  String get longBreak;

  /// No description provided for @longBreakAfter.
  ///
  /// In de, this message translates to:
  /// **'Lange Pause nach'**
  String get longBreakAfter;

  /// No description provided for @minutes.
  ///
  /// In de, this message translates to:
  /// **'Minuten'**
  String get minutes;

  /// No description provided for @pomodorosUnit.
  ///
  /// In de, this message translates to:
  /// **'Pomodoros'**
  String get pomodorosUnit;

  /// No description provided for @behaviorTitle.
  ///
  /// In de, this message translates to:
  /// **'Verhalten'**
  String get behaviorTitle;

  /// No description provided for @behaviorDescription.
  ///
  /// In de, this message translates to:
  /// **'Passe an, wie sich der Timer während der Nutzung verhält.'**
  String get behaviorDescription;

  /// No description provided for @autoStartNextPhase.
  ///
  /// In de, this message translates to:
  /// **'Nächste Phase automatisch starten'**
  String get autoStartNextPhase;

  /// No description provided for @enableSound.
  ///
  /// In de, this message translates to:
  /// **'Sound aktivieren'**
  String get enableSound;

  /// No description provided for @enableVibration.
  ///
  /// In de, this message translates to:
  /// **'Vibration aktivieren'**
  String get enableVibration;

  /// No description provided for @vibrationDescription.
  ///
  /// In de, this message translates to:
  /// **'Die konkrete mobile Vibration wird später über ein Plugin angebunden.'**
  String get vibrationDescription;

  /// No description provided for @appearanceTitle.
  ///
  /// In de, this message translates to:
  /// **'Darstellung'**
  String get appearanceTitle;

  /// No description provided for @appearanceDescription.
  ///
  /// In de, this message translates to:
  /// **'Wähle Designmodus und Hauptfarbe der Anwendung.'**
  String get appearanceDescription;

  /// No description provided for @appearanceLabel.
  ///
  /// In de, this message translates to:
  /// **'Darstellung'**
  String get appearanceLabel;

  /// No description provided for @systemTheme.
  ///
  /// In de, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightMode.
  ///
  /// In de, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In de, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @themeColor.
  ///
  /// In de, this message translates to:
  /// **'Theme-Farbe'**
  String get themeColor;

  /// No description provided for @red.
  ///
  /// In de, this message translates to:
  /// **'Rot'**
  String get red;

  /// No description provided for @blue.
  ///
  /// In de, this message translates to:
  /// **'Blau'**
  String get blue;

  /// No description provided for @green.
  ///
  /// In de, this message translates to:
  /// **'Grün'**
  String get green;

  /// No description provided for @purple.
  ///
  /// In de, this message translates to:
  /// **'Lila'**
  String get purple;

  /// No description provided for @saveSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen speichern'**
  String get saveSettings;

  /// No description provided for @noChanges.
  ///
  /// In de, this message translates to:
  /// **'Keine Änderungen vorhanden'**
  String get noChanges;

  /// No description provided for @decrease.
  ///
  /// In de, this message translates to:
  /// **'Verringern'**
  String get decrease;

  /// No description provided for @increase.
  ///
  /// In de, this message translates to:
  /// **'Erhöhen'**
  String get increase;

  /// No description provided for @minutesShort.
  ///
  /// In de, this message translates to:
  /// **'min'**
  String get minutesShort;

  /// No description provided for @settingsSavedButNotSynced.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen lokal gespeichert, aber noch nicht synchronisiert.'**
  String get settingsSavedButNotSynced;

  /// No description provided for @settingsLoadRemoteFailed.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen konnten nicht vom Backend geladen werden. Lokale Einstellungen werden verwendet.'**
  String get settingsLoadRemoteFailed;

  /// No description provided for @statsTitle.
  ///
  /// In de, this message translates to:
  /// **'Statistik'**
  String get statsTitle;

  /// No description provided for @statsRefresh.
  ///
  /// In de, this message translates to:
  /// **'Aktualisieren'**
  String get statsRefresh;

  /// No description provided for @statsWeek.
  ///
  /// In de, this message translates to:
  /// **'Woche'**
  String get statsWeek;

  /// No description provided for @statsMonth.
  ///
  /// In de, this message translates to:
  /// **'Monat'**
  String get statsMonth;

  /// No description provided for @statsYear.
  ///
  /// In de, this message translates to:
  /// **'Jahr'**
  String get statsYear;

  /// No description provided for @statsTasksTime.
  ///
  /// In de, this message translates to:
  /// **'Aufgabenzeit'**
  String get statsTasksTime;

  /// No description provided for @chartFocusPerDay.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit pro Tag'**
  String get chartFocusPerDay;

  /// No description provided for @chartFocusPerCalendarWeek.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit pro KW'**
  String get chartFocusPerCalendarWeek;

  /// No description provided for @chartFocusPerMonth.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit pro Monat'**
  String get chartFocusPerMonth;

  /// No description provided for @chartFocusPerTask.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit pro Aufgabe'**
  String get chartFocusPerTask;

  /// No description provided for @xAxisWeek.
  ///
  /// In de, this message translates to:
  /// **'X-Achse: Tage der Woche'**
  String get xAxisWeek;

  /// No description provided for @xAxisMonth.
  ///
  /// In de, this message translates to:
  /// **'X-Achse: Kalenderwochen im Monat'**
  String get xAxisMonth;

  /// No description provided for @xAxisYear.
  ///
  /// In de, this message translates to:
  /// **'X-Achse: Monate im Jahr'**
  String get xAxisYear;

  /// No description provided for @xAxisTasks.
  ///
  /// In de, this message translates to:
  /// **'X-Achse: Aufgaben'**
  String get xAxisTasks;

  /// No description provided for @periodNoData.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum: Keine Daten vorhanden'**
  String get periodNoData;

  /// No description provided for @periodRange.
  ///
  /// In de, this message translates to:
  /// **'Zeitraum: {start} – {end}'**
  String periodRange(String start, String end);

  /// No description provided for @previousPeriod.
  ///
  /// In de, this message translates to:
  /// **'Vorheriger Zeitraum'**
  String get previousPeriod;

  /// No description provided for @nextPeriod.
  ///
  /// In de, this message translates to:
  /// **'Nächster Zeitraum'**
  String get nextPeriod;

  /// No description provided for @statsLoading.
  ///
  /// In de, this message translates to:
  /// **'Statistiken werden geladen ...'**
  String get statsLoading;

  /// No description provided for @taskStatsLoading.
  ///
  /// In de, this message translates to:
  /// **'Aufgabenstatistik wird geladen ...'**
  String get taskStatsLoading;

  /// No description provided for @taskStatsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Arbeitszeit pro Aufgabe vorhanden. Starte einen Pomodoro mit Aufgabe, um Daten zu sehen.'**
  String get taskStatsEmpty;

  /// No description provided for @pomodoros.
  ///
  /// In de, this message translates to:
  /// **'Pomodoros'**
  String get pomodoros;

  /// No description provided for @focusTime.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit'**
  String get focusTime;

  /// No description provided for @streak.
  ///
  /// In de, this message translates to:
  /// **'Serie'**
  String get streak;

  /// No description provided for @bestPeriod.
  ///
  /// In de, this message translates to:
  /// **'Bester Zeitraum'**
  String get bestPeriod;

  /// No description provided for @daysCount.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Tag} other{{count} Tage}}'**
  String daysCount(int count);

  /// No description provided for @yAxisFocusHoursWithXAxis.
  ///
  /// In de, this message translates to:
  /// **'Y-Achse: Fokuszeit in Stunden · {xAxisText}'**
  String yAxisFocusHoursWithXAxis(String xAxisText);

  /// No description provided for @focusTimeMinutes.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit in Minuten'**
  String get focusTimeMinutes;

  /// No description provided for @sortedByHighestFocusTime.
  ///
  /// In de, this message translates to:
  /// **'Sortiert nach höchster Fokuszeit.'**
  String get sortedByHighestFocusTime;

  /// No description provided for @taskPomodoroMinutes.
  ///
  /// In de, this message translates to:
  /// **'{pomodoros} Pomodoros · {minutes} min'**
  String taskPomodoroMinutes(int pomodoros, int minutes);

  /// No description provided for @statsNoData.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Statistikdaten vorhanden.'**
  String get statsNoData;

  /// No description provided for @statsLoadFailed.
  ///
  /// In de, this message translates to:
  /// **'Statistiken konnten nicht geladen werden. Bitte anmelden und Internetverbindung prüfen.'**
  String get statsLoadFailed;

  /// No description provided for @taskStatsLoadFailed.
  ///
  /// In de, this message translates to:
  /// **'Aufgabenstatistik konnte nicht geladen werden.'**
  String get taskStatsLoadFailed;

  /// No description provided for @todayPomodorosLoadFailed.
  ///
  /// In de, this message translates to:
  /// **'Die heutige Pomodoro-Anzahl konnte nicht geladen werden.'**
  String get todayPomodorosLoadFailed;

  /// No description provided for @noTaskTitle.
  ///
  /// In de, this message translates to:
  /// **'Ohne Aufgabe'**
  String get noTaskTitle;

  /// No description provided for @calendarWeekShort.
  ///
  /// In de, this message translates to:
  /// **'KW {week}'**
  String calendarWeekShort(String week);

  /// No description provided for @calendarWeekWithYear.
  ///
  /// In de, this message translates to:
  /// **'KW {week}/{year}'**
  String calendarWeekWithYear(String week, String year);

  /// No description provided for @tasksTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben'**
  String get tasksTitle;

  /// No description provided for @tasksRefreshTooltip.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben aktualisieren'**
  String get tasksRefreshTooltip;

  /// No description provided for @taskSingular.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe'**
  String get taskSingular;

  /// No description provided for @deleteTaskTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe löschen?'**
  String get deleteTaskTitle;

  /// No description provided for @deleteTaskMessage.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du die Aufgabe „{title}“ wirklich löschen?'**
  String deleteTaskMessage(String title);

  /// No description provided for @tasksLoading.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben werden geladen ...'**
  String get tasksLoading;

  /// No description provided for @tasksEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Aufgaben vorhanden. Erstelle deine erste Aufgabe.'**
  String get tasksEmpty;

  /// No description provided for @tasksSearchEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Aufgaben gefunden. Passe Suche oder Filter an.'**
  String get tasksSearchEmpty;

  /// No description provided for @noTimerTaskSelected.
  ///
  /// In de, this message translates to:
  /// **'Keine Timer-Aufgabe ausgewählt'**
  String get noTimerTaskSelected;

  /// No description provided for @activeTimerTask.
  ///
  /// In de, this message translates to:
  /// **'Aktive Timer-Aufgabe: {title}'**
  String activeTimerTask(String title);

  /// No description provided for @taskSelectionLockedDescription.
  ///
  /// In de, this message translates to:
  /// **'Eine Timer-Phase läuft oder ist pausiert. Die Aufgabe ist deshalb aktuell gesperrt.'**
  String get taskSelectionLockedDescription;

  /// No description provided for @taskSelectionNextWorkPhaseDescription.
  ///
  /// In de, this message translates to:
  /// **'Diese Aufgabe wird für die nächste Arbeitsphase verwendet.'**
  String get taskSelectionNextWorkPhaseDescription;

  /// No description provided for @withoutTask.
  ///
  /// In de, this message translates to:
  /// **'Ohne Aufgabe'**
  String get withoutTask;

  /// No description provided for @searchTasks.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben suchen'**
  String get searchTasks;

  /// No description provided for @clearSearch.
  ///
  /// In de, this message translates to:
  /// **'Suche löschen'**
  String get clearSearch;

  /// No description provided for @filterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get filterAll;

  /// No description provided for @filterOpen.
  ///
  /// In de, this message translates to:
  /// **'Offen'**
  String get filterOpen;

  /// No description provided for @filterCompleted.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get filterCompleted;

  /// No description provided for @sortLabel.
  ///
  /// In de, this message translates to:
  /// **'Sortierung'**
  String get sortLabel;

  /// No description provided for @sortNewest.
  ///
  /// In de, this message translates to:
  /// **'Neueste zuerst'**
  String get sortNewest;

  /// No description provided for @sortPriority.
  ///
  /// In de, this message translates to:
  /// **'Priorität'**
  String get sortPriority;

  /// No description provided for @sortPomodoros.
  ///
  /// In de, this message translates to:
  /// **'Pomodoros'**
  String get sortPomodoros;

  /// No description provided for @active.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get completed;

  /// No description provided for @locked.
  ///
  /// In de, this message translates to:
  /// **'Gesperrt'**
  String get locked;

  /// No description provided for @forTimer.
  ///
  /// In de, this message translates to:
  /// **'Für Timer'**
  String get forTimer;

  /// No description provided for @priorityLow.
  ///
  /// In de, this message translates to:
  /// **'Niedrig'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get priorityHigh;

  /// No description provided for @taskLoadRemoteFailed.
  ///
  /// In de, this message translates to:
  /// **'Aufgaben konnten nicht vom Backend geladen werden. Lokale Daten werden weiter angezeigt.'**
  String get taskLoadRemoteFailed;

  /// No description provided for @taskSavedLocallyNotSynced.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe wurde lokal gespeichert, konnte aber nicht mit dem Konto synchronisiert werden.'**
  String get taskSavedLocallyNotSynced;

  /// No description provided for @taskSaveFailedRolledBack.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe konnte nicht gespeichert werden. Die letzte Änderung wurde zurückgenommen.'**
  String get taskSaveFailedRolledBack;

  /// No description provided for @taskDeleteFailedRestored.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe konnte nicht im Konto gelöscht werden. Die Aufgabe wurde wiederhergestellt.'**
  String get taskDeleteFailedRestored;

  /// No description provided for @taskCreateTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe erstellen'**
  String get taskCreateTitle;

  /// No description provided for @taskEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe bearbeiten'**
  String get taskEditTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get taskTitleLabel;

  /// No description provided for @taskTitleRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte Titel eingeben'**
  String get taskTitleRequired;

  /// No description provided for @taskTitleTooShort.
  ///
  /// In de, this message translates to:
  /// **'Der Titel ist zu kurz.'**
  String get taskTitleTooShort;

  /// No description provided for @taskDescriptionLabel.
  ///
  /// In de, this message translates to:
  /// **'Beschreibung'**
  String get taskDescriptionLabel;

  /// No description provided for @priorityLabel.
  ///
  /// In de, this message translates to:
  /// **'Priorität'**
  String get priorityLabel;

  /// No description provided for @tagsLabel.
  ///
  /// In de, this message translates to:
  /// **'Tags/Kategorien'**
  String get tagsLabel;

  /// No description provided for @tagsHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Uni, Arbeit, Entwicklung'**
  String get tagsHint;

  /// No description provided for @timerResetTitle.
  ///
  /// In de, this message translates to:
  /// **'Timer zurücksetzen?'**
  String get timerResetTitle;

  /// No description provided for @timerResetMessage.
  ///
  /// In de, this message translates to:
  /// **'Die aktuelle Phase wird abgebrochen und nicht als abgeschlossene Sitzung gespeichert.'**
  String get timerResetMessage;

  /// No description provided for @taskNoneSelected.
  ///
  /// In de, this message translates to:
  /// **'Keine Aufgabe ausgewählt'**
  String get taskNoneSelected;

  /// No description provided for @currentTask.
  ///
  /// In de, this message translates to:
  /// **'Aktuelle Aufgabe: {title}'**
  String currentTask(String title);

  /// No description provided for @taskForWorkPhase.
  ///
  /// In de, this message translates to:
  /// **'Aufgabe für diese Arbeitsphase'**
  String get taskForWorkPhase;

  /// No description provided for @taskLockedToPhase.
  ///
  /// In de, this message translates to:
  /// **'Diese Phase ist fest mit der ausgewählten Aufgabe verbunden.'**
  String get taskLockedToPhase;

  /// No description provided for @phaseWork.
  ///
  /// In de, this message translates to:
  /// **'Arbeitsphase'**
  String get phaseWork;

  /// No description provided for @phaseShortBreak.
  ///
  /// In de, this message translates to:
  /// **'Kurze Pause'**
  String get phaseShortBreak;

  /// No description provided for @phaseLongBreak.
  ///
  /// In de, this message translates to:
  /// **'Lange Pause'**
  String get phaseLongBreak;

  /// No description provided for @timerStatusSaving.
  ///
  /// In de, this message translates to:
  /// **'Speichern ...'**
  String get timerStatusSaving;

  /// No description provided for @timerStatusRunning.
  ///
  /// In de, this message translates to:
  /// **'Läuft'**
  String get timerStatusRunning;

  /// No description provided for @timerStatusPaused.
  ///
  /// In de, this message translates to:
  /// **'Pausiert'**
  String get timerStatusPaused;

  /// No description provided for @timerStatusReady.
  ///
  /// In de, this message translates to:
  /// **'Bereit'**
  String get timerStatusReady;

  /// No description provided for @phaseDescriptionWork.
  ///
  /// In de, this message translates to:
  /// **'Fokuszeit'**
  String get phaseDescriptionWork;

  /// No description provided for @phaseDescriptionShortBreak.
  ///
  /// In de, this message translates to:
  /// **'Kurze Erholung'**
  String get phaseDescriptionShortBreak;

  /// No description provided for @phaseDescriptionLongBreak.
  ///
  /// In de, this message translates to:
  /// **'Längere Erholung'**
  String get phaseDescriptionLongBreak;

  /// No description provided for @afterNextPhase.
  ///
  /// In de, this message translates to:
  /// **'{phaseDescription} · Danach: {nextPhase}'**
  String afterNextPhase(String phaseDescription, String nextPhase);

  /// No description provided for @todayPomodorosLoading.
  ///
  /// In de, this message translates to:
  /// **'Heute: wird geladen ...'**
  String get todayPomodorosLoading;

  /// No description provided for @todayPomodoros.
  ///
  /// In de, this message translates to:
  /// **'Heute: {pomodoros}'**
  String todayPomodoros(String pomodoros);

  /// No description provided for @pomodoroCount.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Pomodoro} other{{count} Pomodoros}}'**
  String pomodoroCount(int count);

  /// No description provided for @pause.
  ///
  /// In de, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @continueButton.
  ///
  /// In de, this message translates to:
  /// **'Fortsetzen'**
  String get continueButton;

  /// No description provided for @start.
  ///
  /// In de, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @skipPause.
  ///
  /// In de, this message translates to:
  /// **'Pause überspringen'**
  String get skipPause;

  /// No description provided for @shortcutSpaceCompact.
  ///
  /// In de, this message translates to:
  /// **'Space: Start/Pause'**
  String get shortcutSpaceCompact;

  /// No description provided for @shortcutResetCompact.
  ///
  /// In de, this message translates to:
  /// **'R: Reset'**
  String get shortcutResetCompact;

  /// No description provided for @shortcutSkipCompact.
  ///
  /// In de, this message translates to:
  /// **'S: Skip'**
  String get shortcutSkipCompact;

  /// No description provided for @shortcutSpace.
  ///
  /// In de, this message translates to:
  /// **'Leertaste: Start/Pause'**
  String get shortcutSpace;

  /// No description provided for @shortcutReset.
  ///
  /// In de, this message translates to:
  /// **'R: Zurücksetzen'**
  String get shortcutReset;

  /// No description provided for @shortcutSkip.
  ///
  /// In de, this message translates to:
  /// **'S: Pause überspringen'**
  String get shortcutSkip;

  /// No description provided for @phaseSavingTitle.
  ///
  /// In de, this message translates to:
  /// **'Phase wird gespeichert'**
  String get phaseSavingTitle;

  /// No description provided for @phaseSavingDescription.
  ///
  /// In de, this message translates to:
  /// **'Die abgeschlossene Phase wird gespeichert und der Timer wird vorbereitet.'**
  String get phaseSavingDescription;

  /// No description provided for @storageProblem.
  ///
  /// In de, this message translates to:
  /// **'Speicherproblem'**
  String get storageProblem;

  /// No description provided for @oneFinishedPhaseSavingBackground.
  ///
  /// In de, this message translates to:
  /// **'Abgeschlossene Phase wird im Hintergrund gespeichert.'**
  String get oneFinishedPhaseSavingBackground;

  /// No description provided for @manyFinishedPhasesSavingBackground.
  ///
  /// In de, this message translates to:
  /// **'{count} abgeschlossene Phasen werden im Hintergrund gespeichert.'**
  String manyFinishedPhasesSavingBackground(int count);

  /// No description provided for @timerLocalSaveFailed.
  ///
  /// In de, this message translates to:
  /// **'Die abgeschlossene Phase konnte nicht lokal gespeichert werden.'**
  String get timerLocalSaveFailed;

  /// No description provided for @timerBackendSyncFailed.
  ///
  /// In de, this message translates to:
  /// **'Die abgeschlossene Phase wurde lokal gespeichert, aber noch nicht mit dem Backend synchronisiert.'**
  String get timerBackendSyncFailed;

  /// No description provided for @phaseProgress.
  ///
  /// In de, this message translates to:
  /// **'{elapsed} von {total}'**
  String phaseProgress(String elapsed, String total);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

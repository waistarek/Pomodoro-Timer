# Google Play Store vorbereiten

## Voraussetzungen

- Google Play Developer Account
- Flutter-Projekt mit Android-Plattformordner
- App-Name
- Package Name
- App-Icon
- Datenschutzerklärung
- Screenshots

## Schritt 1: Android-Plattform erzeugen

```bash
cd frontend/flutter_app
flutter create --platforms=android .
```

## Schritt 2: Package Name festlegen

Beispiel:

```text
com.deinname.pomodoroapp
```

Der Package Name muss eindeutig sein und kann später nur schwer geändert werden.

## Schritt 3: App-Name setzen

In Android wird der Name in der Android-Konfiguration gesetzt. Für Anfänger am einfachsten später über Flutter-Pakete wie `flutter_launcher_icons` und `flutter_native_splash` ergänzen.

## Schritt 4: App Icon vorbereiten

Benötigt wird ein klares quadratisches Icon. Empfehlung:

```text
1024 x 1024 px PNG
```

## Schritt 5: Keystore erstellen

```bash
keytool -genkey -v -keystore ~/pomodoro-upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Die Passwörter sicher speichern. Ohne Keystore kann später kein Update signiert werden.

## Schritt 6: key.properties erstellen

Datei:

```text
frontend/flutter_app/android/key.properties
```

Beispiel:

```properties
storePassword=DEIN_STORE_PASSWORD
keyPassword=DEIN_KEY_PASSWORD
keyAlias=upload
storeFile=/Users/deinname/pomodoro-upload-keystore.jks
```

Diese Datei darf nicht in Git gespeichert werden.

## Schritt 7: Android Signing konfigurieren

In Flutter folgt man der offiziellen Android-Release-Anleitung und trägt `key.properties` in die Gradle-Konfiguration ein.

## Schritt 8: Release-Build erstellen

AAB (Android App Bundle – Upload-Datei für Google Play):

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

Ausgabe:

```text
build/app/outputs/bundle/release/app-release.aab
```

## Schritt 9: Datenschutzerklärung

Die App hat Login, Aufgaben und Statistikdaten. Deshalb sollte eine Datenschutzerklärung erklären:

- welche Daten gespeichert werden
- wofür die Daten genutzt werden
- wie Benutzer Löschung verlangen können
- wer verantwortlich ist
- welche Server/Hosting-Anbieter genutzt werden

## Schritt 10: Store-Eintrag vorbereiten

Benötigt:

- App-Name
- Kurzbeschreibung
- ausführliche Beschreibung
- Kategorie
- Screenshots
- App-Icon
- Feature Graphic
- Datenschutzerklärung
- Angaben zur Datensicherheit
- Altersfreigabe

## Schritt 11: Test-Release

1. Play Console öffnen.
2. App erstellen.
3. Interner Test oder geschlossener Test auswählen.
4. AAB hochladen.
5. Tester hinzufügen.
6. Release prüfen.
7. Test starten.

## Schritt 12: Production-Release

Erst nach erfolgreichem Test:

1. Production Track öffnen.
2. Neues Release erstellen.
3. AAB hochladen.
4. Release Notes schreiben.
5. Prüfen lassen.
6. Veröffentlichen.

## Wichtige Hinweise

- Version Code muss bei jedem Update erhöht werden.
- Login und Backend müssen stabil funktionieren.
- Datenschutzerklärung muss zur tatsächlichen App passen.
- Für echte Push-Benachrichtigungen werden zusätzliche Berechtigungen und Hinweise benötigt.

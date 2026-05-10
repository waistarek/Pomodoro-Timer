# Apple App Store vorbereiten

## Voraussetzungen

- Mac mit Xcode
- Apple Developer Account
- Flutter-Projekt mit iOS-Plattformordner
- Bundle Identifier
- App Icon
- Datenschutzerklärung
- Screenshots

## Schritt 1: iOS-Plattform erzeugen

```bash
cd frontend/flutter_app
flutter create --platforms=ios .
```

## Schritt 2: Bundle Identifier festlegen

Beispiel:

```text
com.deinname.pomodoroapp
```

Der Bundle Identifier muss in Apple Developer und Xcode zusammenpassen.

## Schritt 3: Xcode öffnen

```bash
open ios/Runner.xcworkspace
```

Dann in Xcode:

1. Runner auswählen.
2. Signing & Capabilities öffnen.
3. Team auswählen.
4. Bundle Identifier prüfen.
5. Automatically manage signing aktivieren.

## Schritt 4: App Icon vorbereiten

Das App Icon wird in Xcode unter Assets gepflegt. Eine einfache Variante ist später die Nutzung von `flutter_launcher_icons`.

## Schritt 5: Splash Screen vorbereiten

Für einen professionellen Startbildschirm kann später `flutter_native_splash` ergänzt werden.

## Schritt 6: Release-Build prüfen

```bash
flutter build ios --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

## Schritt 7: Archive erstellen

In Xcode:

1. Gerät auf `Any iOS Device` setzen.
2. Menü `Product` öffnen.
3. `Archive` auswählen.
4. Nach dem Build öffnet sich Organizer.

## Schritt 8: Upload

Upload ist möglich über:

- Xcode Organizer
- Apple Transporter App

## Schritt 9: TestFlight

1. App Store Connect öffnen.
2. App erstellen.
3. Build auswählen.
4. Testinformationen eintragen.
5. Interne oder externe Tester hinzufügen.
6. TestFlight-Test starten.

## Schritt 10: App Store Connect

Benötigt:

- App-Name
- Beschreibung
- Keywords
- Support-URL
- Datenschutzerklärung-URL
- Screenshots
- Kategorie
- Altersfreigabe
- App Privacy Angaben
- Review-Hinweise

## Schritt 11: Review-Hinweise

Für Apple sollte erklärt werden:

- Testkonto, falls Login erforderlich ist
- was die App macht
- ob Backend-Server erreichbar sein müssen
- ob besondere Berechtigungen genutzt werden

## Schritt 12: Production-Release

1. Alle Metadaten ausfüllen.
2. Build auswählen.
3. App Privacy ausfüllen.
4. Zur Prüfung einreichen.
5. Nach Freigabe veröffentlichen.

## Wichtige Hinweise

- Für iOS braucht man zwingend einen Mac mit Xcode.
- Ohne Apple Developer Account ist kein App-Store-Release möglich.
- Login-Apps brauchen oft ein Testkonto für die Prüfung.
- Datenschutzerklärung muss erreichbar und korrekt sein.

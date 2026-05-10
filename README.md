# Pomodoro App

Professionelle Pomodoro-App als Flutter-Frontend mit Python/FastAPI-Backend.

## Ziel

Die alte HTML/CSS/JavaScript-App wurde in eine moderne Projektstruktur überführt:

- Flutter für Web, Android und iOS
- FastAPI als Python-Backend
- SQLite als einfache lokale Backend-Datenbank
- REST-API für Login, Aufgaben, Sessions, Einstellungen und Statistiken
- Vorbereitung für Netlify, Backend-Hosting, Google Play Store und Apple App Store

## Projektstruktur

```text
pomodoro_app/
  frontend/
    flutter_app/
      lib/
      assets/
      test/
      pubspec.yaml
      netlify.toml
  backend/
    app/
    tests/
    requirements.txt
    main.py
  docs/
    deployment/
    store/
  README.md
```

## Begriffe einfach erklärt

### Frontend

Frontend bedeutet: der sichtbare Teil der App. Dazu gehören Buttons, Timer-Anzeige, Aufgabenliste, Einstellungen und Statistikseiten. In diesem Projekt ist Flutter das Frontend.

### Backend

Backend bedeutet: der unsichtbare Serverteil. Das Backend speichert Benutzer, Aufgaben, Pomodoro-Sessions und Einstellungen. In diesem Projekt ist FastAPI das Backend.

### API

API (Application Programming Interface – Programmierschnittstelle zwischen Softwareteilen) bedeutet: eine klare Schnittstelle, über die Flutter mit dem Backend spricht. Beispiel: Flutter sendet eine Login-Anfrage an `POST /auth/login`.

### REST-API

REST-API (Representational State Transfer Application Programming Interface – HTTP-Schnittstelle für Datenzugriff) bedeutet: Das Frontend ruft URLs mit HTTP-Methoden auf, z. B. `GET /tasks`, `POST /tasks` oder `DELETE /tasks/1`.

### Warum brauchen wir ein Backend?

Ohne Backend bleiben Daten nur auf einem Gerät. Mit Backend können Benutzer sich anmelden und ihre Aufgaben, Einstellungen und Pomodoro-Daten später zwischen Web, Android und iOS synchronisieren.

### Was wird lokal gespeichert?

In der Flutter-App werden lokal gespeichert:

- Einstellungen
- Aufgaben als Offline-Kopie
- Login-Token
- Timer-Zustand nur während der Nutzung

### Was wird im Backend gespeichert?

Im Backend werden gespeichert:

- Benutzerkonto
- Aufgaben
- abgeschlossene Pomodoro-Sessions
- Einstellungen
- berechnete Statistiken

## Lokale Installation

### 1. Backend starten

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload
```

Backend läuft dann unter:

```text
http://127.0.0.1:8000
```

API-Dokumentation:

```text
http://127.0.0.1:8000/docs
```

### 2. Flutter-App vorbereiten

Falls die Ordner `android/`, `ios/` und `web/` noch fehlen, zuerst die Flutter-Plattformdateien erzeugen:

```bash
cd frontend/flutter_app
flutter create --platforms=android,ios,web .
```

Danach Abhängigkeiten installieren:

```bash
flutter pub get
```

### 3. Flutter lokal starten

Web:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

Android:

```bash
flutter run -d android --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

Hinweis: `10.0.2.2` ist aus dem Android-Emulator heraus der Zugriff auf den lokalen Rechner.

## Builds erstellen

### Flutter Web

```bash
cd frontend/flutter_app
flutter build web --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

Ausgabeordner:

```text
frontend/flutter_app/build/web
```

### Android AAB

AAB (Android App Bundle – Upload-Datei für Google Play):

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

Ausgabe:

```text
build/app/outputs/bundle/release/app-release.aab
```

### iOS Release

```bash
flutter build ipa --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

Für iOS werden ein Mac, Xcode und ein Apple Developer Account benötigt.

## Tests

### Backend-Tests

```bash
cd backend
pytest
```

### Flutter-Tests

```bash
cd frontend/flutter_app
flutter test
```

## API-Endpunkte

### Authentifizierung

- `POST /auth/register`
- `POST /auth/login`
- `GET /users/me`

### Aufgaben

- `GET /tasks`
- `POST /tasks`
- `PUT /tasks/{id}`
- `DELETE /tasks/{id}`

### Pomodoro-Sessions

- `GET /sessions`
- `POST /sessions`

### Statistiken

- `GET /stats/daily`
- `GET /stats/weekly`
- `GET /stats/monthly`

### Einstellungen

- `GET /settings`
- `PUT /settings`

## Dokumentation

- Netlify: `docs/deployment/netlify.md`
- Backend: `docs/deployment/backend.md`
- Google Play Store: `docs/store/google-play.md`
- Apple App Store: `docs/store/apple-app-store.md`
- Analyse der alten App: `docs/original-project-analysis.md`

## Fehlerbehebung

### Flutter findet keine Plattformen

Befehl im Ordner `frontend/flutter_app` ausführen:

```bash
flutter create --platforms=android,ios,web .
```

### Backend ist aus Flutter Web nicht erreichbar

Prüfen:

1. Läuft FastAPI?
2. Ist die URL bei `API_BASE_URL` korrekt?
3. Ist CORS im Backend richtig gesetzt?

### Android-Emulator erreicht Backend nicht

Im Android-Emulator nicht `127.0.0.1` verwenden, sondern:

```text
http://10.0.2.2:8000
```

### Login funktioniert nicht

Prüfen:

1. Backend läuft.
2. `/docs` ist erreichbar.
3. Benutzer wurde registriert.
4. `JWT_SECRET` ist in Produktion sicher gesetzt.

## Nächste sinnvolle Erweiterungen

- echte Push-Benachrichtigungen mit `flutter_local_notifications`
- SQLite/Hive im Flutter-Frontend statt JSON in SharedPreferences
- automatische Offline-Synchronisierung mit Konfliktlösung
- PostgreSQL für Produktion
- CI/CD mit GitHub Actions oder GitLab CI

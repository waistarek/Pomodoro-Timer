# Pomodoro Timer

Professionelle Pomodoro-App mit Flutter Web, FastAPI, SQLAlchemy, Alembic und PostgreSQL/Neon.

## 1. Projektüberblick

Diese Anwendung ist ein Pomodoro-Timer mit Benutzerkonto, Aufgabenverwaltung, Statistik, lokalen Offline-Daten und Backend-Synchronisation.

Die App besteht aus zwei Hauptteilen:

```text
Pomodoro-Timer/
├── backend/                 # FastAPI-Backend
└── frontend/
    └── flutter_app/          # echte Flutter-App
```

Wichtig: Das gültige Frontend-Projekt liegt unter:

```text
frontend/flutter_app/
```

Nicht im Ordner `frontend/` direkt.

## 2. Funktionen

- Registrierung und Login
- Pomodoro-Timer mit Arbeitsphase, kurzer Pause und langer Pause
- Aufgabenverwaltung
- Auswahl einer Aufgabe für eine Pomodoro-Session
- Speicherung abgeschlossener Sessions im Backend
- Offline-Warteschlange für Sessions
- Statistik für Tag, Woche, Monat und Aufgaben
- Lokale Einstellungen
- Theme-Auswahl inklusive Farbauswahl
- Backend-Synchronisation
- Deployment über Render und Netlify

## 3. Technologie-Stack

### Frontend

- Flutter
- Dart
- Provider für State Management
- SharedPreferences für lokale Speicherung
- Netlify für Deployment

### Backend

- Python
- FastAPI
- SQLAlchemy
- Alembic für Datenbankmigrationen
- PostgreSQL/Neon als Datenbank
- Render für Deployment

## 4. Projektstruktur

```text
Pomodoro-Timer/
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   ├── models.py
│   │   ├── schemas.py
│   │   ├── database.py
│   │   ├── auth.py
│   │   └── security.py
│   ├── alembic/
│   │   └── versions/
│   ├── tests/
│   ├── requirements.txt
│   └── alembic.ini
│
└── frontend/
    └── flutter_app/
        ├── lib/
        │   ├── main.dart
        │   ├── models/
        │   ├── providers/
        │   ├── screens/
        │   ├── services/
        │   └── theme/
        ├── test/
        ├── pubspec.yaml
        ├── netlify.toml
        └── netlify_build.sh
```

## 5. Lokale Backend-Ausführung

In den Backend-Ordner wechseln:

```bash
cd backend
```

Virtuelle Umgebung erstellen:

```bash
python3 -m venv .venv
```

Virtuelle Umgebung aktivieren:

```bash
source .venv/bin/activate
```

Unter Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Abhängigkeiten installieren:

```bash
pip install -r requirements.txt
```

Backend starten:

```bash
uvicorn app.main:app --reload
```

Standardmäßig ist das Backend danach erreichbar unter:

```text
http://127.0.0.1:8000
```

Swagger-Dokumentation:

```text
http://127.0.0.1:8000/docs
```

## 6. Umgebungsvariablen für das Backend

Das Backend benötigt eine Datenbankverbindung, zum Beispiel:

```env
DATABASE_URL=postgresql+psycopg://USER:PASSWORD@HOST/DBNAME?sslmode=require
SECRET_KEY=your-secret-key
```

Die `.env`-Datei darf nicht ins Git-Repository committed werden.

## 7. Datenbankmigrationen

Migrationen werden mit Alembic verwaltet.

Aktuellen Stand prüfen:

```bash
cd backend
alembic current
alembic heads
```

Migrationen ausführen:

```bash
alembic upgrade head
```

Neue Migration erstellen:

```bash
alembic revision -m "describe change"
```

SQL-Vorschau erzeugen:

```bash
alembic upgrade head --sql > migration_preview.sql
```

## 8. Lokale Frontend-Ausführung

In das echte Flutter-Projekt wechseln:

```bash
cd frontend/flutter_app
```

Abhängigkeiten installieren:

```bash
flutter pub get
```

App im Browser starten:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

Für das produktive Backend:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://pomodoro-backend-00pe.onrender.com
```

## 9. Frontend-Build

Web-Build erstellen:

```bash
cd frontend/flutter_app
flutter build web --release --dart-define=API_BASE_URL=https://pomodoro-backend-00pe.onrender.com
```

Android-Build:

```bash
cd frontend/flutter_app
flutter build apk
```

iOS-Build auf macOS mit Xcode:

```bash
cd frontend/flutter_app
flutter build ios
```

## 10. Netlify-Deployment

Das Netlify-Deployment verwendet das echte Flutter-Projekt:

```toml
[build]
  base = "frontend/flutter_app"
  command = "bash netlify_build.sh"
  publish = "build/web"
```

Der Root-Ordner `frontend/` ist nur ein Container-Ordner. Dort darf kein zweites Flutter-Projekt liegen.

## 11. Render-Deployment

Das Backend kann auf Render deployed werden.

Typische Einstellungen:

```text
Root Directory: backend
Build Command: pip install -r requirements.txt
Start Command: uvicorn app.main:app --host 0.0.0.0 --port $PORT
```

Die Umgebungsvariablen müssen in Render gesetzt werden.

## 12. Tests

Backend-Tests:

```bash
cd backend
pytest -q
```

Frontend-Analyse:

```bash
cd frontend/flutter_app
flutter analyze
```

Frontend-Tests:

```bash
cd frontend/flutter_app
flutter test
```

Formatierung:

```bash
cd frontend/flutter_app
dart format lib test
```

## 13. Wichtige Architekturentscheidungen

### Idempotente Session-Erstellung

Jede Pomodoro-Session besitzt eine `client_session_id`. Dadurch kann dieselbe Session bei Wiederholung oder Offline-Sync nicht mehrfach gespeichert werden.

### Offline-Sessions

Wenn eine Session nicht sofort ans Backend gesendet werden kann, wird sie lokal in `pending_sessions` gespeichert und später synchronisiert.

### Statistik

Statistikdaten werden backendseitig aus abgeschlossenen Sessions berechnet. Tages-, Wochen- und Monatsstatistiken berücksichtigen die lokale Zeitzone.

### Aufgaben-Pomodoros

Die Anzahl abgeschlossener Pomodoros pro Aufgabe wird nicht redundant in der Aufgabe gespeichert, sondern aus den Sessions berechnet.

### Einstellungen

Einstellungen werden lokal und im Backend gespeichert. Dazu gehören Timer-Längen, Auto-Start, Sound, Vibration, Theme und Theme-Farbe.

## 14. Häufige Fehlerquellen

### Falscher Frontend-Ordner

Nicht ausführen:

```bash
cd frontend
flutter build web
```

Richtig:

```bash
cd frontend/flutter_app
flutter build web
```

### Migration vergessen

Wenn ein Feld im Backend-Modell ergänzt wurde, muss für bestehende Datenbanken eine Alembic-Migration ausgeführt werden.

### `.env` versehentlich committen

Dateien mit Geheimnissen wie Datenbank-URL oder Secret-Key dürfen nicht ins Repository.

### Lokale Daten nach Logout

Lokale benutzerbezogene Daten müssen beim Logout gelöscht oder benutzergebunden gespeichert werden.

## 15. Empfohlene Prüfung vor jedem Commit

```bash
cd backend
pytest -q
```

```bash
cd frontend/flutter_app
dart format lib test
flutter analyze
flutter test
flutter build web --release --dart-define=API_BASE_URL=https://pomodoro-backend-00pe.onrender.com
```

## 16. Empfohlene Git-Commit-Konvention

Beispiele:

```text
fix: prevent duplicate pomodoro sessions
fix: load daily stats when opening statistics screen
fix: persist theme color settings in backend
fix: clear local user data on logout
fix: remove duplicate root flutter project
```

## 17. Deployment-Checkliste

Vor Deployment prüfen:

- Backend-Tests erfolgreich
- Frontend-Tests erfolgreich
- `flutter analyze` ohne Fehler
- Alembic-Migrationen auf Neon ausgeführt
- Netlify zeigt auf `frontend/flutter_app`
- Render verwendet den Ordner `backend`
- `API_BASE_URL` zeigt auf das Render-Backend
- Keine `.env`-Dateien im Repository
- Kein zweites Flutter-Projekt im Ordner `frontend/`

## 18. Lizenz

Dieses Projekt ist ein Lern- und Entwicklungsprojekt.

# FastAPI-Backend deployen

## Grundidee

Das Backend ist eine dauerhaft laufende Python-Anwendung. Netlify ist hauptsächlich für statische Webseiten geeignet. Deshalb wird das Backend separat veröffentlicht.

Mögliche Anbieter:

- Render
- Railway
- Fly.io
- eigener Server

## Lokaler Start

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload
```

## Wichtige Dateien

```text
backend/
  requirements.txt
  main.py
  app/main.py
  app/database.py
  app/models.py
  app/schemas.py
  app/security.py
```

## Startbefehl für Hosting

Für einfache Hosting-Anbieter:

```bash
uvicorn app.main:app --host 0.0.0.0 --port $PORT
```

Wenn der Anbieter keinen `$PORT` setzt:

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

## Umgebungsvariablen

```text
DATABASE_URL=sqlite:///./pomodoro.db
JWT_SECRET=sehr_langer_zufaelliger_geheimer_schluessel
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=10080
CORS_ORIGINS=https://deine-netlify-domain.netlify.app,https://deine-domain.de
```

## Datenbank

Für die erste Version reicht SQLite. Für Produktion ist PostgreSQL besser, weil mehrere Serverinstanzen und dauerhafte Speicherung zuverlässiger sind.

SQLite:

```text
DATABASE_URL=sqlite:///./pomodoro.db
```

PostgreSQL später:

```text
DATABASE_URL=postgresql+psycopg://USER:PASSWORD@HOST:PORT/DATABASE
```

Dann müssen zusätzlich ein PostgreSQL-Treiber und Migrationen ergänzt werden.

## CORS

CORS (Cross-Origin Resource Sharing – Browser-Regel für Zugriffe zwischen verschiedenen Domains) muss erlaubt sein, weil Flutter Web und Backend unterschiedliche Domains haben.

Beispiel:

```text
CORS_ORIGINS=https://pomodoro-app.netlify.app,https://api.example.com
```

## HTTPS

Für Login und JWT sollte HTTPS verwendet werden. Die meisten Hosting-Anbieter stellen HTTPS automatisch bereit.

## Backend-URL mit Flutter verbinden

Beim Build:

```bash
flutter build web --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

Für Android/iOS Release:

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://dein-backend.example.com
flutter build ipa --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

## Render-Beispiel

1. Neues Web Service erstellen.
2. Repository verbinden.
3. Root directory: `backend`
4. Build command:

```bash
pip install -r requirements.txt
```

5. Start command:

```bash
uvicorn app.main:app --host 0.0.0.0 --port $PORT
```

6. Environment variables setzen.
7. Deploy starten.

## Fehlerbehebung

### ModuleNotFoundError

Prüfen, ob `requirements.txt` installiert wurde.

### CORS-Fehler im Browser

Prüfen, ob die Netlify-Domain in `CORS_ORIGINS` eingetragen ist.

### Login funktioniert lokal, aber nicht online

Prüfen:

- Backend-URL korrekt?
- HTTPS aktiv?
- `JWT_SECRET` gesetzt?
- Datenbank erreichbar?

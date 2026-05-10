# Flutter Web auf Netlify veröffentlichen

## Grundidee

Netlify eignet sich gut für statische Webseiten. Eine Flutter-Web-App wird beim Build in statische Dateien umgewandelt. Diese Dateien liegen danach in:

```text
frontend/flutter_app/build/web
```

Das Python-Backend läuft nicht dauerhaft auf Netlify. Deshalb wird das Backend separat gehostet, z. B. auf Render, Railway oder Fly.io.

## Schritt 1: Flutter Web lokal testen

```bash
cd frontend/flutter_app
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

## Schritt 2: Release-Build erstellen

```bash
flutter build web --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

## Schritt 3: Netlify manuell hochladen

Für Anfänger ist diese Variante am einfachsten:

1. Bei Netlify anmelden.
2. Neue Website erstellen.
3. Ordner `frontend/flutter_app/build/web` per Drag-and-Drop hochladen.
4. Netlify veröffentlicht die Seite.

## Schritt 4: Deployment über Git

Wenn das Projekt in GitHub oder GitLab liegt:

- Base directory: `frontend/flutter_app`
- Build command:

```bash
flutter build web --release --dart-define=API_BASE_URL=$API_BASE_URL
```

- Publish directory:

```text
build/web
```

## Schritt 5: netlify.toml

Datei:

```text
frontend/flutter_app/netlify.toml
```

Inhalt:

```toml
[build]
  base = "frontend/flutter_app"
  command = "flutter build web --release --dart-define=API_BASE_URL=$API_BASE_URL"
  publish = "build/web"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

Die Redirect-Regel ist wichtig, weil Flutter Web wie eine Single Page Application funktioniert. Ohne diese Regel können direkte Links nach einem Neuladen zu 404-Fehlern führen.

## Schritt 6: Backend-URL als Umgebungsvariable setzen

In Netlify:

1. Site öffnen.
2. Site configuration öffnen.
3. Environment variables öffnen.
4. Variable hinzufügen:

```text
API_BASE_URL=https://dein-backend.example.com
```

## Schritt 7: Domain verbinden

1. Domain settings öffnen.
2. Custom domain hinzufügen.
3. DNS-Einträge nach Netlify-Anleitung setzen.
4. Warten, bis DNS aktiv ist.

## Schritt 8: HTTPS aktivieren

Netlify stellt normalerweise automatisch HTTPS-Zertifikate bereit. Nach dem Verbinden der Domain prüfen:

```text
https://deine-domain.de
```

## Häufige Fehler

### Weiße Seite nach Deployment

Prüfen:

- Wurde `build/web` veröffentlicht?
- Ist `index.html` im veröffentlichten Ordner?
- Wurde Flutter mit `--release` gebaut?

### API funktioniert im Browser nicht

Prüfen:

- Ist `API_BASE_URL` korrekt?
- Hat das Backend HTTPS?
- Ist CORS im Backend für die Netlify-Domain erlaubt?

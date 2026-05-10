# Nächste Schritte

## 1. Backend lokal starten

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload
```

Öffnen:

```text
http://127.0.0.1:8000/docs
```

## 2. Backend testen

```bash
cd backend
source .venv/bin/activate
pytest
```

## 3. Flutter-Plattformdateien erzeugen

```bash
cd frontend/flutter_app
flutter create --platforms=android,ios,web .
flutter pub get
```

## 4. Flutter Web lokal starten

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

## 5. Flutter Web Build erstellen

```bash
flutter build web --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

## 6. Android Build erstellen

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://dein-backend.example.com
```

## 7. iOS Build vorbereiten

```bash
flutter build ios --release --dart-define=API_BASE_URL=https://dein-backend.example.com
open ios/Runner.xcworkspace
```

## 8. Dokumentation lesen

- `README.md`
- `docs/architecture.md`
- `docs/deployment/netlify.md`
- `docs/deployment/backend.md`
- `docs/store/google-play.md`
- `docs/store/apple-app-store.md`

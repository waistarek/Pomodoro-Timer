# Pomodoro Web Assets

Dieser Ordner enthält die von dir hochgeladenen Bilder in einer sauberen Web-App-Ordnerstruktur.

## Struktur

- `logo/` – Logo-Dateien und Logo-Marke
- `favicon/` – Favicons und Apple Touch Icon
- `pwa/` – PWA-Icons (Progressive Web App – installierbare Web-App im Browser)
- `web/` – Hero-/Web-Bilder
- `social/` – Open-Graph- und Social-Media-Vorschaubilder
- `splash/` – Splash-/Startbilder
- `backgrounds/` – abstrakte Hintergründe
- `illustrations/` – Empty-State-Illustrationen
- `ui/` – UI-Vorschauen
- `marketing/` – Marketing-/Feature-Bilder
- `original_upload/` – unveränderte Originaldateien aus deinem Upload
- `preview/contact_sheet.jpg` – Übersicht aller hochgeladenen Dateien

## Wichtig

Einige Dateien sind von Gemini technisch noch nicht perfekt:
- Manche UI-Bilder wirken wie Platzhalter.
- Transparente PNG-Dateien können in manchen Viewern schwarz angezeigt werden, sind aber als RGBA-Dateien mit Alpha-Kanal vorhanden.
- Für produktive App-Store-Screenshots sollten später echte Screenshots aus deiner Flutter-App verwendet werden.

## Empfohlene erste Nutzung im Flutter-Web-Projekt

Kopiere zuerst diese Dateien in dein Flutter-Projekt:

```text
frontend/flutter_app/assets/images/logo/logo_mark_only.png
frontend/flutter_app/assets/images/logo/logo_horizontal.png
frontend/flutter_app/assets/images/illustrations/empty_tasks.png
frontend/flutter_app/assets/images/illustrations/empty_stats.png
frontend/flutter_app/assets/images/backgrounds/gradient_light.png
frontend/flutter_app/assets/images/backgrounds/gradient_dark.png
frontend/flutter_app/web/favicon.png
frontend/flutter_app/web/icons/Icon-192.png
frontend/flutter_app/web/icons/Icon-512.png
```

## Zuordnung

Die genaue Zuordnung von Originaldatei zu neuem Dateinamen steht in:

```text
asset_index.csv
```

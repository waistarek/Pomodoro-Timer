# Zielarchitektur

## Warum Provider statt BLoC?

Für Anfänger ist Provider einfacher als BLoC.

Provider bedeutet:

- weniger Dateien
- weniger Theorie
- schneller verständlich
- gut genug für kleine und mittlere Apps

BLoC (Business Logic Component – Architektur zur strikten Trennung von Ereignissen und Zuständen) ist sehr strukturiert, aber am Anfang deutlich komplizierter.

Dieses Projekt nutzt deshalb:

```text
models/      Datenklassen
services/    API, lokale Speicherung, Sound
providers/   App-Zustand und Logik
screens/     ganze Seiten
widgets/     wiederverwendbare UI-Bausteine
```

## Datenfluss

```text
Screen → Provider → Service → Backend
Screen → Provider → LocalStorage
```

Beispiel Aufgabe erstellen:

1. Benutzer erstellt Aufgabe im Screen.
2. `TaskProvider` nimmt die Aufgabe entgegen.
3. Aufgabe wird lokal gespeichert.
4. Wenn Internet und Login vorhanden sind, wird sie an das Backend gesendet.
5. UI aktualisiert sich automatisch.

## Offline-Strategie

Die App speichert Aufgaben und Einstellungen lokal. Dadurch funktioniert die App auch ohne Internet.

Für eine spätere professionelle Version sollte ergänzt werden:

- lokale SQLite- oder Hive-Datenbank im Flutter-Frontend
- Sync-Queue für nicht übertragene Änderungen
- Konfliktlösung, wenn dieselben Daten auf mehreren Geräten geändert wurden

## Sicherheit

Das Backend nutzt:

- bcrypt für Passwort-Hashing
- JWT für eingeloggte Benutzer
- CORS-Konfiguration für erlaubte Frontend-Domains
- getrennte Benutzer-Daten über `user_id`

Wichtig für Produktion:

- `JWT_SECRET` sicher setzen
- HTTPS verwenden
- PostgreSQL statt SQLite nutzen
- Rate Limiting ergänzen
- Passwort-Reset ergänzen

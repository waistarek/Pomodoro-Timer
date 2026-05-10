# Analyse der vorhandenen HTML/CSS/JavaScript-App

## Vorhandene Dateien

```text
Pomodoro-Timer/
  index.html
  style.css
  script.js
  audios/
    bells.mp3
```

## Vorhandene Funktionen

Die bisherige App kann:

- eine 25-Minuten-Arbeitsphase anzeigen
- eine 5-Minuten-Pause anzeigen
- Timer starten
- Timer pausieren
- Timer zurücksetzen
- automatisch zwischen Arbeit und Pause wechseln
- am Ende einer Phase eine Sounddatei abspielen

## index.html

Die Datei `index.html` enthält:

- Grundstruktur der Seite
- Überschrift `Pomodoro Timer`
- Timer-Anzeige mit `id="timer"`
- Buttons für Start, Pause und Reset
- Audio-Element für `audios/bells.mp3`
- Einbindung von `style.css` und `script.js`

## style.css

Die Datei `style.css` enthält:

- einfache zentrierte Darstellung
- weiße Karte mit Schatten
- große Timer-Anzeige
- farbige Buttons für Start, Pause und Reset

## script.js

Die Datei `script.js` enthält die eigentliche Timerlogik:

- `DEFAULTS.work = 25 * 60`
- `DEFAULTS.rest = 5 * 60`
- `mode` unterscheidet zwischen `work` und `rest`
- `remainingSeconds` speichert die Restzeit
- `running` sagt, ob der Timer läuft
- `endAt` speichert den Zielzeitpunkt der aktuellen Phase
- `tick()` berechnet die Restzeit anhand der echten Uhrzeit
- `switchPhase()` wechselt zwischen Arbeitsphase und Pause
- `startTimer()` startet oder setzt den Timer fort
- `pauseTimer()` pausiert und speichert die Restzeit
- `resetTimer()` setzt auf 25 Minuten Arbeit zurück

## Was muss in Flutter neu umgesetzt werden?

In Flutter werden neu umgesetzt:

- Timerlogik als saubere Dart-Klasse
- UI mit responsivem Layout
- Kreisförmige Fortschrittsanzeige
- Phasenanzeige
- Aufgabenverwaltung
- Einstellungen
- Statistiken
- Login/Register
- API-Verbindung zum Backend
- lokale Speicherung
- Vorbereitung für Web, Android und iOS

## Was kann übernommen werden?

Übernommen werden kann:

- die Grundidee der Timerlogik
- die Standardwerte 25 Minuten Arbeit und 5 Minuten Pause
- die Sounddatei `audios/bells.mp3`

Die alte HTML/CSS/JavaScript-Struktur wird nicht direkt übernommen, weil Flutter eine eigene UI-Struktur verwendet.

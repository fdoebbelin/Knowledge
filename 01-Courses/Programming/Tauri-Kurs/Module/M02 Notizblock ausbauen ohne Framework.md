---
modul: M02
title: Notizblock ausbauen ohne Framework
ue: 4
phase: Fundament
ort: Toolbx
tags: [tauri/kurs/modul, vanilla, ipc]
status: draft
---

# M02 – Notizblock ausbauen ohne Framework

> [!abstract] Worum es geht
> Der `notizblock` aus dem Leitfaden hat genau ein Eingabefeld und einen Knopf. Er wird jetzt zu einer echten Notizliste ausgebaut, weiterhin mit reinem TypeScript und DOM-API. Der dabei entstehende Synchronisationscode ist die Begründung für [[M03 Umstieg auf Vue 3 und Vite]].

## Lernziele

- Den Weg vom Quellcode über Vite zum Fenster nachvollziehen
- Die Rolle von `frontendDist` und `devUrl` erklären
- Einen Rust-Command per `invoke` aufrufen und Fehler behandeln
- Belegen, warum manuelle DOM-Synchronisation bei wachsender Oberfläche kippt

## Ausgangsstand

Aus dem Leitfaden vorhanden: `src/index.html` mit `greet`-Aufruf, `src-tauri/src/main.rs` mit `#[tauri::command] fn greet`. Der `[[bin]]`-Block ist gesetzt, der Binärname lautet weiterhin nicht `app`.

## Inhalte

1. **Projektstruktur** nach der Umstellung aus Modul 00
2. **`tauri.conf.json`** – die Schlüssel `identifier`, `productName`, `build.*`, `app.windows`
3. **Entwicklungszyklus** – Vite-HMR im Frontend, Neukompilierung bei Rust-Änderungen
4. **IPC ohne globales Objekt** – `import { invoke } from "@tauri-apps/api/core"` statt `window.__TAURI__`
5. **WebKit-DevTools** – Rechtsklick, Element untersuchen
6. **Der Ausbau** – Notizliste mit Anlegen, Löschen, Textfilter, Zeichenzähler, ausschließlich per `document.createElement` und Event-Listenern

## Praxisteil

- [ ] `greet` durch `zeitstempel(text: String)` ersetzen, gibt Text mit Zeitstempel zurück
- [ ] Notizliste in Vanilla-TS umsetzen: Anlegen, Löschen, Filter
- [ ] Alle Zeilen markieren, die ausschließlich DOM und Datenmodell abgleichen
- [ ] Zahl notieren, sie wird in Modul 03 wieder gebraucht
- [ ] Fehlerfall provozieren: `invoke` auf einen nicht registrierten Command, Fehlermeldung dokumentieren

> [!question] Reflexionsfrage
> Wie viel Prozent Ihres Codes beschreibt Anwendungslogik, wie viel hält nur die Anzeige aktuell?

## Typische Fallstricke

> [!warning]
> - `invoke` liefert ein Promise. Ohne `await` erscheint `[object Promise]` im DOM.
> - Rust-Commands sind `snake_case`, Parameter kommen aus JavaScript aber häufig in `camelCase` an. Namensmapping früh erklären.
> - Rust-Änderungen lösen eine Neukompilierung aus. Das dauert und ist kein Hänger.
> - Beim Löschen wird das DOM-Element entfernt, aber nicht der Eintrag im Datenmodell. Klassischer Zwei-Wahrheiten-Fehler und bestes Argument für Modul 03.

## Verknüpfung

Weiter mit [[M03 Umstieg auf Vue 3 und Vite]] · zurück zu [[00 Kurskonzept Tauri]]

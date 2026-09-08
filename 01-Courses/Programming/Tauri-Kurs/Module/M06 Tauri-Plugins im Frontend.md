---
modul: M06
titel: Tauri-Plugins im Frontend
ue: 5
phase: Frontend-Kern
ort: Toolbx
tags: [tauri/kurs/modul, plugins, portals]
status: entwurf
---

# M06 – Tauri-Plugins im Frontend

> [!abstract] Worum es geht
> Der Moment, in dem aus einer Weboberfläche eine Desktop-Anwendung wird. Dateien öffnen, speichern, benachrichtigen. Alles aus dem Frontend, ohne eine Zeile Rust. Unter Wayland läuft das über XDG-Portals, was in Modul 07 und 11 wieder aufgegriffen wird.

## Lernziele

- Das Plugin-System von Tauri 2 erklären und ein Plugin vollständig installieren
- Systemdialoge zum Öffnen und Speichern nutzen
- Dateien lesen und schreiben
- Benachrichtigungen, Zwischenablage und externe Links ansprechen
- Erklären, was ein XDG-Portal ist und warum es hier auftaucht

## Inhalte

1. **Plugin-Architektur** – drei Schritte: Crate in `Cargo.toml`, npm-Paket im Frontend, Registrierung in `lib.rs`
2. **`plugin-dialog`** – `open`, `save`, Filter, Mehrfachauswahl
3. **XDG-Portal** – der Dateidialog wird nicht von der Anwendung gezeichnet, sondern vom Portal-Dienst des Systems. Unter Sway braucht es `xdg-desktop-portal-gtk`.
4. **`plugin-fs`** – `readTextFile`, `writeTextFile`, `readDir`, `exists`, Basisverzeichnisse
5. **`plugin-notification`** – Berechtigung anfragen, senden. Unter Sway ist ein Benachrichtigungsdienst wie `mako` nötig, sonst passiert stumm nichts.
6. **`plugin-clipboard-manager`** – Wayland-Zwischenablage
7. **`plugin-opener`** – Links im Standardbrowser statt im WebView
8. **Fehlerbehandlung** – Abbruch durch den Nutzer ist kein Fehlerfall
9. **Pfade** – nie fest verdrahten, immer über die Path-API

Installation, alles im Container:

```nu
cd ~/Projekte/noteflow/src-tauri
cargo add tauri-plugin-dialog tauri-plugin-fs tauri-plugin-notification tauri-plugin-opener
cd ..
npm --prefix frontend install @tauri-apps/plugin-fs @tauri-apps/plugin-notification @tauri-apps/plugin-opener
```

Vorher prüfen, ob die Systemvoraussetzungen auf dem **Host** stehen:

```nu
ls /usr/share/xdg-desktop-portal/portals | get name
pgrep -l mako
```

## Praxisteil

- [ ] Dialog- und FS-Plugin installieren und in `lib.rs` registrieren
- [ ] Notizen als `.md`-Dateien in einem über den Dialog gewählten Ordner speichern
- [ ] Ordner beim Start einlesen und Liste daraus aufbauen
- [ ] Benachrichtigung nach erfolgreichem Speichern
- [ ] Notiztext in die Zwischenablage kopieren
- [ ] Links aus dem Notiztext im Systembrowser öffnen
- [ ] Abbruch des Dateidialogs sauber behandeln

> [!note] Vorschau auf Modul 07
> Die ersten Plugin-Aufrufe scheitern mit einem Berechtigungsfehler. Das ist beabsichtigt und leitet zu [[M07 Sicherheit Capabilities und Sandkasten]] über.

## Typische Fallstricke

> [!warning]
> - Crate installiert, Registrierung in `lib.rs` vergessen.
> - Dateidialog öffnet gar nicht: kein Portal-Dienst auf dem Host. Fehlerbild ist ein stilles Nichts, kein Stacktrace.
> - Benachrichtigung erscheint nicht: kein Benachrichtigungsdienst unter Sway, oder Berechtigung nie angefragt.
> - Nutzer bricht ab, Ergebnis ist `null`, der Code prüft es nicht.
> - Pfadtrennzeichen hart geschrieben statt über die Path-API gebildet.

## Verknüpfung

Weiter mit [[M07 Sicherheit Capabilities und Sandkasten]] · zurück zu [[00 Kurskonzept Tauri]]

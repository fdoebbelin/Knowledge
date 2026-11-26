---
id: 202611262028
title: withGlobalTauri macht Tauri ohne Bundler nutzbar
type: zettel
tags:
  - rust/tauri
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Das Frontend einer Tauri-App spricht das Rust-Backend über `invoke` an. Üblich ist, die Funktion aus dem npm-Paket `@tauri-apps/api` zu importieren. Das setzt Node und einen Bundler wie Vite voraus.

Für ein kleines Frontend aus einer einzigen HTML-Datei geht es einfacher. Mit `"withGlobalTauri": true` unter `app` in `tauri.conf.json` stellt Tauri seine API als globales Objekt `window.__TAURI__` bereit:

```js
const { invoke } = window.__TAURI__.core;
const gruss = await invoke("greet", { name: "Ada" });
```

Die ganze Werkzeugkette bleibt dann bei `cargo`: kein Node, kein npm, kein Build-Schritt für das Frontend. Gestartet wird mit `cargo tauri dev`. Fehlt die Einstellung, meldet die Konsole `window.__TAURI__ is undefined`.

Sobald Single-File-Components oder TypeScript dazukommen, braucht es den Build-Schritt doch – dann lohnt der Weg über npm und Vite.

## Verbindungen

- [[cargo tauri init nennt das Cargo-Paket app]] – die zweite Falle beim Aufsetzen eines Tauri-Projekts
- [[AppImages lassen sich in Toolbx nicht bauen]] – die dritte Anpassung in `tauri.conf.json` für Toolbx
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]

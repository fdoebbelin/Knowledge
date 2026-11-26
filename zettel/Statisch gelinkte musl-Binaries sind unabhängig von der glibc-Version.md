---
id: 202611262025
title: Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version
type: zettel
tags:
  - linux
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Viele Werkzeuge, etwa aus Rust oder Go, gibt es für Linux in zwei Varianten: dynamisch gegen die glibc gelinkt (`-gnu`) oder statisch mit musl (`-musl`). Die gnu-Variante braucht zur Laufzeit eine glibc, die mindestens so neu ist wie beim Bauen. Die musl-Variante bringt alles mit, was sie braucht.

Das zählt, wenn ein Binary in mehreren Umgebungen laufen soll: auf dem Host, in einem Toolbx-Container mit anderer Fedora-Version, in einem künftigen Container. Ein musl-Build unter `~/.local/bin` läuft überall, wo das Home eingehängt ist, ohne Neuinstallation. Nushell etwa liefert dafür eigene Pakete der Form `nu-VERSION-x86_64-unknown-linux-musl.tar.gz`.

Der Preis: Statische Binaries sind größer, und Fehlerbehebungen in Systembibliotheken erreichen sie erst mit einer neuen Version des Werkzeugs. Für einzelne Werkzeuge im Home ist das meist vertretbar.

## Verbindungen

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – wo ein Werkzeug liegen muss, das überall laufen soll
- [[Versionsverzeichnis und Symlink machen Updates umkehrbar]] – wie man ein solches Binary im Home installiert
- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]] – das Problem, das statisches Linken umgeht
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]

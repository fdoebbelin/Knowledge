---
id: 202611262023
title: Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird
type: zettel
tags:
  - linux/flatpak
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
---

Ein kompiliertes Programm ist gegen die Bibliotheken gelinkt, die beim Bauen vorhanden waren, allen voran die glibc. Läuft es später in einer Umgebung mit älteren Bibliotheken, startet es nicht (`version 'GLIBC_2.xx' not found`) oder verhält sich ohne Fehlermeldung falsch.

Bei Flatpak zeigt sich das sofort. Ein Binary aus dem Toolbx-Container ist gegen die aktuelle Fedora-Version gelinkt, die Flatpak-Runtime – etwa die GNOME-Runtime – bringt meist ältere Bibliotheken mit. Ein fertiges Binary oder `.deb` ins Flatpak zu packen ist darum bequem, aber falsch. Richtig ist, den Release im Flatpak-SDK zu bauen, das zur Runtime gehört.

Die Regel betrifft nativen Code. Statische Dateien wie HTML, CSS und gebündeltes JavaScript haben keine Bindung an die glibc und dürfen auch außerhalb des SDK entstehen.

Kurz: Der Entwicklungscontainer ist zum Entwickeln da. Das ausgelieferte Programm entsteht in der Umgebung, in der es auch laufen wird.

## Verbindungen

- [[Die Rust-Erweiterung der Flatpak-SDK muss zur Freedesktop-Basis passen]] – die praktische Folge beim Rust-Build im SDK
- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]] – der andere Ausweg: gar nicht dynamisch linken
- [[Toolbx ist keine Sandbox]] – der Entwicklungscontainer ist zum Bauen da, nicht zum Ausliefern
- [[Entwickeln auf Fedora Atomic]] – Strukturzettel zu diesem Thema

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]]

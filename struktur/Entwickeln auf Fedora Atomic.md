---
id: 202611262032
title: Entwickeln auf Fedora Atomic
type: struktur
tags:
  - linux/atomic
created: 2026-11-26
---

Wie man auf einem unveränderlichen Fedora entwickelt, ohne das Basisimage anzufassen: Werkzeuge im Home, Build-Abhängigkeiten im Toolbx-Container, Auslieferung als Flatpak. Am besten von oben nach unten lesen – vom System über den Container bis zum fertigen Paket.

## Das System

- [[Auf Fedora Atomic ist das Verzeichnis home ein Symlink]] – warum Pfade auf Host und im Container verschieden aussehen
- [[Gelayerte Pakete liest man aus rpm-ostree aus, statt sie aufzuzählen]] – wie man das Basisimage wieder sauber bekommt

## Toolbx: Entwickeln im Container

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]] – die Grundregel, aus der fast alles andere folgt
- [[Toolbx ist keine Sandbox]] – was Toolbx trennt und was nicht
- [[Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft]] – eine gemeinsame Konfiguration für Host und Container
- [[Toolbx übernimmt die Login-Shell vom Host]] – warum `chsh` im Container nicht hält
- [[Rust-Toolchains lassen sich je Container trennen]] – die geteilte Toolchain als typische Falle

## Werkzeuge im Home

- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]] – ein Binary für alle Umgebungen
- [[Versionsverzeichnis und Symlink machen Updates umkehrbar]] – Installieren ohne Paketmanager
- [[In Nushell ist PATH eine Liste]] – Umgebung einrichten in Nushell
- [[grep -m1 am Ende einer Pipe lässt curl abbrechen]] – ein Stolperstein beim Download-Skript

## Ausliefern als Flatpak

- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]] – die zentrale Regel fürs Ausliefern
- [[Die Rust-Erweiterung der Flatpak-SDK muss zur Freedesktop-Basis passen]] – die passende Version finden

## Tauri auf Fedora Atomic

- [[withGlobalTauri macht Tauri ohne Bundler nutzbar]] – Tauri mit `cargo` allein
- [[cargo tauri init nennt das Cargo-Paket app]] – der Binärname, der erst beim Paketieren auffällt
- [[AppImages lassen sich in Toolbx nicht bauen]] – warum Flatpak statt AppImage

## Quellen

- [[Von der leeren Toolbx zur installierten Flatpak-App]] – der Leitfaden, aus dem diese Zettel stammen

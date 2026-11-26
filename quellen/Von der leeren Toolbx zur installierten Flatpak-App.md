---
id: 202611262015
title: Von der leeren Toolbx zur installierten Flatpak-App
type: quelle
tags:
  - linux/toolbx
  - linux/flatpak
  - rust/tauri
created: 2026-11-26
herkunft: 04-Languages/Rust/Tauri/Von der leeren Toolbx zur installierten Flatpak-App.md
autor: Fritz-Rainer Döbbelin
url: https://github.com/fdoebbelin/Tauri-Kurs/blob/main/Anhang/Von%20der%20leeren%20Toolbx%20zur%20installierten%20Flatpak-App.md
art: archiv
---

## Worum es geht

Ein Schritt-für-Schritt-Leitfaden für Fedora Atomic: Eine kleine Tauri-App wird in einem Toolbx-Container entwickelt, im Flatpak-SDK gebaut und als Flatpak installiert und verteilt. Alle Befehle sind in Nushell geschrieben, die Werkzeugkette ist durchgängig `cargo`, ohne Node. Der Leitfaden ist Voraussetzung für zwei Tauri-Kurse und liegt heute im Repository des Tauri-Kurses unter `Anhang/`.

## Kernaussagen

- Der Ablauf hat sechs Phasen: eine Shell einrichten, die auf Host und Container gilt – Container anlegen – entwickeln – Release bauen – als Flatpak paketieren und verteilen – Container wegwerfen und reproduzierbar neu aufbauen.
- Vier Ebenen bleiben getrennt: Das Basisimage wird nicht angefasst, Build-Abhängigkeiten liegen im Toolbx, gebaut wird im Flatpak-SDK, die App läuft im Flatpak-Sandkasten.
- Der Entwicklungscontainer ist zum Bauen da, nicht zum Ausliefern. Das ausgelieferte Programm entsteht dort, wo dieselben Bibliotheken gelten wie später zur Laufzeit.
- Das geteilte Home-Verzeichnis ist zugleich Vorteil und Hauptfehlerquelle: Werkzeuge im Home gibt es überall, Konfiguration und Toolchains muss man aber bewusst nach Host und Container trennen.

## Nicht übernommen

Versionsstände (GNOME 50 auf Freedesktop 25.08), die vollständige Beispiel-App mit Manifest und Metadaten, das Setup-Skript und der Spickzettel – sie stehen im Leitfaden selbst. Die Behauptung, Nushell kenne kein Variablen-Präfix (`FOO=1 befehl`), ist überholt und wurde nicht übernommen.

## Daraus entstandene Zettel

- [[Toolbx teilt mit dem Host nur das Home-Verzeichnis]]
- [[Auf Fedora Atomic ist das Verzeichnis home ein Symlink]]
- [[Toolbx ist keine Sandbox]]
- [[Eine Markerdatei zeigt an, dass die Shell im Toolbx-Container läuft]]
- [[Toolbx übernimmt die Login-Shell vom Host]]
- [[Rust-Toolchains lassen sich je Container trennen]]
- [[Gelayerte Pakete liest man aus rpm-ostree aus, statt sie aufzuzählen]]
- [[Gebaut wird gegen dieselbe Umgebung, in der später gelaufen wird]]
- [[Die Rust-Erweiterung der Flatpak-SDK muss zur Freedesktop-Basis passen]]
- [[Statisch gelinkte musl-Binaries sind unabhängig von der glibc-Version]]
- [[Versionsverzeichnis und Symlink machen Updates umkehrbar]]
- [[cargo tauri init nennt das Cargo-Paket app]]
- [[withGlobalTauri macht Tauri ohne Bundler nutzbar]]
- [[AppImages lassen sich in Toolbx nicht bauen]]
- [[grep -m1 am Ende einer Pipe lässt curl abbrechen]]
- [[In Nushell ist PATH eine Liste]]

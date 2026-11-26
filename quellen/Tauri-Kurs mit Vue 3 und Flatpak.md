---
id: 202611262007
title: Tauri-Kurs mit Vue 3 und Flatpak
type: quelle
tags:
  - tauri/kurs
created: 2026-11-26
herkunft: 01-Courses/Programming/Tauri-Kurs
autor: Fritz-Rainer Döbbelin
url: https://github.com/fdoebbelin/Tauri-Kurs
art: kurs
draft: true
---

## Worum es geht

Ein Kurskonzept für angehende Fachinformatiker Anwendungsentwicklung mit Web-Vorkenntnissen: In 14 Modulen (64 Unterrichtseinheiten) wird aus einem einfachen Notizblock die Markdown-Notizverwaltung „NoteFlow“, gebaut mit Tauri 2, Vue 3, TypeScript und Vite. Entwickelt wird auf Fedora Atomic in einem Toolbx-Container, ausgeliefert als Flatpak. Der Schwerpunkt liegt auf dem Frontend und auf der Anbindung nativer Funktionen.

## Kernaussagen

- Auf dem Host wird nichts installiert. Fehlende Abhängigkeiten gehören in den Toolbx-Container oder ins Flatpak-Manifest.
- Für Single-File-Components und TypeScript braucht es einen Build-Schritt und damit Node. Node läuft deshalb nur im wegwerfbaren Container. Die statischen Frontend-Dateien dürfen außerhalb der Flatpak-SDK entstehen, das Rust-Binary dagegen nicht.
- Tauri-Capabilities und Flatpak-Sandkasten sind zwei getrennte Berechtigungsschichten. Beide werden minimal gesetzt.
- Unter Wayland und Sway bestimmt der Compositor über Fenstergröße und Position, und globale Tastenkürzel funktionieren anders als unter X11.
- Didaktisch gilt „Problem vor Lösung“: Erst der DOM-Code ohne Framework zeigt, wozu Vue gut ist.

## Verwandte Quellen

- [[Kompaktkurs Tauri-Grundlagen]] – eigenständige Einsteigervariante ohne Framework und ohne Node, teilt Umgebung und Zielsystem

## Daraus entstandene Zettel

Noch keine.

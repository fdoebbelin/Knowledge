---
id: 202611262002
title: Kompaktkurs Tauri-Grundlagen
type: quelle
tags:
  - tauri/kurs
created: 2026-11-26
herkunft: 01-Courses/Programming/Tauri-Kompaktkurs
autor: Fritz-Rainer Döbbelin
url: https://github.com/fdoebbelin/Tauri-Kompaktkurs
art: kurs
draft: true
---

## Worum es geht

Ein Kurs für Einsteiger ohne Vorwissen in Webtechniken: In acht Modulen (K0–K7) entsteht eine kleine Lernkarten-App als Desktop-Anwendung mit Tauri 2, die am Ende als Flatpak installiert ist. HTML, CSS und JavaScript werden nur so weit eingeführt, wie dieses eine Projekt sie braucht. Der Kurs liegt mit Leitfaden, Merkblättern und Übungsblättern in einem eigenen Repository.

## Kernaussagen

- Ein Kompaktkurs vermittelt Webtechniken nicht als Handwerk. Das ehrliche Ziel ist, eine vorgegebene Oberfläche zu verstehen und abzuwandeln, nicht eine App von null zu entwerfen.
- Ohne Framework und ohne Node: drei Dateien (`index.html`, `style.css`, `app.js`), gebaut wird nur mit `cargo`. Mit `withGlobalTauri` steht `invoke` ohne `import` bereit.
- Dateizugriffe laufen über vorbereitete Rust-Commands, weil die Tauri-Plugins als npm-Pakete einen Bundler bräuchten.
- Die Kursleitung richtet Container und Projektgerüst vorher ein. Sonst geht ein großer Teil der Kurszeit für die Einrichtung verloren.
- Ein durchgehendes, nach jedem Modul benutzbares Projekt (Lernkarten als Liste aus Objekten in einer JSON-Datei) trägt die Einführung von Arrays und Objekten.

## Daraus entstandene Zettel

Noch keine.

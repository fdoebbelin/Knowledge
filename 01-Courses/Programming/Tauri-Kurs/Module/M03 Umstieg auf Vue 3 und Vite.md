---
modul: M03
titel: Umstieg auf Vue 3 und Vite
ue: 6
phase: Fundament
ort: Toolbx
tags: [tauri/kurs/modul, vue, typescript]
status: entwurf
---

# M03 – Umstieg auf Vue 3 und Vite

> [!abstract] Worum es geht
> Das Kernmodul des Frontend-Schwerpunkts. Die Notizliste aus [[M02 Notizblock ausbauen ohne Framework]] wird nach Vue 3 überführt. Das Framework tritt als Antwort auf ein erlebtes Problem auf, nicht als gesetzte Vorgabe.

## Lernziele

- Aufbau einer Single-File-Component erklären: `<script setup>`, `<template>`, `<style scoped>`
- Reaktiven Zustand mit `ref` und `reactive` anlegen, Rolle von `.value` verstehen
- Abgeleitete Werte mit `computed` bilden
- Listen und Bedingungen mit `v-for` und `v-if` darstellen
- Eingaben mit `v-model` binden
- Den Unterschied zwischen deklarativem und imperativem UI-Code am eigenen Code belegen

## Inhalte

1. **Warum ein Framework** – Rückblick auf die Zeilenzählung aus Modul 02
2. **Was Vite im Tauri-Zyklus tut** – `beforeDevCommand` startet den Devserver, Tauri lädt `devUrl`, HMR läuft über WebKitGTK
3. **Single-File-Components** – die drei Blöcke, `scoped` Styles
4. **Reaktivität**
   - `ref` für Einzelwerte, `.value` im Script, automatisches Unwrapping im Template
   - `reactive` für Objekte und wann es sich lohnt
   - `computed` für abgeleitete Werte
5. **Template-Syntax** – `v-if`, `v-else`, `v-for` mit `:key`, Kurzformen `:` und `@`
6. **Zweiweg-Bindung** mit `v-model`
7. **TypeScript in Vue** – `interface Note`, typisiertes `ref<Note[]>`
8. **Portierung** der Notizliste
9. **Lebenszyklus** – `onMounted`, im nächsten Modul relevant

## Praxisteil

- [ ] `App.vue` mit der portierten Notizliste umsetzen
- [ ] `interface Note` mit `id`, `titel`, `inhalt`, `geaendert` definieren
- [ ] Filter über `computed` statt manueller Neuberechnung
- [ ] `zeitstempel`-Command aus Modul 02 einbinden
- [ ] Zeilenzahl mit dem Vanilla-Stand vergleichen und Ergebnis dokumentieren
- [ ] Prüfen: Kann der Zwei-Wahrheiten-Fehler aus Modul 02 hier überhaupt noch auftreten?

## Typische Fallstricke

> [!warning]
> - `.value` im Script vergessen. Häufigster Fehler des Moduls.
> - `v-for` ohne `:key`. Funktioniert scheinbar, führt beim Löschen zu falschen Ergebnissen.
> - Destrukturierung eines `reactive`-Objekts zerstört die Reaktivität.
> - Direkte DOM-Zugriffe aus alter Gewohnheit. Konsequent zurückweisen.
> - HMR reagiert nicht: Vite beobachtet versehentlich `src-tauri`. `watch.ignored` aus Modul 00 prüfen.

## Material

- Vue-Dokumentation, deutschsprachig verfügbar
- Handout: Gegenüberstellung Vanilla gegen Vue für dieselbe Funktion

## Lernerfolgskontrolle

Vue-Komponente mit drei Reaktivitätsfehlern. Finden, benennen, korrigieren.

## Verknüpfung

Weiter mit [[M04 Komponenten und UI-Gestaltung]] · zurück zu [[00 Kurskonzept Tauri]]

---
modul: M05
title: Zustand und Navigation
ue: 4
phase: Frontend-Kern
ort: Toolbx
tags: [tauri/kurs/modul, vue, pinia, router]
status: draft
---

# M05 – Zustand und Navigation

> [!abstract] Worum es geht
> Wenn Daten von mehreren Komponenten gebraucht werden, reicht das Durchreichen über Props nicht mehr. Dazu Navigation zwischen Ansichten mit der Besonderheit, die für Tauri gilt.

## Lernziele

- Erkennen, wann zentraler Zustand gerechtfertigt ist
- Einen Pinia-Store mit State, Getters und Actions aufbauen
- Vue Router einrichten und navigieren
- Erklären, warum der Hash-Modus hier die sichere Wahl ist

## Inhalte

1. **Prop-Drilling** am gewachsenen NoteFlow-Beispiel
2. **Pinia** – `defineStore`, State, Getters, Actions, Zugriff in Komponenten
3. **Abgrenzung** – lokaler Zustand bleibt lokal, nur Geteiltes wandert in den Store
4. **Vue Router** – Routen, `RouterLink`, `RouterView`, programmatische Navigation
5. **Hash- gegen History-Modus** – im Devserver funktioniert beides, im Release lädt Tauri über das `tauri://`-Protokoll. Der History-Modus bricht dort. Der Fehler tritt erst in Modul 11 auf, deshalb hier vorbeugen.
6. **Ansichten in NoteFlow** – Liste, Editor, Einstellungen
7. **Zustandserhalt** mit `KeepAlive`

```nu
# Installation im Container
npm --prefix frontend install pinia vue-router
```

## Praxisteil

- [ ] Notizen aus den Komponenten in einen Pinia-Store überführen
- [ ] Getter für gefilterte und sortierte Notizen
- [ ] Router mit drei Routen, ausdrücklich `createWebHashHistory`
- [ ] Einstellungsansicht anlegen, Theme-Umschalter dorthin verlagern
- [ ] Prüfen: Bleibt der Filter beim Ansichtswechsel erhalten?
- [ ] Gegenprobe zur Vorbereitung von Modul 11: kurz auf `createWebHistory` umstellen, `cargo tauri build --no-bundle` bauen, Binary starten, leere Seite dokumentieren, zurückstellen

## Typische Fallstricke

> [!warning]
> - History-Modus funktioniert im Devserver und bricht im Release. Die Gegenprobe im Praxisteil macht das früh sichtbar.
> - Alles landet im Store, auch reiner Komponentenzustand.
> - Store-State wird von außen verändert statt über Actions.

## Diskussionsimpuls

Braucht eine App mit drei Ansichten überhaupt einen Router? Argumente für beide Seiten sammeln.

## Verknüpfung

Weiter mit [[M06 Tauri-Plugins im Frontend]] · zurück zu [[00 Kurskonzept Tauri]]

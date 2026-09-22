---
modul: M04
title: Komponenten und UI-Gestaltung
ue: 6
phase: Frontend-Kern
ort: Toolbx
tags: [tauri/kurs/modul, vue, css, ux]
status: draft
---

# M04 – Komponenten und UI-Gestaltung

> [!abstract] Worum es geht
> Aus einer großen `App.vue` wird eine sinnvoll zerlegte Komponentenstruktur. Dazu die Frage, wie eine Oberfläche aussieht, die sich unter Sway wie eine Desktop-Anwendung anfühlt.

## Lernziele

- Eine Oberfläche in Komponenten mit klaren Zuständigkeiten zerlegen
- Daten über `props` nach unten, Ereignisse über `emit` nach oben führen
- Inhalte über Slots einsetzen
- Ein Farbschema mit CSS Custom Properties aufbauen und Dark Mode unterstützen
- Die CSS-Grenzen von WebKitGTK einschätzen

## Inhalte

1. **Komponentenschnitt** – `NoteList`, `NoteItem`, `NoteEditor`, `Sidebar`, `Toolbar`
2. **Datenfluss** – `defineProps`, `defineEmits`, einseitiger Datenfluss
3. **Slots** – Standard-Slot und benannte Slots am Beispiel eines Dialogs
4. **Layout unter einem Tiling-Compositor**
   - Das Fenster bekommt die Größe, die Sway vorgibt. Feste Pixelhöhen sind hier besonders riskant.
   - CSS Grid für die Grundaufteilung, Flexbox innerhalb, Scrollbereiche sauber begrenzen
   - Test bei extremen Seitenverhältnissen: `swaymsg` Layout wechseln und Oberfläche prüfen
5. **Theming** – Custom Properties als Design-Token, `prefers-color-scheme`, manueller Umschalter
6. **WebKitGTK-Realität** – Fassung prüfen, bevor moderne CSS-Merkmale eingeplant werden

```nu
pkg-config --modversion webkit2gtk-4.1
```

7. **Desktop-Anmutung** – Textauswahl außerhalb von Eingabefeldern unterbinden, Browser-Kontextmenü ersetzen, sichtbarer Fokusring, Ladezustände ohne Layout-Sprünge
8. **Tastaturbedienung** – unter Sway besonders wichtig, weil Nutzer maustastenarm arbeiten
9. **Barrierefreiheit** – semantisches HTML, ARIA nur wo nötig

## Praxisteil

- [ ] `App.vue` in mindestens fünf Komponenten zerlegen
- [ ] Auswahl über `emit`, Anzeige über `props`
- [ ] Wiederverwendbare Dialog-Komponente mit benannten Slots
- [ ] Token-Datei mit Farben, Abständen und Radien
- [ ] Dark Mode umschaltbar
- [ ] Anwendung vollständig mit der Tastatur bedienbar
- [ ] Fenster über `swaymsg` auf ein sehr schmales und ein sehr breites Layout zwingen, Oberfläche prüfen

## Typische Fallstricke

> [!warning]
> - Zu feine Zerlegung. Eine Komponente pro Button hilft niemandem.
> - Props werden direkt verändert. Vue warnt, die Ursache bleibt oft unklar.
> - Fixe Pixelhöhen. Unter einem Tiling-Compositor fällt das sofort auf.
> - Fokusringe aus optischen Gründen entfernt. Damit ist die Tastaturbedienung tot.
> - Moderne CSS-Merkmale wie `backdrop-filter` oder `:has()` werden je nach WebKitGTK-Fassung nicht unterstützt. Vorher prüfen statt hinterher suchen.

## Lernerfolgskontrolle

Vorgegebener Screenshot wird in ein Komponentendiagramm überführt. Bewertet wird die Begründung des Schnitts.

## Verknüpfung

Weiter mit [[M05 Zustand und Navigation]] · zurück zu [[00 Kurskonzept Tauri]]

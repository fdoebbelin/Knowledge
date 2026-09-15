---
modul: M01
title: Architektur im Ebenenmodell
ue: 3
phase: Orientierung
ort: beide
tags: [tauri/kurs/modul, architektur, atomic]
status: entwurf
---

# M01 – Architektur im Ebenenmodell

> [!abstract] Worum es geht
> Zwei Modelle übereinandergelegt: die Zwei-Prozess-Architektur von Tauri und das Vier-Ebenen-Modell des Atomic-Systems. Wer beide sauber trennt, versteht später, warum ein Fehler mal in den Container, mal ins Manifest und mal in die Capability gehört.

## Lernziele

- Die Trennung von Rust-Core und WebView beschreiben
- Erklären, warum Tauri die System-WebView nutzt
- Die vier Ebenen aus dem Leitfaden benennen und Fehler darin verorten
- Tauri gegen Electron, PWA und native Entwicklung abgrenzen
- Die Besonderheiten von WebKitGTK gegenüber WebView2 und WKWebView benennen

## Inhalte

1. **Zwei Prozesse** – Rust-Core erzeugt Fenster und stellt native Funktionen bereit, WebView rendert
2. **System-WebView** – hier ausschließlich WebKitGTK 4.1, im Flatpak die Fassung aus `org.gnome.Platform`
3. **Konsequenz** – kleine Bundles, aber unterschiedliche Rendering-Engines je Zielplattform
4. **Die vier Ebenen** und was jeweils dort hingehört

| Ebene | Beispiel für ein Problem | Richtiger Ort für die Lösung |
|---|---|---|
| Basisimage | Portal fehlt, Dateidialog öffnet nicht | Systemkonfiguration, nicht das Projekt |
| Toolbx | `webkit2gtk-4.1 not found` | `dnf install` im Container |
| Flatpak-SDK | `xdo.h: No such file` | Modul im Manifest ergänzen |
| Anwendung | App darf Ordner nicht lesen | Capability oder `finish-args` |

5. **Vergleich der Ansätze**

| Kriterium | Tauri | Electron | PWA | Nativ (GTK) |
|---|---|---|---|---|
| Bundle-Größe | sehr klein | groß | keine Installation | klein |
| Speicherbedarf | gering | hoch | gering | gering |
| Rendering-Konsistenz | plattformabhängig | einheitlich | browserabhängig | einheitlich |
| Systemzugriff | umfassend | umfassend | eingeschränkt | vollständig |
| Sprachbedarf | Web + etwas Rust | Web | Web | C, Vala, Python |

6. **WebKitGTK im Besonderen** – DMA-BUF-Renderer, ältere CSS-Unterstützung als Chromium, kein `backdrop-filter` in manchen Fassungen
7. **Tauri 1 gegenüber Tauri 2** – Plugin-System, Berechtigungsmodell, mobile Ziele

## Praxisteil

- [ ] Im Projekt `noteflow` die Dateien den beiden Prozessen zuordnen
- [ ] Für fünf vorgegebene Fehlermeldungen die richtige Ebene bestimmen
- [ ] `flatpak info --show-permissions de.metarow.Notizblock` ausführen und mit den Rechten eines Toolbx-Prozesses vergleichen
- [ ] Größe des Notizblock-Flatpak gegen eine Electron-Referenz stellen

> [!question] Kernfrage des Moduls
> Der Leitfaden nennt Toolbx ausdrücklich **keine Sandbox** und belegt das mit `/run/host`. Das Flatpak dagegen sieht `$HOME` nicht. Erklären Sie den Unterschied und warum beide Werkzeuge trotzdem nebeneinander sinnvoll sind.

## Typische Fallstricke

> [!warning]
> Teilnehmende erwarten pixelgleiche Ergebnisse auf allen Plattformen. Da hier nur WebKitGTK vorliegt, fällt der Unterschied im Kurs gar nicht auf. Genau deshalb muss er theoretisch benannt und in Modul 11 über CI-Artefakte wenigstens einmal sichtbar gemacht werden.

## Verknüpfung

Weiter mit [[M02 Notizblock ausbauen ohne Framework]] · zurück zu [[00 Kurskonzept Tauri]]

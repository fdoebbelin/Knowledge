---
id: 202611262045
title: Der Bildschirm-Ursprung oben links stammt aus der Abtastreihenfolge der Bildröhre
type: zettel
tags:
  - informatik/grafik
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Koordinatenursprung 2D – Raster vs. kartesisch.md
---

Bei einer Kathodenstrahlröhre schreibt der Elektronenstrahl das Bild Zeile für Zeile: Er beginnt oben links, läuft nach rechts, springt eine Zeile tiefer zurück an den linken Rand und so weiter bis unten rechts. Dann kehrt er nach oben links zurück.

![[crt-rasterscan.svg]]

Der Bildspeicher (Framebuffer) wurde in genau dieser Reihenfolge adressiert. Adresse 0 ist das Pixel oben links, die Adressen steigen nach rechts und dann zeilenweise nach unten. Dass *y* nach unten wächst, ist also keine Entscheidung über Geometrie, sondern folgt aus der Speicheradresse: Das Pixel (*x*, *y*) liegt bei *y* · Breite + *x*.

Diese Konvention erbten fast alle bildschirmnahen Systeme: X11, Windows GDI, HTML und CSS, Canvas 2D, SVG. Auch Bilddateien wie PNG und JPEG speichern ihre Zeilen von oben nach unten. Eine Ausnahme ist BMP: Bei positiver Bildhöhe steht dort die unterste Zeile zuerst.

![[raster-vs-kartesisch.svg]]

## Verbindungen

- [[Die Richtung der y-Achse hängt von der Domäne ab, nicht von der Epoche]] – warum diese Konvention nicht die einzige geblieben ist
- [[OpenGL-Texturen stehen auf dem Kopf, weil Bilddateien oben beginnen]] – wo sie mit der Gegenkonvention zusammenstößt
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

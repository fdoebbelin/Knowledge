---
id: 202611262046
title: Die Richtung der y-Achse hängt von der Domäne ab, nicht von der Epoche
type: zettel
tags:
  - informatik/grafik
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Koordinatenursprung 2D – Raster vs. kartesisch.md
---

Man könnte meinen, früher habe der Ursprung oben links gelegen und heute gelte das mathematische System mit *y* nach oben. Einen solchen Umschwung gab es nicht. Beide Konventionen bestehen nebeneinander, und welche gilt, hängt vom Fachgebiet ab.

**y nach oben**, Ursprung unten links: die Mathematik seit Descartes; PostScript (1980er) und damit PDF, weil man im Druck eine Seite vom unteren Rand aus bemisst; OpenGL (1992), als 3D-Schnittstelle in mathematischer Konvention entworfen; macOS mit AppKit und Quartz als Erbe von NeXTSTEP und Display PostScript.

**y nach unten**, Ursprung oben links: X11, Windows GDI, HTML und CSS, Canvas 2D, SVG und Apples UIKit auf iOS. Derselbe Hersteller hat also beide: AppKit zählt nach oben, UIKit nach unten.

Verschoben haben sich höchstens die Gewichte. Seit Grafik über die GPU läuft und 2D als Sonderfall von 3D behandelt wird, ist *y* nach oben in Spiel-Engines, Plot-Bibliotheken wie matplotlib und wissenschaftlicher Visualisierung häufiger geworden. Bildschirm und Web zählen weiter nach unten.

Als Merksatz: *y* nach unten denkt in Bildspeicher, *y* nach oben denkt in Mathematik und Papier.

## Verbindungen

- [[Der Bildschirm-Ursprung oben links stammt aus der Abtastreihenfolge der Bildröhre]] – woher die Konvention mit y nach unten stammt
- [[OpenGL-Texturen stehen auf dem Kopf, weil Bilddateien oben beginnen]] – die Reibung, wenn beide in einem Programm zusammenkommen
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

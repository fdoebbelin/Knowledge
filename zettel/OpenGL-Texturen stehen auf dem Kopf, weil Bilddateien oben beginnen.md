---
id: 202611262047
title: OpenGL-Texturen stehen auf dem Kopf, weil Bilddateien oben beginnen
type: zettel
tags:
  - informatik/grafik
created: 2026-11-26
herkunft: 01-Courses/Programming/CS-Basics/Koordinatenursprung 2D – Raster vs. kartesisch.md
---

Lädt man ein PNG unverändert als OpenGL-Textur, steht es auf dem Kopf. Bilddateien speichern ihre Zeilen von oben nach unten, die erste Zeile im Speicher ist die oberste. OpenGL legt die Texturkoordinate (0, 0) aber unten links und behandelt die erste übergebene Zeile als unterste.

![[opengl-textur-flip.svg]]

Es gibt zwei Abhilfen. Entweder man spiegelt das Bild beim Laden senkrecht – viele Bildlader haben dafür einen Schalter, etwa `stbi_set_flip_vertically_on_load` in stb_image. Oder man rechnet die *v*-Koordinate um:

```glsl
vec2 uv = vec2(texCoord.x, 1.0 - texCoord.y);
```

Beim Portieren zwischen OpenGL und Direct3D kommt das Thema wieder: Direct3D legt den Texturursprung oben links und orientiert auch den Bildraum anders. Wer für beide Schnittstellen schreibt, muss an mehreren Stellen bewusst spiegeln.

## Verbindungen

- [[Der Bildschirm-Ursprung oben links stammt aus der Abtastreihenfolge der Bildröhre]] – warum Bilddateien oben beginnen
- [[Die Richtung der y-Achse hängt von der Domäne ab, nicht von der Epoche]] – warum OpenGL unten beginnt
- [[Grundlagen der Informatik]] – Strukturzettel zu diesem Thema

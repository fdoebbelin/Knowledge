---
tags:
  - computergrafik
  - koordinatensysteme
  - lehrmaterial
aliases:
  - "Koordinatenursprung 2D"
  - "y-down vs y-up"
created: 2026-06-17
---

# Koordinatenursprung in 2D: Raster (oben links) vs. kartesisch

> [!question] Ausgangsfrage
> Historisch lag der Koordinatenursprung im 2D-Bereich **oben links**, heute scheint dagegen das *normale kartesische* Koordinatensystem zu gelten. Was sind die **Hintergründe** dieser Konvention – und hat tatsächlich ein **Wandel** stattgefunden?

> [!summary] Kernaussage in einem Satz
> Es gab **keinen sauberen Umschwung**. `y nach unten` (Ursprung oben links) ist ein **Hardware-Artefakt** der CRT-Abtastung und Framebuffer-Adressierung; `y nach oben` (Ursprung unten links) ist die **mathematische bzw. Druck-Konvention**. Beide existieren bis heute **parallel** – welche gilt, hängt von der Domäne ab, nicht von der Epoche.

---

## 1. Die Wurzel „oben links": Hardware, nicht Mathematik

Der `y-down`-Ursprung stammt direkt aus der **Abtastlogik der Kathodenstrahlröhre (CRT)**. Der Elektronenstrahl tastet das Bild zeilenweise ab (*raster scan*): Start oben links, horizontal nach rechts, dann **Zeilenrücklauf** (*horizontal retrace*) eine Zeile tiefer, und so fort bis unten rechts, gefolgt vom **Bildrücklauf** (*vertical retrace*) zurück nach oben links.

![[crt-rasterscan.svg]]

Der entscheidende Punkt: Der **Framebuffer-Speicher wurde linear in genau dieser Reihenfolge adressiert**. Adresse `0` = Pixel oben links, steigende Adressen nach rechts und dann nach unten. `y` wächst nach unten, weil die *Speicheradresse* nach unten wächst. Das war also keine mathematische Designentscheidung, sondern fiel **zwangsläufig** aus der physikalischen Abtastreihenfolge.

Diese Konvention vererbte sich an fast alle bildschirmnahen Systeme: X11, Windows GDI, HTML/CSS, Canvas 2D, SVG.

> [!info] Kuriose Ausnahme
> Das Windows-**BMP**-Format speichert seine Pixelzeilen standardmäßig *bottom-up* (positive Bildhöhe = unterste Zeile zuerst) – ein eigener historischer Sonderweg, der bis heute zu „auf dem Kopf"-Effekten beim naiven Einlesen führt.

---

## 2. Die kartesische Wurzel: Mathematik und Druck

Das kartesische System (Descartes, *La Géométrie*, 1637) misst `y` nach oben, Ursprung typischerweise unten links. Das ist die Konvention der **Mathematik, Physik und Vermessung** – überall dort, wo man „Höhe" intuitiv nach oben misst.

In der Computerwelt taucht diese Konvention aber **nicht neu** auf. In bestimmten Domänen ist sie sogar *älter* als der heutige Web-Stack.

---

## 3. Gegenüberstellung

![[raster-vs-kartesisch.svg]]

| Merkmal             | Raster / Bildschirm        | Kartesisch                |
| ------------------- | -------------------------- | ------------------------- |
| Ursprung            | oben links                 | unten links               |
| `y`-Richtung        | nach **unten**             | nach **oben**             |
| Herkunft            | CRT-Abtastung, Framebuffer | Mathematik, Druck         |
| Pixel `(0,0)`       | erstes abgetastetes Pixel  | (kein direkter Bezug)     |

---

## 4. Wo welches System lebt – und warum es kein „Wandel" ist

Hier liegt der eigentliche Punkt, an dem die Ausgangsfrage zu relativieren ist: Es gab **keinen historischen Umschwung** im Sinne von „früher oben links, heute kartesisch". Beide Konventionen existieren **parallel**, domänenspezifisch – und teils ist `y-up` sogar das *ältere* System der jeweiligen Domäne:

- **PostScript (Mitte der 1980er) und damit PDF** nutzen den Ursprung *bewusst* unten links, `y` nach oben. Grund: Herkunft aus Typografie und Druck – man bemaßt eine Seite vom unteren Blattrand nach oben (in *points*). Jedes PDF arbeitet bis heute kartesisch.
- **OpenGL (SGI, ab 1992)** legt Framebuffer und Texturen auf den Ursprung *unten links*. Es wurde als 3D-API in mathematischer Konvention (rechtshändiges KS, `y-up`) entworfen; die 2D-Sicht ist nur ein Spezialfall davon. `glViewport`, `gl_FragCoord` und die Texturkoordinate `(0,0)` liegen alle unten links.
- **Selbst innerhalb der GUI-Welt gespalten:** macOS' **AppKit/Quartz** nutzt den Ursprung unten links, `y-up` (Erbe von NeXTSTEP / Display PostScript). Apples eigenes **iOS-UIKit** kippte später wieder auf oben links, `y-down`. Zwei Frameworks desselben Herstellers, zwei Konventionen.
- **Bildschirm-/Fenster-/Web-Bereich** ist dagegen bis heute überwiegend `y-down`: X11, Windows GDI, HTML/CSS, Canvas 2D, SVG. Das hat sich gerade *nicht* gewandelt.

> [!note] Was sich real verschoben hat
> Wenn man von einem Trend sprechen will, dann von diesem: Mit **GPU-basiertem Rendering**, Shader-Programmierung und der Behandlung von 2D als Spezialfall von 3D (alles ist letztlich ein texturiertes Quad) ist `y-up` in modernen Toolchains – Engines, Plotting-Bibliotheken wie *matplotlib*, wissenschaftliche Visualisierung – präsenter geworden. Das ist eine **Verschiebung der Gewichte zwischen Domänen**, kein Ablösen einer Konvention durch eine andere.

---

## 5. Die praktische Reibung: Textur-Flip

Genau dieses Nebeneinander ist eine der klassischen Bug-Quellen und eignet sich gut als didaktisches Beispiel:

![[opengl-textur-flip.svg]]

Das „Textur steht auf dem Kopf"-Problem in OpenGL entsteht, weil **Bilddateien** (PNG, JPEG) zeilenweise von oben gespeichert werden (`y-down`-Erbe der Hardware), **OpenGL-Texturen** aber unten links beginnen. Man muss die `v`-Koordinate spiegeln (`v → 1 − v`) oder das Bild beim Laden vertikal flippen.

Beim Portieren zwischen **OpenGL und Direct3D** kommt hinzu, dass D3D historisch den Ursprung oben links für Texturen verwendet und den Clip-Space anders orientiert – ein Dauerthema bei Cross-API-Code.

---

> [!tip] Merksatz für den Unterricht
> Der `y-down`-Ursprung ist ein **Hardware-Artefakt** (Adressreihenfolge im Framebuffer), der `y-up`-Ursprung eine **mathematische bzw. Druck-Konvention**. Welcher gilt, hängt nicht von der Epoche ab, sondern davon, ob man gerade *„am Bildschirmspeicher"* oder *„in der Mathematik / auf dem Papier"* denkt.

## Verwandte Notizen

- [[Framebuffer und Speicherlayout]]
- [[OpenGL Texturkoordinaten]]
- [[SVG Koordinatensystem]]
- [[Rechtshändige vs. linkshändige Koordinatensysteme]]

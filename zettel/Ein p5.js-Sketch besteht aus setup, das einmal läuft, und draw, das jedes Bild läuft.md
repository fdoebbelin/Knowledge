---
id: 202611270943
title: Ein p5.js-Sketch besteht aus setup, das einmal läuft, und draw, das jedes Bild läuft
type: zettel
tags:
  - javascript/p5
created: 2026-11-27
herkunft: 01-Courses/Programming/JavaScript-STEM
---

Ein statisches Bild ist eine Folge von Zeichenbefehlen. Ein Programm, das sich bewegt oder auf die Maus reagiert, braucht dagegen einen zeitlichen Ablauf. p5.js teilt ihn – wie Processing – auf zwei Funktionen auf, die die Bibliothek selbst aufruft:

```javascript
function setup() {        // einmal, beim Start
  createCanvas(400, 300);
}

function draw() {         // immer wieder, standardmäßig 60-mal je Sekunde
  background(220);
  ellipse(mouseX, mouseY, 40, 40);
}
```

In `setup` gehören die Anfangsbedingungen: Größe der Zeichenfläche, Startwerte, in einem Spiel etwa Punktestand null und Level eins. `draw` ist die Schleife, die bis zum Programmende läuft: Eingaben auswerten, Zustand fortschreiben, Bild neu zeichnen.

Ein typischer Anfängerfehler zeigt den Unterschied: Steht `background` in `setup` statt in `draw`, wird die Fläche nicht mehr gelöscht und der Kreis hinterlässt eine Spur. Variablen, die von Bild zu Bild erhalten bleiben sollen, müssen außerhalb beider Funktionen deklariert werden.

## Verbindungen

- [[p5.js ist Processing für den Browser]] – woher das Modell stammt
- [[Inkrementelle Entwicklung baut ein Programm in Schritten, die jeder für sich laufen]] – vom statischen Bild zur Animation ist genau so ein Schritt
- [[Grundlagen der Informatik]] – Strukturzettel, Abschnitt Grafik programmieren

## Quellen

- [[Learning p5.js – Notizen zu Learning Processing]]

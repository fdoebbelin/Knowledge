---
id: 202611271057
title: Pygame läuft nicht direkt im Browser, weil es über SDL die Hardware anspricht
type: zettel
tags:
  - python/web
created: 2026-11-27
herkunft: 01-Courses/Training/Military
---

Pygame ist eine dünne Python-Schicht über der C-Bibliothek **SDL** (Simple DirectMedia Layer). SDL greift über das Betriebssystem auf Grafik, Ton, Tastatur und Gamepad zu und macht diesen Zugriff plattformübergreifend gleich. Genau diesen direkten Zugriff verweigert der Browser aus Sicherheitsgründen: Webinhalte laufen in einer Sandbox und sehen nur die Schnittstellen, die der Browser anbietet – Canvas, WebGL, Web Audio, Tastatur- und Mausereignisse.

**Pygbag** löst das, indem es Python, Pygame und SDL gemeinsam nach WebAssembly übersetzt, wobei SDL auf die Browser-Schnittstellen umgeleitet wird. Das Spiel selbst bleibt Python-Code. Zwei Anpassungen sind trotzdem nötig:

- Die Spielschleife muss die Kontrolle in jedem Bild kurz an den Browser zurückgeben. Dazu wird sie `async` und ruft `await asyncio.sleep(0)` auf – sonst friert die Seite ein.
- Die Einstiegsdatei heißt `main.py`; Pygbag packt den Ordner und startet einen Testserver.

Ton, Vollbild und Netzwerkzugriffe verhalten sich im Browser anders als am Desktop und brauchen oft eigene Lösungen.

## Verbindungen

- [[Python-Spiele kommen auf drei Wegen in den Browser]] – Pygbag ist ein Beispiel für den WebAssembly-Weg
- [[Ein p5.js-Sketch besteht aus setup, das einmal läuft, und draw, das jedes Bild läuft]] – im Browser übernimmt die Bibliothek die Spielschleife und ruft den eigenen Code je Bild auf
- [[Web und Browser]] – Strukturzettel zu diesem Thema

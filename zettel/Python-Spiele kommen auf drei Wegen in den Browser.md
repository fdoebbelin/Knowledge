---
id: 202611271056
title: Python-Spiele kommen auf drei Wegen in den Browser
type: zettel
tags:
  - python/web
created: 2026-11-27
herkunft: 01-Courses/Training/Military
---

Ein Browser führt von sich aus nur JavaScript und WebAssembly aus. Wer ein Python-Programm – etwa ein kleines Spiel – im Browser oder in einem Webview-Fenster zeigen will, hat drei Möglichkeiten:

- **Den Python-Interpreter als WebAssembly mitliefern.** CPython wird nach WebAssembly übersetzt und lädt mit der Seite; der eigene Python-Code läuft darin unverändert. Beispiele sind Pyodide und – speziell für Pygame – Pygbag. Nachteil: große Downloads und spürbar weniger Tempo als nativ.
- **Python in JavaScript nachbauen.** Skulpt ist ein in JavaScript geschriebener Python-Interpreter, wie ihn Lernplattformen für kleine Übungen nutzen. Er ist leicht, beherrscht aber nur einen Teil der Sprache und der Bibliotheken.
- **Python nativ laufen lassen und nur die Oberfläche im Webview zeigen.** pywebview öffnet ein Fenster mit der Webview-Komponente des Betriebssystems; die Logik bleibt ein normales Python-Programm, das mit der HTML-Oberfläche über eine JavaScript-Brücke spricht. Das ist dieselbe Arbeitsteilung wie bei Tauri, nur mit Python statt Rust im Hintergrund.

Welcher Weg passt, entscheidet vor allem, ob das Programm ohne Installation im Browser laufen soll (die ersten beiden) oder als Desktop-Anwendung (der dritte).

## Verbindungen

- [[Pygame läuft nicht direkt im Browser, weil es über SDL die Hardware anspricht]] – warum gerade Spiele den ersten Weg brauchen
- [[withGlobalTauri macht Tauri ohne Bundler nutzbar]] – Tauri verbindet eine Webview-Oberfläche ebenso mit einem nativen Hintergrundprozess
- [[Web und Browser]] – Strukturzettel zu diesem Thema

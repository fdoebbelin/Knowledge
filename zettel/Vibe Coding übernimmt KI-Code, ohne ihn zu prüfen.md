---
id: 202611281525
title: Vibe Coding übernimmt KI-Code, ohne ihn zu prüfen
type: zettel
tags:
  - ki
  - programmieren
created: 2026-11-28
herkunft:
  - 02-Tech/AI/00 Vibe Coding mit Gemini CLI.md
  - 01-Courses/AI
  - 01-Courses/Programming/PythonAugmentedDevelopment
---

Den Begriff **Vibe Coding** prägte Andrej Karpathy im Februar 2025. In seiner Beschreibung gibt man sich ganz dem Gefühl hin und vergisst, dass es den Code überhaupt gibt. Er fügte an, für Wegwerfprojekte am Wochenende sei das gar nicht so schlecht.

Im Sprachgebrauch heißt inzwischen oft jedes Programmieren mit KI so. Das verwischt den entscheidenden Unterschied. Simon Willison zieht die Grenze beim Prüfen: Vibe Coding ist, mit einem Sprachmodell Software zu bauen, **ohne den erzeugten Code zu begutachten**. Wer den Code gelesen und gründlich getestet hat und ihn jemand anderem erklären kann, betreibt gewöhnliche Softwareentwicklung, auch wenn ein Modell jede Zeile geschrieben hat. Seine Regel für sich selbst: Er committet nichts, was er nicht genau erklären könnte.

Es kommt also nicht darauf an, wer tippt, sondern wer den Code verantworten kann. Vor einer Aufgabe lohnt sich die Frage, was ein unentdeckter Fehler anrichten würde. Für einen Versuch, den man danach verwirft, wiegt er wenig. Für Software, die mit echten Daten, Geld oder Zugängen arbeitet, reicht „es läuft“ nicht.

## Verbindungen

- [[Mit Coding-Agenten verschiebt sich Entwicklerarbeit vom Schreiben zum Vorgeben und Prüfen]] – was die geprüfte Form vom Menschen verlangt
- [[Wer KI-Code prüfen soll, braucht ein eigenes Programmverständnis]] – die Voraussetzung dafür, Code erklären zu können
- [[Ein Agent meldet Erfolg erst nach geprüftem Ergebnis]] – dieselbe Forderung an den Agenten selbst
- [[Aider macht jede Änderung zu einem Git-Commit]] – Änderungen eines Agenten bleiben nachvollziehbar
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- Simon Willison: [Not all AI-assisted programming is vibe coding](https://simonwillison.net/2025/Mar/19/vibe-coding/) (19. März 2025), dort auch Karpathys Wortlaut

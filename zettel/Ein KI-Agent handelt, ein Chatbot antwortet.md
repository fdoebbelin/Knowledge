---
id: 202611271301
title: Ein KI-Agent handelt, ein Chatbot antwortet
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 01-Courses/AI
---

Ein **Chatbot** arbeitet nach dem Muster Frage → Antwort. Er gibt Wissen weiter, führt aber nichts aus. Auf „Welcher Prozess belegt Port 8080?“ nennt er `ss -tlnp | grep 8080` – tippen muss der Mensch selbst.

Ein **KI-Agent** bekommt statt einer Frage ein Ziel: „Port 8080 auf dem Server ist belegt, finde heraus warum.“ Er unterscheidet sich vom Chatbot in drei Punkten:

- **Werkzeuge:** Er darf Befehle ausführen, Dateien lesen, APIs aufrufen.
- **Eigene Schrittfolge:** Er legt selbst fest, was als Nächstes zu tun ist – Prozess finden, Logs lesen, Ursache eingrenzen –, ohne für jeden Schritt eine neue Anweisung zu brauchen.
- **Ergebnisprüfung:** Er wertet aus, was ein Schritt ergeben hat, und ändert den Plan, wenn etwas fehlschlägt.

Aus dem Unterschied folgt das Risiko: Ein Chatbot kann sich irren, ein Agent kann auf Grund seines Irrtums *handeln*. Deshalb braucht ein Agent Grenzen, die ein Chatbot nicht braucht.

## Verbindungen

- [[Der ReAct-Zyklus wechselt zwischen Denken, Handeln und Beobachten]] – wie die eigene Schrittfolge im Inneren abläuft
- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – die wichtigste Grenze für das Handeln
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

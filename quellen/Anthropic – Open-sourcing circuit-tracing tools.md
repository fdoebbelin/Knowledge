---
id: 202611281522
title: Anthropic – Open-sourcing circuit-tracing tools
type: quelle
tags:
  - ki
created: 2026-11-28
herkunft: 02-Tech/AI/LLM-Basics/Open-sourcing circuit-tracing tools.md
autor: Anthropic
url: https://www.anthropic.com/research/open-source-circuit-tracing
art: artikel
status: entwurf
---

## Worum es geht

Eine Ankündigung vom 29. Mai 2025: Anthropic veröffentlicht Werkzeuge, mit denen sich untersuchen lässt, wie ein Sprachmodell zu einer bestimmten Ausgabe kommt. Geleitet haben das Projekt Teilnehmer des Programms *Anthropic Fellows* zusammen mit Decode Research.

## Kernaussagen

- Das Verfahren erzeugt **Attributionsgraphen**. Sie zeigen laut Artikel teilweise, welche internen Schritte zu einer Ausgabe geführt haben.
- Veröffentlicht wurden die quelloffene Bibliothek [circuit-tracer](https://github.com/safety-research/circuit-tracer) und eine Oberfläche bei Neuronpedia, in der man die Graphen ansehen kann.
- Man kann Graphen für unterstützte Modelle mit offenen Gewichten erzeugen, sie beschriften und teilen. Hypothesen lassen sich prüfen, indem man Werte interner Merkmale verändert und die Ausgabe beobachtet.
- Als Beispiele nennt der Artikel Gemma-2-2b und Llama-3.2-1b.
- Einen eigenen Abschnitt über die Grenzen des Verfahrens hat der Artikel nicht; es bleibt bei der Einschränkung „teilweise“.

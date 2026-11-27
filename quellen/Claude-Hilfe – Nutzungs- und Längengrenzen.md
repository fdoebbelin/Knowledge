---
id: 202611271318
title: Claude-Hilfe – Nutzungs- und Längengrenzen
type: quelle
tags:
  - ki/werkzeuge
created: 2026-11-27
herkunft: 02-Tech/AI/Claude-Code/Nutzungs- und Längenbeschränkungen verstehen.md
autor: Anthropic
url: https://support.claude.com/en/articles/11647753-understanding-usage-and-length-limits
art: doku
---

## Worum es geht

Ein Hilfeartikel von Anthropic, der zwei Arten von Grenzen bei Claude auseinanderhält: wie viel man in einem Zeitraum nutzen darf und wie lang ein einzelnes Gespräch werden kann. Gesichert im Februar 2026; Zahlen und Tarife ändern sich laufend.

## Kernaussagen

- Nutzungsgrenzen sind ein Budget über die Zeit. Sie hängen vom Tarif ab, und alle Oberflächen – Web, Desktop, Claude Code – zehren vom selben Budget.
- Längengrenzen ergeben sich aus dem Kontextfenster, dem Arbeitsgedächtnis des Modells für ein Gespräch. Zum Zeitpunkt der Sicherung waren es meist 200.000 Token.
- Nähert sich ein Gespräch der Grenze, fasst Claude ältere Teile automatisch zusammen.
- Werkzeuge, Konnektoren und lange Projektanweisungen belegen Kontext und kosten Nutzung; wer sie abschaltet, wenn sie nicht gebraucht werden, kommt mit beidem weiter.
- Projekte laden über RAG nur die passenden Teile der Projektdateien in den Kontext.

## Daraus entstandene Zettel

- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]]

---
id: 202611281507
title: Ein dauerhaftes Gedächtnis macht aus einer Prompt Injection ein bleibendes Problem
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Ohne Gedächtnis wirkt eine eingeschleuste Anweisung höchstens in der laufenden Sitzung. Schreibt der Agent dagegen Gelesenes in ein dauerhaftes Gedächtnis, kann die Anweisung dort bleiben. Wird der Eintrag später wieder geladen, steht er erneut im Kontext, womöglich lange nachdem die E-Mail oder Webseite vergessen ist, aus der er stammt. Eine neue Sitzung beseitigt das Problem dann nicht.

Daraus folgt:

- Was aus nicht vertrauenswürdigen Quellen stammt, wird nicht ungeprüft dauerhaft gemerkt. Die Dokumentation von OpenClaw verlangt, damit zu warten, bis eine vertrauenswürdige Stelle es bestätigt hat.
- Ein Gedächtnis in lesbaren Dateien lässt sich durchsehen und bereinigen. Nach einem Verdacht gehört das dazu.
- Eine Erinnerung wie „das wurde genehmigt“ ist keine Zugriffskontrolle. Das Gedächtnis kann Zusammenhänge festhalten, setzt aber keine Regeln durch.

## Geheimnisse bleiben liegen

Gespeichert wird auch, was nie dorthin sollte. Bei OpenClaw ist laut Dokumentation davon auszugehen, dass alles unter `~/.openclaw/` Geheimnisse oder private Daten enthalten kann. Sitzungsprotokolle, Werkzeugergebnisse und gelesene `.env`-Dateien behalten ihren ursprünglichen Text samt Zugangsdaten. Der Ordner und seine Sicherungen sind deshalb so zu schützen wie ein Passwortspeicher.

## Verbindungen

- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – der Angriff, den das Gedächtnis verlängert
- [[Ein Agentengedächtnis aus Markdown-Dateien wird durch einen Suchindex nutzbar]] – wie Einträge wieder in den Kontext kommen
- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – eine Freigabe, die nicht aus dem Gedächtnis kommen darf
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- OpenClaw-Dokumentation: [Memory](https://docs.openclaw.ai/concepts/memory)
- OpenClaw-Dokumentation: [Secrets and storage](https://docs.openclaw.ai/gateway/security/secrets-and-storage)

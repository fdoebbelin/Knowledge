---
id: 202611281504
title: Ein per Messenger erreichbarer Agent braucht eine Liste erlaubter Absender
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Nimmt ein KI-Agent Aufträge über WhatsApp, Telegram oder ähnliche Dienste an, ist der Chat seine Befehlszeile. Wer ihm schreiben darf, kann ihn mit allem beauftragen, was seine Werkzeuge hergeben. Deshalb muss vorab feststehen, wessen Nachrichten er verarbeitet.

OpenClaw regelt das für Direktnachrichten mit der Einstellung `dmPolicy` (Stand November 2026):

| Wert | Wirkung |
|---|---|
| `pairing` (Vorgabe) | Unbekannte bekommen einen Kopplungscode und werden ignoriert, bis man sie freigibt |
| `allowlist` | Unbekannte werden abgewiesen, ohne Kopplungsangebot |
| `open` | jeder darf schreiben; dafür muss die Liste ausdrücklich `*` enthalten |
| `disabled` | eingehende Direktnachrichten werden ignoriert |

**Gruppen** brauchen eine eigene Entscheidung. Dort zählt, wer Mitglied ist, denn jedes zugelassene Mitglied kann den Agenten ansprechen. Eingrenzen lässt sich das mit einer Liste erlaubter Gruppen oder Absender und damit, dass der Agent nur auf ausdrückliche Erwähnung reagiert.

Bei mehreren Nutzern kommt die Trennung der Gespräche dazu: In der Vorgabe teilen sich alle Direktnachrichten eine Sitzung des Agenten. Für diesen Fall empfiehlt die Dokumentation eine eigene Sitzung je Kanal und Gegenüber (`session.dmScope: "per-channel-peer"`).

Die Absenderliste schützt nicht vor Anweisungen, die in Inhalten stecken, etwa in einer weitergeleiteten E-Mail oder einer Webseite.

## Verbindungen

- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – der Weg, den eine Absenderliste offen lässt
- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – begrenzt, was auch ein zugelassener Absender auslösen kann
- [[Ein offenes Kontrollpanel eines Agenten gibt seine Zugangsdaten preis]] – der zweite Zugang neben dem Messenger
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[IT-Administrator – OpenClaw-Agenten übernehmen das Ruder]]
- OpenClaw-Dokumentation: [Access control](https://docs.openclaw.ai/gateway/security/access-control)

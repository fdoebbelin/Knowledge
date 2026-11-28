---
id: 202611281509
title: Ein dauerhaft laufender Agent braucht eine Kostengrenze
type: zettel
tags:
  - ki/agenten
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Ein Chatbot verursacht Kosten, wenn jemand ihn fragt. Ein Agent, der im Hintergrund läuft, kann auch arbeiten, wenn niemand hinsieht: nach Zeitplan, als Reaktion auf Ereignisse oder weil er an einer Aufgabe in einer Schleife hängt. Bei einem Modell, das nach Verbrauch abgerechnet wird, fällt das unter Umständen erst mit der Rechnung auf.

Ein regelmäßiger Prüflauf alle 30 Minuten sind 48 Läufe am Tag, wenn er rund um die Uhr aktiv ist. Was ein Lauf kostet, hängt vom Modell und von der Menge des geladenen Kontexts ab.

Sinnvolle Grenzen:

- den Verbrauch beim Anbieter regelmäßig ansehen und, wo möglich, ein Limit setzen
- für Aufträge festlegen, wann der Agent aufhört
- Zeitpläne nur einschalten, wenn man sie braucht

OpenClaw bildet solche Prüfläufe, früher „Heartbeat“, als gewöhnliche Automatisierungsaufträge ab (Stand November 2026). Bei einer neuen Einrichtung ist der angelegte Prüfauftrag abgeschaltet. Eingeschaltet läuft er alle 30 Minuten, sofern der Anbieter nichts anderes vorgibt. Um den Aufwand zu begrenzen, nennt die Dokumentation neben dem Abschalten unter anderem die Einstellung `activeHours` für die aktiven Zeiten. Einen Betrag je Lauf nennt die geprüfte Seite nicht.

## Verbindungen

- [[Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung]] – die Stoppbedingung gegen endlose Schleifen
- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]] – die Grenzen bei Abonnements
- [[Der ReAct-Zyklus wechselt zwischen Denken, Handeln und Beobachten]] – die Schleife, die ohne Abbruch weiterläuft
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[IT-Administrator – OpenClaw-Agenten übernehmen das Ruder]]
- OpenClaw-Dokumentation: [Heartbeat migration](https://docs.openclaw.ai/gateway/heartbeat)

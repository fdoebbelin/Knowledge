---
id: 202611281506
title: Ein offenes Kontrollpanel eines Agenten gibt seine Zugangsdaten preis
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
---

Ein dauerhaft laufender Agent hat oft eine Verwaltungsoberfläche im Browser. Dahinter liegt, was er zum Arbeiten braucht: Schlüssel für Modelle und Dienste, Gesprächsverläufe, seine Einstellungen und womöglich der Weg zu seinen Werkzeugen. Ist die Oberfläche ungeschützt erreichbar, muss ein Angreifer den Agenten nicht überlisten, er bedient ihn einfach. Anfang 2026 wurde über Hunderte falsch eingerichtete OpenClaw-Installationen berichtet, die so im Internet standen.

Bei OpenClaw bedient das **Gateway** auch diese Oberfläche. Laut Dokumentation (Stand November 2026):

- Auf einem gewöhnlichen Rechner ist es in der Vorgabe nur lokal erreichbar (`gateway.bind: "loopback"`).
- **Vorsicht bei Containern:** Erkennt es einen Container, führt die Einstellung `auto` zu `0.0.0.0`, also zu allen Netzwerkschnittstellen.
- Eine Anmeldung ist in der Vorgabe Pflicht, empfohlen wird ein Token.
- Wer das gemeinsame Geheimnis für den HTTP-Zugang hat, bekommt vollen Betreiberzugriff. Abgestufte Rechte schützen hier nicht.

Daraus folgt:

- nie ohne Anmeldung an `0.0.0.0` binden
- für den Fernzugriff einen geschützten Weg wählen; die Dokumentation zieht Tailscale Serve einer Freigabe ins lokale Netz vor
- bei einer Freigabe ins lokale Netz per Firewall nur bestimmte Absenderadressen zulassen
- verschlüsselt übertragen, sonst sind Seite und Geheimnis mitlesbar

## Verbindungen

- [[Ein per Messenger erreichbarer Agent braucht eine Liste erlaubter Absender]] – derselbe Gedanke für den Zugang über den Chat
- [[Ein gepushtes Geheimnis muss man austauschen]] – auch offengelegte Schlüssel eines Agenten werden ersetzt
- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – begrenzt, was ein Eindringling erreicht
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

## Quellen

- [[Golem – OpenClaw nach Namensänderungen unter Beschuss]]
- [[IT-Administrator – OpenClaw-Agenten übernehmen das Ruder]]
- OpenClaw-Dokumentation: [Network exposure](https://docs.openclaw.ai/gateway/security/network-exposure)

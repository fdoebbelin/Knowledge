---
id: 202611281503
title: IT-Administrator – OpenClaw-Agenten übernehmen das Ruder
type: quelle
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-28
herkunft: 02-Tech/AI/OpenClaw
autor: Daniel Richey
url: https://www.it-administrator.de/openclaw-ki-agenten-moltbook
art: artikel
---

## Worum es geht

Ein Überblick vom 2. Februar 2026 über Aufbau und Inbetriebnahme von OpenClaw: ein dauerhaft laufendes Gateway, das Nachrichten aus Chatdiensten an Agenten weiterreicht, die mit Sprachmodellen und Skills arbeiten.

## Kernaussagen

- Zugriffskontrolle und Ausführung liegen beim Gateway und den Agenten; die Chat-Anwendung ist nur die Oberfläche.
- Früh entscheidend ist, die Kanäle sauber zu koppeln und Zugriffe ausdrücklich freizugeben. Für Direktnachrichten gibt es ein Kopplungs- und Freigabemodell.
- Bei Gruppenchats und Testräumen ist Vorsicht nötig. Ein System, auf dem der Agent weitreichenden Zugriff hat, ist idealerweise ein eigenes Testsystem.
- Das lokale Kontrollpanel soll nicht frei aus dem Internet erreichbar sein.
- Skills sollte man sparsam aktivieren und ihre Voraussetzungen prüfen. Skills von Dritten zu installieren, ist ein Vertrauenssprung, besonders wenn Wallets, API-Schlüssel oder Signaturen im Spiel sind.
- Den Verbrauch beim angebundenen KI-Dienst muss man im Auge behalten, sonst drohen hohe Rechnungen.

## Daraus entstandene Zettel

- [[Ein per Messenger erreichbarer Agent braucht eine Liste erlaubter Absender]]
- [[Ein fremder Skill ist ungeprüfter Code mit den Rechten des Agenten]]
- [[Ein offenes Kontrollpanel eines Agenten gibt seine Zugangsdaten preis]]
- [[Ein dauerhaft laufender Agent braucht eine Kostengrenze]]

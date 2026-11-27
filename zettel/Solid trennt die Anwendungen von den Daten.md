---
id: 202611271100
title: Solid trennt die Anwendungen von den Daten
type: zettel
tags:
  - web/solid
created: 2026-11-27
herkunft: 01-Courses/Training/BFD-Programs
---

Im heutigen Web speichert jede Anwendung ihre Daten selbst: Fotos liegen beim Fotodienst, Kontakte beim Netzwerk, Notizen bei der Notiz-App. Wer den Anbieter wechselt, verliert seine Daten oder muss sie mühsam exportieren (Vendor Lock-in). **Solid**, ein Projekt von Tim Berners-Lee, dreht das um:

- **Pod.** Jede Person hat einen eigenen Datenspeicher im Web, den Pod – selbst betrieben oder bei einem Anbieter ihrer Wahl.
- **WebID.** Eine URL, die die Person identifiziert. Mit ihr meldet man sich bei jeder Solid-Anwendung an, statt überall ein eigenes Konto anzulegen.
- **Zugriffsregeln.** Die Person legt im Pod fest, welche Person oder Anwendung welchen Ordner lesen oder schreiben darf, und kann das jederzeit widerrufen.

Eine Anwendung ist damit nur noch eine Sicht auf die Daten. Schreibt eine Notiz-App eine Notiz in den Pod, kann eine ganz andere App sie danach anzeigen – vorausgesetzt, beide verstehen dasselbe Datenformat. Genau das ist die Schwachstelle in der Praxis: Es gibt wenige Anwendungen, und ohne Anwendungen gibt es wenig Grund für einen Pod.

## Verbindungen

- [[Linked Data macht Daten über gemeinsame Vokabulare maschinenlesbar]] – das gemeinsame Datenformat, das verschiedene Apps zusammenarbeiten lässt
- [[Web 3.0 und Web3 meinen zwei verschiedene Ideen]] – Solid gehört zur semantischen, nicht zur Krypto-Lesart
- [[Web und Browser]] – Strukturzettel zu diesem Thema

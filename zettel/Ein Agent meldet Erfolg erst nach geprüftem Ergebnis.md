---
id: 202611271306
title: Ein Agent meldet Erfolg erst nach geprüftem Ergebnis
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-27
herkunft: 01-Courses/AI
---

Sprachmodelle erzeugen auch Falsches mit großer Überzeugung – sie **halluzinieren**. Bei einem Chatbot ist das ärgerlich, bei einem Agenten wird es gefährlich, weil er auf Grund der falschen Annahme weiterhandelt. Typische Fälle:

- **Erfundene Befehle:** `systemctl reload-config nginx` gibt es nicht, richtig wäre `systemctl reload nginx`.
- **Falsche Diagnose:** Der Agent tippt auf das Netz, die Ursache ist Speichermangel.
- **Erfundene Fakten:** eine CVE-Nummer oder Versionsangabe, die es nicht gibt.

Am gefährlichsten ist ein Agent, der nach einem fehlgeschlagenen Schritt trotzdem „erledigt“ meldet. Das Gegenmittel ist Prüfen statt Annehmen:

- jede Aktion wirklich ausführen und den **Exit-Code** und die Ausgabe auswerten
- Erfolg nur melden, wenn das Ergebnis dem erwarteten entspricht
- Unsicherheit aussprechen und „weiß ich nicht“ sagen, statt eine Lücke zu füllen
- bei Diagnosen mehrere Ursachen nennen und begründen, warum eine wahrscheinlicher ist
- Fakten an Quellen festmachen: Manpage, Dokumentation, CVE-Datenbank

Diese Regeln lassen sich dem Agenten in den Prompt schreiben. Verlassen sollte man sich darauf nicht: Wer das Ergebnis eines Agenten nicht selbst beurteilen kann, merkt den Fehler erst, wenn er Folgen hat.

## Verbindungen

- [[Der ReAct-Zyklus wechselt zwischen Denken, Handeln und Beobachten]] – die Beobachtung ist der Schritt, in dem geprüft wird
- [[Ein Bug ist ein technischer Fehler und ein falsches Bild im Kopf zugleich]] – auch ein Agent kann ein falsches Bild vom System haben
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

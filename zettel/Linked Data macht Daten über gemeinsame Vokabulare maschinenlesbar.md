---
id: 202611271101
title: Linked Data macht Daten über gemeinsame Vokabulare maschinenlesbar
type: zettel
tags:
  - web/solid
created: 2026-11-27
herkunft: 01-Courses/Training/BFD-Programs
---

Ein Eintrag `Name: Max` ist für Menschen klar, für Programme nicht: Ist „Name“ der Vorname, der Anzeigename, der Name einer Firma? Zwei Anwendungen, die das Feld unterschiedlich deuten, können keine Daten austauschen.

**Linked Data** löst das mit zwei Ideen:

- **Begriffe sind URLs.** Statt „Name“ steht dort eine weltweit eindeutige Adresse aus einem veröffentlichten **Vokabular**, etwa `http://xmlns.com/foaf/0.1/name` aus dem FOAF-Vokabular, kurz `foaf:name`. Wer dasselbe Vokabular nutzt, meint dasselbe.
- **Aussagen sind Tripel.** Jede Information wird als Subjekt – Prädikat – Objekt festgehalten: *(Person X) – foaf:name – „Max“*, *(Person X) – foaf:knows – (Person Y)*. Weil auch Subjekte und Objekte URLs sein können, verweisen Daten auf andere Daten im Web und bilden ein Netz.

Das Datenmodell dahinter heißt RDF. Gängige Vokabulare sind FOAF für Personen und Beziehungen und schema.org, mit dem auch Suchmaschinen Webseiten auswerten.

## Verbindungen

- [[Solid trennt die Anwendungen von den Daten]] – Solid-Pods speichern Daten als Linked Data, damit verschiedene Apps sie lesen können
- [[Web 3.0 und Web3 meinen zwei verschiedene Ideen]] – Linked Data ist der Kern des semantischen Webs
- [[Web und Browser]] – Strukturzettel zu diesem Thema

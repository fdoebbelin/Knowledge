---
id: 202611281419
title: Ein Ziffernpräfix sortiert Namen vor die Buchstaben
type: zettel
tags:
  - dateiablage
created: 2026-11-28
---

Soll ein Ordner verlässlich vor den übrigen, mit Buchstaben benannten Ordnern stehen, beginnt man seinen Namen mit einer **Ziffer**. Sonderzeichen wie `_` oder `!` sind unzuverlässig, weil Programme verschieden sortieren. Ein Test mit denselben Namen im November 2026:

| Sortierung | Reihenfolge |
| --- | --- |
| nach Bytewerten (Locale `C`) | `!Neu`, `00-Poststelle`, `Ablage`, `Knowledge`, `_Ablage` |
| `en_US.UTF-8` (`sort`, glibc 2.43) | `00-Poststelle`, `_Ablage`, `Ablage`, `Knowledge`, `!Neu` |
| Windows 11, Vergleich wie im Explorer (`StrCmpLogicalW`) | `!Neu`, `_Ablage`, `00-Poststelle`, `Ablage`, `Knowledge` |

`_Ablage` landet je nach Verfahren ganz hinten, bei `Ablage` oder vor den Ziffern. Nur der Name mit Ziffer steht in allen drei Fällen vor allen Buchstaben – aber nicht unbedingt ganz oben: Unter Windows kommen `!` und `_` noch davor.

Zwei Stellen (`00-`, `01-`) lassen Platz für eine feste Reihenfolge. Die führende Null ist nötig, weil eine reine Zeichensortierung `10-` vor `2-` stellt; der Explorer vergleicht Zahlen dagegen nach ihrem Wert.

Aus demselben Grund sortieren Datumsangaben in der Form `JJJJ-MM-TT` am Namensanfang chronologisch: Alle Teile sind gleich lang, und der größte steht vorn.

Für Namen von GitHub-Repositorys fällt `!` ohnehin weg: Erlaubt sind nur ASCII-Buchstaben, Ziffern, `.`, `-` und `_`. Ein führender Punkt versteckt einen Ordner unter Linux.

## Verbindungen

- [[Ein Austausch-Repository stellt Dateien zu, ohne sie zu bearbeiten]] – Anwendung bei Repository- und Sendungsnamen
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]

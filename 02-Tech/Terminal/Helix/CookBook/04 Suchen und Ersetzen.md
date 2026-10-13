---
title: "Helix-Cookbook – Kapitel 4: Suchen und Ersetzen"
aliases:
  - Helix Cookbook Suchen und Ersetzen
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[Helix-Cookbook]]. Helix kennt kein `:%s///` – stattdessen wird gesucht, ausgewählt und geändert. Siehe auch [[Migrating from Vim]] für die Vim-Gegenüberstellung.

## Suchen

| Befehl | Wirkung |
|---|---|
| `/` / `?` | vorwärts / rückwärts suchen (regulärer Ausdruck) |
| `n` / `N` | nächster / voriger Treffer |
| `*` | aktuelle Auswahl als Suchmuster übernehmen |
| `Space /` | globale Suche im ganzen Projekt (mit Picker) |

## Rezept: Alles ersetzen

> [!example] `% s regex ⏎ c neu Esc`
> 1. `%` – ganze Datei auswählen
> 2. `s` `regex` `⏎` – jeder Treffer wird eine eigene Auswahl (Mehrfach-Cursor, siehe [[05 Mehrfachauswahl]])
> 3. `c` `neu` `Esc` – alle Treffer gleichzeitig überschreiben
>
> Ohne `%` wirkt das nur innerhalb der aktuellen Auswahl, etwa in einer mit `mi{` gewählten Funktion (siehe [[02 Auswahl-Grundlagen]]).

## Rezept: Wort unter dem Cursor suchen

> [!example] `miw * n`
> `miw` wählt das Wort, `*` übernimmt es als Suchmuster, `n` springt zum nächsten Vorkommen.
> Mit Language Server geht auch `Alt-o` `*` `n` (`Alt-o` wählt den ganzen Bezeichner statt nur die Buchstabenfolge, siehe [[02 Auswahl-Grundlagen]]).

## Rezept: Nur in der aktuellen Auswahl ersetzen

> [!example] `s foo ⏎ c bar Esc ,`
> `s` öffnet eine Eingabe für einen regulären Ausdruck und wählt alle Treffer **innerhalb** der aktuellen Auswahl aus (ein Cursor pro Treffer). `c` `bar` `Esc` ändert alle gleichzeitig, `,` kehrt danach zu einem Cursor zurück.

## Verwandt

- [[Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[05 Mehrfachauswahl]] – `s` ist zugleich der zentrale Mehrfachauswahl-Befehl
- [[09 Code und LSP]] – projektweite Suche nach Symbolen statt nach Text
- [[Migrating from Vim]] – `:%s/a/b/g` auf Helix übertragen

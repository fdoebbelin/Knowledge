---
title: "Helix-Cookbook – Kapitel 11: Markdown-Rezepte"
aliases:
  - Helix Cookbook Markdown-Rezepte
tags:
  - helix
  - editor
  - cookbook
  - markdown
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]].

Markdown bringt in Helix eine eigene Tree-sitter-Grammatik mit (Syntax-Highlighting, Textobjekte wie `mi"`/`mi(` funktionieren wie überall). Was hier speziell ist: die Kommentarmarkierung und die verfügbaren Language Server. `hx --health markdown` zeigt, was auf dem System aktiv ist.

> [!info] Language Server für Markdown
> Helix kennt drei mögliche Server für Markdown: `marksman`, `markdown-oxide`, `rumdl` (der erste installierte wird benutzt). Sie liefern vor allem Diagnosen für kaputte Links/Referenzen sowie eine Gliederung über den Symbol-Picker. Ohne installierten Server funktionieren Tree-sitter-Features (Highlighting, Textobjekte) trotzdem – nur die ●-Befehle aus [[09 Code und LSP]] entfallen dann.

## Gliederung über den Symbol-Picker

| Befehl | Wirkung |
|---|---|
| `Space s` | Überschriften der aktuellen Datei als durchsuchbare Liste (Picker) |
| `Space S` | dasselbe projektweit, über alle Markdown-Dateien |

Setzt einen der oben genannten Server voraus (siehe [[09 Code und LSP]]). Schneller als Scrollen, sobald eine Datei mehr als ein, zwei Bildschirmseiten hat.

## Überschriftenebene ändern

| Befehl | Wirkung |
|---|---|
| `gh` `d` | Cursor an den Zeilenanfang, erstes `#` löschen – eine Ebene höher |
| `gh` `i` `#` `Esc` | ein `#` vor der Überschrift einfügen – eine Ebene tiefer |

> [!example] Alle Überschriften der Datei auf einmal tiefer setzen
> `%` wählt die ganze Datei, `s` `(?m)^#+` `⏎` wählt bei **jeder** Zeile die führenden `#`-Zeichen einzeln aus (siehe Tipp unten), `i` `#` `Esc` fügt überall ein zusätzliches `#` ein – aus `##` wird `###`, aus `#` wird `##`, usw.

> [!tip] `(?m)` für `^` in jeder Zeile
> Innerhalb einer mehrzeilige Auswahl (hier durch `%`) bindet `^`/`$` in `s` sonst nur an Anfang/Ende der **gesamten** Auswahl, nicht an jede Zeile. Das Präfix `(?m)` (multiline) schaltet das um. Mehr zu `s` und Regex in [[04 Suchen und Ersetzen]].

## Checklisten abhaken

Kein eigener Befehl nötig – eine Checkbox ist nur ein Zeichen zwischen eckigen Klammern.

> [!example] `- [ ]` ↔ `- [x]`
> Cursor irgendwo in der Zeile: `f[` springt zur öffnenden Klammer, `l` einen nach rechts auf das Leerzeichen/`x`, `r` `x` hakt ab, `r` `Space` macht die Markierung rückgängig.

## Tabellen ausrichten

Helix hat keinen eingebauten Markdown-Tabellenformatierer. Die Pipe-Zeichen lassen sich aber wie jede andere Spalte mit Mehrfachauswahl ausrichten (siehe [[05 Mehrfachauswahl]]):

```text
| Name | Alter |
|---|---|
| Ada | 36 |
| Grace | 85 |
```

1. Die betroffenen Zeilen auswählen (`x` je Zeile oder `Alt-s` nach einer größeren Auswahl).
2. `s` `\|` `⏎` wählt in jeder Zeile alle `|`-Zeichen als eigene Auswahl.
3. `&` richtet sie spaltenweise aus.

Funktioniert nur, wenn jede Zeile gleich viele `|` hat – bei fehlenden Spalten vorher mit `|` auffüllen.

## Codeblock einfügen

> [!example] Fenced Code Block um eine Auswahl legen
> Cursor in der ersten Zeile des Blocks: `O` öffnet eine Zeile darüber, tippe ` ```sprache` `Esc`. Cursor ans Ende des Blocks, `o` öffnet eine Zeile darunter, tippe ` ``` ` `Esc`. (Dreifache Backticks sind kein Surround-Paar – `ms` kennt nur einzelne Zeichen, siehe [[06 Surround]] – deshalb manuell oben und unten einfügen.)

## Kommentare

| Befehl | Wirkung |
|---|---|
| `Ctrl-c` | Auswahl in `<!-- -->` einschließen bzw. auskommentieren (siehe [[03 Text umformen]]) |

Markdown kennt keinen Zeilenkommentar, nur den HTML-Block-Kommentar `<!-- -->` – `Ctrl-c` nutzt automatisch diesen.

## Fließtext umbrechen

`:reflow` bricht die Auswahl hart auf die konfigurierte Breite um (siehe [[03 Text umformen]]) – praktisch für Absätze, die beim Bearbeiten krumm geworden sind. Listen und Tabellen vorher aus der Auswahl ausschließen, sonst verrutschen sie.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[05 Mehrfachauswahl]] – Grundlage für Tabellen-Ausrichtung und Mehrfach-Ersetzungen
- [[06 Surround]] – Surround-Grenzen bei mehrzeichigen Markierungen wie Codeblöcken
- [[09 Code und LSP]] – Symbol-Picker, Diagnosen, generell was ein Language Server beisteuert
- [[03 Text umformen]] – `Ctrl-c`, `:reflow`

---
title: "Helix-Cookbook – Kapitel 9: Code und LSP"
aliases:
  - Helix Cookbook Code und LSP
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]].

Diese Befehle brauchen einen Language Server (●). Ob einer läuft, zeigt `hx --health <sprache>`.

## Springen und Nachschlagen

| Befehl | Wirkung |
|---|---|
| `gd` / `gy` | zur Definition / Typdefinition |
| `gr` / `gi` | zu den Referenzen / zur Implementierung |
| `Space k` | Dokumentation zum Symbol (Hover) |
| `Space h` | alle Referenzen des Symbols in der Datei auswählen (Mehrfach-Cursor, siehe [[05 Mehrfachauswahl]]) |

## Symbole durchsuchen

| Befehl | Wirkung |
|---|---|
| `Space s` | Symbol-Picker für die aktuelle Datei |
| `Space S` | Symbol-Picker für das ganze Projekt (Workspace) |

**Erklärung:** Öffnet einen Picker mit Funktionen, Klassen und Variablen. Namen anfangen zu tippen, `Enter` springt hin.

## Ändern über den LSP

| Befehl | Wirkung |
|---|---|
| `Space r` | Symbol im ganzen Projekt umbenennen |
| `Space a` | Code-Aktion anwenden (z. B. Import ergänzen) |
| `:fmt` | Datei mit dem Language Server formatieren (siehe auch [[03 Text umformen]]) |

> [!tip] `Space r` schlägt jedes Suchen-&-Ersetzen
> Umbenennen über den LSP versteht Geltungsbereiche und benennt nur das *echte* Symbol um – nicht zufällige Textgleichheit. Für sicheres Refactoring der bessere Weg als Mehrfachauswahl (vgl. [[04 Suchen und Ersetzen]]).

## Diagnosen

| Befehl | Wirkung |
|---|---|
| `]d` / `[d` | zur nächsten / vorigen Diagnose (Fehler, Warnung) |
| `]D` / `[D` | erste / letzte Diagnose im Dokument |
| `Space d` / `Space D` | Diagnose-Picker Datei / Workspace |
| `:lsp-restart` / `:lsp-stop` | Language Server neu starten / stoppen |

> [!tip] Fehler abarbeiten
> `]d` springt zum nächsten Fehler, `Space k` zeigt die Meldung, `Space a` bietet oft direkt eine Korrektur an.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01 Navigation und Sprünge]] – `]f`/`[f` und weitere Treesitter-Sprünge zu Funktion/Typ/Argument
- [[04 Suchen und Ersetzen]] – textbasierte Alternative zu `Space r`
- [[05 Mehrfachauswahl]] – `Space h` erzeugt Cursor aus Referenzen

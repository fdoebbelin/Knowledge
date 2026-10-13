---
title: "Helix-Cookbook – Kapitel 5: Mehrfachauswahl"
aliases:
  - Helix Cookbook Mehrfachauswahl
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

Mehrfach-Cursor sind in Helix kein Zusatz, sondern Grundwerkzeug. Die zentrale Idee: **Eine große Auswahl wird in viele kleine zerlegt**, danach wirkt jede Aktion aus [[03 Text umformen]] oder [[02 Auswahl-Grundlagen]] auf alle gleichzeitig.

## Cursor erzeugen

| Befehl | Wirkung |
|---|---|
| `C` / `Alt-C` | Auswahl in die Zeile darunter / darüber kopieren (neuer Cursor) |
| `s` | in der Auswahl alle Treffer eines regulären Ausdrucks auswählen |
| `S` | Auswahl **an** den Treffern aufteilen (die Treffer selbst fallen weg) |
| `Alt-s` | Auswahl an Zeilenumbrüchen aufteilen – eine Auswahl pro Zeile |

## Cursor verwalten

| Befehl | Wirkung |
|---|---|
| `,` / `Alt-,` | nur Haupt-Auswahl behalten / Haupt-Auswahl entfernen |
| `;` | jede Auswahl auf ihren Cursor zusammenziehen |
| `K` / `Alt-K` | Auswahlen behalten / entfernen, die einen Regex enthalten |
| `(` `)` | anderer Cursor wird Haupt-Cursor |
| `Alt-(` `Alt-)` | **Inhalte** der Auswahlen rotieren (z. B. zwei Argumente tauschen) |
| `&` | Auswahlen spaltenbündig ausrichten |
| `Alt-_` | angrenzende Auswahlen verschmelzen |

> [!example] Schritt für Schritt: Variablen umbenennen
> Ausgangstext:
> ```python
> wert = 1
> print(wert)
> summe = wert + wert
> ```
> 1. `%` – ganze Datei auswählen
> 2. `s` `wert` `⏎` – vier Cursor, einer pro Vorkommen
> 3. `c` `betrag` `Esc` – alle vier gleichzeitig ersetzt
> 4. `,` – zurück zu einem Cursor

> [!example] Werte ausrichten mit `&`
> Bei `a = 1`, `abc = 2`, `ab = 3` untereinander: alle drei Zeilen mit `x` `x` `x` wählen, `s` `=` `⏎` wählt die Gleichheitszeichen, `&` richtet sie in einer Spalte aus.

## Rezept: Blockauswahl simulieren

> [!example] `C C C → l l → c`
> Helix hat keinen Block-Modus. Stattdessen stapelt `C` Cursor nach unten, normale Bewegungen (z. B. `l` `l`) ziehen die Auswahl in die Breite, und `c`, `d` oder `i` wirken auf den ganzen Block.

> [!question]- Übung 5.1 – Liste nummerieren
> Vier Zeilen `- punkt` untereinander sollen `- 1punkt`, `- 2punkt` … werden.
>
> > [!success]- Lösung
> > Cursor auf das erste `p` von `punkt`, `C` `C` `C` erzeugt vier Cursor untereinander, `"#P` fügt vor jedem Cursor dessen laufende Nummer ein (Register `#`, siehe [[07 Register und Makros]]) → `- 1punkt` usw. Leerzeichen danach mit `a` `␣` `Esc` nachtragen.

> [!question]- Übung 5.2 – Argumente tauschen
> `teile(zaehler, nenner)` → `teile(nenner, zaehler)`.
>
> > [!success]- Lösung
> > Cursor in die Klammer, `mi(` wählt `zaehler, nenner`, `s` `\w+` `⏎` wählt beide Wörter einzeln, `Alt-)` rotiert die Inhalte.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[02 Auswahl-Grundlagen]] – `Alt-p`/`Alt-n` wählen Nachbarknoten statt neuer Cursor
- [[04 Suchen und Ersetzen]] – `s` ist hier wie dort derselbe Befehl
- [[07 Register und Makros]] – `"#` nummeriert Cursor, Makros als Alternative zu vielen Cursorn

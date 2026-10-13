---
title: "Helix-Cookbook – Kapitel 3: Text umformen"
aliases:
  - Helix Cookbook Text umformen
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[Helix-Cookbook]]. Wie eine Aktion immer auf die aktuelle Auswahl wirkt: [[Helix-Leitfaden#1 Das Grundprinzip Auswahl → Aktion]].

Alle Aktionen hier wirken auf die **aktuelle Auswahl**. Das Muster ist deshalb immer: *auswählen (siehe [[01 Navigation und Sprünge]], [[02 Auswahl-Grundlagen]]), dann Taste*.

## Löschen und Ändern

| Befehl | Wirkung | Beispiel |
|---|---|---|
| `d` | Auswahl löschen (und kopieren) | `x` `d` löscht die Zeile |
| `Alt-d` | löschen **ohne** kopieren | Zwischenablage bleibt erhalten |
| `c` / `Alt-c` | ändern (löschen + Einfügemodus), mit/ohne kopieren | `w` `c` ersetzt ein Wort |
| `r` *z* | jedes Zeichen der Auswahl durch *z* ersetzen | `x` `r` `-` macht die Zeile zu Strichen |
| `R` | Auswahl durch zuvor kopierten Text ersetzen | |

> [!question]- Übung 3.1 – Wort ersetzen
> In `call(foo, bar)` steht der Cursor auf `c`. Ersetze `call` durch `run`.
>
> > [!success]- Lösung
> > `t(` wählt `call` (bis vor die Klammer), dann `c` `run` `Esc`.

## Groß-/Kleinschreibung

| Befehl | Wirkung |
|---|---|
| `~` | Groß-/Kleinschreibung umschalten |
| `` ` `` | in Kleinbuchstaben |
| `` Alt-` `` | in GROSSBUCHSTABEN |

## Zeilen, Einrückung, Leerraum

| Befehl | Wirkung | Beispiel |
|---|---|---|
| `J` | Zeilen der Auswahl verbinden | |
| `Alt-J` | verbinden, eingefügtes Leerzeichen bleibt ausgewählt | |
| `>` / `<` | ein- / ausrücken | `x` `x` `>` rückt zwei Zeilen ein |
| `_` | Leerraum am Anfang und Ende der Auswahl entfernen | |
| `:reflow` | Auswahl auf eine Breite hart umbrechen | für Fließtext/Kommentare |

## Zahlen, Kommentare, Formatierung

| Befehl | Wirkung | Beispiel |
|---|---|---|
| `Ctrl-a` / `Ctrl-x` | Zahl unter dem Cursor +1 / −1 | `5` `Ctrl-a` addiert 5 |
| `Ctrl-c` | Kommentar an / aus | sprachabhängig, braucht keinen LSP |
| `:fmt` | Datei mit dem Language Server formatieren ● | |
| `:sort` / `:rsort` | Auswahlen sortieren / rückwärts sortieren | |

> [!example] Spalten ausrichten
> Bei `a = 1`, `abc = 2`, `ab = 3` untereinander: alle drei Zeilen auswählen, `s` `=` `Enter` wählt die Gleichheitszeichen, `&` richtet sie in einer Spalte aus. `&` zählt als Mehrfachauswahl-Befehl, siehe [[05 Mehrfachauswahl]].

## Verwandt

- [[Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[Helix-Leitfaden]] – Grundprinzip Auswahl → Aktion
- [[02 Auswahl-Grundlagen]] – Kopieren, Einfügen, Rückgängig
- [[04 Suchen und Ersetzen]] – wenn die Änderung erst gefunden werden muss
- [[05 Mehrfachauswahl]] – dieselbe Änderung an vielen Stellen gleichzeitig

---
title: "Helix-Cookbook – Kapitel 2: Auswahl-Grundlagen"
aliases:
  - Helix Cookbook Auswahl-Grundlagen
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]]. Das Auswahl-→-Aktion-Prinzip mit Grafik: [[01-Leitfaden zum Spickzettel#1 Das Grundprinzip Auswahl → Aktion]], [[01-Leitfaden zum Spickzettel#3 Bewegen ist Auswählen – der Kompass]].

Dieses Kapitel versammelt die Befehle, die zum täglichen Handwerkszeug gehören, sobald eine Auswahl steht: sie ausweiten/zurücknehmen, kopieren, einfügen, rückgängig machen – und entlang des Syntaxbaums statt entlang von Zeichen auswählen.

## Auswahl erweitern, zurücknehmen, umdrehen

| Befehl | Wirkung |
|---|---|
| `x` | aktuelle Zeile auswählen, jedes weitere `x` nimmt die nächste Zeile dazu |
| `X` | Auswahl auf ganze Zeilen erweitern |
| `Alt-x` | Auswahl auf ganze Zeilen verkleinern |
| `%` | ganze Datei auswählen |
| `;` | Auswahl auf den Cursor zusammenziehen |
| `Alt-;` | Anker und Cursor tauschen (die Auswahl wächst dann am anderen Ende) |
| `Alt-:` | Auswahlrichtung erzwungen vorwärts |
| `,` | bei mehreren Auswahlen nur die Haupt-Auswahl behalten |
| `v` | Auswahlmodus ein/aus – Bewegungen **erweitern** statt zu ersetzen |

> [!question]- Übung 2.1 – Auswahl erweitern
> Der Cursor steht am Anfang von `alpha beta gamma delta`. Du willst `alpha beta gamma` löschen – aber **ohne Zähler**.
>
> > [!success]- Lösung
> > `v` `e` `e` `e` `d` – ohne `v` würde jedes `e` die Auswahl **ersetzen**, mit `v` wird sie **erweitert**.

## Kopieren und Einfügen

| Befehl | Wirkung |
|---|---|
| `y` | Auswahl kopieren (yank) |
| `p` / `P` | nach / vor der Auswahl einfügen |
| `Space y` / `Space Y` | in die System-Zwischenablage kopieren (alle / nur Haupt-Auswahl) |
| `Space p` / `Space P` | aus der System-Zwischenablage einfügen |
| `Space R` | Auswahl durch Zwischenablage ersetzen |

> [!warning] Zwei Zwischenablagen
> `y` und `p` verwenden das **Helix-interne** Register. Nur die `Space`-Varianten sprechen mit der Zwischenablage des Betriebssystems – also mit dem Browser oder einem anderen Programm.

## Rückgängig und Wiederholen

| Befehl | Wirkung |
|---|---|
| `u` | Rückgängig |
| `U` | Wiederherstellen (Redo, **nicht** `Strg-r` wie in Vim) |
| `Alt-u` / `Alt-U` | in der Änderungshistorie zurück / vor |
| `:ear` / `:lat` | früherer / späterer Stand (auch mit Zeitangabe, z. B. `:ear 5m`) |
| `.` | letztes Einfügen wiederholen |

## Entlang des Syntaxbaums auswählen ●

Statt Zeichen oder Wörtern zu zählen, lässt sich die Auswahl direkt am Syntaxbaum entlanghangeln – das braucht eine Tree-sitter-Grammatik für die Sprache (prüfen mit `hx --health <sprache>`).

| Befehl | Wirkung |
|---|---|
| `Alt-o` | Auswahl auf den umgebenden Syntaxknoten vergrößern (Ausdruck → Anweisung → Block → Funktion) |
| `Alt-i` | wieder verkleinern |
| `Alt-p` / `Alt-n` | vorigen / nächsten Nachbarknoten wählen (z. B. nächstes Argument) |

> [!tip] `Alt-o` mehrmals drücken
> Das ist oft der schnellste Weg, „die ganze Funktion“ oder „den ganzen `if`-Block“ auszuwählen, ohne Zeilen zu zählen.

> [!question]- Übung 2.2 – Vom Wort zur ganzen Funktion
> Cursor steht irgendwo im Wort `name` einer Funktionsdefinition `def gruss(name): ...`.
>
> > [!success]- Lösung
> > `miw` wählt das Wort. `Alt-o` einmal springt auf den umschließenden Ausdruck (z. B. die Parameterliste), jedes weitere `Alt-o` wächst eine Ebene weiter – bis zur ganzen Funktion. `Alt-i` macht einen Schritt rückgängig.

## Textobjekte in Kürze

`mi`/`ma` + Objektbuchstabe wählen **innen** bzw. **außen** ein Textobjekt – zum Beispiel `mi(` für den Inhalt der nächsten Klammer, `miw` für das Wort unter dem Cursor. Die vollständige Objekt-Tabelle und die Surround-Befehle (`ms`, `mr`, `md`) mit Grafik: [[01-Leitfaden zum Spickzettel#7 Match & Surround]].

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Grundprinzip, Kompass-Grafik, Match & Surround
- [[01 Navigation und Sprünge]] – Bewegungen, die gleichzeitig Auswahl sind
- [[05 Mehrfachauswahl]] – wenn aus einer Auswahl viele werden
- [[07 Register und Makros]] – benannte Zwischenablagen statt des Standardregisters

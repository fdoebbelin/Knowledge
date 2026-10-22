---
title: Feinschliff – Merkblatt
modul: K6
typ: merkblatt
tags: [tauri/kompaktkurs/merkblatt, css, ux]
status: active
---

# K6 – Merkblatt

## Die eine Regel

> **Eine Verbesserung, nicht fünf.**

Aus „ich will einen Löschknopf" wird schnell „ich will auch noch eine Rückfrage, wenn man alle löscht, und eine Animation". Das sind drei Verbesserungen.

Der Satz, der bremst: „Wenn das fertig ist, habe ich **eine** Verbesserung."

## Die Werkzeug-Brückentabelle

Welcher Wunsch braucht welche Bausteine – alles aus den bisherigen Modulen:

| Wunsch | Werkzeug | Modul |
|---|---|---|
| Anzahl der Karten anzeigen | `karten.length`, `.textContent` | K3, K4 |
| Zählen, wie viele Karten schon gezeigt wurden | Zähler-Variable (`let`), `if` | K3 |
| Leere Eingabe abfangen | `if`, `.value`, `.trim()` | K3, K4 |
| Antwort erst nach Klick zeigen | `if`, `.textContent` | K3, K4 |
| Löschknopf pro Listeneintrag | `createElement`, `appendChild`, `addEventListener` | K4 |
| Karte aus der Liste entfernen | `indexOf`, `splice` | K3, bedingt erlaubt, einmal als Rezept |
| Karte optisch hervorheben | `border`, `border-radius`, `box-shadow` | K2 |
| Wichtigsten Knopf auffälliger machen | `font-weight`, `padding`, `#id` statt `.klasse` | K2 |
| Eigenes Farbschema | `background-color`, `color`, `border-color` | K2 |
| Abstand zwischen Frage und Antwort | `margin`, `gap` | K2 |
| Anwendung auf eine Breite begrenzen | `max-width` | K2 |
| Farbe der Karte abhängig vom Zustand | `.className` oder `classList` | bedingt erlaubt, wird bei Bedarf erklärt |
| Nach jeder Änderung anzeigen | `listeAnzeigen()` | K4 |
| Nach jeder Änderung speichern | `await speichern()` | K5 |

## Die vier Schritte einer Verbesserung

1. **Formulieren** – Was genau soll passieren? Ein Satz mit „wenn … dann".
2. **Nachschlagen** – Welche Bausteine aus der Tabelle oben werden gebraucht?
3. **Umsetzen** – klein anfangen, nach jeder Änderung hinsehen
4. **Prüfen** – Stimmt das Ergebnis? Bleibt der Rest heil?

## Nach jeder Änderung an den Daten

| Was passiert | Dann aufrufen |
|---|---|
| Die Liste der Karten hat sich geändert | `listeAnzeigen()` |
| Die Karten sollen auf der Platte bleiben | `await speichern()` |

Beides wird leicht vergessen. Beides fällt sofort auf: einmal stehen die alten Einträge da, einmal ist die Änderung beim nächsten Start weg.

## Was hier nicht kommt

| Nicht verwenden | Grund |
|---|---|
| Neue CSS-Eigenschaften | Alles, was gebraucht wird, steht im [[K2 Merkblatt]] |
| CSS Grid | ein Layoutsystem genügt |
| `position: absolute` | erzeugt mehr Probleme, als es löst |
| Pfeilfunktionen `=>` | zweite Schreibweise für Funktionen |
| `class`, `this` | Objektorientierung ist ein eigener Kurs |

Die verbindliche Liste steht in [[Anhang Sprachumfang JavaScript]].

## Vor dem Umbauen

- Eine Kopie der Dateien anlegen
- Prüfen, ob der Stand von [[K5 Daten behalten]] wiederherstellbar ist
- Nach jeder Änderung hinsehen, nicht erst am Ende

## Der Kontrast-Check

Ist der Text aus zwei Metern Entfernung lesbar? Nicht verbieten, sondern hinsehen lassen.

> „Können Sie das aus zwei Metern Entfernung lesen?"

## Verknüpfung

Leitfaden: [[K6 Feinschliff]] · Übungen: [[K6 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K7 Als Anwendung ausliefern]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

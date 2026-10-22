---
title: Feinschliff – Übungen
modul: K6
typ: uebungsblatt
tags: [tauri/kompaktkurs/uebung, css, ux]
status: active
---

# K6 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Die eine Verbesserung
- F2 Welche Bausteine braucht welcher Wunsch
- F3 Was nach einer Änderung aufzurufen ist
- F4 Der Löschknopf
- F5 Was hier nicht kommt
- F6 Die Begründung

---

## F1 Warum gilt die Regel „eine Verbesserung, nicht fünf"? Was ist der Preis von zu viel auf einmal?

> [!success]- Antwort F1
> Aus einem Wunsch wie „ich will einen Löschknopf" wird schnell „ich will auch noch eine Rückfrage, wenn man alle löscht, und eine Animation, und eine Warnung, wenn die Liste leer ist". Das sind drei Verbesserungen.
>
> **Der Preis:** Fünf halbe Sachen und eine kaputte Datei. Wer gleichzeitig an fünf Stellen umbaut, kann hinterher nicht mehr sagen, welche Änderung den Fehler verursacht hat – und findet ihn unter Umständen nicht mehr.
>
> **Der Satz, der bremst:** „Wenn das fertig ist, habe ich **eine** Verbesserung."

---

## F2 Welche Bausteine werden für welchen Wunsch gebraucht?

| Wunsch | Bausteine |
|---|---|
| Anzahl der Karten anzeigen | |
| Leere Eingabe abfangen | |
| Zählen, wie viele Karten schon gezeigt wurden | |
| Karte optisch hervorheben | |
| Wichtigsten Knopf auffälliger machen | |

> [!success]- Antwort F2
> | Wunsch | Bausteine |
> |---|---|
> | Anzahl der Karten anzeigen | `karten.length`, `.textContent` |
> | Leere Eingabe abfangen | `if`, `.value`, `.trim()` |
> | Zählen, wie viele Karten schon gezeigt wurden | Zähler-Variable (`let`), `if` |
> | Karte optisch hervorheben | `border`, `border-radius`, `box-shadow` |
> | Wichtigsten Knopf auffälliger machen | `font-weight`, `padding`, `#id` statt `.klasse` |
>
> Alles davon stammt aus den bisherigen Modulen – nichts ist neu. Die vollständige Brückentabelle steht im [[K6 Merkblatt]].

---

## F3 Was muss nach einer Änderung an den Karten aufgerufen werden? Und was, wenn die Änderung auf der Platte bleiben soll?

> [!success]- Antwort F3
> | Was passiert | Dann aufrufen |
> |---|---|
> | Die Liste der Karten hat sich geändert | `listeAnzeigen()` |
> | Die Karten sollen auf der Platte bleiben | `await speichern()` |
>
> Beides wird leicht vergessen, und beides fällt sofort auf: einmal stehen die alten Einträge da, einmal ist die Änderung beim nächsten Start weg.

---

## F4 Der Löschknopf braucht drei Bausteine aus drei verschiedenen Modulen. Welche?

> [!success]- Antwort F4
> | Baustein | Woher |
> |---|---|
> | `document.createElement("button")` | [[K4 JavaScript im Fenster]] |
> | `karten.indexOf(karte)` und `karten.splice(pos, 1)` | Listen aus [[K3 JavaScript – die Bausteine]] |
> | `await speichern();` | [[K5 Daten behalten]] |
>
> **`indexOf` und `splice` sind die eine Ausnahme:** Sie stehen nicht in der allgemeinen Liste des [[Anhang Sprachumfang JavaScript]], sondern nur unter „Bedingt erlaubt“. Sie werden hier einmal als vollständige Zeile erklärt – und nur, wenn diese Verbesserung gewählt wurde.
>
> **Was man dabei beobachtet:** Der Löschknopf verschwindet beim ersten Klick. Das ist richtig so – beim Neuaufbau der Liste wird jeder Knopf neu erzeugt.

---

## F5 Welche dieser Werkzeuge kommen in diesem Modul **nicht** vor? Begründen Sie jeweils kurz.

| Werkzeug | kommt vor? |
|---|---|
| CSS Grid | ☐ |
| `position: absolute` | ☐ |
| Pfeilfunktionen `=>` | ☐ |
| `class` und `this` | ☐ |
| `border-radius` | ☐ |
| `box-shadow` | ☐ |

> [!success]- Antwort F5
> | Werkzeug | kommt vor? |
> |---|---|
> | CSS Grid | ✘ – ein Layoutsystem genügt |
> | `position: absolute` | ✘ – erzeugt mehr Probleme, als es löst |
> | Pfeilfunktionen `=>` | ✘ – zweite Schreibweise für Funktionen |
> | `class` und `this` | ✘ – Objektorientierung ist ein eigener Kurs |
> | `border-radius` | ✔ – aus [[K2 CSS – das Aussehen]] |
> | `box-shadow` | ✔ – aus [[K2 CSS – das Aussehen]] |
>
> Die verbindliche Liste steht in [[Anhang Sprachumfang JavaScript]]. Alles, was dort steht, darf benutzt werden – alles andere nicht.

---

## F6 Welche Frage wird beim Vorstellen gestellt – und warum ist die Begründung wertvoller als die Lösung?

> [!success]- Antwort F6
> Die Frage lautet: „Warum genau diese Entscheidung? Was wäre schlechter geworden, wenn Sie es anders gemacht hätten?"
>
> **Warum die Begründung wertvoller ist:** Gesucht wird nicht die beste Lösung, sondern die eigene. Eine begründete Entscheidung ist mehr wert als fünf nachgemachte Regeln – sie zeigt, dass die Person selbst gedacht hat.

---

## Verknüpfung

Leitfaden: [[K6 Feinschliff]] · Merkblatt: [[K6 Merkblatt]]
Weiter mit [[K7 Als Anwendung ausliefern]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

---
title: CSS – das Aussehen – Merkblatt
modul: K2
typ: merkblatt
aliases:
  - K2b Handout
tags: [tauri/kompaktkurs/merkblatt, css]
status: active
---

# K2 – Merkblatt

## Der Aufbau einer Regel

```
body { background-color: #f4f4f4; }
 │      │                  │      │
 │      │                  │      └─ Semikolon
 │      │                  └──────── Wert
 │      └─────────────────────────── Eigenschaft
 └────────────────────────────────── Selektor
```

**Drei Fragen, immer dieselben:** Wen betrifft es? Was soll anders sein? Wie soll es sein?

Das Semikolon ist Pflicht. Fehlt es, versteht das Programm die betroffene **und** die nächste Erklärung nicht mehr.

## Farben

```
#f4f4f4
 └┬┘└┬┘└┬┘
  │  │  └─ Blau
  │  └──── Grün
  └─────── Rot
```

Jede Stelle von `00` bis `ff`. Nur Hex-Werte, keine Farbnamen.

| Zweck | Vorschlag |
|---|---|
| Seitenhintergrund | `#f4f4f4` |
| Kartenhintergrund | `#ffffff` |
| Text | `#222222` |
| Nebentext | `#555555` |
| Rahmen | `#cccccc` |
| Hauptfarbe | `#2a4d69` |
| Hauptfarbe hell (`:hover`) | `#3d6b91` |
| Zweitfarbe | `#6b8f71` |

## Die drei Selektoren

| Selektor | Schreibweise | Trifft | Typischer Einsatz |
|---|---|---|---|
| **Typ** | `button` | alle dieser Sorte | Grundaussehen aller Knöpfe |
| **Klasse** | `.knopf-anzeige` | eine Gruppe | mehrere Elemente gleich aussehen lassen |
| **`id`** | `#karte-frage` | genau eines | ein bestimmtes Element |

**Zeichenwechsel:** Im HTML `class="knopf-anzeige"` **ohne** Punkt, `id="karte-frage"` **ohne** Raute. Im CSS **mit** Punkt bzw. Raute.

**Spezifität:** Je genauer der Selektor, desto stärker.

```
#id   schlägt   .klasse   schlägt   element
```

Bei gleich genauen Selektoren gewinnt die weiter unten stehende Regel.

**Zustand:** `button:hover` – nur, solange die Maus darauf steht.

## Das Boxmodell

```
┌─────────────────────────────────┐
│  margin  (außen, unsichtbar)    │
│  ┌───────────────────────────┐  │
│  │  border                   │  │
│  │  ┌─────────────────────┐  │  │
│  │  │  padding            │  │  │
│  │  │  ┌───────────────┐  │  │  │
│  │  │  │    Inhalt     │  │  │  │
│  │  │  └───────────────┘  │  │  │
│  │  └─────────────────────┘  │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

> **`padding` schiebt den Inhalt vom Rahmen weg.
> `margin` schiebt den Rahmen von den Nachbarn weg.**

Bildvergleich: Das Passepartout zwischen Bild und Rahmen ist `padding`, der Rahmen ist `border`, der Abstand zum Nachbarbild ist `margin`.

| Angabe | Bedeutung |
|---|---|
| `border: 2px solid #cccccc;` | wie dick, welche Art, welche Farbe – immer in dieser Reihenfolge |
| `border: none;` | vorhandenen Rahmen entfernen |
| `padding: 20px;` | alle vier Seiten gleich |
| `padding: 8px 16px;` | oben/unten 8, links/rechts 16 |
| `max-width: 400px;` | höchstens so breit – wird das Fenster schmaler, wird das Element mit |
| `width: 400px;` | **nie im Kurs** – das Element läuft aus dem Fenster |

## Flexbox

Drei Zeilen auf dem **umgebenden** Element:

```css
#eingabe {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
```

| Zeile | Bedeutung |
|---|---|
| `display: flex` | „Ich kümmere mich um die Anordnung meiner Kinder." |
| `flex-direction: column` | untereinander. `row` = nebeneinander, ist die Voreinstellung. |
| `gap: 12px` | Abstand zwischen den Kindern – einmal gesetzt, gilt überall |

**Flexbox wirkt auf alle Kinder.** Sollen nur zwei von vier Elementen nebeneinander stehen, brauchen diese zwei eine eigene Kiste – hier `div#knopf-leiste`.

**Ausrichten:**

| Eigenschaft | Wirkt | Werte |
|---|---|---|
| `justify-content` | **in** Laufrichtung (bei `row`: links ↔ rechts) | `flex-start`, `center`, `flex-end`, `space-between` |
| `align-items` | **quer** zur Laufrichtung (bei `row`: oben ↔ unten) | `flex-start`, `center`, `flex-end` |

CSS Grid kommt im Kurs nicht vor.

## Die Eigenschaften dieses Kurses

| Eigenschaft | Wofür | Beispielwert |
|---|---|---|
| `color` | Textfarbe | `#222222` |
| `background-color` | Hintergrundfarbe | `#ffffff` |
| `font-family` | Schriftart | `system-ui, sans-serif` |
| `font-size` | Schriftgröße | `16px` |
| `font-weight` | Schriftstärke | `400` normal, `700` fett |
| `padding` | Innenabstand | `20px` |
| `margin` | Außenabstand | `24px` |
| `border` | Rahmen | `2px solid #cccccc` |
| `border-radius` | runde Ecken | `12px` |
| `max-width` | Höchstbreite | `400px` |
| `display: flex` | Anordnung übernehmen | – |
| `flex-direction` | Richtung | `row`, `column` |
| `gap` | Abstand zwischen Kindern | `12px` |
| `justify-content` | Ausrichtung in Laufrichtung | `center` |
| `align-items` | Ausrichtung quer dazu | `center` |
| `cursor` | Mauszeiger | `pointer` |

## Die zwei Diagnosefragen

```
Eine Regel wirkt nicht      → Namen laut vorlesen, # und . prüfen
ALLE Regeln ab hier nicht   → darüber suchen: Semikolon oder Klammer
```

| Was zu sehen ist | Wahrscheinliche Ursache |
|---|---|
| Nichts passiert, keine Fehlermeldung | Selektorname stimmt nicht mit der `id` überein |
| Falsches Element ändert sich | `#` und `.` vertauscht |
| Zwei Regeln, die stärkere gewinnt nicht wie erwartet | Spezifität: `#id` > `.klasse` > `element` |
| Kasten wird beim Verkleinern abgeschnitten | `width` statt `max-width` |
| Zu viel steht nebeneinander | `display: flex` sitzt auf dem falschen Bereich |
| Abstand innen gewünscht, außen entstanden | `margin` statt `padding` |
| Text kaum lesbar | zu wenig Kontrast |

## Wörter

| Wort | Bedeutung in einem Satz |
|---|---|
| **CSS** | Die Sprache, in der das Aussehen beschrieben wird. |
| **Regel** | Selektor plus geschweifte Klammern mit Erklärungen darin. |
| **Selektor** | Der Teil vor der Klammer: wen die Regel betrifft. |
| **Eigenschaft** | Was verändert wird, zum Beispiel `color`. |
| **Wert** | Wie es sein soll, zum Beispiel `#2a4d69`. |
| **Boxmodell** | Inhalt, `padding`, `border`, `margin` – von innen nach außen. |
| **Flexbox** | Anordnungssystem: `display: flex` auf dem umgebenden Element. |
| **Hex-Wert** | Farbschreibweise mit Raute und sechs Zeichen. |

## Verknüpfung

Leitfaden: [[K2 CSS – das Aussehen]] · Übungen: [[K2 Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

---
baustein: K2
typ: handout
title: CSS – das Aussehen – Handout
ue: 5
kurstag: 1-2
tags: [tauri/kompaktkurs/handout, css]
status: entwurf
---

# K2 – CSS – das Aussehen

> [!abstract] Worum es in dieser Einheit geht
> Aus der nackten Struktur wird etwas, das wie eine Anwendung aussieht. Sie lernen, wie eine CSS-Regel aufgebaut ist, wie Sie ein bestimmtes Element ansprechen, wie Abstände funktionieren und wie Sie Dinge nebeneinander anordnen.

---

## 1 Wie das Aussehen zur Struktur kommt

Im Kopf Ihrer `index.html` steht seit dem ersten Tag diese Zeile:

```html
<link rel="stylesheet" href="style.css" />
```

Sie sagt: Zu dieser Datei gehört ein Anstrich, und der steht in `style.css`. Solange die Datei leer war, sah alles nach Werkseinstellung aus.

---

## 2 Der Aufbau einer Regel

```
body { background-color: #f4f4f4; }
 │      │                  │      │
 │      │                  │      └─ Semikolon: beendet die Erklärung
 │      │                  └──────── Wert: welcher
 │      └─────────────────────────── Eigenschaft: was
 └────────────────────────────────── Selektor: wen betrifft es
```

Drei Fragen, jedes Mal dieselben: **Wen betrifft es? Was soll anders sein? Wie soll es sein?**

Übliche Schreibweise über mehrere Zeilen:

```css
body {
  background-color: #f4f4f4;
  color: #222222;
}
```

> [!warning] Das Semikolon ist Pflicht
> Fehlt es, versteht das Programm die betroffene **und** die nächste Erklärung nicht mehr. Das ist der häufigste Fehler dieses Bausteins.

---

## 3 Farben

Farben schreiben wir im Kurs ausschließlich als Hex-Wert:

```
#f4f4f4
 └┬┘└┬┘└┬┘
  │  │  └─ Blau
  │  └──── Grün
  └─────── Rot
```

Jede Stelle läuft von `00` (nichts davon) bis `ff` (voll). `#ffffff` ist Weiß, `#000000` ist Schwarz, `#888888` ein mittleres Grau.

### Eine brauchbare Startpalette

| Zweck | Vorschlag | |
|---|---|---|
| Seitenhintergrund | `#f4f4f4` | sehr helles Grau |
| Kartenhintergrund | `#ffffff` | Weiß |
| Text | `#222222` | fast Schwarz |
| Nebentext | `#555555` | mittleres Grau |
| Rahmen | `#cccccc` | helles Grau |
| Hauptfarbe | `#2a4d69` | dunkles Blau |
| Hauptfarbe hell | `#3d6b91` | für `:hover` |
| Zweitfarbe | `#6b8f71` | gedämpftes Grün |

Sie dürfen jederzeit eigene Farben wählen. Achten Sie nur darauf, dass Text auf seinem Hintergrund **aus zwei Metern Entfernung** lesbar bleibt.

---

## 4 Die drei Selektoren

| Selektor | Schreibweise | Trifft | Typischer Einsatz |
|---|---|---|---|
| **Typ** | `button` | alle Elemente dieser Sorte | Grundaussehen aller Knöpfe |
| **Klasse** | `.knopf-anzeige` | eine Gruppe | mehrere Elemente sollen gleich aussehen |
| **`id`** | `#karte-frage` | genau ein Element | ein bestimmtes Element, sonst nichts |

```css
button          { border-radius: 6px; }     /* alle Knöpfe */
.knopf-anzeige  { background-color: #6b8f71; }  /* die zwei Blätterknöpfe */
#karte-frage    { font-size: 20px; }        /* nur die Frage */
```

> [!important] Der Zeichenwechsel
> Im HTML steht `class="knopf-anzeige"` **ohne** Punkt und `id="karte-frage"` **ohne** Raute.
> Im CSS steht `.knopf-anzeige` **mit** Punkt und `#karte-frage` **mit** Raute.
> Das ist verwirrend und lässt sich nicht wegerklären. Es ist einfach so.

### Wenn zwei Regeln dasselbe Element treffen

> [!tip] Merksatz
> **Je genauer der Selektor, desto stärker.**
> `#id` schlägt `.klasse` schlägt `element`.

Bei gleich genauen Selektoren gewinnt die Regel, die **weiter unten** in der Datei steht.

### Ein Zustand: `:hover`

```css
button:hover {
  background-color: #3d6b91;
}
```

Der Doppelpunkt heißt: nur in diesem Zustand – hier also nur, solange die Maus darauf steht.

---

## 5 Das Boxmodell

Jedes Element ist eine Kiste aus vier Schichten:

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

> [!important] Der Merksatz
> **`padding` schiebt den Inhalt vom Rahmen weg.
> `margin` schiebt den Rahmen von den Nachbarn weg.**

Bildvergleich: Ein gerahmtes Bild an der Wand. Das Passepartout ist `padding`, der Rahmen ist `border`, der Abstand zum Nachbarbild ist `margin`.

### Der Rahmen

```css
border: 2px solid #cccccc;
```

Drei Angaben in dieser Reihenfolge: **wie dick, welche Art, welche Farbe.** `solid` heißt durchgezogen. `border: none` entfernt einen vorhandenen Rahmen – nützlich bei Knöpfen.

### Zahlenangaben

```css
padding: 20px;        /* alle vier Seiten gleich */
padding: 8px 16px;    /* oben/unten 8, links/rechts 16 */
```

### Breite

```css
max-width: 400px;
```

`max-width` heißt **höchstens** so breit. Wird das Fenster schmaler, wird das Element mit. Bei `width` bliebe es stur und liefe aus dem Fenster.

> [!note] Kursregel
> Im Kurs immer `max-width`, nie `width`.

---

## 6 Flexbox – Dinge anordnen

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
| `flex-direction: column` | untereinander. `row` heißt nebeneinander und ist die Voreinstellung. |
| `gap: 12px` | Abstand zwischen den Kindern – einmal gesetzt, gilt überall |

> [!tip] Warum `gap` besser ist als `margin`
> Mit `margin` müssten Sie jedem Element einzeln einen Abstand geben und beim letzten wieder wegnehmen. `gap` erledigt das in einer Zeile. Genau dafür gibt es Flexbox.

### Wichtig: Flexbox wirkt auf die Kinder

Sollen nur zwei von vier Elementen nebeneinander stehen, brauchen diese zwei eine eigene Kiste:

```html
<div id="knopf-leiste">
  <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
  <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
</div>
```

```css
#knopf-leiste {
  display: flex;
  gap: 12px;
}
```

**Das ist der Moment, in dem das unsichtbare `<div>` aus [[K1 HTML – die Struktur]] seinen Zweck bekommt.**

### Ausrichten

| Eigenschaft | Wirkt | Werte |
|---|---|---|
| `justify-content` | **in** Laufrichtung (bei `row`: links ↔ rechts) | `flex-start`, `center`, `flex-end`, `space-between` |
| `align-items` | **quer** zur Laufrichtung (bei `row`: oben ↔ unten) | `flex-start`, `center`, `flex-end` |

Die beiden werden ständig verwechselt, auch von Fortgeschrittenen. Die ehrliche Empfehlung: hinschreiben, hinsehen, gegebenenfalls das andere nehmen.

> [!note] CSS Grid kommt nicht vor
> Es gibt ein zweites Anordnungssystem, das mit Zeilen und Spalten arbeitet. Für diese Oberfläche wird es nicht gebraucht. Es steht auf der Liste für den Anschlusskurs.

---

## 7 Alle Eigenschaften dieses Kurses

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

---

## 8 Referenzfassung `style.css`

Ein vollständiges Beispiel. Ihre Farben dürfen und sollen abweichen.

```css
body {
  background-color: #f4f4f4;
  color: #222222;
  font-family: system-ui, sans-serif;
  font-size: 16px;
  margin: 24px;
  max-width: 600px;
}

h1 {
  color: #2a4d69;
  font-size: 28px;
}

h2 {
  font-size: 18px;
  font-weight: 600;
}

input, textarea {
  font-size: 16px;
  padding: 8px;
  border: 1px solid #cccccc;
  border-radius: 6px;
}

button {
  background-color: #2a4d69;
  color: #ffffff;
  font-size: 16px;
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

button:hover {
  background-color: #3d6b91;
}

.knopf-anzeige {
  background-color: #6b8f71;
}

.knopf-anzeige:hover {
  background-color: #85a88a;
}

#eingabe {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-width: 400px;
}

#anzeige {
  background-color: #ffffff;
  border: 2px solid #cccccc;
  border-radius: 12px;
  padding: 20px;
  margin: 24px;
  max-width: 400px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

#karte-frage {
  font-size: 20px;
  font-weight: 700;
}

#karte-antwort {
  color: #555555;
}

#knopf-leiste {
  display: flex;
  gap: 12px;
}

li:hover {
  background-color: #eeeeee;
}
```

---

## 9 Fehlersuche

> [!important] Die zwei Diagnosefragen
> **Wirkt eine einzelne Regel nicht?**
> → Namen im CSS und im HTML **laut** nebeneinander vorlesen. `#` und `.` prüfen.
>
> **Wirken alle Regeln ab einer bestimmten Stelle nicht?**
> → Nicht bei den letzten Änderungen suchen, sondern **darüber**: fehlendes Semikolon oder fehlende geschweifte Klammer.

| Was Sie sehen | Wahrscheinliche Ursache |
|---|---|
| Nichts passiert, keine Fehlermeldung | Selektorname stimmt nicht mit der `id` überein |
| Falsches Element ändert sich | `#` und `.` vertauscht |
| Zwei Regeln, die stärkere gewinnt nicht wie erwartet | Spezifität: `#id` > `.klasse` > `element` |
| Kasten wird beim Verkleinern abgeschnitten | `width` statt `max-width` |
| Zu viel steht nebeneinander | `display: flex` sitzt auf dem falschen Bereich |
| Abstand innen gewünscht, außen entstanden | `margin` statt `padding` |

---

## 10 Wörter von heute

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

---

## 11 Was Sie nach dieser Einheit können sollten

- [ ] Eine Regel aus Selektor, Eigenschaft und Wert aufbauen
- [ ] Elemente über Typ, `class` und `id` ansprechen
- [ ] Sagen, welcher Selektor gewinnt, wenn zwei zutreffen
- [ ] Das Boxmodell erklären und `padding` von `margin` unterscheiden
- [ ] Farben, Schrift und Abstände setzen
- [ ] Mit Flexbox untereinander und nebeneinander anordnen
- [ ] Die zwei Diagnosefragen anwenden

---

## Verknüpfung

Übungen: [[K2c Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

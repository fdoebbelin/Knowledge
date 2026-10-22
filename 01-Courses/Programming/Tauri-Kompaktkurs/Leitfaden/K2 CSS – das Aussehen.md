---
title: CSS – das Aussehen
modul: K2
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, css]
status: active
---

# K2 – CSS – das Aussehen

## Inhaltsübersicht

- Wie das Aussehen zur Struktur kommt
- Der Aufbau einer CSS-Regel
- Farben als Hex-Wert
- Drei Wege, ein Element zu treffen
- Wenn zwei Regeln dasselbe Element treffen
- Das Boxmodell
- Flexbox: Dinge anordnen
- Die eigene Gestaltung
- Absichtlicher Fehler: Semikolon und Klammer
- Die zwei Diagnosefragen
- Typische Stolperstellen
- Stand am Ende des Moduls

Aus der nackten Struktur wird etwas, das wie eine Anwendung aussieht. Das ist der optische Sprung des Kurses – hier wird aus einer Sammlung von Feldern zum ersten Mal etwas, das man jemandem zeigen möchte.

An diesem Modul wird es bequem, zwei Dateien nebeneinander offen zu halten: `index.html` und `style.css`. Wer zwischen Tabs wechseln muss, verliert den Zusammenhang zwischen `id` und Selektor.

## Wie das Aussehen zur Struktur kommt

Im Kopf der `index.html` steht seit dem ersten Modul diese Zeile:

```html
<link rel="stylesheet" href="style.css" />
```

Sie sagt: Zu dieser Datei gehört ein Anstrich, und der steht in `style.css`. Solange die Datei leer war, sah alles nach Werkseinstellung aus. Das ändert sich jetzt.

> [!note] CSS Grid kommt nicht vor
> Es gibt ein zweites Anordnungssystem, das mit Zeilen und Spalten arbeitet. Für diese Oberfläche wird es nicht gebraucht. Es steht auf der Liste für den Anschlusskurs.

## Der Aufbau einer CSS-Regel

```
body { background-color: #f4f4f4; }
 │      │                  │      │
 │      │                  │      └─ Semikolon: beendet die Erklärung
 │      │                  └──────── Wert: wie soll es sein
 │      └─────────────────────────── Eigenschaft: was soll anders sein
 └────────────────────────────────── Selektor: wen betrifft es
```

Drei Fragen, jedes Mal dieselben: **Wen betrifft es? Was soll anders sein? Wie soll es sein?**

Geschrieben wird über mehrere Zeilen:

```css
body {
  background-color: #f4f4f4;
  color: #222222;
}
```

Die erste Regel wird gemeinsam getippt – in die bisher leere `style.css`:

```css
body {
  background-color: #f4f4f4;
}
```

Speichern. Hinsehen. **Pause machen.** Nichts sagen, bis jemand reagiert.

> [!important] Das Semikolon ist Pflicht
> Fehlt es, versteht das Programm die betroffene **und** die nächste Erklärung nicht mehr. Das ist der häufigste Fehler dieses Moduls.

## Farben als Hex-Wert

```
#f4f4f4
 └┬┘└┬┘└┬┘
  │  │  └─ Blau
  │  └──── Grün
  └─────── Rot
```

Jede Stelle läuft von `00` (nichts davon) bis `ff` (voll). `#ffffff` ist Weiß, `#000000` ist Schwarz, `#888888` ein mittleres Grau.

Eine brauchbare Startpalette:

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

> [!tip] Kursregel Farben
> Ausschließlich Hex-Werte, keine Farbnamen wie `red`. Begründung an die Gruppe: „Es gibt beides, aber wenn drei Leute mischen, sieht die Datei aus wie ein Flohmarkt. Wir bleiben bei einer Schreibweise."

Eigene Farben sind erlaubt und erwünscht. Einzige Bedingung: Text auf seinem Hintergrund muss **aus zwei Metern Entfernung** lesbar bleiben.

## Drei Wege, ein Element zu treffen

| Selektor | Schreibweise | Trifft | Typischer Einsatz |
|---|---|---|---|
| **Typ** | `button` | alle Elemente dieser Sorte | Grundaussehen aller Knöpfe |
| **Klasse** | `.knopf-anzeige` | eine Gruppe | mehrere Elemente sollen gleich aussehen |
| **`id`** | `#karte-frage` | genau ein Element | ein bestimmtes Element, sonst nichts |

### Der Typselektor: alle auf einmal

```css
button {
  background-color: #2a4d69;
  color: #ffffff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}
```

Alle Knöpfe ändern sich gleichzeitig.

> „Ich habe `button` geschrieben, ohne Raute, ohne Punkt. Das heißt: alle Knöpfe, die es gibt und die es je geben wird. Wenn später ein vierter Knopf eingebaut wird, sieht der sofort genauso aus."

`cursor: pointer` mit der Maus vorführen: Der Mauszeiger wird zur Hand. Ohne das wirkt ein Knopf wie ein Bild – die billigste Verbesserung, die es gibt.

### Der Klassenselektor: eine Gruppe

Zurück in die `index.html` – auf die beiden Anzeige-Knöpfe zeigen:

```html
<button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
<button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
```

> „Erinnern Sie sich an das zweite Namensschild aus [[K1 HTML – die Struktur]]? Jetzt kommt es zum Einsatz. Diese beiden Knöpfe gehören zusammen – es sind die zum Blättern. Der wichtige Knopf ist der andere, der Karten anlegt. Also gebe ich den beiden eine andere Farbe, aber nicht jedem einzeln."

```css
.knopf-anzeige {
  background-color: #6b8f71;
}
```

> [!important] Der Zeichenwechsel
> Im HTML steht `class="knopf-anzeige"` **ohne** Punkt und `id="karte-frage"` **ohne** Raute.
> Im CSS steht `.knopf-anzeige` **mit** Punkt und `#karte-frage` **mit** Raute.
> Das ist verwirrend und lässt sich nicht wegerklären. Es ist einfach so.

### Der `id`-Selektor: genau eines

Jetzt wird die Heftliste aus [[K1 HTML – die Struktur]] gebraucht.

```css
#anzeige {
  background-color: #ffffff;
}

#karte-frage {
  font-size: 20px;
  font-weight: 700;
}
```

> „Und jetzt schlagen Sie Ihre Liste auf. Jeder Name darin ist eine Adresse, an die Sie etwas schicken können. Deshalb haben wir sie angelegt."

Reihum: jede Person greift ein Element **aus ihrer Liste** heraus und gibt ihm eine Eigenschaft.

> [!danger] Der häufigste Fehler des Moduls beginnt hier
> `#` und `.` werden vertauscht, und der Name im Selektor stimmt nicht mit der `id` im HTML überein. Beides erzeugt **keine** Fehlermeldung – es passiert schlicht nichts.
>
> Sofort die Diagnoseregel mitgeben: „Wenn nichts passiert, lesen Sie den Namen im CSS und den Namen im HTML **laut** nebeneinander vor. Nicht ansehen, vorlesen. Fast immer hört man es."

### Warum drei Wege?

Die Frage wird gestellt, Antworten werden gesammelt, dann aufgelöst:

> „Einer würde reichen, aber dann müssten Sie jedes Element einzeln beschreiben. Mit den drei Wegen sagen Sie einmal, wie Knöpfe grundsätzlich aussehen, und danach nur noch die Abweichungen. Das ist der ganze Trick."

## Wenn zwei Regeln dasselbe Element treffen

Hier kommt die Frage, sie kommt zuverlässig: *Warum gewinnt Grün gegen Blau?*

Antwort als Merksatz an die Tafel:

```
Je genauer der Selektor, desto stärker.
#id   schlägt   .klasse   schlägt   element
```

> „Beide Regeln treffen zu, beide sagen etwas über die Hintergrundfarbe. Dann gewinnt die genauere. `button` meint alle, `.knopf-anzeige` meint zwei bestimmte – also ist sie genauer und setzt sich durch. Das ist die einzige Regel dazu, die in diesem Kurs gebraucht wird."

Bei gleich genauen Selektoren gewinnt die Regel, die **weiter unten** in der Datei steht.

Ein Zustand: `:hover`

```css
button:hover {
  background-color: #3d6b91;
}
```

Der Doppelpunkt heißt: nur in diesem Zustand – also nur, solange die Maus darauf steht. Eine Oberfläche, die auf die Maus reagiert, fühlt sich lebendig an.

## Das Boxmodell

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

Bildvergleich: Ein gerahmtes Bild an der Wand. Das Passepartout zwischen Bild und Rahmen ist `padding`, der Rahmen ist `border`, der Abstand zum Nachbarbild ist `margin`.

Das Boxmodell wird am Anzeigebereich in fünf Schritten durchgespielt. **Nach jedem Schritt speichern und hinsehen.** Nicht vorgreifen, auch wenn es zäh wirkt – hier entsteht das Verständnis.

**Schritt 1 – nur der Rahmen**

```css
#anzeige {
  background-color: #ffffff;
  border: 2px solid #cccccc;
}
```

> „Drei Angaben in einer Zeile: wie dick, welche Art, welche Farbe. Immer in dieser Reihenfolge. `solid` heißt durchgezogen – es gibt auch gestrichelt, aber das brauchen wir nicht."

**Schritt 2 – Innenabstand**

```css
  padding: 20px;
```

> „Sehen Sie, wie der Text vom Rahmen wegrückt? Der Rahmen bleibt, wo er ist, der Inhalt rutscht nach innen. Deshalb wird die Kiste größer."

**Schritt 3 – Außenabstand**

```css
  margin: 24px;
```

> „Und jetzt rückt die ganze Kiste weg – von der Überschrift darüber und vom Rand. Innen ändert sich nichts."

**Schritt 4 – runde Ecken**

```css
  border-radius: 12px;
```

**Schritt 5 – Breite begrenzen**

```css
  max-width: 400px;
```

> „`max-width` heißt: höchstens so breit. Ziehen Sie das Fenster mal schmaler." – Fenster verkleinern lassen. „Die Kiste wird mit. Bei `width` wäre sie stur geblieben und aus dem Fenster gelaufen. Deshalb im Kurs immer `max-width`."

### Die Zahl davor

> „Eine Zahl bedeutet: alle vier Seiten gleich. Sie können auch zwei schreiben – dann gilt die erste für oben und unten, die zweite für links und rechts."

```css
button {
  padding: 8px 16px;
}
```

Mehr nicht. Die Vier-Werte-Form kommt nicht vor.

Reihum: jede Person macht dasselbe an einem selbst gewählten Element aus ihrer `id`-Liste – Rahmen, Innenabstand, Außenabstand, in dieser Reihenfolge, mit Hinsehen dazwischen.

> [!warning] Der klassische Verwechslungsfall
> „Ich wollte mehr Luft **im** Kasten und habe `margin` genommen – jetzt ist der Kasten weiter weg, aber innen genauso eng." Nicht neu erklären, sondern auf den Merksatz zeigen und die Person selbst korrigieren lassen.

## Flexbox: Dinge anordnen

Ziel ist genau ein Anwendungsfall – Dinge nebeneinander oder untereinander anordnen.

### Untereinander mit Abstand

```css
#eingabe {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-width: 400px;
}
```

| Zeile | Bedeutung |
|---|---|
| `display: flex` | „Ich kümmere mich um die Anordnung meiner Kinder." |
| `flex-direction: column` | untereinander. `row` heißt nebeneinander und ist die Voreinstellung. |
| `gap: 12px` | Abstand zwischen den Kindern – einmal gesetzt, gilt überall |

> [!tip] Warum `gap` besser ist als `margin`
> Mit `margin` müssten Sie jedem Element einzeln einen Abstand geben und beim letzten wieder wegnehmen. `gap` erledigt das in einer Zeile. Genau dafür gibt es Flexbox.

### Nebeneinander – und warum eine eigene Kiste nötig ist

Zuerst probieren lassen:

```css
#anzeige {
  display: flex;
  flex-direction: row;
}
```

Das Ergebnis ist unbrauchbar – Frage, Antwort und beide Knöpfe stehen in einer Reihe.

> „Genau das ist das Problem: Ich will nicht **alles** nebeneinander, sondern nur die beiden Knöpfe. Und dafür brauche ich eine Kiste um genau diese beiden. Erinnern Sie sich an das unsichtbare `div` aus [[K1 HTML – die Struktur]], von dem keiner wusste, wozu es gut ist? Jetzt wissen wir es."

In die `index.html`, die beiden Knöpfe umschließen:

```html
<div id="knopf-leiste">
  <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
  <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
</div>
```

**Ins Heft:** `knopf-leiste` als elfter Eintrag.

```css
#anzeige {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

#knopf-leiste {
  display: flex;
  gap: 12px;
}
```

> „`row` ist die Voreinstellung – wenn Sie nichts schreiben, stehen die Dinge nebeneinander. Deshalb steht bei der Knopfleiste keine Richtung."

### Ausrichten

Nur an der Knopfleiste, jeweils ausprobieren und wieder zurücknehmen:

```css
#knopf-leiste {
  display: flex;
  gap: 12px;
  justify-content: center;
  align-items: center;
}
```

> „Zwei Wörter, die man dauernd verwechselt. `justify-content` arbeitet **in** Laufrichtung – bei einer Reihe also links, mittig, rechts. `align-items` arbeitet **quer dazu** – bei einer Reihe also oben, mittig, unten."

Werte durchprobieren: `flex-start`, `center`, `flex-end`, `space-between`. Nach jedem Wert hinsehen.

> [!tip] Wenn die Verwechslung bleibt
> Nicht bekämpfen. Die Merkhilfe für den Kurs lautet: „Ausprobieren ist schneller als merken. Schreiben Sie `center` hin und schauen Sie, ob es das war, was Sie wollten." Das ist ehrlich und in der Praxis genau das, was auch Profis tun.

## Die eigene Gestaltung

Jetzt wird selbst gearbeitet. **Pflicht sind drei Aufgaben, danach freie Hand.** Wichtig ist nur: Nach jeder Änderung hinsehen, und wenn etwas nicht wirkt, den Namen laut vorlesen.

**Pflicht:**

1. Die Eingabefelder gestalten – Rahmen, Innenabstand, Schriftgröße
2. Ein `:hover` für die Knöpfe
3. Die eigenen drei Farben umsetzen: Hintergrund, Karte, Knöpfe

Zu `:hover` gemeinsam:

```css
button:hover {
  background-color: #3d6b91;
}
```

> „Der Doppelpunkt heißt: nur in diesem Zustand. Also nur, solange die Maus darauf steht."

Die Kursleitung geht herum und achtet auf:

- Lesbarkeit des Kontrasts
- ob wirklich nach jeder Änderung hingesehen wird
- ob jemand anfängt, Dinge aus dem Internet zu kopieren – dann freundlich einfangen: „Alles, was Sie brauchen, steht auf Ihrem Merkblatt. Was Sie kopieren, können Sie später nicht reparieren."

> [!note] Bewusst unterschiedliche Ergebnisse
> Am Ende sollen sich die drei Anwendungen deutlich unterscheiden. Das ist der Punkt: Ab hier ist es **die eigene** Anwendung. Wer alles gleich haben will, hat das Modul missverstanden.

## Absichtlicher Fehler: Semikolon und Klammer

### Die erste Variante: das fehlende Semikolon

Mitten in der Datei ein Semikolon löschen:

```css
#anzeige {
  background-color: #ffffff
  border: 2px solid #cccccc;
  padding: 20px;
}
```

Speichern, neu laden.

**Beobachtbar:** Der Hintergrund **und** der Rahmen fehlen. `padding` wirkt noch.

> „Interessant, oder? Es fehlt nicht nur eine Zeile, sondern zwei. Ohne Semikolon weiß das Programm nicht, wo die eine Erklärung aufhört, und liest die nächste Zeile als Teil derselben. Das Ergebnis ergibt keinen Sinn, also wirft es beides weg und macht danach normal weiter."

### Die zweite Variante: die fehlende Klammer

```css
#anzeige {
  background-color: #ffffff;
```

> „Und das hier ist die schlimmere Sorte. Jetzt hört die Regel nie auf, und **alles**, was Sie darunter noch schreiben, verschwindet. Wenn Ihre letzten fünf Änderungen alle nicht wirken, suchen Sie nicht bei den fünf Änderungen. Suchen Sie darüber."

Beide Varianten selbst einbauen, hinsehen, reparieren.

## Die zwei Diagnosefragen

```
Eine Regel wirkt nicht      → Namen laut vorlesen, # und . prüfen
ALLE Regeln ab hier nicht   → darüber suchen: Semikolon oder Klammer
```

| Was zu sehen ist | Wahrscheinliche Ursache |
|---|---|
| Nichts passiert, keine Fehlermeldung | Selektorname stimmt nicht mit der `id` überein |
| Falsches Element ändert sich | `#` und `.` vertauscht |
| Zwei Regeln, die stärkere gewinnt nicht wie erwartet | Spezifität: `#id` schlägt `.klasse` schlägt `element` |
| Kasten wird beim Verkleinern abgeschnitten | `width` statt `max-width` |
| Zu viel steht nebeneinander | `display: flex` sitzt auf dem falschen Bereich |
| Abstand innen gewünscht, außen entstanden | `margin` statt `padding` |

## Typische Stolperstellen

> [!warning]
> - Fehlendes Semikolon oder fehlende geschweifte Klammer. Alles darunter wirkt dann nicht.
> - `#` und `.` werden verwechselt.
> - Der Selektorname stimmt nicht mit der `id` in der HTML-Datei überein. Die Liste aus [[K1 HTML – die Struktur]] zum Abgleich benutzen.
> - Farben als Namen und als Hex-Werte gemischt. Im Kurs auf Hex festlegen.
> - `width` statt `max-width` – der Kasten läuft dann aus dem Fenster.
> - `margin` statt `padding`, wenn mehr Luft **innen** gewünscht ist.

## Stand am Ende des Moduls

- [ ] Die erste Regel geschrieben und die Anatomie einer Regel benannt
- [ ] Alle Knöpfe über den Typselektor gestaltet, eine Gruppe über die Klasse, einzelne über die `id`
- [ ] Den Merksatz zur Spezifität erklären können
- [ ] Das Boxmodell am eigenen Element durchgespielt, `padding` und `margin` unterschieden
- [ ] Der Eingabebereich mit Flexbox angeordnet, die Knopfleiste als elfter `id` im Heft
- [ ] Eigene Farbwahl getroffen, Kontrast aus zwei Metern lesbar
- [ ] Beide Fehlerarten eingebaut, erkannt und repariert

## Verknüpfung

Merkblatt: [[K2 Merkblatt]] · Übungen: [[K2 Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

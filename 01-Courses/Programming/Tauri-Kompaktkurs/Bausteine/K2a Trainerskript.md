---
baustein: K2
typ: trainerskript
titel: CSS – das Aussehen – Trainerskript
ue: 5
tag: 1-2
dauer: 225 min in zwei Blöcken
zielgruppe: 3 Teilnehmende ohne Vorkenntnisse
tags: [tauri/kompaktkurs/trainerskript, css]
status: entwurf
---

# K2 – Trainerskript

> [!abstract] Zweck dieses Dokuments
> Zum Mitlesen während des Unterrichts. Alles in Zitatform ist **Sprechtext** und kann wörtlich verwendet werden. Alles andere sind Handlungsanweisungen an die Kursleitung.

> [!important] Der motivatorisch wichtigste Baustein
> Hier wird aus einer Sammlung von Feldern zum ersten Mal etwas, das man jemandem zeigen möchte. Der optische Sprung ist der größte des ganzen Kurses. Planen Sie bewusst Momente ein, in denen nur hingesehen und nichts getippt wird.

## Zeitraster

Der Baustein läuft über zwei Tage. **Block A schließt mit einem vorzeigbaren Stand ab**, das ist bei der Aufteilung wichtiger als eine gleichmäßige Verteilung.

### Block A – Tag 1, letzte 2 UE (90 min)

| Zeit | Abschnitt | Format |
|---|---|---|
| 00–30 | 1. Die erste Regel | gemeinsam |
| 30–70 | 2. Drei Wege, ein Element zu treffen | gemeinsam + reihum |
| 70–90 | Tagesabschluss: Farben festlegen, Stand sichern | selbstständig |

### Block B – Tag 2, erste 3 UE (135 min)

| Zeit | Abschnitt | Format |
|---|---|---|
| 000–045 | 3. Boxmodell | gemeinsam, langsam |
| 045–090 | 4. Flexbox | gemeinsam |
| 090–120 | 5. Die Anwendung gestalten | selbstständig |
| 120–135 | 6. Absichtlicher Fehler | gemeinsam |

> [!warning] Abweichung vom Konzeptdokument
> [[K2 CSS – das Aussehen]] summiert 240 Minuten bei 225 verfügbaren. Gekürzt sind Abschnitt 4 (60 → 45) und Abschnitt 5 (45 → 30). Abschnitt 3 bleibt bei 45 Minuten – er braucht die Zeit.
>
> Die freie Gestaltung aus Abschnitt 5 ist der einzige Inhalt, der später noch einmal vorkommt: [[K6 Feinschliff]] widmet ihr 45 eigene Minuten. Deshalb ist sie hier die richtige Stelle zum Kürzen.

---

## Vorlauf

**Ausgangsstand:** Ergebnis aus [[K1 HTML – die Struktur]]. Vollständige Oberfläche, zehn `id`-Namen im Heft, `style.css` leer.

- [ ] Alle drei Anwendungen laufen
- [ ] `src/style.css` ist im Editor geöffnet – ab jetzt sind zwei Dateien gleichzeitig offen
- [ ] Hex-Palette ausgedruckt auf dem Tisch (siehe [[Anhang Vorbereitung durch die Kursleitung]])
- [ ] Notizhefte mit der `id`-Liste liegen bereit – sie wird heute zum ersten Mal benutzt
- [ ] Zwischenstand `stand-k2` bereit

> [!tip] Zwei Dateien nebeneinander
> Spätestens jetzt lohnt der zweite Editor-Bereich: `index.html` und `style.css` gleichzeitig sichtbar. Wer zwischen Tabs wechseln muss, verliert den Zusammenhang zwischen `id` und Selektor.

---

# Block A – Tag 1

## 1. Die erste Regel (30 min)

**Ziel:** Der erste sichtbare Erfolg, und der Aufbau einer Regel sitzt.

### 1a Wo das Aussehen herkommt (5 min)

Zeigen Sie die Zeile im Kopf der `index.html`:

```html
<link rel="stylesheet" href="style.css" />
```

> „Diese Zeile war von Anfang an da. Sie sagt: Zu dieser Datei gehört ein Anstrich, und der steht in `style.css`. Bisher war die Datei leer, deshalb sah alles nach Werkseinstellung aus. Das ändern wir jetzt."

### 1b Die erste Regel (10 min)

Gemeinsam in die leere `style.css` tippen:

```css
body {
  background-color: #f4f4f4;
}
```

Speichern. Hinsehen. **Pause machen.** Nichts sagen, bis jemand reagiert.

> „Das ist der Moment, auf den dieser Kurs hinarbeitet. Sie haben eine Zeile in eine bisher leere Datei geschrieben, und die Anwendung sieht anders aus."

### 1c Die Anatomie einer Regel (10 min)

Tafelbild, bleibt den ganzen Baustein stehen:

```
body { background-color: #f4f4f4; }
 │      │                  │      │
 │      │                  │      └─ Semikolon: beendet die Erklärung
 │      │                  └──────── Wert: welcher
 │      └─────────────────────────── Eigenschaft: was
 └────────────────────────────────── Selektor: wen betrifft es
```

Vokabeln laut sprechen lassen: **Selektor, Eigenschaft, Wert.**

> „Jede einzelne Zeile, die Sie heute schreiben, hat diesen Aufbau. Wen betrifft es, was soll anders sein, wie soll es sein. Drei Fragen, immer dieselben."

Zu den Hex-Farben in zwei Sätzen:

> „Die Raute mit sechs Zeichen ist eine Farbe: zwei Stellen Rot, zwei Stellen Grün, zwei Stellen Blau, jeweils von `00` bis `ff`. `#ffffff` ist Weiß, `#000000` ist Schwarz. Sie müssen das nicht rechnen können – Sie haben eine Palette auf dem Tisch."

> [!note] Kursregel Farben
> Ausschließlich Hex-Werte, keine Farbnamen wie `red`. Begründung an die Gruppe: „Es gibt beides, aber wenn drei Leute mischen, sieht die Datei aus wie ein Flohmarkt. Wir bleiben bei einer Schreibweise."

### 1d Reihum (5 min)

Jede Person ändert die Hintergrundfarbe auf eine selbst gewählte, sagt den Hex-Wert laut und zeigt das Ergebnis.

---

## 2. Drei Wege, ein Element zu treffen (40 min)

**Ziel:** Typ-, Klassen- und `id`-Selektor unterscheiden – und wissen, welcher gewinnt.

### 2a Alle auf einmal: der Typselektor (10 min)

```css
button {
  background-color: #2a4d69;
  color: #ffffff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}
```

Speichern. **Alle drei** Knöpfe ändern sich gleichzeitig.

> „Ich habe `button` geschrieben, ohne Raute, ohne Punkt. Das heißt: alle Knöpfe, die es gibt und die es je geben wird. Wenn Sie morgen einen vierten Knopf einbauen, sieht der sofort genauso aus."

`cursor: pointer` mit der Maus vorführen:

> „Und das hier ist eine Kleinigkeit mit großer Wirkung: Der Mauszeiger wird zur Hand. Ohne das wirkt ein Knopf wie ein Bild. Es ist die billigste Verbesserung, die es gibt."

### 2b Eine Gruppe: der Klassenselektor (12 min)

Zurück in die `index.html` – auf die beiden Anzeige-Knöpfe zeigen:

```html
<button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
<button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
```

> „Erinnern Sie sich an das zweite Namensschild von gestern? Jetzt kommt es zum Einsatz. Diese beiden Knöpfe gehören zusammen – es sind die zum Blättern. Der wichtige Knopf ist der andere, der Karten anlegt. Also gebe ich den beiden eine andere Farbe, aber nicht jedem einzeln."

```css
.knopf-anzeige {
  background-color: #6b8f71;
}
```

Der Punkt wird ausdrücklich betont:

> „Punkt heißt Klasse. Die Klasse steht im HTML ohne Punkt, im CSS mit Punkt. Das ist verwirrend und lässt sich nicht wegerklären – es ist einfach so."

**Hier kommt die Frage: Warum gewinnt Grün gegen Blau?** Sie kommt zuverlässig. Antwort als Merksatz an die Tafel:

```
Je genauer der Selektor, desto stärker.
#id   schlägt   .klasse   schlägt   element
```

> „Beide Regeln treffen zu, beide sagen etwas über die Hintergrundfarbe. Dann gewinnt die genauere. `button` meint alle, `.knopf-anzeige` meint zwei bestimmte – also ist sie genauer und setzt sich durch. Das ist die einzige Regel dazu, die Sie in diesem Kurs brauchen."

### 2c Genau eines: der `id`-Selektor (10 min)

Jetzt wird die Heftliste gebraucht.

```css
#anzeige {
  background-color: #ffffff;
}

#karte-frage {
  font-size: 20px;
  font-weight: 700;
}
```

> „Und jetzt schlagen Sie Ihre Liste von gestern auf. Jeder Name darin ist eine Adresse, an die Sie jetzt etwas schicken können. Deshalb haben wir sie angelegt."

Reihum: jede Person greift ein Element **aus ihrer Liste** heraus und gibt ihm eine Eigenschaft.

> [!danger] Der häufigste Fehler des Bausteins beginnt hier
> `#` und `.` werden vertauscht, und der Name im Selektor stimmt nicht mit der `id` im HTML überein. Beides erzeugt **keine** Fehlermeldung – es passiert schlicht nichts.
>
> Sofort die Diagnoseregel mitgeben: „Wenn nichts passiert, lesen Sie den Namen im CSS und den Namen im HTML **laut** nebeneinander vor. Nicht ansehen, vorlesen. Fast immer hört man es."

### 2d Die Frage, die gestellt werden muss (8 min)

> „Warum gibt es drei Wege? Wäre einer nicht einfacher?"

Antworten sammeln, dann auflösen und an die Tafel:

| Selektor | Schreibweise | Trifft | Typischer Einsatz |
|---|---|---|---|
| Typ | `button` | alle dieser Sorte | Grundaussehen aller Knöpfe |
| Klasse | `.knopf-anzeige` | eine Gruppe | mehrere Elemente sollen gleich aussehen |
| `id` | `#karte-frage` | genau eines | ein bestimmtes Element, sonst nichts |

> „Einer würde reichen, aber dann müssten Sie jedes Element einzeln beschreiben. Mit den drei Wegen sagen Sie einmal, wie Knöpfe grundsätzlich aussehen, und danach nur noch die Abweichungen. Das ist der ganze Trick."

---

## Tagesabschluss Block A (20 min)

- Jede Person legt ihre drei Farben fest: Hintergrund, Karte, Knöpfe. In der Palette aussuchen, im Heft notieren.
- Kurz gegenseitig zeigen.
- Stand sichern.

> „Sie haben heute mit HTML angefangen und hören mit einer Anwendung auf, die nach etwas aussieht. Morgen früh kümmern wir uns um die Abstände – das ist der Teil, der aus ‚sieht nach etwas aus' ein ‚sieht fertig aus' macht."

> [!tip] Kontrastprüfung nebenbei
> Wenn jemand hellgrauen Text auf weißem Grund wählt: nicht verbieten, sondern hinsehen lassen. „Können Sie das aus zwei Metern Entfernung lesen?" Das ist die Miniatur-Lektion in Barrierefreiheit, die in [[K6 Feinschliff]] wieder aufgegriffen wird.

---

# Block B – Tag 2

## 3. Boxmodell (45 min)

**Ziel:** `padding`, `border` und `margin` auseinanderhalten. Der Abschnitt, der bei Anfängern am meisten Zeit braucht und sie auch bekommen soll.

### 3a Das Bild (10 min)

Tafelbild, groß:

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

**Merksatz an die Tafel, wortwörtlich:**

> **`padding` schiebt den Inhalt vom Rahmen weg.
> `margin` schiebt den Rahmen von den Nachbarn weg.**

> „Stellen Sie sich ein gerahmtes Bild vor. Das Passepartout zwischen Bild und Rahmen ist `padding`. Der Rahmen ist `border`. Und der Abstand zum nächsten Bild an der Wand ist `margin`."

### 3b Schritt für Schritt am Anzeigebereich (25 min)

Eine Eigenschaft nach der anderen. **Nach jedem Schritt speichern und hinsehen.** Nicht vorgreifen, auch wenn es zäh wirkt – hier entsteht das Verständnis.

Schritt 1, nur der Rahmen:

```css
#anzeige {
  background-color: #ffffff;
  border: 2px solid #cccccc;
}
```

> „Drei Angaben in einer Zeile: wie dick, welche Art, welche Farbe. Immer in dieser Reihenfolge. `solid` heißt durchgezogen – es gibt auch gestrichelt, aber das brauchen wir nicht."

Schritt 2, Innenabstand:

```css
  padding: 20px;
```

> „Sehen Sie, wie der Text vom Rahmen wegrückt? Der Rahmen bleibt, wo er ist, der Inhalt rutscht nach innen. Deshalb wird die Kiste größer."

Schritt 3, Außenabstand:

```css
  margin: 24px;
```

> „Und jetzt rückt die ganze Kiste weg – von der Überschrift darüber und vom Rand. Innen ändert sich nichts."

Schritt 4, runde Ecken:

```css
  border-radius: 12px;
```

Schritt 5, Breite begrenzen:

```css
  max-width: 400px;
```

> „`max-width` heißt: höchstens so breit. Ziehen Sie das Fenster mal schmaler." — Fenster verkleinern lassen. „Die Kiste wird mit. Bei `width` wäre sie stur geblieben und aus dem Fenster gelaufen. Deshalb im Kurs immer `max-width`."

### 3c Die Zahl davor (5 min)

> „Eine Zahl bedeutet: alle vier Seiten gleich. Sie können auch zwei schreiben – dann gilt die erste für oben und unten, die zweite für links und rechts. Das brauchen wir gleich bei den Knöpfen, weil die seitlich mehr Luft vertragen als oben und unten."

```css
button {
  padding: 8px 16px;
}
```

Mehr nicht. Die Vier-Werte-Form kommt nicht vor.

### 3d Reihum (5 min)

Jede Person macht dasselbe an einem selbst gewählten Element aus ihrer `id`-Liste: Rahmen, Innenabstand, Außenabstand, in dieser Reihenfolge, mit Hinsehen dazwischen.

> [!warning] Der klassische Verwechslungsfall
> „Ich wollte mehr Luft **im** Kasten und habe `margin` genommen – jetzt ist der Kasten weiter weg, aber innen genauso eng." Nicht neu erklären, sondern auf den Merksatz zeigen und die Person selbst korrigieren lassen.

---

## 4. Flexbox (45 min)

**Ziel:** Genau ein Anwendungsfall – Dinge nebeneinander oder untereinander anordnen.

### 4a Untereinander mit Abstand (12 min)

```css
#eingabe {
  display: flex;
  flex-direction: column;
  gap: 12px;
  max-width: 400px;
}
```

Speichern, hinsehen.

> „Drei Zeilen, und der Eingabebereich sortiert sich. `display: flex` heißt: Ich kümmere mich jetzt um die Anordnung meiner Kinder. `flex-direction: column` heißt: untereinander. Und `gap` ist der Abstand dazwischen – einmal gesetzt, gilt für alle Zwischenräume."

`gap` ausdrücklich gegen `margin` abgrenzen:

> „Vorher hätten Sie jedem Element einzeln einen Außenabstand geben müssen und beim letzten wieder wegnehmen. `gap` erledigt das in einer Zeile. Das ist der Grund, warum es Flexbox gibt."

### 4b Nebeneinander (15 min)

Jetzt kommt der Rückbezug auf [[K1 HTML – die Struktur]]. Zuerst probieren lassen:

```css
#anzeige {
  display: flex;
  flex-direction: row;
}
```

Das Ergebnis ist unbrauchbar – Frage, Antwort und beide Knöpfe stehen in einer Reihe.

> „Genau das ist das Problem: Ich will nicht **alles** nebeneinander, sondern nur die beiden Knöpfe. Und dafür brauche ich eine Kiste um genau diese beiden. Erinnern Sie sich an gestern, als das `div` unsichtbar war und keiner wusste, wozu es gut ist? Jetzt wissen wir es."

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

### 4c Ausrichten (13 min)

Nur an der Knopfleiste, jeweils ausprobieren und wieder zurücknehmen:

```css
#knopf-leiste {
  display: flex;
  gap: 12px;
  justify-content: center;
  align-items: center;
}
```

> „Zwei Wörter, die man dauernd verwechselt. `justify-content` arbeitet **in Laufrichtung** – bei einer Reihe also links, mittig, rechts. `align-items` arbeitet **quer dazu** – bei einer Reihe also oben, mittig, unten."

Werte durchprobieren lassen: `flex-start`, `center`, `flex-end`, `space-between`. Nach jedem Wert hinsehen.

> [!tip] Wenn die Verwechslung bleibt
> Nicht bekämpfen. Die Merkhilfe für den Kurs lautet: „Ausprobieren ist schneller als merken. Schreiben Sie `center` hin und schauen Sie, ob es das war, was Sie wollten." Das ist ehrlich und in der Praxis genau das, was auch Profis tun.

### 4d CSS Grid in einem Satz (5 min)

Wird gefragt werden, sobald jemand nachschlägt:

> „Es gibt ein zweites System für Anordnung, das heißt Grid und arbeitet mit Zeilen und Spalten wie eine Tabelle. Für unsere Oberfläche brauchen wir es nicht, und zwei Systeme gleichzeitig zu lernen wäre in dieser Woche zu viel. Es steht auf der Liste für den Anschlusskurs."

---

## 5. Die Anwendung gestalten (30 min)

**Ziel:** Eigenständiges Anwenden. Freie Farbwahl.

Vorgabe an die Gruppe:

> „Sie haben jetzt alles beisammen. Ich gebe Ihnen drei Pflichtaufgaben und danach freie Hand. Wichtig ist nur: Nach jeder Änderung hinsehen, und wenn etwas nicht wirkt, den Namen laut vorlesen."

**Pflicht:**
1. Die Eingabefelder gestalten – Rahmen, Innenabstand, Schriftgröße
2. Ein `:hover` für die Knöpfe
3. Die eigenen drei Farben aus Block A umsetzen

Zu `:hover` gemeinsam:

```css
button:hover {
  background-color: #3d6b91;
}
```

> „Der Doppelpunkt heißt: nur in diesem Zustand. Also nur, solange die Maus darauf steht. Das ist die zweite Kleinigkeit mit großer Wirkung – eine Oberfläche, die auf die Maus reagiert, fühlt sich lebendig an."

Danach freie Arbeit. Sie gehen herum und achten auf:

- Lesbarkeit des Kontrasts
- ob wirklich nach jeder Änderung hingesehen wird
- ob jemand anfängt, Dinge aus dem Internet zu kopieren – dann freundlich einfangen: „Alles, was Sie brauchen, steht auf Ihrem Handout. Was Sie kopieren, können Sie morgen nicht reparieren."

> [!note] Bewusst unterschiedliche Ergebnisse
> Am Ende sollen sich die drei Anwendungen deutlich unterscheiden. Das ist der Punkt: Ab hier ist es **die eigene** Anwendung. Wer alles gleich haben will, hat den Baustein missverstanden.

---

## 6. Absichtlicher Fehler (15 min)

**Ziel:** Verstehen, warum ein einzelnes fehlendes Zeichen alles Folgende lahmlegt.

### 6a Vorführung (6 min)

Auf Ihrem Gerät, mitten in der Datei ein Semikolon löschen:

```css
#anzeige {
  background-color: #ffffff
  border: 2px solid #cccccc;
  padding: 20px;
}
```

Speichern, neu laden.

Beobachtbar: Der Hintergrund **und** der Rahmen fehlen. `padding` wirkt noch.

> „Interessant, oder? Es fehlt nicht nur eine Zeile, sondern zwei. Ohne Semikolon weiß das Programm nicht, wo die eine Erklärung aufhört, und liest die nächste Zeile als Teil derselben. Das Ergebnis ergibt keinen Sinn, also wirft es beides weg und macht danach normal weiter."

Zweite Variante zeigen – die geschweifte Klammer:

```css
#anzeige {
  background-color: #ffffff;
```

> „Und das hier ist die schlimmere Sorte. Jetzt hört die Regel nie auf, und **alles**, was Sie darunter noch schreiben, verschwindet. Wenn Ihre letzten fünf Änderungen alle nicht wirken, suchen Sie nicht bei den fünf Änderungen. Suchen Sie darüber."

### 6b Jede Person selbst (6 min)

Beide Varianten einbauen, hinsehen, reparieren.

### 6c Abschluss (3 min)

Die Diagnoseregel des Bausteins an die Tafel:

```
Eine Regel wirkt nicht      → Namen laut vorlesen, # und . prüfen
ALLE Regeln ab hier nicht   → darüber suchen: Semikolon oder Klammer
```

> „Morgen kommt der schwerste Teil der Woche. Sie werden einen halben Tag lang nichts im Fenster sehen, weil wir die Sprache lernen, mit der die Anwendung später denkt. Ich sage Ihnen das vorher, damit Sie wissen: Es ist so geplant und liegt nicht an Ihnen."

---

## Kontrollpunkte

| Nach Abschnitt | Woran Sie erkennen, dass es sitzt |
|---|---|
| 1 | Jede Person benennt Selektor, Eigenschaft und Wert an einer beliebigen Regel |
| 2 | Jede Person sagt, welcher der drei Selektoren gewinnt, wenn zwei zutreffen |
| 3 | Jede Person erklärt den Unterschied zwischen `padding` und `margin` in eigenen Worten |
| 4 | Jede Person kann sagen, warum die Knopfleiste ein eigenes `div` braucht |
| 6 | Jede Person kennt die zwei Diagnosefragen |

**Lernstandsgespräch nach K2** (aus [[00 Kompaktkonzept Tauri Grundlagen]]):

> „Ändern Sie die Hintergrundfarbe der Karte und erklären Sie, welche Datei Sie dafür anfassen."

Erwartet: `style.css`, Regel `#anzeige`, Eigenschaft `background-color`. Wer stattdessen in die `index.html` geht, hat die Aufteilung aus [[K0 Ankommen und erste eigene Änderung]] nicht verinnerlicht – dann fünf Minuten investieren, das trägt bis K7.

---

## Wenn es klemmt

| Symptom | Wahrscheinliche Ursache | Sofortmaßnahme |
|---|---|---|
| Eine Regel wirkt nicht | `#`/`.` vertauscht oder Name stimmt nicht | Namen im CSS und im HTML **laut** nebeneinander vorlesen |
| Alle Regeln ab einer Stelle wirken nicht | fehlendes Semikolon oder fehlende `}` | oberhalb der ersten wirkungslosen Regel suchen |
| Zwei Regeln widersprechen sich | Spezifität | Merksatz: `#id` schlägt `.klasse` schlägt `element` |
| Der Kasten wird beim Verkleinern abgeschnitten | `width` statt `max-width` | Kursregel: immer `max-width` |
| Flexbox ordnet zu viel an | `display: flex` sitzt auf dem falschen Bereich | „Wer ist der Vater der Dinge, die nebeneinander sollen?" |
| Text kaum lesbar | zu wenig Kontrast | aus zwei Metern lesen lassen |
| Person kopiert CSS aus dem Netz | Ungeduld | freundlich einfangen, Handout reicht aus |
| Person ist deutlich schneller | – | Zusatzaufgaben aus [[K2c Übungsblatt]], **kein** JavaScript |

## Übergabe an K3

- [ ] `src/style.css` vollständig, jede Person mit eigener Farbwahl
- [ ] `index.html` enthält jetzt `div#knopf-leiste`
- [ ] Elf `id`-Namen im Heft
- [ ] Stand als `stand-k2` gesichert
- [ ] Angekündigt, dass K3 optisch nichts zeigt

## Verknüpfung

Konzept: [[K2 CSS – das Aussehen]] · Handout: [[K2b Handout]] · Übungen: [[K2c Übungsblatt]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

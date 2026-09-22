---
baustein: K1
typ: trainerskript
title: HTML – die Struktur – Trainerskript
ue: 4
kurstag: 1
dauer: 180 min
zielgruppe: 3 Teilnehmende ohne Vorkenntnisse
tags: [tauri/kompaktkurs/trainerskript, html]
status: draft
---

# K1 – Trainerskript

> [!abstract] Zweck dieses Dokuments
> Zum Mitlesen während des Unterrichts. Alles in Zitatform ist **Sprechtext** und kann wörtlich verwendet werden. Alles andere sind Handlungsanweisungen an die Kursleitung.

> [!important] Das eigentliche Ergebnis dieses Bausteins
> Nicht die fertige Oberfläche – die könnte man auch austeilen. Das Ergebnis ist die **`id`-Liste im Notizheft jeder Person**. Ohne sie steht [[K4 JavaScript im Fenster]] still. Abschnitt 3 und der Praxisteil sind deshalb nicht verhandelbar, auch wenn die Zeit knapp wird.

## Zeitraster

| Zeit | Abschnitt | Format |
|---|---|---|
| 000–030 | 1. Wie ein Element aussieht | Tafelbild + gemeinsam am Bildschirm |
| 030–075 | 2. Die Elemente durchgehen | reihum, jede Person zwei Elemente |
| 075–105 | 3. `id` als Name | Gespräch, Heftarbeit |
| 105–165 | 4. Die Oberfläche bauen | gemeinsam, in vier Etappen |
| 165–180 | 5. Absichtlicher Fehler | gemeinsam |

Pausen liegen zwischen den Abschnitten, nicht innerhalb. Abschnitt 4 wird **nicht** geteilt.

---

## Vorlauf

**Ausgangsstand:** Ergebnis aus [[K0 Ankommen und erste eigene Änderung]]. `src/index.html` enthält Grundgerüst plus eine `<h1>` mit dem Namen der jeweiligen Person. `style.css` und `app.js` sind leer.

- [ ] Alle drei Anwendungen laufen, Editor links, Fenster rechts
- [ ] Die Notizhefte liegen aufgeschlagen daneben – heute wird darin geschrieben
- [ ] Vorlage „Liste der `id`-Namen" ausgeteilt (siehe [[Anhang Vorbereitung durch die Kursleitung]], Abschnitt 5)
- [ ] Zwischenstand `stand-k1` liegt bereit, falls jemand blockiert

> [!tip] Der Morgenbefehl steht auf der Karte
> ```nu
> toolbox enter tauri-dev
> cd ~/Projekte/lernkarten
> cargo tauri dev
> ```
> Nicht diktieren. Auf die [[Anhang Befehlskarte]] zeigen und tippen lassen. Ab heute schlagen die Teilnehmenden selbst nach.

---

## 1. Wie ein Element aussieht (30 min)

**Ziel:** Öffnendes Tag, Inhalt, schließendes Tag – und Verschachtelung als Prinzip.

### 1a Die Anatomie (15 min)

Tafelbild, groß, bleibt den ganzen Tag stehen:

```
<p>Hallo</p>
 │  │    │
 │  │    └─ Ende-Tag: gleicher Name mit Schrägstrich
 │  └────── Inhalt: was im Fenster erscheint
 └───────── Start-Tag: sagt, was für ein Ding das ist
```

> „Gestern haben Sie einen Text zwischen zwei Marken geschrieben, ohne dass wir gesagt haben, was die Marken bedeuten. Das holen wir jetzt nach. Eine Marke sagt: Hier fängt eine Überschrift an. Die andere sagt: Hier hört sie auf. Zusammen mit dem Text dazwischen heißt das ein **Element**."

Begriff an die Tafel: **Element = Start-Tag + Inhalt + Ende-Tag.**

> „Sie haben gestern gesehen, was passiert, wenn das Ende-Tag fehlt. Alles wurde Überschrift. Jetzt wissen Sie auch, warum."

Reihum: jede Person zeigt in ihrer `index.html` auf ein Start-Tag, seinen Inhalt und sein Ende-Tag.

### 1b Verschachtelung (15 min)

Gemeinsam eintippen, unter die `<h1>`:

```html
<div>
  <p>Erster Absatz.</p>
  <p>Zweiter Absatz.</p>
</div>
```

Speichern, hinsehen. **Es sieht aus wie vorher.** Das ist beabsichtigt und wird ausgesprochen:

> „Optisch passiert nichts. Ein `div` ist ein unsichtbarer Bereich – eine Kiste, in die man Sachen legt. Warum das nützlich ist, sehen Sie morgen: Dann bekommt die ganze Kiste auf einmal einen Rahmen, und nicht jeder Absatz einzeln."

Tafelbild zur Verschachtelungsregel:

```
richtig:  <div><p>Text</p></div>
falsch:   <div><p>Text</div></p>
```

> „Merksatz: **Was zuletzt aufgemacht wurde, wird zuerst wieder zugemacht.** Wie beim Anziehen – das Hemd kommt vor der Jacke an und nach der Jacke aus."

Einrückung ansprechen, aber richtig einordnen:

> „Die Einrückung ist dem Rechner völlig egal. Sie ist ausschließlich für Sie da. Wer nicht einrückt, findet ab Abschnitt 4 seine eigenen Fehler nicht mehr. Deshalb ist sie in diesem Kurs Pflicht."

> [!warning] Nicht erklären
> Kein `<!DOCTYPE>`, kein `<head>` gegen `<body>`, keine Erklärung von `<meta charset>` oder `<link>`. Wenn gefragt wird: „Das ist der Rahmen, den jede solche Datei braucht. Der ist vorbereitet und wir fassen ihn nicht an." Der Zeitplan trägt keine Exkursion.

---

## 2. Die Elemente durchgehen (45 min)

**Ziel:** Jedes der acht Elemente wurde einmal gesehen, eingebaut und wieder entfernt.

**Format:** Reihum, jede Person zwei Elemente. Einbauen, hinsehen, laut sagen was passiert, wieder entfernen. Das Ausbauen ist Teil der Übung – es hält die Datei sauber und nimmt die Scheu vorm Löschen.

Arbeitsstelle ist ein Spielbereich unter der `<h1>`:

```html
<div id="spielwiese">
  <!-- hier wird ausprobiert -->
</div>
```

> [!note] Kommentare
> Die Zeile mit `<!-- -->` fällt auf und wird gefragt werden. Antwort in einem Satz: „Das ist eine Notiz für Menschen. Der Rechner überliest sie." Nicht mehr dazu, aber ruhig verwenden – Kommentare sind eine gute Gewohnheit.

Reihenfolge und Sprechhinweise:

| # | Element | Was gezeigt wird | Satz dazu |
|---|---|---|---|
| 1 | `<h1>`, `<h2>` | zwei Größen untereinander | „Die Zahl ist keine Größe, sondern eine Rangfolge. `h1` ist die Hauptüberschrift, `h2` eine Unterüberschrift. Dass sie kleiner ist, ist nur die Voreinstellung." |
| 2 | `<p>` | zwei Absätze | „Ein Absatz. Zwei davon stehen automatisch untereinander mit Abstand." |
| 3 | `<div>` | Kiste um zwei Absätze | „Unsichtbar. Zum Gruppieren." |
| 4 | `<button>` | ein Knopf | „Der Knopf ist da und lässt sich drücken. Es passiert nur nichts – das kommt am dritten Tag." |
| 5 | `<input>` | einzeiliges Feld mit `placeholder` | „Ein Eingabefeld. Der graue Text darin ist nur ein Hinweis und verschwindet beim Tippen." |
| 6 | `<textarea>` | mehrzeiliges Feld | „Dasselbe für längeren Text. Achtung, hier kommt gleich die Ausnahme." |
| 7 | `<ul>`, `<li>` | Liste mit drei Einträgen | „Die Liste ist der Rahmen, jeder Eintrag ein `li`. Beides gehört zusammen." |
| 8 | `<span>` | Wort im Absatz hervorgehoben | „Wie ein `div`, nur für ein einzelnes Wort mitten im Text." |

Bei Nummer 5 und 6 ausdrücklich stehen bleiben:

```html
<input placeholder="Frage" />
<textarea placeholder="Antwort"></textarea>
```

> „Und hier ist eine Ungereimtheit, für die es keine gute Erklärung gibt: Das einzeilige Feld hat **kein** Ende-Tag, das mehrzeilige **schon**. Der Grund ist historisch. Sie müssen es nicht verstehen, nur wissen. Ich schreibe es an die Tafel, und da bleibt es die ganze Woche stehen."

Tafel, dauerhaft:

```
<input ... />          ohne Ende-Tag
<textarea ...></textarea>   mit Ende-Tag, direkt hintereinander
```

Bei Nummer 7 die Liste stehen lassen und den Ausblick geben:

> „Merken Sie sich diese Liste. Am dritten Tag wird sie leer sein, und das Programm füllt sie selbst – für jede Karte einen Eintrag."

Am Ende: Spielwiese komplett leeren.

---

## 3. `id` als Name (30 min)

**Ziel:** Verstehen, wozu Namen da sind – und die eigene `id`-Liste anlegen.

### 3a Warum Namen (10 min)

> „Stellen Sie sich vor, ich stehe in einem Raum mit drei Personen und sage: ‚Können Sie mir bitte das Blatt geben?' Was passiert?"

Antworten abwarten – die Gruppe kommt selbst darauf.

> „Genau. Nichts, oder alle drei gleichzeitig. Deshalb geben wir jedem Element, das wir später ansprechen wollen, einen Namen. Das Attribut dafür heißt `id`."

```html
<button id="knopf-umdrehen">Umdrehen</button>
```

Tafelbild zur Attribut-Anatomie:

```
<button id="knopf-umdrehen">Umdrehen</button>
        └──┬─┘ └──────┬─────┘
           │          └─ Wert, immer in Anführungszeichen
           └─ Attributname, steht im Start-Tag
```

> „Ein Attribut steht **im** Start-Tag, niemals im Ende-Tag. Es beschreibt das Element näher. Der Wert steht in Anführungszeichen – immer, ohne Ausnahme."

### 3b Die Kursregeln (10 min)

An die Tafel, dauerhaft:

```
id-Regeln in diesem Kurs
1. alles klein                    frage-feld     nicht  Frage-Feld
2. kein Leerzeichen, Bindestrich  karten-liste   nicht  karten liste
3. auf Deutsch                    knopf-neu      nicht  new-button
4. jede id nur EINMAL im ganzen Dokument
```

> „Regel eins bis drei sind Kursregeln. Man könnte es anders machen, aber wenn drei Leute drei Schreibweisen benutzen, verlieren wir am dritten Tag eine halbe Stunde. Regel vier ist keine Kursregel, sondern eine echte Vorschrift: Ein Name, der zweimal vergeben ist, ist kein Name mehr."

> [!danger] Regel 4 bricht erst in K4
> Eine doppelte `id` fällt heute nicht auf. Das Fenster sieht normal aus. In [[K4 JavaScript im Fenster]] wird dann stumm das falsche Element angesprochen – ein Fehler ohne Fehlermeldung, der teuer zu suchen ist. Deshalb heute betonen und im Praxisteil aktiv gegenprüfen.

### 3c `class` in einem Satz (5 min)

```html
<button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
<button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
```

> „Es gibt ein zweites Namensschild: `class`. Der Unterschied ist einfach: Die `id` ist Ihr Name, den gibt es nur einmal. Die `class` ist Ihre Schulklasse – die teilen Sie mit anderen. Wenn morgen zwei Knöpfe gleich aussehen sollen, spreche ich die Klasse an und nicht jeden einzeln."

Mehr nicht. `class` wird heute nur gesetzt, benutzt wird es in [[K2 CSS – das Aussehen]].

### 3d Die Liste anlegen (5 min)

Jede Person legt im Heft eine zweispaltige Tabelle an:

| `id` | wofür |
|---|---|
| | |

> „Ab jetzt gilt: Jedes Mal, wenn Sie eine `id` vergeben, tragen Sie sie hier ein. Diese Liste brauchen Sie am dritten Tag, und dann ist es zu spät, sie nachzubauen. Sie schreiben von Hand mit, weil das, was man einmal geschrieben hat, wiederfindbar wird."

---

## 4. Die Oberfläche bauen (60 min)

**Ziel:** Die vollständige Oberfläche steht. Alle `id`-Namen sind im Heft.

**Format:** Gemeinsam, in vier Etappen. Nach jeder Etappe: speichern, hinsehen, `id`s eintragen, kurz durchatmen. Sie tippen sichtbar mit, im gleichen Takt.

> „Wir bauen jetzt in vier Portionen. Nach jeder Portion sehen wir nach, ob es noch stimmt. Wer schneller ist, wartet – wir bleiben zusammen, weil die Reihenfolge später wichtig wird."

### Etappe 1 – Eingabebereich (20 min)

```html
<div id="eingabe">
  <h2>Neue Karte</h2>
  <input id="frage-feld" type="text" placeholder="Frage" />
  <textarea id="antwort-feld" placeholder="Antwort"></textarea>
  <button id="knopf-neu">Karte anlegen</button>
</div>
```

Zu `type="text"` ein Satz:

> „`type` sagt, welche Sorte Feld es ist. Es gibt auch Zahlenfelder und Ankreuzfelder. Wir benutzen im ganzen Kurs nur `text`."

**Ins Heft:** `eingabe`, `frage-feld`, `antwort-feld`, `knopf-neu`.

### Etappe 2 – Anzeigebereich (20 min)

```html
<div id="anzeige">
  <p id="karte-frage">Noch keine Karte</p>
  <p id="karte-antwort"></p>
  <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
  <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
</div>
```

Zwei Dinge, die auffallen werden, vorwegnehmen:

> „Erstens: In `karte-frage` steht ein Text, in `karte-antwort` steht nichts. Das ist Absicht – der Text kommt am dritten Tag vom Programm. Zweitens: Der leere Absatz ist unsichtbar. Er ist trotzdem da, wie ein reservierter Stuhl."

**Ins Heft:** `anzeige`, `karte-frage`, `karte-antwort`, `knopf-umdrehen`, `knopf-weiter`.

### Etappe 3 – Kartenliste (10 min)

```html
<h2>Alle Karten</h2>
<ul id="karten-liste"></ul>
```

> „Und jetzt die Liste, die Sie vorhin mit drei Einträgen gesehen haben – diesmal leer. Im Fenster ist sie unsichtbar. Genau so soll es sein: Sie haben noch keine Karten. Am dritten Tag füllt das Programm sie."

Erfahrungsgemäß kommt hier Irritation. Die Frage aufnehmen, nicht abwiegeln:

> „Ich weiß, es fühlt sich falsch an, etwas Leeres hinzuschreiben. Aber genau das ist der Unterschied zwischen einer Webseite und einer Anwendung: Sie bauen den Platz, die Inhalte kommen später von selbst."

**Ins Heft:** `karten-liste`.

### Etappe 4 – Aufräumen und Gegenlesen (10 min)

- Spielwiese aus Abschnitt 2 entfernen, falls noch Reste da sind
- Einrückung durchgehen, gemeinsam sauber machen
- **`id`-Liste gegen die Datei prüfen:** jede Person liest ihre Heftliste vor, die Nachbarperson sucht sie in der Datei

Elf Einträge sollen es sein: `eingabe`, `frage-feld`, `antwort-feld`, `knopf-neu`, `anzeige`, `karte-frage`, `karte-antwort`, `knopf-umdrehen`, `knopf-weiter`, `karten-liste` – plus `spielwiese`, falls behalten (dann streichen).

> [!tip] Der Gegenlese-Schritt ist der Kern
> Er dauert fünf Minuten und ersetzt am dritten Tag eine halbe Stunde Fehlersuche. Nicht kürzen, auch wenn die Zeit drängt. Eher Etappe 4 auf Kosten der Zusatzaufgaben verlängern.

---

## 5. Absichtlicher Fehler (15 min)

**Ziel:** Sehen, was ein nicht geschlossener Bereich anrichtet – und dass es reparabel ist.

### 5a Vorführung (5 min)

Auf Ihrem Gerät: das `</div>` von `#eingabe` löschen.

```html
<div id="eingabe">
  <h2>Neue Karte</h2>
  <input id="frage-feld" type="text" placeholder="Frage" />
  <textarea id="antwort-feld" placeholder="Antwort"></textarea>
  <button id="knopf-neu">Karte anlegen</button>

<div id="anzeige">
```

Speichern, neu laden.

Beobachtbar: Der Anzeigebereich rutscht in den Eingabebereich hinein. Optisch ist der Unterschied heute klein, weil noch keine Rahmen und Farben gesetzt sind.

> „Sehen Sie den Unterschied? Kaum. Und genau das ist die Botschaft dieses Fehlers: Er tut heute nicht weh. Morgen, wenn die Kiste einen Rahmen bekommt, sitzt plötzlich der halbe Bildschirm im falschen Kasten – und Sie werden den Fehler morgen suchen und heute gemacht haben."

Reparieren. Dann zeigen, wie man solche Fehler findet:

> „Zwei Handgriffe helfen fast immer. Erstens: Einrückung ansehen. Wo die Einrückung nach rechts wandert und nicht zurückkommt, fehlt ein Ende-Tag. Zweitens: Klicken Sie im Editor auf eine Klammer – der Editor zeigt Ihnen die zugehörige."

### 5b Jede Person selbst (7 min)

Fehler einbauen, hinsehen, an der Einrückung erkennen, reparieren.

### 5c Abschluss (3 min)

> „Sie haben jetzt eine vollständige Oberfläche. Sie tut nichts, sie sieht nach nichts aus – aber alle Teile sind da und alle haben einen Namen. Als Nächstes kommt der Anstrich, und das ist der Teil, bei dem man zum ersten Mal Lust bekommt, es jemandem zu zeigen."

Stand sichern lassen.

---

## Kontrollpunkte

| Nach Abschnitt | Woran Sie erkennen, dass es sitzt |
|---|---|
| 1 | Jede Person zeigt Start-Tag, Inhalt und Ende-Tag an einem beliebigen Element |
| 2 | Jede Person nennt aus dem Kopf den Unterschied zwischen `<input>` und `<textarea>` |
| 3 | Jede Person erklärt in eigenen Worten, warum eine `id` nur einmal vorkommen darf |
| 4 | Zehn `id`-Namen stehen im Heft und stimmen mit der Datei überein |
| 5 | Jede Person hat den Fehler selbst eingebaut, an der Einrückung erkannt und repariert |

---

## Wenn es klemmt

| Symptom | Wahrscheinliche Ursache | Sofortmaßnahme |
|---|---|---|
| Nach dem Eingabefeld ist die ganze Seite verrutscht | `<textarea>` ohne Ende-Tag | Tafelbild aus Abschnitt 2 zeigen, nicht neu erklären |
| Ein Element erscheint gar nicht | Attributwert ohne Anführungszeichen oder Tippfehler im Tag-Namen | Zeile laut vorlesen lassen – beim Vorlesen fällt es meist selbst auf |
| Der `placeholder`-Text ist weg | Es wurde hineingetippt | Feld leeren, Text kommt zurück. Guter Moment für „Hinweis, kein Inhalt" |
| Die Liste ist unsichtbar | `<ul>` ist leer – korrekt | Nicht als Fehler behandeln, siehe Etappe 3 |
| Datei ist zerfahren, Struktur unklar | zu viel auf einmal geändert | `stand-k1` kopieren, weiterarbeiten, Ursache in der Pause suchen |
| Eine Person ist deutlich schneller | – | Zusatzaufgaben Z1–Z3 aus [[K1c Übungsblatt]], **kein** CSS |

> [!warning] Die häufigste Versuchung
> Eine schnelle Person fängt an, Farben oder Größen auszuprobieren. Das nimmt [[K2 CSS – das Aussehen]] den Einstieg weg. Formulierung: „Das ist genau der nächste Abschnitt. Halten Sie den Gedanken fest, in einer Stunde fangen wir damit an."

## Übergabe an K2

Am Ende dieses Bausteins muss vorliegen:

- [ ] `src/index.html` vollständig, sauber eingerückt, alle Bereiche geschlossen
- [ ] Zehn `id`-Namen im Heft jeder Person, gegen die Datei geprüft
- [ ] Die beiden Anzeige-Knöpfe tragen `class="knopf-anzeige"` – K2 braucht eine Klassengruppe zum Üben
- [ ] `style.css` und `app.js` sind weiterhin leer

## Verknüpfung

Konzept: [[K1 HTML – die Struktur]] · Handout: [[K1b Handout]] · Übungen: [[K1c Übungsblatt]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

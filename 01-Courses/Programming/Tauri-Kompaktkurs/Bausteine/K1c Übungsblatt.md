---
baustein: K1
typ: uebungsblatt
titel: HTML – die Struktur – Übungen
ue: 4
tag: 1
tags: [tauri/kompaktkurs/uebung, html]
status: entwurf
---

# K1 – Übungsblatt

> [!info] Hinweis zu den Lösungen
> Die Lösungen stehen jeweils direkt unter der Aufgabe in einem zugeklappten Kasten. Auf dem gedruckten Teilnehmerblatt werden die Lösungskästen entfernt – die Kursleitungsfassung behält sie.

> [!tip] Die Regel für alle Aufgaben
> **Ändern → Speichern → Hinsehen.** Immer nur eine Sache auf einmal.

---

## Ü1.1 Ein Element zerlegen

Gegeben:

```html
<button id="knopf-neu">Karte anlegen</button>
```

Beschriften Sie die Bestandteile:

1. Start-Tag: `________________________________`
2. Inhalt: `________________________________`
3. Ende-Tag: `________________________________`
4. Attributname: `________________________________`
5. Attributwert: `________________________________`

> [!success]- Lösung Ü1.1
> 1. Start-Tag: `<button id="knopf-neu">`
> 2. Inhalt: `Karte anlegen`
> 3. Ende-Tag: `</button>`
> 4. Attributname: `id`
> 5. Attributwert: `knopf-neu`
>
> **Häufiger Fehler:** Das Attribut wird nicht zum Start-Tag gezählt. Es gehört hinein – ein Attribut steht immer im Start-Tag, nie im Ende-Tag und nie im Inhalt.

---

## Ü1.2 Alle acht Elemente ausprobieren

Legen Sie unter Ihrer Überschrift einen Spielbereich an:

```html
<div id="spielwiese">
</div>
```

Bauen Sie **jedes** der acht Elemente einmal hinein, sehen Sie nach, was passiert, und entfernen Sie es wieder. Haken Sie ab:

- [ ] `<h1>` und `<h2>`
- [ ] `<p>`
- [ ] `<div>`
- [ ] `<button>`
- [ ] `<input>`
- [ ] `<textarea>`
- [ ] `<ul>` mit drei `<li>`
- [ ] `<span>` mitten in einem Absatz

Notieren Sie im Heft: **Welche zwei Elemente sind im Fenster unsichtbar, obwohl sie da sind?**

> [!success]- Lösung Ü1.2
> ```html
> <div id="spielwiese">
>   <h2>Eine Unterüberschrift</h2>
>   <p>Ein Absatz.</p>
>   <button>Ein Knopf</button>
>   <input type="text" placeholder="Hinweistext" />
>   <textarea placeholder="Mehr Text"></textarea>
>   <ul>
>     <li>Erster Eintrag</li>
>     <li>Zweiter Eintrag</li>
>     <li>Dritter Eintrag</li>
>   </ul>
>   <p>Ein Wort ist <span>hervorgehoben</span>.</p>
> </div>
> ```
>
> **Unsichtbar sind `<div>` und `<span>`.** Beide sind reine Bereiche ohne eigenes Aussehen. Sie werden erst in [[K2 CSS – das Aussehen]] nützlich, wenn ein ganzer Bereich auf einmal Rahmen oder Farbe bekommt.
>
> Ebenfalls akzeptabel als Antwort: ein leeres `<p></p>`. Es ist zwar sichtbar veranlagt, ohne Inhalt aber nicht wahrnehmbar.
>
> **Am Ende der Aufgabe wird die Spielwiese vollständig geleert.**

---

## Ü1.3 Fehler finden

In jedem Schnipsel steckt genau ein Fehler. Markieren Sie ihn und schreiben Sie die richtige Fassung daneben.

**a)**
```html
<p>Das ist ein Absatz.</div>
```

**b)**
```html
<div>
  <p>Text im Bereich.
</div>
```

**c)**
```html
<textarea placeholder="Antwort" />
```

**d)**
```html
<button id=knopf-neu>Karte anlegen</button>
```

**e)**
```html
<ul>
  Erster Eintrag
  Zweiter Eintrag
</ul>
```

**f)**
```html
<div>
  <p>Erster</p>
  <p>Zweiter</p>
```

> [!success]- Lösungen Ü1.3
> **a)** Start- und Ende-Tag gehören zusammen. Ende-Tag falsch.
> ```html
> <p>Das ist ein Absatz.</p>
> ```
>
> **b)** Dem Absatz fehlt das Ende-Tag. Der Bereich schließt, bevor der Absatz geschlossen ist.
> ```html
> <div>
>   <p>Text im Bereich.</p>
> </div>
> ```
>
> **c)** `<textarea>` braucht ein Ende-Tag – das ist die Ausnahme aus dem Handout. Nur `<input>` darf sich selbst schließen.
> ```html
> <textarea placeholder="Antwort"></textarea>
> ```
>
> **d)** Der Attributwert steht ohne Anführungszeichen.
> ```html
> <button id="knopf-neu">Karte anlegen</button>
> ```
>
> **e)** Einträge einer Liste müssen in `<li>` stehen. Loser Text in einer `<ul>` gehört dort nicht hin.
> ```html
> <ul>
>   <li>Erster Eintrag</li>
>   <li>Zweiter Eintrag</li>
> </ul>
> ```
>
> **f)** Dem `<div>` fehlt das Ende-Tag. Erkennbar daran, dass die Einrückung nach rechts wandert und nicht zurückkommt.
> ```html
> <div>
>   <p>Erster</p>
>   <p>Zweiter</p>
> </div>
> ```
>
> **Hinweis für die Kursleitung:** b) und f) sind derselbe Fehlertyp auf zwei Ebenen. Wer beide findet, hat das Prinzip verstanden; wer nur einen findet, braucht den Einrückungs-Handgriff noch einmal gezeigt.

---

## Ü1.4 `id`-Namen beurteilen

Welche dieser Namen entsprechen den Kursregeln? Kreuzen Sie an und begründen Sie kurz bei den falschen.

| Name | in Ordnung | verstößt gegen |
|---|---|---|
| `frage-feld` | ☐ | |
| `Karten-Liste` | ☐ | |
| `knopf neu` | ☐ | |
| `deleteButton` | ☐ | |
| `karte-antwort` | ☐ | |
| `eingabe` | ☐ | |

> [!success]- Lösung Ü1.4
> | Name | in Ordnung | verstößt gegen |
> |---|---|---|
> | `frage-feld` | ✔ | – |
> | `Karten-Liste` | ✘ | Regel 1: alles klein |
> | `knopf neu` | ✘ | Regel 2: kein Leerzeichen, Bindestrich verwenden |
> | `deleteButton` | ✘ | Regel 1 (Großbuchstabe) und Regel 3 (Deutsch) |
> | `karte-antwort` | ✔ | – |
> | `eingabe` | ✔ | – |
>
> **Nachfrage an die Gruppe:** „Welche der Regeln ist keine Kursregel, sondern eine echte Vorschrift?" → Regel 4: jede `id` nur einmal im Dokument. Die anderen drei sind Vereinbarungen, damit alle dasselbe schreiben.

---

## Ü1.5 Die Oberfläche bauen

Wird gemeinsam in vier Etappen gebaut. Haken Sie nach jeder Etappe ab und tragen Sie die `id`-Namen **sofort** in Ihre Heftliste ein.

**Etappe 1 – Eingabebereich**
- [ ] Bereich `eingabe` mit Unterüberschrift „Neue Karte"
- [ ] Eingabefeld für die Frage
- [ ] Mehrzeiliges Feld für die Antwort
- [ ] Knopf „Karte anlegen"
- [ ] Vier `id`-Namen im Heft

**Etappe 2 – Anzeigebereich**
- [ ] Bereich `anzeige`
- [ ] Absatz für die Frage mit dem Text „Noch keine Karte"
- [ ] Leerer Absatz für die Antwort
- [ ] Zwei Knöpfe: „Umdrehen" und „Nächste", beide mit `class="knopf-anzeige"`
- [ ] Fünf `id`-Namen im Heft

**Etappe 3 – Kartenliste**
- [ ] Unterüberschrift „Alle Karten"
- [ ] Leere Liste `karten-liste`
- [ ] Ein `id`-Name im Heft

**Etappe 4 – Aufräumen**
- [ ] Spielwiese aus Ü1.2 entfernt
- [ ] Einrückung durchgehend sauber
- [ ] Heftliste gegen die Datei geprüft – von der Nachbarperson

> [!success]- Lösung Ü1.5 – vollständige Datei
> ```html
> <!DOCTYPE html>
> <html lang="de">
>   <head>
>     <meta charset="UTF-8" />
>     <title>Lernkarten</title>
>     <link rel="stylesheet" href="style.css" />
>   </head>
>   <body>
>     <h1>Lernkarten von Anna</h1>
>
>     <div id="eingabe">
>       <h2>Neue Karte</h2>
>       <input id="frage-feld" type="text" placeholder="Frage" />
>       <textarea id="antwort-feld" placeholder="Antwort"></textarea>
>       <button id="knopf-neu">Karte anlegen</button>
>     </div>
>
>     <div id="anzeige">
>       <p id="karte-frage">Noch keine Karte</p>
>       <p id="karte-antwort"></p>
>       <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
>       <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
>     </div>
>
>     <h2>Alle Karten</h2>
>     <ul id="karten-liste"></ul>
>
>     <script src="app.js"></script>
>   </body>
> </html>
> ```
>
> **Die zehn `id`-Namen:**
>
> | `id` | wofür |
> |---|---|
> | `eingabe` | Bereich zum Anlegen einer Karte |
> | `frage-feld` | Eingabefeld für die Frage |
> | `antwort-feld` | mehrzeiliges Feld für die Antwort |
> | `knopf-neu` | Knopf „Karte anlegen" |
> | `anzeige` | Bereich, in dem die aktuelle Karte steht |
> | `karte-frage` | Absatz mit der Frage der aktuellen Karte |
> | `karte-antwort` | Absatz mit der Antwort, zunächst leer |
> | `knopf-umdrehen` | Knopf „Umdrehen" |
> | `knopf-weiter` | Knopf „Nächste" |
> | `karten-liste` | Liste aller angelegten Karten, zunächst leer |
>
> **Zwei Stellen, die als Fehler wahrgenommen werden und keine sind:**
> `karte-antwort` ist leer, weil der Text ab K4 vom Programm kommt. `karten-liste` ist leer, weil das Programm die Einträge erzeugt.
>
> **Prüfschritt Etappe 4:** Jede Person liest ihre Heftliste vor, die Nachbarperson sucht jeden Namen in der Datei. Fünf Minuten, die in K4 eine halbe Stunde sparen.

---

## Ü1.6 Absichtlich kaputt machen

1. Löschen Sie das `</div>` des Bereichs `eingabe`.
2. Speichern, hinsehen. **Beschreiben Sie in einem Satz, was sich verändert hat.**
3. Finden Sie den Fehler ausschließlich über die Einrückung wieder.
4. Reparieren Sie ihn.

Ihre Beobachtung: `_______________________________________________`

> [!success]- Lösung Ü1.6
> **Beobachtung:** Der Anzeigebereich liegt jetzt innerhalb des Eingabebereichs. Optisch ist der Unterschied heute klein, weil noch keine Rahmen und Farben gesetzt sind.
>
> **Das ist der eigentliche Lerninhalt:** Der Fehler tut heute nicht weh. Sobald in [[K2 CSS – das Aussehen]] die Bereiche Rahmen bekommen, sitzt plötzlich der halbe Bildschirm im falschen Kasten – und der Fehler wurde einen Tag vorher gemacht.
>
> **Fund über die Einrückung:** Ab der Zeile mit `<div id="anzeige">` steht alles zwei Stufen weiter rechts, als es sollte, und kommt bis zum Dateiende nicht zurück. Genau dort fehlt das Ende-Tag.
>
> **Reparatur:** `</div>` hinter dem Knopf „Karte anlegen" wieder einfügen.
>
> **Zweiter Handgriff zum Zeigen:** Im Editor auf eine spitze Klammer klicken – er hebt die zugehörige hervor. Findet er keine, ist das der Beweis.

---

## Zusatzaufgaben für Schnellere

> [!note] Freiwillig
> Kein neuer Stoff, keine Farben, keine Größen. Wer Lust auf Gestaltung hat: Das ist genau der nächste Baustein.

**Z1 – Der Zähler.** Bereiten Sie im Anzeigebereich einen Platz für eine Anzeige der Form „Karte 3 von 12" vor. Die Zahlen sollen später vom Programm eingesetzt werden, stehen also in eigenen Namensbereichen mitten im Satz.

**Z2 – Doppelte `id` beweisen.** Geben Sie zwei verschiedenen Elementen dieselbe `id`. Was verändert sich im Fenster?

**Z3 – Struktur beschreiben.** Zeichnen Sie die Verschachtelung Ihrer Datei als Baum ins Heft, ohne in die Datei zu sehen. Danach vergleichen.

> [!success]- Lösungen Z1 bis Z3
> **Z1** – dafür ist `<span>` da: ein Namensbereich mitten im Text.
> ```html
> <p>Karte <span id="zaehler">0</span> von <span id="gesamt">0</span></p>
> ```
> Beide `id`-Namen kommen ins Heft. Diese Vorbereitung wird in [[K4 JavaScript im Fenster]] als Zusatzaufgabe tatsächlich benutzt.
>
> **Z2** – im Fenster verändert sich **nichts**. Genau das ist die Antwort und der Grund, warum dieser Fehler gefährlich ist: Er ist heute unsichtbar und schlägt erst in K4 zu, wenn das Programm stumm das falsche Element erwischt. Danach wieder auf eindeutige Namen zurückbauen.
>
> **Z3** – erwartete Struktur:
> ```
> body
> ├── h1
> ├── div#eingabe
> │   ├── h2
> │   ├── input#frage-feld
> │   ├── textarea#antwort-feld
> │   └── button#knopf-neu
> ├── div#anzeige
> │   ├── p#karte-frage
> │   ├── p#karte-antwort
> │   ├── button#knopf-umdrehen
> │   └── button#knopf-weiter
> ├── h2
> └── ul#karten-liste
> ```
> Wer diesen Baum aus dem Kopf zeichnen kann, hat Verschachtelung verstanden. Die Schreibweise `div#eingabe` wird nebenbei eingeführt – sie taucht in [[K2 CSS – das Aussehen]] als Selektor wieder auf.

---

## Abschlusskontrolle

Haken Sie ab, wenn Sie es **selbst** gemacht haben:

- [ ] Ü1.1 Element zerlegt und benannt
- [ ] Ü1.2 Alle acht Elemente eingebaut und wieder entfernt
- [ ] Ü1.3 Sechs Fehler gefunden und berichtigt
- [ ] Ü1.4 `id`-Namen beurteilt
- [ ] Ü1.5 Oberfläche vollständig gebaut, zehn `id`-Namen im Heft
- [ ] Ü1.6 Fehler eingebaut, über die Einrückung gefunden, repariert

## Verknüpfung

Handout: [[K1b Handout]] · Trainerskript: [[K1a Trainerskript]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

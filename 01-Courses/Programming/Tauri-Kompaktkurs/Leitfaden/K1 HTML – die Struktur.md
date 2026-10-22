---
title: HTML – die Struktur
modul: K1
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, html]
status: active
---

# K1 – HTML – die Struktur

## Inhaltsübersicht

- Wie ein Element aufgebaut ist
- Verschachtelung und Einrückung
- Die acht Elemente dieses Kurses
- Attribute
- `id` und `class`
- Die Oberfläche der Lernkarten-Anwendung
- Absichtlicher Fehler: ein nicht geschlossenes `<div>`
- Typische Stolperstellen
- Stand am Ende des Moduls

Am Ende steht die vollständige Oberfläche der Lernkarten-Anwendung. Sie sieht noch schlicht aus und tut noch nichts, aber alle Bestandteile sind da und jedes hat einen Namen.

## Wie ein Element aufgebaut ist

```
<p>Hallo</p>
 │  │    │
 │  │    └─ Ende-Tag: derselbe Name mit Schrägstrich
 │  └────── Inhalt: was im Fenster erscheint
 └───────── Start-Tag: sagt, was für ein Ding das ist
```

**Element = Start-Tag + Inhalt + Ende-Tag.**

In [[K0 Ankommen und erste eigene Änderung]] wurde ein Text zwischen zwei Marken geschrieben, ohne dass geklärt wurde, was die Marken bedeuten. Eine Marke sagt: Hier fängt eine Überschrift an. Die andere sagt: Hier hört sie auf. Zusammen mit dem Text dazwischen heißt das ein **Element**.

Ein Ende-Tag fehlt → das Programm weiß nicht, wo das Element aufhört, und nimmt an, es hört nie auf. Genau das war beim absichtlichen Fehler in K0 zu sehen.

Reihum: in der eigenen `index.html` auf ein Start-Tag, seinen Inhalt und sein Ende-Tag zeigen.

## Verschachtelung und Einrückung

Elemente dürfen ineinander liegen. Unter die `<h1>`:

```html
<div>
  <p>Erster Absatz.</p>
  <p>Zweiter Absatz.</p>
</div>
```

Speichern, hinsehen: **Es sieht aus wie vorher.** Das ist beabsichtigt.

**Ein `<div>` ist ein unsichtbarer Bereich – eine Kiste, in die man Sachen legt.** Wozu das nützlich ist, zeigt [[K2 CSS – das Aussehen]]: Dann bekommt die ganze Kiste auf einmal einen Rahmen, und nicht jeder Absatz einzeln.

> [!important] Die Verschachtelungsregel
> **Was zuletzt aufgemacht wurde, wird zuerst wieder zugemacht.**
>
> ```
> richtig:  <div><p>Text</p></div>
> falsch:   <div><p>Text</div></p>
> ```
>
> Wie beim Anziehen – das Hemd kommt vor der Jacke an und nach der Jacke aus.

**Einrückung:** dem Rechner völlig egal, aber ausschließlich für den Menschen da. Jede Verschachtelungsebene rückt zwei Leerzeichen weiter ein. Wer nicht einrückt, findet später seine eigenen Fehler nicht mehr. Deshalb ist die Einrückung Kursregel.

> [!note] Nicht vertiefen
> `<!DOCTYPE>`, `<head>` gegen `<body>`, `<meta charset>`, `<link>` – das ist der Rahmen, den jede solche Datei braucht. Er ist vorbereitet und wird nicht angefasst.

## Die acht Elemente dieses Kurses

Mehr als diese acht braucht die Anwendung nicht:

| Element | Wofür | Beispiel |
|---|---|---|
| `<h1>`, `<h2>` | Überschriften | `<h1>Lernkarten</h1>` |
| `<p>` | Textabsatz | `<p>Noch keine Karte</p>` |
| `<div>` | unsichtbarer Bereich zum Gruppieren | `<div>…</div>` |
| `<button>` | Knopf | `<button>Umdrehen</button>` |
| `<input>` | einzeiliges Eingabefeld | `<input type="text" />` |
| `<textarea>` | mehrzeiliges Eingabefeld | `<textarea></textarea>` |
| `<ul>`, `<li>` | Liste und Listeneintrag | `<ul><li>Eintrag</li></ul>` |
| `<span>` | kleiner Bereich mitten im Text | `<p>Karte <span>3</span></p>` |

Jedes einmal einbauen, die Wirkung ansehen und wieder entfernen. Das Ausbauen gehört dazu – es hält die Datei sauber und nimmt die Scheu vorm Löschen.

Arbeitsstelle ist ein Spielbereich unter der `<h1>`:

```html
<div id="spielwiese">
  <!-- hier wird ausprobiert -->
</div>
```

> [!note] Kommentare
> Die Zeile mit `<!-- -->` fällt auf. Antwort in einem Satz: „Das ist eine Notiz für Menschen. Der Rechner überliest sie." Kommentare sind eine gute Gewohnheit.

| # | Element | Wirkung | Erläuterung |
|---|---|---|---|
| 1 | `<h1>`, `<h2>` | zwei Größen untereinander | Die Zahl ist keine Größe, sondern eine Rangfolge. `h1` ist die Hauptüberschrift, `h2` eine Unterüberschrift. Dass `h2` kleiner dargestellt wird, ist nur die Voreinstellung. |
| 2 | `<p>` | zwei Absätze | Zwei Absätze stehen automatisch untereinander mit Abstand. |
| 3 | `<div>` | Kiste um zwei Absätze | Unsichtbar. Zum Gruppieren. |
| 4 | `<button>` | ein Knopf | Der Knopf ist da und lässt sich drücken. Es passiert nur nichts – das kommt in [[K4 JavaScript im Fenster]]. |
| 5 | `<input>` | einzeiliges Feld mit `placeholder` | Der graue Text darin ist nur ein Hinweis und verschwindet beim Tippen. |
| 6 | `<textarea>` | mehrzeiliges Feld | Dasselbe für längeren Text – mit einer Ausnahme, siehe unten. |
| 7 | `<ul>`, `<li>` | Liste mit drei Einträgen | Die Liste ist der Rahmen, jeder Eintrag ein `li`. Beides gehört zusammen. |
| 8 | `<span>` | Wort im Absatz hervorgehoben | Wie ein `div`, nur für ein einzelnes Wort mitten im Text. |

### Die eine Ausnahme

```html
<input placeholder="Frage" />
<textarea placeholder="Antwort"></textarea>
```

> [!warning] Unlogisch, aber so ist es
> Das einzeilige Feld hat **kein** Ende-Tag, das mehrzeilige **schon**. Der Grund ist historisch. Das muss nicht verstanden, nur gewusst werden. Bei `<textarea>` stehen Start- und Ende-Tag direkt hintereinander, wenn das Feld leer sein soll.

**Die Liste merken:** `<ul>` ist beim Bau der Oberfläche leer, und in [[K4 JavaScript im Fenster]] füllt das Programm sie selbst – für jede Karte einen Eintrag.

Am Ende dieser Übung wird die Spielwiese vollständig geleert.

## Attribute

Ein Attribut beschreibt ein Element näher. Es steht **im Start-Tag**, niemals im Ende-Tag.

```
<button id="knopf-umdrehen">Umdrehen</button>
        └─┬┘ └──────┬──────┘
          │         └─ Wert, immer in Anführungszeichen
          └─ Attributname
```

Im Kurs werden vier Attribute benutzt:

| Attribut | Wofür |
|---|---|
| `id` | Name eines einzelnen Elements. Damit wird es ab [[K4 JavaScript im Fenster]] angesprochen. |
| `class` | Gruppenname. Mehrere Elemente dürfen dieselbe Klasse haben. |
| `placeholder` | Grauer Hinweistext in einem Eingabefeld. Verschwindet beim Tippen. |
| `type` | Sorte des Eingabefelds. Im Kurs nur `type="text"`. |

## `id` und `class`

> [!tip] Der Unterschied in einem Bild
> Die **`id`** ist der eigene Name – den gibt es nur einmal.
> Die **`class`** ist die Schulklasse – die wird mit anderen geteilt.

Die Frage, warum Namen überhaupt nötig sind: „Können Sie mir bitte das Blatt geben?" in einem Raum mit drei Personen. Es passiert nichts, oder alle drei reagieren gleichzeitig. Deshalb bekommt jedes Element, das später angesprochen werden soll, einen Namen – das Attribut `id`.

### Regeln für `id`-Namen in diesem Kurs

1. **Alles klein** — `frage-feld`, nicht `Frage-Feld`
2. **Kein Leerzeichen**, stattdessen Bindestrich — `karten-liste`
3. **Auf Deutsch** — `knopf-neu`, nicht `new-button`
4. **Jede `id` nur einmal im ganzen Dokument**

Regeln 1 bis 3 sind Kursregeln, damit alle dasselbe schreiben. Wenn drei Leute drei Schreibweisen benutzen, geht später Zeit für die Fehlersuche verloren. Regel 4 ist keine Kursregel, sondern eine echte Vorschrift: Ein Name, der zweimal vergeben ist, ist kein Name mehr.

> [!danger] Regel 4 bricht erst in K4
> Eine doppelte `id` fällt beim Bauen der Oberfläche nicht auf. Das Fenster sieht normal aus. In [[K4 JavaScript im Fenster]] wird dann stumm das falsche Element angesprochen – ein Fehler ohne Fehlermeldung, der teuer zu suchen ist. Deshalb sofort sauber vergeben.

`class` wird hier nur gesetzt:

```html
<button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
<button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
```

Benutzt wird die Klasse in [[K2 CSS – das Aussehen]]: Wenn zwei Knöpfe gleich aussehen sollen, wird die Klasse angesprochen und nicht jeder Knopf einzeln.

### Die eigene `id`-Liste

Im Heft eine zweispaltige Tabelle anlegen:

| `id` | wofür |
|---|---|
| | |

Jedes Mal, wenn eine `id` vergeben wird, wird sie dort eingetragen.

> [!important] Diese Liste ist das eigentliche Ergebnis dieses Moduls
> In [[K4 JavaScript im Fenster]] wird jedes dieser Elemente im Programm angesprochen. Wer die Liste dann nicht hat, sucht die Namen einzeln in der Datei zusammen. Von Hand mitschreiben lohnt sich – was man einmal geschrieben hat, findet man wieder.

## Die Oberfläche der Lernkarten-Anwendung

Gebaut wird in vier Portionen. Nach jeder Portion wird gespeichert, hingesehen, die `id`s eingetragen und kurz durchgeatmet. Die Reihenfolge wird später wichtig, deshalb bleibt die Gruppe zusammen.

### Etappe 1 – Eingabebereich

```html
<div id="eingabe">
  <h2>Neue Karte</h2>
  <input id="frage-feld" type="text" placeholder="Frage" />
  <textarea id="antwort-feld" placeholder="Antwort"></textarea>
  <button id="knopf-neu">Karte anlegen</button>
</div>
```

`type="text"` sagt, welche Sorte Feld es ist. Es gibt auch Zahlenfelder und Ankreuzfelder; im Kurs wird nur `text` benutzt.

**Ins Heft:** `eingabe`, `frage-feld`, `antwort-feld`, `knopf-neu`.

### Etappe 2 – Anzeigebereich

```html
<div id="anzeige">
  <p id="karte-frage">Noch keine Karte</p>
  <p id="karte-antwort"></p>
  <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
  <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
</div>
```

Zwei Dinge fallen auf und sind Absicht:

> In `karte-frage` steht ein Text, in `karte-antwort` steht nichts. Der Text kommt später vom Programm. Und der leere Absatz ist unsichtbar, aber trotzdem da – wie ein reservierter Stuhl.

**Ins Heft:** `anzeige`, `karte-frage`, `karte-antwort`, `knopf-umdrehen`, `knopf-weiter`.

### Etappe 3 – Kartenliste

```html
<h2>Alle Karten</h2>
<ul id="karten-liste"></ul>
```

Die Liste ist im Fenster unsichtbar. Genau so soll es sein: Es gibt noch keine Karten. Später füllt das Programm sie.

Es fühlt sich falsch an, etwas Leeres hinzuschreiben. Aber genau das ist der Unterschied zwischen einer Webseite und einer Anwendung: **Es wird der Platz gebaut, die Inhalte kommen später von selbst.**

**Ins Heft:** `karten-liste`.

### Etappe 4 – Aufräumen und Gegenlesen

- Spielwiese entfernen, falls noch Reste darin stehen
- Einrückung durchgehen und gemeinsam sauber machen
- **`id`-Liste gegen die Datei prüfen:** jede Person liest ihre Heftliste vor, die Nachbarperson sucht sie in der Datei

Die zehn `id`-Namen: `eingabe`, `frage-feld`, `antwort-feld`, `knopf-neu`, `anzeige`, `karte-frage`, `karte-antwort`, `knopf-umdrehen`, `knopf-weiter`, `karten-liste`.

> [!tip] Der Gegenlese-Schritt ist der Kern
> Er ersetzt in [[K4 JavaScript im Fenster]] eine lange Fehlersuche und wird deshalb nicht gekürzt.

### Die fertige Datei

```html
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8" />
    <title>Lernkarten</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <h1>Lernkarten von Anna</h1>

    <div id="eingabe">
      <h2>Neue Karte</h2>
      <input id="frage-feld" type="text" placeholder="Frage" />
      <textarea id="antwort-feld" placeholder="Antwort"></textarea>
      <button id="knopf-neu">Karte anlegen</button>
    </div>

    <div id="anzeige">
      <p id="karte-frage">Noch keine Karte</p>
      <p id="karte-antwort"></p>
      <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
      <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
    </div>

    <h2>Alle Karten</h2>
    <ul id="karten-liste"></ul>

    <script src="app.js"></script>
  </body>
</html>
```

| Stelle | Warum leer |
|---|---|
| `<p id="karte-antwort"></p>` | Der Text kommt später vom Programm. Der leere Absatz ist ein reservierter Platz. |
| `<ul id="karten-liste"></ul>` | Das Programm erzeugt für jede Karte einen Eintrag. Gebaut wird nur der Rahmen. |
| `style.css` | Kommt in [[K2 CSS – das Aussehen]] dran. |
| `app.js` | Kommt ab [[K3 JavaScript – die Bausteine]] dran. |

## Absichtlicher Fehler: ein nicht geschlossenes `<div>`

Das `</div>` von `#eingabe` wird gelöscht:

```html
<div id="eingabe">
  <h2>Neue Karte</h2>
  <input id="frage-feld" type="text" placeholder="Frage" />
  <textarea id="antwort-feld" placeholder="Antwort"></textarea>
  <button id="knopf-neu">Karte anlegen</button>

<div id="anzeige">
```

Speichern, neu laden.

**Beobachtbar:** Der Anzeigebereich rutscht in den Eingabebereich hinein. Optisch ist der Unterschied klein, weil noch keine Rahmen und Farben gesetzt sind.

> [!warning] Dieser Fehler tut jetzt kaum weh
> Sobald die Bereiche in [[K2 CSS – das Aussehen]] einen Rahmen bekommen, sitzt plötzlich der halbe Bildschirm im falschen Kasten – und der Fehler wurde hier gemacht.

**Zwei Handgriffe, die fast immer helfen:**

1. **Einrückung ansehen.** Wo die Einrückung nach rechts wandert und nicht zurückkommt, fehlt ein Ende-Tag.
2. **Im Editor auf eine spitze Klammer klicken** – er zeigt die zugehörige an. Findet er keine, ist das der Beweis.

Danach selbst: Fehler einbauen, hinsehen, an der Einrückung erkennen, reparieren.

## Typische Stolperstellen

> [!warning]
> - `<textarea>` braucht ein schließendes Tag, `<input>` nicht. Das ist inkonsequent und irritiert regelmäßig.
> - Anführungszeichen um Attributwerte werden vergessen.
> - `id` wird doppelt vergeben. Fällt hier nicht auf, bricht in [[K4 JavaScript im Fenster]].
> - Groß- und Kleinschreibung bei `id` ist relevant. Deshalb die Kursregel: immer klein.
> - Ab einer Stelle ist alles verrutscht → ein `</div>` oder `</textarea>` fehlt.
> - Alles ist plötzlich riesig → ein `</h1>` oder `</h2>` fehlt.
> - Der graue Hinweistext ist weg → es wurde ins Feld getippt. Feld leeren, er kommt zurück.
> - Die Liste ist unsichtbar → sie ist leer. Das ist richtig so.

## Stand am Ende des Moduls

- [ ] Alle acht Elemente einmal selbst eingebaut und wieder entfernt
- [ ] Die Oberfläche vollständig nachgebaut, sauber eingerückt, alle Bereiche geschlossen
- [ ] Zehn `id`-Namen im Heft, gegen die Datei geprüft
- [ ] Die beiden Anzeige-Knöpfe tragen `class="knopf-anzeige"`
- [ ] Den Fehler selbst eingebaut, an der Einrückung erkannt und repariert
- [ ] `style.css` und `app.js` sind weiterhin leer

## Verknüpfung

Merkblatt: [[K1 Merkblatt]] · Übungen: [[K1 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

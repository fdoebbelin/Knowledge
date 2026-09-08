---
baustein: K1
typ: handout
titel: HTML – die Struktur – Handout
ue: 4
tag: 1
tags: [tauri/kompaktkurs/handout, html]
status: entwurf
---

# K1 – HTML – die Struktur

> [!abstract] Worum es in dieser Einheit geht
> Sie bauen die vollständige Oberfläche Ihrer Lernkarten-Anwendung. Sie sieht am Ende noch schlicht aus und tut noch nichts – aber alle Bestandteile sind da und jeder hat einen Namen.

---

## 1 Wie ein Element aufgebaut ist

```
<p>Hallo</p>
 │  │    │
 │  │    └─ Ende-Tag: derselbe Name mit Schrägstrich
 │  └────── Inhalt: was im Fenster erscheint
 └───────── Start-Tag: sagt, was für ein Ding das ist
```

**Element = Start-Tag + Inhalt + Ende-Tag.**

Fehlt das Ende-Tag, weiß das Programm nicht, wo das Element aufhört – und nimmt an, es hört nie auf. Genau das haben Sie gestern gesehen.

---

## 2 Verschachtelung

Elemente dürfen ineinander liegen:

```html
<div>
  <p>Erster Absatz.</p>
  <p>Zweiter Absatz.</p>
</div>
```

> [!important] Die Verschachtelungsregel
> **Was zuletzt aufgemacht wurde, wird zuerst wieder zugemacht.**
>
> ```
> richtig:  <div><p>Text</p></div>
> falsch:   <div><p>Text</div></p>
> ```

**Einrückung** ist dem Rechner egal, aber für Sie überlebenswichtig: Jede Verschachtelungsebene rückt zwei Leerzeichen weiter ein. Wo die Einrückung nach rechts wandert und nicht zurückkommt, fehlt ein Ende-Tag.

---

## 3 Die Elemente dieses Kurses

Mehr als diese acht braucht die Anwendung nicht.

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

Die Zahl bei `h1` und `h2` ist **keine Größenangabe**, sondern eine Rangfolge: `h1` ist die Hauptüberschrift, `h2` eine Unterüberschrift. Dass `h2` kleiner dargestellt wird, ist nur die Voreinstellung.

> [!warning] Die Ausnahme, die immer wieder stolpern lässt
> ```html
> <input placeholder="Frage" />          ← ohne Ende-Tag
> <textarea placeholder="Antwort"></textarea>   ← mit Ende-Tag
> ```
> Das ist unlogisch und hat historische Gründe. Sie müssen es nicht verstehen, nur wissen. Bei `<textarea>` stehen Start- und Ende-Tag direkt hintereinander, wenn das Feld leer sein soll.

---

## 4 Attribute

Ein Attribut beschreibt ein Element näher. Es steht **im Start-Tag**, niemals im Ende-Tag.

```
<button id="knopf-umdrehen">Umdrehen</button>
        └─┬┘ └──────┬──────┘
          │         └─ Wert, immer in Anführungszeichen
          └─ Attributname
```

Im Kurs benutzen wir vier Attribute:

| Attribut | Wofür |
|---|---|
| `id` | Name eines einzelnen Elements. Damit sprechen wir es ab K4 an. |
| `class` | Gruppenname. Mehrere Elemente dürfen dieselbe Klasse haben. |
| `placeholder` | Grauer Hinweistext in einem Eingabefeld. Verschwindet beim Tippen. |
| `type` | Sorte des Eingabefelds. Wir benutzen nur `type="text"`. |

---

## 5 `id` und `class`

> [!tip] Der Unterschied in einem Bild
> Die **`id`** ist Ihr Name – den gibt es nur einmal.
> Die **`class`** ist Ihre Schulklasse – die teilen Sie mit anderen.

### Regeln für `id`-Namen in diesem Kurs

1. **Alles klein** — `frage-feld`, nicht `Frage-Feld`
2. **Kein Leerzeichen**, stattdessen Bindestrich — `karten-liste`
3. **Auf Deutsch** — `knopf-neu`, nicht `new-button`
4. **Jede `id` nur einmal im ganzen Dokument**

Regeln 1 bis 3 sind Kursregeln, damit alle dasselbe schreiben. Regel 4 ist eine echte Vorschrift.

> [!danger] Eine doppelte `id` fällt heute nicht auf
> Das Fenster sieht ganz normal aus. Der Fehler bricht erst in [[K4 JavaScript im Fenster]] auf – dann wird stumm das falsche Element angesprochen, ohne Fehlermeldung. Deshalb: sofort sauber vergeben.

---

## 6 Ihre `id`-Liste

Legen Sie in Ihrem Heft eine Tabelle an und tragen Sie **jede** `id` ein, sobald Sie sie vergeben:

| `id` | wofür |
|---|---|
| `eingabe` | Bereich zum Anlegen einer Karte |
| `frage-feld` | Eingabefeld für die Frage |
| … | … |

> [!important] Diese Liste ist das eigentliche Ergebnis von heute
> Am dritten Tag sprechen Sie jedes dieser Elemente im Programm an. Wer die Liste dann nicht hat, sucht die Namen einzeln in der Datei zusammen. Von Hand mitschreiben lohnt sich – was man einmal geschrieben hat, findet man wieder.

---

## 7 Die fertige Oberfläche

So sieht `src/index.html` am Ende dieser Einheit aus. Ihre `<h1>` behält Ihren Namen aus gestern.

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

### Warum manches leer bleibt

| Stelle | Warum leer |
|---|---|
| `<p id="karte-antwort"></p>` | Der Text kommt ab K4 vom Programm. Der leere Absatz ist ein reservierter Platz. |
| `<ul id="karten-liste"></ul>` | Das Programm erzeugt für jede Karte einen Eintrag. Sie bauen nur den Rahmen. |
| `style.css` | Kommt in [[K2 CSS – das Aussehen]] dran. |
| `app.js` | Kommt ab [[K3 JavaScript – die Bausteine]] dran. |

Das ist der Unterschied zwischen einer Webseite und einer Anwendung: **Sie bauen den Platz, die Inhalte kommen später von selbst.**

---

## 8 Typische Fehler und woran man sie erkennt

| Was Sie sehen | Wahrscheinliche Ursache |
|---|---|
| Ab einer Stelle ist alles verrutscht | Ein `</div>` oder `</textarea>` fehlt |
| Ein Element erscheint gar nicht | Tippfehler im Tag-Namen oder fehlende Anführungszeichen |
| Alles ist plötzlich riesig | Ein `</h1>` oder `</h2>` fehlt |
| Der graue Hinweistext ist weg | Sie haben ins Feld getippt – Feld leeren, er kommt zurück |
| Die Liste ist unsichtbar | Sie ist leer. Das ist richtig so. |

**Zwei Handgriffe, die fast immer helfen:**

1. Die Einrückung ansehen. Wandert sie nach rechts und kommt nicht zurück, fehlt ein Ende-Tag.
2. Im Editor auf eine spitze Klammer klicken – er zeigt die zugehörige an.

---

## 9 Wörter von heute

| Wort | Bedeutung in einem Satz |
|---|---|
| **HTML** | Die Sprache, in der die Struktur einer Oberfläche beschrieben wird. |
| **Tag** | Eine Marke in spitzen Klammern, ausgesprochen „Täg". Es gibt Start- und Ende-Tags. |
| **Element** | Start-Tag, Inhalt und Ende-Tag zusammen. |
| **Attribut** | Zusatzangabe im Start-Tag, zum Beispiel `id="knopf-neu"`. |
| **Verschachtelung** | Elemente liegen ineinander. |
| **Einrückung** | Leerzeichen am Zeilenanfang, die die Verschachtelung sichtbar machen. |

---

## 10 Was Sie nach dieser Einheit können sollten

- [ ] Ein Element aus Start-Tag, Inhalt und Ende-Tag beschreiben
- [ ] Verschachtelung lesen und selbst korrekt schreiben
- [ ] Die acht Elemente des Kurses einsetzen
- [ ] Den Unterschied zwischen `<input>` und `<textarea>` nennen
- [ ] Attribute setzen, insbesondere `id`
- [ ] Erklären, warum eine `id` nur einmal vorkommen darf

---

## Verknüpfung

Übungen: [[K1c Übungsblatt]] · [[Anhang Befehlskarte]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

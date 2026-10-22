---
title: HTML – die Struktur – Merkblatt
modul: K1
typ: merkblatt
aliases:
  - K1b Handout
tags: [tauri/kompaktkurs/merkblatt, html]
status: active
---

# K1 – Merkblatt

## Wie ein Element aufgebaut ist

```
<p>Hallo</p>
 │  │    │
 │  │    └─ Ende-Tag
 │  └────── Inhalt: was im Fenster erscheint
 └───────── Start-Tag
```

**Element = Start-Tag + Inhalt + Ende-Tag.**

Fehlt das Ende-Tag, nimmt das Programm an, das Element hört nie auf.

## Verschachtelung

```
richtig:  <div><p>Text</p></div>
falsch:   <div><p>Text</div></p>
```

**Was zuletzt aufgemacht wurde, wird zuerst wieder zugemacht.**

Einrückung: zwei Leerzeichen je Ebene. Dem Rechner egal, für den Menschen entscheidend – wandert die Einrückung nach rechts und kommt nicht zurück, fehlt ein Ende-Tag.

## Die acht Elemente

| Element | Wofür | Beispiel |
|---|---|---|
| `<h1>`, `<h2>` | Überschriften (Rangfolge, keine Größe) | `<h1>Lernkarten</h1>` |
| `<p>` | Textabsatz | `<p>Noch keine Karte</p>` |
| `<div>` | unsichtbarer Bereich zum Gruppieren | `<div>…</div>` |
| `<button>` | Knopf | `<button>Umdrehen</button>` |
| `<input>` | einzeiliges Eingabefeld | `<input type="text" />` |
| `<textarea>` | mehrzeiliges Eingabefeld | `<textarea></textarea>` |
| `<ul>`, `<li>` | Liste und Listeneintrag | `<ul><li>Eintrag</li></ul>` |
| `<span>` | kleiner Bereich mitten im Text | `<p>Karte <span>3</span></p>` |

## Die eine Ausnahme

```html
<input placeholder="Frage" />          ← ohne Ende-Tag
<textarea placeholder="Antwort"></textarea>   ← mit Ende-Tag
```

Unlogisch, aber so ist es. Nicht verstehen, nur wissen.

## Die vier Attribute

| Attribut | Wofür |
|---|---|
| `id` | Name eines einzelnen Elements. Wird ab [[K4 JavaScript im Fenster]] angesprochen. |
| `class` | Gruppenname. Mehrere Elemente dürfen dieselbe Klasse haben. |
| `placeholder` | Grauer Hinweistext im Eingabefeld. Verschwindet beim Tippen. |
| `type` | Sorte des Eingabefelds. Im Kurs nur `type="text"`. |

Ein Attribut steht **im Start-Tag**, niemals im Ende-Tag. Der Wert steht immer in Anführungszeichen.

```
<button id="knopf-umdrehen">Umdrehen</button>
        └─┬┘ └──────┬──────┘
          │         └─ Wert
          └─ Attributname
```

## `id` und `class`

> Die **`id`** ist der eigene Name – den gibt es nur einmal.
> Die **`class`** ist die Schulklasse – die wird mit anderen geteilt.

### Die vier Regeln für `id`-Namen

1. **Alles klein** — `frage-feld`, nicht `Frage-Feld`
2. **Kein Leerzeichen**, stattdessen Bindestrich — `karten-liste`
3. **Auf Deutsch** — `knopf-neu`, nicht `new-button`
4. **Jede `id` nur einmal im ganzen Dokument**

Regeln 1 bis 3 sind Kursregeln. Regel 4 ist eine echte Vorschrift: Ein Name, der zweimal vergeben ist, ist kein Name mehr.

> [!danger] Regel 4 bricht erst in K4
> Eine doppelte `id` fällt hier nicht auf. In [[K4 JavaScript im Fenster]] wird dann stumm das falsche Element angesprochen – ein Fehler ohne Fehlermeldung.

## Die zehn `id`-Namen der Oberfläche

| `id` | wofür |
|---|---|
| `eingabe` | Bereich zum Anlegen einer Karte |
| `frage-feld` | Eingabefeld für die Frage |
| `antwort-feld` | mehrzeiliges Feld für die Antwort |
| `knopf-neu` | Knopf „Karte anlegen" |
| `anzeige` | Bereich, in dem die aktuelle Karte steht |
| `karte-frage` | Absatz mit der Frage der aktuellen Karte |
| `karte-antwort` | Absatz mit der Antwort, zunächst leer |
| `knopf-umdrehen` | Knopf „Umdrehen" |
| `knopf-weiter` | Knopf „Nächste" |
| `karten-liste` | Liste aller angelegten Karten, zunächst leer |

## Fehlerbild und Diagnose

| Was zu sehen ist | Wahrscheinliche Ursache |
|---|---|
| Ab einer Stelle ist alles verrutscht | ein `</div>` oder `</textarea>` fehlt |
| Ein Element erscheint gar nicht | Tippfehler im Tag-Namen oder fehlende Anführungszeichen |
| Alles ist plötzlich riesig | ein `</h1>` oder `</h2>` fehlt |
| Der graue Hinweistext ist weg | es wurde ins Feld getippt – Feld leeren, er kommt zurück |
| Die Liste ist unsichtbar | sie ist leer. Das ist richtig so. |

**Zwei Handgriffe, die fast immer helfen:**

1. **Einrückung ansehen.** Wandert sie nach rechts und kommt nicht zurück, fehlt ein Ende-Tag.
2. **Im Editor auf eine spitze Klammer klicken** – er zeigt die zugehörige an. Findet er keine, ist das der Beweis.

## Wörter

| Wort | Bedeutung in einem Satz |
|---|---|
| **HTML** | Die Sprache, in der die Struktur einer Oberfläche beschrieben wird. |
| **Tag** | Eine Marke in spitzen Klammern. Es gibt Start- und Ende-Tags. |
| **Element** | Start-Tag, Inhalt und Ende-Tag zusammen. |
| **Attribut** | Zusatzangabe im Start-Tag, zum Beispiel `id="knopf-neu"`. |
| **Verschachtelung** | Elemente liegen ineinander. |
| **Einrückung** | Leerzeichen am Zeilenanfang, die die Verschachtelung sichtbar machen. |

## Verknüpfung

Leitfaden: [[K1 HTML – die Struktur]] · Übungen: [[K1 Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

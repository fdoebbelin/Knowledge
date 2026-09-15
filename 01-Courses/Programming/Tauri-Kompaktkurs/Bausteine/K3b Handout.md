---
baustein: K3
typ: handout
title: JavaScript – die Bausteine – Handout
ue: 6
kurstag: 2-3
tags: [tauri/kompaktkurs/handout, javascript]
status: entwurf
---

# K3 – JavaScript – die Bausteine

> [!abstract] Worum es in dieser Einheit geht
> Sie lernen die Sprache, mit der Ihre Anwendung später denkt. **Im Fenster wird sich nichts verändern** – alle Ergebnisse erscheinen in der Konsole. Das ist so geplant: erst die Sprache, dann die Wirkung.

> [!important] Wenn es sich zäh anfühlt
> Das ist normal und war eingeplant. Es ist der schwerste Abschnitt der Woche, und er ist der einzige ohne optische Rückmeldung. Morgen kommt alles zusammen, und dann funktionieren die Knöpfe.

---

## 1 Die Konsole

Rechtsklick im Anwendungsfenster → **Element untersuchen** → Reiter **Konsole**.

Die Konsole bleibt ab jetzt den ganzen Kurs über offen. Sie ist Ihr wichtigstes Werkzeug: Hier erscheint alles, was Ihr Programm ausgibt, und alle Fehlermeldungen.

```js
console.log("Hallo Konsole");
```

> [!warning] Zwei Ausgabeorte nicht verwechseln
> Das **Terminal** zeigt Meldungen des Programmkerns.
> Die **Konsole** zeigt Meldungen aus dem Fenster – also alles, was Sie in `app.js` schreiben.

Sie können unten in der Konsole auch selbst Befehle eintippen. Das ist zum Ausprobieren praktisch, aber alles Getippte ist beim nächsten Neuladen weg. Was bleiben soll, gehört in `app.js`.

> [!note] Das ständige `undefined`
> Nach jedem Befehl, den Sie in die Konsole tippen, erscheint zusätzlich eine Zeile `undefined`. Das ist die Antwort auf „Und was ist dabei herausgekommen?" – bei `console.log` kommt nichts heraus. Diese Zeile können Sie ignorieren.

Nach jeder Änderung an `app.js`: speichern und im Fenster **neu laden** (Rechtsklick → Neu laden).

---

## 2 Variablen

Eine Variable ist eine beschriftete Schublade. Der Name steht links, der Inhalt rechts, das Gleichheitszeichen legt hinein.

```js
const name = "Anna";
let punkte = 0;
```

| | Bedeutung |
|---|---|
| `const` | Diese Schublade wird einmal gefüllt und danach nicht mehr. |
| `let` | Der Inhalt darf wechseln. |

```js
punkte = 10;        // geht
name = "Bernd";     // Fehlermeldung
```

> [!important] Kursregel
> **Im Zweifel `const`.** Das Programm sagt Ihnen, wenn es nicht geht – dann ändern Sie es in `let`. Andersherum merkt es niemand.

`var` gibt es auch. Das ist die alte dritte Form und kommt im Kurs nicht vor.

---

## 3 Die Datentypen

```js
const anzahl = 3;                 // Zahl, ohne Anführungszeichen
const frage = "Was ist HTML?";    // Text, mit Anführungszeichen
const umgedreht = false;          // Wahrheitswert: nur true oder false
```

Der Unterschied steckt in den Anführungszeichen. `3` ist eine Zahl, mit der man rechnen kann. `"3"` ist ein Text, der zufällig aus einer Ziffer besteht:

```js
console.log(3 + 4);        // 7
console.log("3" + "4");    // 34
```

Bei Texten heißt das Plus nicht „rechne", sondern „häng aneinander":

```js
const gruss = "Hallo " + name + "!";
```

Auf das Leerzeichen achten – es fehlt beim ersten Versuch fast immer.

`.trim()` entfernt Leerzeichen am Anfang und Ende eines Textes:

```js
const eingabe = "  Anna  ";
console.log(eingabe.trim());   // "Anna"
```

Dazu kommen zwei **Sammelformen**: die Liste (Abschnitt 6) und das Objekt (Abschnitt 7).

---

## 4 Funktionen

```
        ┌──────────────────────────┐
"Anna" ─┤  begruessung(name)       ├─→ "Hallo Anna"
hinein  │  macht immer dasselbe    │   heraus
        └──────────────────────────┘
```

Eine Funktion ist eine Maschine: Oben kommt etwas hinein, unten kommt etwas heraus, und dazwischen passiert immer dasselbe.

```js
function begruessung(name) {
  return "Hallo " + name;
}

console.log(begruessung("Anna"));
```

| Teil | Bedeutung |
|---|---|
| `function` | „Achtung, jetzt kommt eine Maschine" |
| `begruessung` | ihr Name, frei gewählt |
| `(name)` | was hineingeht – der **Parameter** |
| `{ … }` | was drin passiert |
| `return` | was herauskommt |
| `begruessung("Anna")` | die Maschine anwerfen – der **Aufruf** |

> [!danger] Der häufigste Fehler des ganzen Kurses
> **Eine Funktion aufschreiben heißt nicht, sie zu benutzen.**
>
> Wird sie nie aufgerufen, passiert nichts – und es gibt **keine Fehlermeldung**. Wenn Ihr Programm scheinbar gar nichts tut, prüfen Sie zuerst, ob der Aufruf fehlt.

### Die drei Fragen

An jeder Funktion beantwortbar:

1. **Was geht hinein?** → die Klammer hinter dem Namen
2. **Was kommt heraus?** → was hinter `return` steht
3. **Wann passiert etwas?** → beim Aufruf, nicht beim Aufschreiben

### `return` ist nicht `console.log`

```js
function variante1(zahl) {
  return zahl * 2;
}

function variante2(zahl) {
  console.log(zahl * 2);
}

const a = variante1(5);   // a ist 10
const b = variante2(5);   // b ist undefined
```

> [!tip] Merksatz
> **`console.log` ist Reden. `return` ist Abliefern.**
> Wer mit dem Ergebnis weiterarbeiten will, braucht `return`.

Fehlt `return`, kommt `undefined` heraus.

---

## 5 Entscheidungen mit `if`

```js
if (punkte > 10) {
  console.log("geschafft");
} else {
  console.log("weiter üben");
}
```

Stimmt die Bedingung in der Klammer, läuft der erste Block. Sonst der zweite. Der `else`-Teil ist freiwillig.

| Zeichen | Bedeutung |
|---|---|
| `>` | größer als |
| `<` | kleiner als |
| `===` | ist gleich |
| `!==` | ist ungleich |

> [!important] Kursregel
> **Immer `===`, nie `==`.** Es gibt beides, das kürzere arbeitet ungenauer. In diesem Kurs gilt: `===` vergleichen, `=` zuweisen.

```js
if (punkte = 10) { … }     // falsch – das weist zu
if (punkte === 10) { … }   // richtig – das vergleicht
```

Ein Gleichheitszeichen legt in die Schublade. Drei fragen, was drin ist. Die Verwechslung erzeugt **keine** Fehlermeldung.

`if` lässt sich mit `return` verbinden:

```js
function bewertung(anzahl) {
  if (anzahl > 10) {
    return "schon ein guter Stapel";
  } else {
    return "da geht noch mehr";
  }
}
```

---

## 6 Listen

```js
const farben = ["rot", "gruen", "blau"];
```

Eckige Klammern, Werte mit Komma getrennt. Eine Schublade mit mehreren Fächern.

| Zugriff | Ergebnis |
|---|---|
| `farben[0]` | `"rot"` |
| `farben[1]` | `"gruen"` |
| `farben[2]` | `"blau"` |
| `farben.length` | `3` |

> [!warning] Der Index beginnt bei null
> Drei Einträge, aber der letzte hat die Nummer **zwei**. Das ist gewöhnungsbedürftig und die Quelle vieler Fehler. Zählen Sie einmal laut mit: null, eins, zwei.

### Ergänzen

```js
farben.push("gelb");
console.log(farben.length);   // 4
```

`push` hängt hinten an. Der Punkt heißt: Diese Sache kann etwas.

> [!note] Warum geht `push` bei `const`?
> Weil sich die Schublade nicht ändert, nur ihr Inhalt. `const` verbietet, eine **andere** Liste hineinzulegen – nicht, die vorhandene zu füllen.

### Durchlaufen

```js
for (const farbe of farben) {
  console.log(farbe);
}
```

Wörtlich gelesen: *für jede Farbe aus den Farben, tu Folgendes.* Der Name `farbe` ist frei gewählt und gilt nur innerhalb der Klammern.

> [!tip] Namensregel
> Einzahl aus der Mehrzahl: `for (const karte of karten)`. Wer das durchhält, liest seinen eigenen Code später noch.

Das klassische `for (let i = 0; …)` kommt im Kurs nicht vor.

---

## 7 Objekte

```js
const karte = {
  frage: "Was ist HTML?",
  antwort: "Die Struktur einer Seite"
};

console.log(karte.frage);
```

Geschweifte Klammern, innen Paare aus Feldname und Wert, getrennt durch Doppelpunkt. Zugriff über den Punkt.

> [!important] Der Vergleich, der alles klärt
> **Liste** = Regal mit **nummerierten** Fächern → `farben[0]`
> **Objekt** = Regal mit **beschrifteten** Fächern → `karte.frage`

Eckige Klammer und Zahl bei der Liste. Punkt und Name beim Objekt. Wer das vertauscht, bekommt `undefined`.

### Felder ändern und ergänzen

```js
karte.antwort = "Die Struktur";   // ändern
karte.gezeigt = false;            // neues Feld anlegen
```

---

## 8 Der Datenbestand der Anwendung

Listen und Objekte zusammen ergeben das, worauf der ganze Kurs hinausläuft:

```js
const karten = [
  { frage: "Was ist HTML?", antwort: "Die Struktur einer Seite" },
  { frage: "Was ist CSS?", antwort: "Das Aussehen einer Seite" },
  { frage: "Was ist eine id?", antwort: "Der Name eines Elements" }
];

for (const karte of karten) {
  console.log(karte.frage);
}
```

Eine Liste, darin drei Objekte, jedes mit den Feldern `frage` und `antwort`.

| Ausdruck | Was dabei herauskommt |
|---|---|
| `karten` | die ganze Liste |
| `karten.length` | wie viele Karten |
| `karten[0]` | die erste Karte – ein **Objekt** |
| `karten[0].frage` | deren Frage – ein **Text** |

Die letzte Zeile kombiniert beide Zugriffsarten. Wer sie in Worte auflösen kann, hat den Abschnitt verstanden.

**Alles, was Ihr Programm über Karten weiß, steht ab jetzt hier drin.** Jede Karte, die Sie morgen anlegen, wird ein weiteres Objekt in dieser Liste.

---

## 9 Referenzfassung `app.js`

Der Stand am Ende dieser Einheit:

```js
// Lernkarten – Datenbestand und erste Funktionen
// Noch nichts im Fenster sichtbar, alle Ausgaben in der Konsole

const karten = [
  { frage: "Was ist HTML?", antwort: "Die Struktur einer Seite" },
  { frage: "Was ist CSS?", antwort: "Das Aussehen einer Seite" },
  { frage: "Was ist eine id?", antwort: "Der Name eines Elements" }
];

let aktuelleKarte = 0;

function anzahlKarten() {
  return karten.length;
}

function karteAnlegen(frage, antwort) {
  const neueKarte = { frage: frage, antwort: antwort };
  karten.push(neueKarte);
  return neueKarte;
}

function alleFragenAusgeben() {
  for (const karte of karten) {
    console.log(karte.frage);
  }
}

console.log("Karten geladen:", anzahlKarten());
alleFragenAusgeben();
```

> [!note] Warum `let aktuelleKarte`?
> Weil sich die Nummer der angezeigten Karte dauernd ändert, sobald morgen der Knopf „Nächste" funktioniert. Genau dafür gibt es `let`.

---

## 10 Fehlersuche

> [!important] Die Diagnosetabelle
> | Was Sie sehen | Was das meistens heißt |
> |---|---|
> | **gar nichts**, keine Meldung | Funktion nie aufgerufen |
> | **`undefined`** | da war nichts, wo etwas sein sollte: `return` vergessen, Index zu groß oder Feldname falsch |
> | **rote Meldung** | erste Zeile lesen, Zeilennummer merken, dort anfangen |

Lesen Sie bei einer Fehlermeldung **nur die erste Zeile**. Der Rest darunter ist für Leute, die den Browser gebaut haben.

| Weitere typische Fälle | Ursache |
|---|---|
| `if` verhält sich unlogisch | `=` statt `===` |
| Zugriff liefert nichts | `liste.feld` statt `liste[0]`, oder umgekehrt |
| Änderung wirkt nicht | nach dem Speichern nicht neu geladen |
| Ausgabe nicht auffindbar | im Terminal gesucht statt in der Konsole |

---

## 11 Wörter von heute

| Wort | Bedeutung in einem Satz |
|---|---|
| **JavaScript** | Die Sprache, in der beschrieben wird, was passiert. |
| **Variable** | Eine beschriftete Schublade für einen Wert. |
| **Funktion** | Eine Maschine: etwas hinein, etwas heraus. |
| **Parameter** | Was in die Funktion hineingeht. |
| **Aufruf** | Die Funktion anwerfen. Ohne ihn passiert nichts. |
| **`return`** | Was die Funktion abliefert. |
| **Liste** | Mehrere Werte in nummerierten Fächern. |
| **Index** | Die Nummer eines Fachs. Beginnt bei null. |
| **Objekt** | Mehrere Werte in beschrifteten Fächern. |
| **Feld** | Ein beschriftetes Fach eines Objekts. |
| **`undefined`** | Da war nichts, wo etwas sein sollte. |
| **Konsole** | Das Ausgabefenster für alles aus `app.js`. |

---

## 12 Was Sie nach dieser Einheit können sollten

- [ ] Werte in Variablen ablegen und wieder auslesen
- [ ] `const` und `let` unterscheiden
- [ ] Zahl, Text und Wahrheitswert auseinanderhalten
- [ ] Eine Funktion schreiben, aufrufen und ein Ergebnis zurückgeben
- [ ] `return` von `console.log` unterscheiden
- [ ] Mit `if` Entscheidungen treffen
- [ ] Eine Liste anlegen, ergänzen, zählen und durchlaufen
- [ ] Ein Objekt anlegen und auf seine Felder zugreifen
- [ ] `karten[0].frage` in Worte auflösen
- [ ] Die drei Zeilen der Diagnosetabelle anwenden

---

## Verknüpfung

Übungen: [[K3c Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

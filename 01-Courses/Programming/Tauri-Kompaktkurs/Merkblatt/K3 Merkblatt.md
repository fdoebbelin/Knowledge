---
title: JavaScript – die Bausteine – Merkblatt
modul: K3
typ: merkblatt
aliases:
  - K3b Handout
tags: [tauri/kompaktkurs/merkblatt, javascript]
status: active
---

# K3 – Merkblatt

## Die Konsole

Rechtsklick im Anwendungsfenster → **Element untersuchen** → Reiter **Konsole**.

| Ort | Zeigt |
|---|---|
| **Terminal** | Meldungen des Programmkerns |
| **Konsole** | alles aus `app.js` |

In der Konsole kann man selbst Befehle eintippen – beim nächsten Neuladen ist alles weg. Was bleiben soll, gehört in `app.js`.

Nach jedem Befehl in der Konsole erscheint zusätzlich `undefined`. Das ist normal und kann ignoriert werden.

## Variablen

```js
const name = "Anna";
let punkte = 0;
```

| | Bedeutung |
|---|---|
| `const` | wird einmal gefüllt und danach nicht mehr |
| `let` | der Inhalt darf wechseln |

**Kursregel: Im Zweifel `const`.** `var` kommt im Kurs nicht vor.

## Die Datentypen

```js
const anzahl = 3;                 // Zahl, ohne Anführungszeichen
const frage = "Was ist HTML?";    // Text, mit Anführungszeichen
const umgedreht = false;          // Wahrheitswert: nur true oder false
```

```js
console.log(3 + 4);        // 7
console.log("3" + "4");    // 34
```

Bei Texten heißt das Plus „häng aneinander", nicht „rechne".

```js
const gruss = "Hallo " + name + "!";   // Leerzeichen nicht vergessen
const eingabe = "  Anna  ";
console.log(eingabe.trim());            // "Anna"
```

## Funktionen

```
        ┌──────────────────────────┐
"Anna" ─┤  begruessung(name)       ├─→ "Hallo Anna"
 hinein  │  macht immer dasselbe    │   heraus
        └──────────────────────────┘
```

```js
function begruessung(name) {
  return "Hallo " + name;
}

console.log(begruessung("Anna"));
```

| Teil | Bedeutung |
|---|---|
| `function` | jetzt kommt eine Maschine |
| `begruessung` | ihr Name, frei gewählt |
| `(name)` | was hineingeht – der **Parameter** |
| `{ … }` | was drin passiert |
| `return` | was herauskommt |
| `begruessung("Anna")` | die Maschine anwerfen – der **Aufruf** |

> [!danger] **Eine Funktion aufschreiben heißt nicht, sie zu benutzen.**
> Wird sie nie aufgerufen, passiert nichts – und es gibt **keine Fehlermeldung**.

**Die drei Fragen:**

1. **Was geht hinein?** → die Klammer hinter dem Namen
2. **Was kommt heraus?** → was hinter `return` steht
3. **Wann passiert etwas?** → beim Aufruf, nicht beim Aufschreiben

> [!tip] **`console.log` ist Reden. `return` ist Abliefern.**
> Wer mit dem Ergebnis weiterarbeiten will, braucht `return`. Fehlt es, kommt `undefined` heraus.

## Entscheidungen

```js
if (punkte > 10) {
  console.log("geschafft");
} else {
  console.log("weiter üben");
}
```

| Zeichen | Bedeutung |
|---|---|
| `>` | größer als |
| `<` | kleiner als |
| `===` | ist gleich |
| `!==` | ist ungleich |

> **Kursregel: Immer `===`, nie `==`.** `===` vergleichen, `=` zuweisen.
> Ein `=` legt in die Schublade, drei `=` fragen, was drin ist. Die Verwechslung erzeugt **keine** Fehlermeldung.

## Listen

```js
const farben = ["rot", "gruen", "blau"];
```

| Zugriff | Ergebnis |
|---|---|
| `farben[0]` | `"rot"` |
| `farben[1]` | `"gruen"` |
| `farben[2]` | `"blau"` |
| `farben.length` | `3` |

> **Der Index beginnt bei null.** Drei Einträge, aber der letzte hat die Nummer zwei.

```js
farben.push("gelb");          // hängt hinten an
console.log(farben.length);   // 4
```

```js
for (const farbe of farben) {
  console.log(farbe);
}
```

> „Für jede Farbe aus den Farben, tu Folgendes." – Einzahl aus der Mehrzahl: `for (const karte of karten)`.

## Objekte

```js
const karte = {
  frage: "Was ist HTML?",
  antwort: "Die Struktur einer Seite"
};

console.log(karte.frage);
```

> **Liste** = Regal mit **nummerierten** Fächern → `farben[0]`
> **Objekt** = Regal mit **beschrifteten** Fächern → `karte.frage`

Eckige Klammer und Zahl bei der Liste, Punkt und Name beim Objekt. Wer das vertauscht, bekommt `undefined`.

```js
karte.antwort = "Die Struktur";   // ändern
karte.gezeigt = false;             // neues Feld anlegen
```

## Der Datenbestand

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

| Ausdruck | Was herauskommt |
|---|---|
| `karten` | die ganze Liste |
| `karten.length` | wie viele Karten |
| `karten[0]` | die erste Karte – ein **Objekt** |
| `karten[0].frage` | deren Frage – ein **Text** |

```js
let aktuelleKarte = 0;

function anzahlKarten() {
  return karten.length;
}

function karteAnlegen(frage, antwort) {
  const neueKarte = { frage: frage, antwort: antwort };
  karten.push(neueKarte);
  return neueKarte;
}
```

`aktuelleKarte` ist ein `let`, weil sich die Nummer der angezeigten Karte dauernd ändert.

## Die Diagnosetabelle

| Was zu sehen ist | Was das meistens heißt |
|---|---|
| **gar nichts**, keine Meldung | Funktion nie aufgerufen |
| **`undefined`** | da war nichts, wo etwas sein sollte: `return` vergessen, Index zu groß, Feldname falsch |
| **rote Meldung** | erste Zeile lesen, Zeilennummer merken, dort anfangen |

| Weitere Fälle | Ursache |
|---|---|
| `if` verhält sich unlogisch | `=` statt `===` |
| Zugriff liefert nichts | `liste.feld` statt `liste[0]`, oder umgekehrt |
| Änderung wirkt nicht | nach dem Speichern nicht neu geladen |
| Ausgabe nicht auffindbar | im Terminal gesucht statt in der Konsole |

Bei einer Fehlermeldung **nur die erste Zeile** lesen. Der Rest darunter ist für Leute, die den Browser gebaut haben.

## Wörter

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

## Verknüpfung

Leitfaden: [[K3 JavaScript – die Bausteine]] · Übungen: [[K3 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

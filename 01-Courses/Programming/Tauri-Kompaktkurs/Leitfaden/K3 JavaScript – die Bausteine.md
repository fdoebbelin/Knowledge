---
title: JavaScript – die Bausteine
modul: K3
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, javascript]
status: active
---

# K3 – JavaScript – die Bausteine

## Inhaltsübersicht

- Die Ansage: warum im Fenster nichts passiert
- Die Konsole
- Variablen
- Die Datentypen
- Funktionen
- Entscheidungen mit `if`
- Listen
- Objekte
- Beides zusammen: der Datenbestand
- Absichtlicher Fehler: `undefined` und die rote Meldung
- Die Diagnosetabelle
- Typische Stolperstellen
- Stand am Ende des Moduls

Hier wird die Sprache eingeführt, mit der die Anwendung später denkt. **Im Fenster verändert sich nichts** – alle Ergebnisse erscheinen in der Konsole.

> [!danger] Der schwerste Abschnitt des Kurses
> Zwei Dinge kommen zusammen: Es ist neuer Denkstoff, und es ist **im Fenster nichts sichtbar**. Nach den Tagen mit sofortiger optischer Rückmeldung ist das ein Entzug.
>
> Das muss zu Beginn ausdrücklich gesagt werden. Ein angekündigter Durststrecke wird ausgehalten, eine unerwartete nicht.

> [!tip] Was hier noch nicht kommt
> Kein Zugriff auf das Fenster, kein `document.querySelector`, kein `addEventListener`. Das kommt in [[K4 JavaScript im Fenster]] und ist die Belohnung für diesen Abschnitt. Wer hier vorgreift, nimmt dem nächsten Modul den gesamten Aufhänger.

## Die Konsole

Rechtsklick ins Anwendungsfenster → **Element untersuchen** → Reiter **Konsole**.

> „Das ist ab jetzt Ihr wichtigstes Werkzeug. Sie bleibt den Rest des Kurses offen. Alles, was Sie schreiben, erscheint hier – und alle Fehlermeldungen auch."

Erste Zeile in `src/app.js`:

```js
console.log("Hallo Konsole");
```

Speichern, neu laden, hinsehen.

> [!warning] Zwei Ausgabeorte auseinanderhalten
> Das **Terminal** zeigt Meldungen des Programmkerns, die **Konsole** zeigt Meldungen aus dem Fenster – also alles, was in `app.js` steht. Wer hier im Terminal sucht, findet nichts. Einmal ausdrücklich sagen und auf beide zeigen.

Unten in der Konsole kann man auch selbst Befehle eintippen. Das ist zum Ausprobieren erlaubt und schnell. **Aber:** Alles Getippte ist beim nächsten Neuladen weg. Was bleiben soll, gehört in `app.js`.

> [!note] Das ständige `undefined`
> Nach jedem Befehl, der in die Konsole getippt wird, erscheint zusätzlich eine Zeile `undefined`. Das ist die Antwort auf „Und was ist dabei herausgekommen?" – bei `console.log` kommt nichts heraus, es wird nur ausgegeben. Diese Zeile kann ignoriert werden.

## Variablen

```js
const name = "Anna";
let punkte = 0;
console.log(name);
console.log(punkte);
```

> „Eine Variable ist eine beschriftete Schublade. Sie legen etwas hinein und können es später über die Beschriftung wieder herausholen. Der Name links, der Inhalt rechts, das Gleichheitszeichen legt hinein."

| | Bedeutung |
|---|---|
| `const` | Diese Schublade wird einmal gefüllt und danach nicht mehr. |
| `let` | Der Inhalt darf wechseln. |

```js
punkte = 10;        // geht
name = "Bernd";     // Fehlermeldung
```

Ausprobieren lassen, die Fehlermeldung gemeinsam lesen.

> „`const` heißt: Diese Schublade wird einmal gefüllt und danach nicht mehr. `let` heißt: Der Inhalt darf wechseln. **Kursregel: Im Zweifel `const`.** Das Programm sagt Ihnen, wenn es nicht geht – und dann ändern Sie es in `let`. Andersherum merkt es niemand."

> [!note] `var` kommt nicht vor
> Wird beim Nachschlagen im Netz gefunden werden. Antwort in einem Satz: „Das ist die alte dritte Form. Drei Schreibweisen für dasselbe zu lernen ist Zeitverschwendung – wir nehmen die zwei aktuellen."

Reihum: jede Person legt drei Variablen an, gibt sie aus, und versucht einmal, eine `const` zu überschreiben, um die Fehlermeldung zu sehen.

## Die Datentypen

```js
const anzahl = 3;                 // Zahl, ohne Anführungszeichen
const frage = "Was ist HTML?";    // Text, mit Anführungszeichen
const umgedreht = false;          // Wahrheitswert: nur true oder false
```

> „Drei Sorten von Werten, und der Unterschied steckt in den Anführungszeichen. `3` ist eine Zahl, mit der man rechnen kann. `"3"` ist ein Text, der zufällig aus einer Ziffer besteht."

```js
console.log(3 + 4);        // 7
console.log("3" + "4");    // 34
```

> „Beim Text bedeutet das Plus nicht ‚rechne', sondern ‚häng aneinander'. Das ist keine Marotte, das brauchen wir gleich dauernd."

Texte verbinden:

```js
const gruss = "Hallo " + name + "!";
console.log(gruss);
```

Auf das Leerzeichen hinweisen – es fehlt beim ersten Versuch immer.

`.trim()` in einem Satz:

```js
const eingabe = "  Anna  ";
console.log(eingabe.trim());
```

> „Das entfernt Leerzeichen am Anfang und Ende. Klingt nach einer Kleinigkeit – aber wenn jemand versehentlich ein Leerzeichen eintippt, ist die Eingabe für das Programm nicht mehr leer. Wir brauchen das später."

Ausblick, ohne Details:

> „Es gibt noch zwei Sorten, und die sind die wichtigsten: eine für viele Werte auf einmal und eine für zusammengehörige Werte. Die kommen gleich."

## Funktionen

> [!danger] Der schwierigste Abschnitt
> Hier Zeit nehmen, nichts vorziehen. Wer hier stolpert, versteht den Rest des Kurses nicht.

### Das Bild

```
        ┌──────────────────────────┐
"Anna" ─┤  begruessung(name)       ├─→ "Hallo Anna"
 hinein  │  macht immer dasselbe    │   heraus
        └──────────────────────────┘
```

> „Eine Funktion ist eine Maschine. Oben kommt etwas hinein, unten kommt etwas heraus, und dazwischen passiert immer dasselbe. Ein Fleischwolf: Sie geben Fleisch hinein, es kommt Hack heraus. Was Sie hineingeben, entscheiden Sie – was die Maschine tut, steht ein für alle Mal fest."

### Die erste Funktion

```js
function begruessung(name) {
  return "Hallo " + name;
}

console.log(begruessung("Anna"));
```

Zeile für Zeile, langsam:

| Teil | Was es bedeutet |
|---|---|
| `function` | „Achtung, jetzt kommt eine Maschine" |
| `begruessung` | ihr Name – frei gewählt, wie bei einer Variablen |
| `(name)` | was hineingeht. Der **Parameter**. |
| `{ … }` | was drin passiert |
| `return` | was herauskommt |
| `begruessung("Anna")` | die Maschine **anwerfen**. Ohne diese Zeile passiert nichts. |

> [!danger] Der häufigste Fehler des ganzen Kurses beginnt hier
> **Funktion definiert, aber nie aufgerufen.** Es passiert nichts, und es gibt **keine Fehlermeldung**. Das ist die schlimmste Kombination für Anfänger.
>
> Sofort vorführen: die letzte Zeile auskommentieren, speichern, hinsehen. Nichts. Dann wieder hinein. Und den Merksatz an die Tafel:
>
> **Eine Funktion aufschreiben heißt nicht, sie zu benutzen.**

### Die drei Fragen

Jede Person muss sie an einer beliebigen Funktion beantworten können:

```
1. Was geht hinein?      → die Klammer hinter dem Namen
2. Was kommt heraus?     → was hinter return steht
3. Wann passiert etwas?  → beim Aufruf, nicht beim Aufschreiben
```

Reihum an `begruessung` durchspielen, dann an einer zweiten Funktion:

```js
function doppelt(zahl) {
  return zahl * 2;
}
```

### `return` gegen `console.log`

Die Verwechslung ist garantiert. Deshalb aktiv vorwegnehmen:

```js
function variante1(zahl) {
  return zahl * 2;
}

function variante2(zahl) {
  console.log(zahl * 2);
}

const a = variante1(5);
const b = variante2(5);
console.log(a);    // 10
console.log(b);    // undefined
```

> „Beide zeigen eine 10 an. Aber nur die erste **gibt** auch eine 10 zurück. Die zweite sagt sie nur laut und behält nichts.
>
> `console.log` ist Reden. `return` ist Abliefern. Wenn Sie mit dem Ergebnis weiterarbeiten wollen, brauchen Sie `return`."

Und der Anschlussfehler:

> „Wenn `return` fehlt, kommt `undefined` heraus. Merken Sie sich dieses Wort – es heißt fast immer: Da war nichts, wo etwas hätte sein sollen."

Reihum: jede Person schreibt eine Funktion mit **einem** Parameter und einem `return`. Frei wählbar. Danach aufrufen und ausgeben. Die Kursleitung prüft dabei genau eines: **Wird sie auch aufgerufen?**

## Entscheidungen mit `if`

```js
let punkte = 12;

if (punkte > 10) {
  console.log("geschafft");
} else {
  console.log("weiter üben");
}
```

> „Wenn das in der Klammer stimmt, läuft der erste Block. Sonst der zweite. Der `else`-Teil ist freiwillig – manchmal gibt es nichts zu tun, wenn es nicht stimmt."

Wert ändern lassen, beide Zweige sehen.

| Zeichen | Bedeutung |
|---|---|
| `>` | größer als |
| `<` | kleiner als |
| `===` | ist gleich |
| `!==` | ist ungleich |

> [!important] Die Kursregel zu `===`
> **Immer drei Gleichheitszeichen, nie zwei.** Es gibt in JavaScript auch `==`, das arbeitet ungenauer. Den Unterschied zu erklären kostet mehr Zeit, als er einbringt. In diesem Kurs gilt: `===` vergleichen, `=` zuweisen. Ohne Ausnahme.

Der zweite garantierte Fehler:

```js
if (punkte = 10) { … }     // falsch: das weist zu
if (punkte === 10) { … }   // richtig: das vergleicht
```

> „Ein Gleichheitszeichen legt in die Schublade. Drei fragen, was drin ist. Verwechseln Sie das, macht Ihr Programm etwas völlig anderes als gedacht – und meldet keinen Fehler."

`if` mit `return` in einer Funktion kombinieren:

```js
function bewertung(anzahl) {
  if (anzahl > 10) {
    return "schon ein guter Stapel";
  } else {
    return "da geht noch mehr";
  }
}
```

Reihum: jede Person schreibt eine Funktion mit `if` und `return`.

> [!tip] Der Grenzfall
> Bei jeder Bedingung mit `>` oder `<` einmal fragen, was **am Rand** passiert. Bei genau 10 greift der `else`-Zweig, weil `>` echt größer bedeutet. Wer auch die 10 einschließen will, schreibt die Bedingung anders.

## Listen

### Anlegen und zugreifen

```js
const farben = ["rot", "gruen", "blau"];
console.log(farben.length);
console.log(farben[0]);
```

> „Eckige Klammern, Werte mit Komma dazwischen. Eine Schublade mit mehreren Fächern statt einem."

**Der Nullpunkt.** Gemeinsam an die Tafel und laut abzählen:

```
farben[0]  →  "rot"
farben[1]  →  "gruen"
farben[2]  →  "blau"
farben.length  →  3
```

> „Drei Einträge, aber der letzte hat die Nummer zwei. Das ist gewöhnungsbedürftig und die Quelle vieler Fehler. Zählen Sie es einmal gemeinsam mit mir ab, laut: null, eins, zwei."

Reihum: jede Person greift auf einen Eintrag zu und sagt vorher, welchen sie erwartet.

### Ergänzen

```js
farben.push("gelb");
console.log(farben.length);
```

> „`push` hängt hinten an. Der Punkt heißt: Diese Sache kann etwas. Wie ein Knopf an einem Gerät."

Hier die Rückfrage aufnehmen, die kommen wird:

> „Warum geht das bei `const`? Weil sich die Schublade nicht ändert, nur ihr Inhalt. `const` verbietet, eine **andere** Liste hineinzulegen – nicht, die vorhandene zu füllen. Das ist eine Feinheit, die Sie nicht begründen können müssen. Merken reicht."

### Durchlaufen

```js
for (const farbe of farben) {
  console.log(farbe);
}
```

> „Lesen Sie das wörtlich: für jede Farbe aus den Farben, tu Folgendes. Der Name `farbe` ist frei gewählt – er gilt nur innerhalb der Klammern und steht in jedem Durchgang für einen anderen Eintrag."

Sinnvolle Namensregel mitgeben:

> „Einzahl aus der Mehrzahl. `for (const farbe of farben)`, `for (const karte of karten)`. Wer das durchhält, liest seinen eigenen Code später noch."

> [!note] Das klassische `for` kommt nicht vor
> `for (let i = 0; i < liste.length; i++)` wird beim Nachschlagen auftauchen. Antwort: „Das ist die ältere Form mit drei Dingen in einer Zeile. Sie kann mehr, wir brauchen das Mehr nicht."

## Objekte

### Der Vergleich

An die Tafel:

```
Liste:   Regal mit NUMMERIERTEN Fächern    farben[0]
Objekt:  Regal mit BESCHRIFTETEN Fächern   karte.frage
```

```js
const karte = {
  frage: "Was ist HTML?",
  antwort: "Die Struktur einer Seite"
};

console.log(karte.frage);
console.log(karte.antwort);
```

> „Geschweifte Klammern, und innen Paare aus Beschriftung und Wert, getrennt durch Doppelpunkt. Zugriff über den Punkt und den Namen des Fachs."

### Die Verwechslung

Bewusst gegenüberstellen, weil sie sonst durcheinandergehen:

```js
farben[0]       // Liste: eckige Klammer, Nummer
karte.frage     // Objekt: Punkt, Name
```

> „Eckige Klammer und Zahl bei der Liste. Punkt und Name beim Objekt. Wenn Sie das vertauschen, bekommen Sie `undefined` – und Sie erinnern sich, was `undefined` heißt."

Reihum: jede Person legt ein Objekt mit drei Feldern an, das etwas aus ihrem Leben beschreibt, und gibt zwei Felder aus.

### Felder ändern und ergänzen

```js
karte.antwort = "Die Struktur";
karte.gezeigt = false;
console.log(karte);
```

> „Ein Feld ändern geht mit dem Gleichheitszeichen, wie bei einer Variablen. Und wenn Sie ein Fach beschriften, das es noch nicht gibt, wird es angelegt."

Das Ändern eines Feldes ist auch bei `const` erlaubt – genau wie bei `push` in einer Liste. Verboten wäre nur, ein **anderes** Objekt hineinzulegen.

### Verschachtelt lesen

Nur **lesen**, nicht schreiben lassen:

```js
const stapel = {
  titel: "Webtechniken",
  karte: { frage: "Was ist CSS?", antwort: "Das Aussehen" }
};

console.log(stapel.karte.frage);
```

> „Man kann Objekte ineinander legen. Sie brauchen das heute nicht selbst – aber Sie sollen es einmal gesehen haben, damit es Sie nicht überrascht."

## Beides zusammen: der Datenbestand

Listen und Objekte zusammen ergeben das, worauf der ganze Kurs hinausläuft.

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

**Langsam vorlesen lassen.** Eine Person liest die Struktur laut vor: „Eine Liste, darin drei Objekte, jedes mit den Feldern Frage und Antwort."

An die Tafel:

```
karten            → die ganze Liste
karten.length     → wie viele
karten[0]         → die erste Karte (ein Objekt)
karten[0].frage   → deren Frage (ein Text)
```

Die letzte Zeile gemeinsam durchsprechen – sie kombiniert beide Zugriffsarten und ist der eigentliche Verständnistest.

> „Und das ist der Datenbestand Ihrer Anwendung. Alles, was Ihr Programm über Karten weiß, steht ab jetzt hier drin. Jede Karte, die Sie später anlegen, wird ein weiteres Objekt in dieser Liste."

### Zwei Funktionen dazu

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

Auf `let aktuelleKarte` zeigen:

> „Das ist ein `let`, kein `const`. Warum? Weil sich die Nummer der angezeigten Karte dauernd ändert, sobald der Knopf ‚Nächste' funktioniert. Das ist der Fall, für den es `let` gibt."

`karteAnlegen` gemeinsam testen:

```js
karteAnlegen("Was ist eine Funktion?", "Eine Maschine mit rein und raus");
console.log(anzahlKarten());
```

## Absichtlicher Fehler: `undefined` und die rote Meldung

```js
console.log(karten[5]);
console.log(karten[5].frage);
```

Erste Zeile: `undefined`. Zweite Zeile: eine **echte Fehlermeldung** in Rot.

> „Die erste Zeile fragt nach einem Fach, das es nicht gibt. Antwort: `undefined` – da ist nichts. Kein Fehler, nur eine leere Antwort.
>
> Die zweite Zeile fragt dieses Nichts nach seiner Frage. Und da bricht es ab, denn Nichts hat keine Frage. Lesen Sie die Meldung – sie sagt genau das."

Fehlermeldung gemeinsam lesen, Zeilennummer suchen lassen.

> „Die Meldung nennt eine Zeilennummer. Fangen Sie immer dort an. Und lesen Sie nur die **erste** Zeile – der Rest darunter ist für Leute, die den Browser gebaut haben."

Beide Varianten selbst einbauen, Meldung lesen, Zeilennummer finden, reparieren.

## Die Diagnosetabelle

An die Tafel, sie trägt bis zum Kursende:

```
undefined        →  da war nichts, wo etwas sein sollte
                    (Index zu groß? return vergessen? Feldname falsch?)
gar nichts       →  Funktion nie aufgerufen
rote Meldung     →  erste Zeile lesen, Zeilennummer merken
```

| Weitere typische Fälle | Ursache |
|---|---|
| `if` verhält sich unlogisch | `=` statt `===` |
| Zugriff liefert nichts | `liste.feld` oder `objekt[0]` verwechselt |
| Änderung wirkt nicht | nach dem Speichern nicht neu geladen |
| Ausgabe nicht auffindbar | im Terminal gesucht statt in der Konsole |
| Konsole zeigt nach jedem Befehl `undefined` | normales Verhalten – ignorieren |

## Typische Stolperstellen

> [!warning]
> - Der Index beginnt bei null. Der letzte von vier Einträgen ist `[3]`, nicht `[4]`.
> - `return` vergessen → `undefined`.
> - Funktion nie aufgerufen → gar nichts, ohne Fehlermeldung.
> - `=` statt `===` → das Programm tut etwas anderes als gedacht, ohne Fehlermeldung.
> - `liste.feld` und `objekt[0]` verwechselt → `undefined`.
> - Ausgaben im Terminal gesucht statt in der Konsole.
> - Nach dem Bearbeiten von `app.js` nicht neu geladen.

## Stand am Ende des Moduls

- [ ] Die Konsole ist offen und wird gelesen
- [ ] Variablen mit `const` und `let` angelegt, die `const`-Fehlermeldung gesehen
- [ ] Zahl, Text und Wahrheitswert unterschieden, `.trim()` benutzt
- [ ] Mindestens drei eigene Funktionen geschrieben **und aufgerufen**
- [ ] Den Unterschied zwischen `return` und `console.log` erklären können
- [ ] Eine Funktion mit `if` und `return` geschrieben
- [ ] Eine Liste angelegt, ergänzt, gezählt und durchlaufen
- [ ] Ein Objekt angelegt, Felder geändert und ergänzt
- [ ] `karten[0].frage` in Worte aufgelöst
- [ ] Die Diagnosetabelle angewendet, `undefined` und rote Meldung gelesen
- [ ] Die `id`-Liste aus [[K1 HTML – die Struktur]] liegt aufgeschlagen bereit

## Verknüpfung

Merkblatt: [[K3 Merkblatt]] · Übungen: [[K3 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

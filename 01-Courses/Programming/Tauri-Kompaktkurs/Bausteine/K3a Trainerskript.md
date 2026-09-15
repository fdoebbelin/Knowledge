---
baustein: K3
typ: trainerskript
title: JavaScript – die Bausteine – Trainerskript
ue: 6
kurstag: 2-3
dauer: 270 min in zwei Blöcken
zielgruppe: 3 Teilnehmende ohne Vorkenntnisse
tags: [tauri/kompaktkurs/trainerskript, javascript]
status: entwurf
---

# K3 – Trainerskript

> [!abstract] Zweck dieses Dokuments
> Zum Mitlesen während des Unterrichts. Alles in Zitatform ist **Sprechtext** und kann wörtlich verwendet werden. Alles andere sind Handlungsanweisungen an die Kursleitung.

> [!danger] Der schwerste Baustein des Kurses
> Hier bricht erfahrungsgemäß das Tempo ein. Zwei Dinge kommen zusammen: Es ist neuer Denkstoff, und es ist **im Fenster nichts sichtbar**. Nach zwei Tagen mit sofortiger optischer Rückmeldung ist das ein Entzug.
>
> Sagen Sie das zu Beginn ausdrücklich an. Ein angekündigter Durststrecke wird ausgehalten, eine unerwartete nicht.

## Zeitraster

> [!warning] Abweichung vom Konzeptdokument
> [[K3 JavaScript – die Bausteine]] summiert 300 Minuten bei 270 verfügbaren. Gekürzt sind Abschnitt 1 (45 → 40), Abschnitt 2 (30 → 20), Abschnitt 4 (30 → 25), Abschnitt 5 (45 → 40), Abschnitt 6 (45 → 40) und Abschnitt 7 (30 → 25). **Abschnitt 3 bleibt bei 60 Minuten** – Funktionen sind die Hürde, an der es hängt.
>
> Der Schnitt zwischen den Tagen liegt nach den Objekten. Tag 3 beginnt damit, dass Listen und Objekte zum Datenbestand der Anwendung zusammenwachsen – ein guter Einstieg in einen Tag.
>
> **Wenn die Zeit nicht reicht:** Die eine Reserve-UE aus [[K6 Feinschliff]] geht in Abschnitt 3 und in freie Übungszeit, nicht in zusätzlichen Stoff.

### Block A – Tag 2, letzte 5 UE (225 min)

| Zeit | Abschnitt | Format |
|---|---|---|
| 000–040 | 1. Variablen und die Konsole | gemeinsam |
| 040–060 | 2. Die vier Datentypen | gemeinsam |
| 060–120 | 3. Funktionen | gemeinsam, langsam, reihum |
| 120–145 | 4. Entscheidungen mit `if` | gemeinsam |
| 145–185 | 5. Listen | gemeinsam + reihum |
| 185–225 | 6. Objekte | gemeinsam + reihum |

### Block B – Tag 3, erste 1 UE (45 min)

| Zeit | Abschnitt | Format |
|---|---|---|
| 00–25 | 7. Beides zusammen | gemeinsam |
| 25–40 | 8. Absichtlicher Fehler | gemeinsam |
| 40–45 | Übergang zu K4 | Ansage |

---

## Vorlauf

**Ausgangsstand:** Ergebnis aus [[K2 CSS – das Aussehen]]. Oberfläche steht und ist gestaltet, `app.js` ist leer.

- [ ] Alle drei Anwendungen laufen
- [ ] `src/app.js` ist im Editor geöffnet
- [ ] Die Konsole lässt sich auf allen drei Geräten öffnen – **am Vortag testen**
- [ ] Zwischenstand `stand-k3` bereit

> [!danger] Die Konsole vorher prüfen
> Rechtsklick im Anwendungsfenster → „Element untersuchen" → Reiter „Konsole". Das ist der Web-Inspektor von WebKit und steht nur im Entwicklungslauf zur Verfügung. Funktioniert er auf einem Gerät nicht, ist der gesamte Baustein blockiert – es gibt heute keine andere Rückmeldung.
>
> Notfallplan: Zwei Personen an einem Gerät arbeiten lassen, statt den Baustein ohne Konsole zu versuchen.

---

# Block A – Tag 2

## 1. Variablen und die Konsole (40 min)

**Ziel:** Die Konsole ist offen und wird gelesen. Variablen sind Schubladen mit Namen.

### 1a Die Ansage (5 min)

Nicht überspringen. Sie ist die Versicherung gegen den Tempoeinbruch.

> „Die nächsten Stunden sehen anders aus als die letzten zwei Tage. Im Fenster wird sich **nichts** verändern. Wir lernen jetzt die Sprache, mit der die Anwendung später denkt – und Denken sieht man nicht.
>
> Das ist so geplant. Wenn Sie das Gefühl bekommen, es geht nicht voran: Es geht voran, nur an einer Stelle, die man nicht sieht. Morgen früh kommt alles zusammen, und dann funktionieren die Knöpfe."

### 1b Die Konsole öffnen (10 min)

Gemeinsam, Schritt für Schritt:

1. Rechtsklick ins Anwendungsfenster
2. „Element untersuchen"
3. Reiter „Konsole"

> „Das ist ab jetzt Ihr wichtigstes Werkzeug. Sie bleibt den Rest des Kurses offen. Alles, was Sie heute schreiben, erscheint hier – und alle Fehlermeldungen auch."

Erste Zeile in `app.js`:

```js
console.log("Hallo Konsole");
```

Speichern, neu laden, hinsehen. **Warten, bis es bei allen dreien steht.**

> [!warning] Zwei Ausgabeorte auseinanderhalten
> Das Terminal zeigt Meldungen des Rust-Teils, die Konsole zeigt Meldungen des Fensters. Wer heute im Terminal sucht, findet nichts. Einmal ausdrücklich sagen und auf beide zeigen.

### 1c Variablen (15 min)

```js
const name = "Anna";
let punkte = 0;
console.log(name);
console.log(punkte);
```

Bildvergleich an die Tafel:

> „Eine Variable ist eine beschriftete Schublade. Sie legen etwas hinein und können es später über die Beschriftung wieder herausholen. Der Name links, der Inhalt rechts, das Gleichheitszeichen legt hinein."

Dann `const` gegen `let`:

```js
punkte = 10;        // geht
name = "Bernd";     // Fehlermeldung
```

Ausprobieren lassen, Fehlermeldung gemeinsam lesen.

> „`const` heißt: Diese Schublade wird einmal gefüllt und danach nicht mehr. `let` heißt: Der Inhalt darf wechseln. **Kursregel: Im Zweifel `const`.** Das Programm sagt Ihnen, wenn es nicht geht – und dann ändern Sie es in `let`. Andersherum merkt es niemand."

> [!note] `var` kommt nicht vor
> Wird beim Nachschlagen im Netz gefunden werden. Antwort in einem Satz: „Das ist die alte dritte Form. Drei Schreibweisen für dasselbe zu lernen ist Zeitverschwendung – wir nehmen die zwei aktuellen."

### 1d Reihum (10 min)

Jede Person legt drei Variablen an, gibt sie aus, und versucht einmal, eine `const` zu überschreiben, um die Fehlermeldung zu sehen.

> [!tip] Direkt in die Konsole tippen
> Man kann unten in der Konsole auch selbst Befehle eintippen. Das ist zum Ausprobieren erlaubt und schnell. **Aber:** Alles Getippte ist beim nächsten Neuladen weg. Was bleiben soll, gehört in `app.js`.
>
> Zweite Irritation vorwegnehmen: Nach jedem Konsolenbefehl erscheint zusätzlich `undefined`. „Das ist die Antwort auf ‚Und was ist dabei herausgekommen?'. Bei `console.log` kommt nichts heraus, es wird nur ausgegeben. Ignorieren Sie diese Zeile."

---

## 2. Die vier Datentypen (20 min)

**Ziel:** Zahl, Text und Wahrheitswert unterscheiden. Liste und Objekt werden nur angekündigt.

```js
const anzahl = 3;                 // Zahl, ohne Anführungszeichen
const frage = "Was ist HTML?";    // Text, mit Anführungszeichen
const umgedreht = false;          // Wahrheitswert, nur true oder false
```

> „Drei Sorten von Werten, und der Unterschied steckt in den Anführungszeichen. `3` ist eine Zahl, mit der man rechnen kann. `"3"` ist ein Text, der zufällig aus einer Ziffer besteht."

Vorführen, warum das zählt:

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

> „Es gibt noch zwei Sorten, und die sind die wichtigsten: eine für viele Werte auf einmal und eine für zusammengehörige Werte. Die kommen heute Nachmittag."

---

## 3. Funktionen (60 min)

**Ziel:** Der schwierigste Abschnitt. Zeit nehmen, nichts vorziehen.

### 3a Das Bild (10 min)

Tafelbild, bleibt bis Kursende stehen:

```
        ┌──────────────────────────┐
"Anna" ─┤  begruessung(name)       ├─→ "Hallo Anna"
hinein  │  macht immer dasselbe    │   heraus
        └──────────────────────────┘
```

> „Eine Funktion ist eine Maschine. Oben kommt etwas hinein, unten kommt etwas heraus, und dazwischen passiert immer dasselbe. Ein Fleischwolf: Sie geben Fleisch hinein, es kommt Hack heraus. Was Sie hineingeben, entscheiden Sie – was die Maschine tut, steht ein für alle Mal fest."

### 3b Die erste Funktion (15 min)

```js
function begruessung(name) {
  return "Hallo " + name;
}

console.log(begruessung("Anna"));
```

Zeile für Zeile durchgehen, langsam:

| Teil | Was er bedeutet |
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

### 3c Die drei Fragen (10 min)

An die Tafel. Jede Person muss sie an einer beliebigen Funktion beantworten können:

```
1. Was geht hinein?      → die Klammer hinter dem Namen
2. Was kommt heraus?     → was hinter return steht
3. Wann passiert etwas?  → beim Aufruf, nicht beim Aufschreiben
```

Reihum an `begruessung` durchspielen, dann an einer zweiten Funktion, die Sie vorgeben:

```js
function doppelt(zahl) {
  return zahl * 2;
}
```

### 3d `return` gegen `console.log` (10 min)

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

### 3e Reihum, jede Person eine eigene (15 min)

Vorgabe: eine Funktion mit **einem** Parameter und einem `return`. Frei wählbar. Danach aufrufen und ausgeben.

Sie gehen herum und prüfen genau eines: **Wird sie auch aufgerufen?**

---

## 4. Entscheidungen mit `if` (25 min)

**Ziel:** Bedingung, zwei Zweige, die Vergleichsoperatoren.

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

Vergleiche an die Tafel:

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

Danach `if` mit `return` in einer Funktion kombinieren:

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

---

## 5. Listen (40 min)

**Ziel:** Anlegen, ergänzen, zählen, zugreifen, durchlaufen.

### 5a Anlegen und zugreifen (15 min)

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

### 5b Ergänzen (10 min)

```js
farben.push("gelb");
console.log(farben.length);
console.log(farben);
```

> „`push` hängt hinten an. Der Punkt heißt: Diese Sache kann etwas. Wie ein Knopf an einem Gerät."

Hier die Rückfrage aufnehmen, die kommen wird:

> „Warum geht das bei `const`? Weil sich die Schublade nicht ändert, nur ihr Inhalt. `const` verbietet, eine **andere** Liste hineinzulegen – nicht, die vorhandene zu füllen. Das ist eine Feinheit, die Sie nicht begründen können müssen. Merken reicht."

### 5c Durchlaufen (15 min)

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

---

## 6. Objekte (40 min)

**Ziel:** Zusammengehörige Werte unter beschrifteten Feldern.

### 6a Der Vergleich (10 min)

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

### 6b Die Verwechslung (10 min)

Bewusst gegenüberstellen, weil sie sonst durcheinandergehen:

```js
farben[0]       // Liste: eckige Klammer, Nummer
karte.frage     // Objekt: Punkt, Name
```

> „Eckige Klammer und Zahl bei der Liste. Punkt und Name beim Objekt. Wenn Sie das vertauschen, bekommen Sie `undefined` – und Sie erinnern sich, was `undefined` heißt."

Reihum: jede Person legt ein Objekt mit drei Feldern an, das etwas aus ihrem Leben beschreibt, und gibt zwei Felder aus.

### 6c Felder ändern und ergänzen (10 min)

```js
karte.antwort = "Die Struktur";
karte.gezeigt = false;
console.log(karte);
```

> „Ein Feld ändern geht mit dem Gleichheitszeichen, wie bei einer Variablen. Und wenn Sie ein Fach beschriften, das es noch nicht gibt, wird es angelegt."

Nicht vertiefen. Es ist die Vorbereitung für die Zusatzaufgabe in [[K6 Feinschliff]].

### 6d Verschachtelt lesen (10 min)

Nur **lesen**, nicht schreiben lassen:

```js
const stapel = {
  titel: "Webtechniken",
  karte: { frage: "Was ist CSS?", antwort: "Das Aussehen" }
};

console.log(stapel.karte.frage);
```

> „Man kann Objekte ineinander legen. Sie brauchen das heute nicht selbst – aber Sie sollen es einmal gesehen haben, damit es Sie morgen nicht überrascht."

---

# Block B – Tag 3

## 7. Beides zusammen (25 min)

**Ziel:** Der Datenbestand der Anwendung entsteht. Das ist der Übergang zu [[K4 JavaScript im Fenster]].

### 7a Kurzer Rückblick (5 min)

Ohne Datei, nur mündlich, reihum:

- „Was ist eine Funktion in einem Satz?"
- „Was ist der Unterschied zwischen Liste und Objekt?"
- „Was heißt `undefined`?"

### 7b Die Liste aus Objekten (15 min)

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

> „Und das ist der Datenbestand Ihrer Anwendung. Alles, was Ihr Programm über Karten weiß, steht ab jetzt hier drin. Jede Karte, die Sie morgen anlegen, wird ein weiteres Objekt in dieser Liste."

An die Tafel:

```
karten            → die ganze Liste
karten.length     → wie viele
karten[0]         → die erste Karte (ein Objekt)
karten[0].frage   → deren Frage (ein Text)
```

Die letzte Zeile gemeinsam durchsprechen – sie kombiniert beide Zugriffsarten und ist der eigentliche Verständnistest.

### 7c Zwei Funktionen dazu (5 min)

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

> „Das ist ein `let`, kein `const`. Warum? Weil sich die Nummer der angezeigten Karte dauernd ändert, sobald Sie morgen auf ‚Nächste' drücken. Das ist der Fall, für den es `let` gibt."

`karteAnlegen` gemeinsam testen:

```js
karteAnlegen("Was ist eine Funktion?", "Eine Maschine mit rein und raus");
console.log(anzahlKarten());
```

---

## 8. Absichtlicher Fehler (15 min)

**Ziel:** `undefined` als Diagnosewerkzeug verstehen.

### 8a Vorführung (5 min)

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

### 8b Jede Person selbst (7 min)

Beide Varianten einbauen, Meldung lesen, Zeilennummer finden, reparieren.

### 8c Die Diagnosetabelle (3 min)

An die Tafel, sie trägt bis Kursende:

```
undefined        →  da war nichts, wo etwas sein sollte
                    (Index zu groß? return vergessen? Feldname falsch?)
gar nichts       →  Funktion nie aufgerufen
rote Meldung     →  erste Zeile lesen, Zeilennummer merken
```

---

## Übergang zu K4 (5 min)

> „Sie haben heute nichts gesehen und trotzdem das Schwerste hinter sich. Ab jetzt geht es bergab – im guten Sinn.
>
> Ihre Anwendung hat jetzt einen Datenbestand. Was ihr fehlt, ist die Verbindung zwischen diesem Datenbestand und dem Fenster. Die bauen wir als Nächstes, und dann funktionieren die Knöpfe."

Heftliste bereitlegen lassen:

> „Und schlagen Sie Ihre `id`-Liste auf. In zehn Minuten brauchen Sie sie."

---

## Kontrollpunkte

| Nach Abschnitt | Woran Sie erkennen, dass es sitzt |
|---|---|
| 1 | Konsole ist offen, jede Person hat die `const`-Fehlermeldung gesehen |
| 3 | Jede Person beantwortet die drei Fragen an einer fremden Funktion |
| 3 | Jede Person nennt den Unterschied zwischen `return` und `console.log` |
| 4 | Jede Person sagt, was `=` und was `===` tut |
| 5 | Jede Person zählt die Indizes einer Liste korrekt ab |
| 6 | Jede Person unterscheidet `liste[0]` von `objekt.feld` |
| 7 | Jede Person löst `karten[0].frage` in Worte auf |

---

## Wenn es klemmt

| Symptom | Wahrscheinliche Ursache | Sofortmaßnahme |
|---|---|---|
| Gar nichts passiert, keine Meldung | Funktion nie aufgerufen | Merksatz zeigen, nicht neu erklären |
| `undefined` als Ergebnis | `return` vergessen, Index zu groß oder Feldname falsch | Diagnosetabelle |
| Rote Meldung, Person erstarrt | Meldung nicht gelesen | Erste Zeile **laut vorlesen** lassen |
| `if` verhält sich unlogisch | `=` statt `===` | Kursregel wiederholen |
| Zugriff liefert nichts | `liste.feld` oder `objekt[0]` verwechselt | Regalbild zeigen |
| Konsole zeigt nach jedem Befehl `undefined` | normales Verhalten | einmal erklären, dann ignorieren |
| Person sucht Ausgaben im Terminal | zwei Ausgabeorte | auf die Konsole zeigen |
| Änderungen wirken nicht | nach Bearbeiten von `app.js` nicht neu geladen | Rechtsklick → Neu laden |
| Tempo bricht ein | normal für diesen Baustein | Reserve-UE aus [[K6 Feinschliff]] ziehen, Stoff **nicht** kürzen |
| Person ist deutlich schneller | – | Zusatzaufgaben aus [[K3c Übungsblatt]], **kein** DOM-Zugriff |

> [!warning] Die Versuchung, vorzugreifen
> Eine schnelle Person will `document.querySelector` ausprobieren, weil sie es irgendwo gesehen hat. Das nimmt [[K4 JavaScript im Fenster]] den gesamten Aufhänger. Formulierung: „Das ist genau der nächste Baustein und die Belohnung für heute. Heben Sie es sich auf."

## Übergabe an K4

- [ ] `src/app.js` enthält den Datenbestand `karten` als Liste aus Objekten
- [ ] `let aktuelleKarte = 0` ist angelegt
- [ ] Die Funktionen `anzahlKarten` und `karteAnlegen` sind vorhanden und getestet
- [ ] Jede Person hat mindestens drei eigene Funktionen geschrieben und aufgerufen
- [ ] Die Konsole ist auf allen Geräten offen und wird gelesen
- [ ] Die `id`-Liste aus [[K1 HTML – die Struktur]] liegt aufgeschlagen bereit
- [ ] Stand als `stand-k3` gesichert

## Verknüpfung

Konzept: [[K3 JavaScript – die Bausteine]] · Handout: [[K3b Handout]] · Übungen: [[K3c Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

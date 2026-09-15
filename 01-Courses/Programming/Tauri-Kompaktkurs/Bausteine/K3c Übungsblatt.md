---
baustein: K3
typ: uebungsblatt
title: JavaScript – die Bausteine – Übungen
ue: 6
kurstag: 2-3
tags: [tauri/kompaktkurs/uebung, javascript]
status: entwurf
---

# K3 – Übungsblatt

> [!info] Hinweis zu den Lösungen
> Die Lösungen stehen jeweils direkt unter der Aufgabe in einem zugeklappten Kasten. Auf dem gedruckten Teilnehmerblatt werden die Lösungskästen entfernt – die Kursleitungsfassung behält sie.

> [!important] Die Diagnosetabelle
> **gar nichts** → Funktion nie aufgerufen
> **`undefined`** → da war nichts, wo etwas sein sollte
> **rote Meldung** → erste Zeile lesen, Zeilennummer merken

Alle Aufgaben werden in `src/app.js` geschrieben. Nach dem Speichern im Fenster neu laden und in der Konsole nachsehen.

---

# Block A – Tag 2

## Ü3.1 Konsole und Variablen

1. Öffnen Sie die Konsole und lassen Sie sie offen.
2. Legen Sie fünf Variablen an: zwei Texte, zwei Zahlen, einen Wahrheitswert.
3. Geben Sie alle fünf aus.
4. Versuchen Sie, eine `const` zu überschreiben. Notieren Sie die **erste Zeile** der Fehlermeldung.

Fehlermeldung: `_______________________________________________`

> [!success]- Lösung Ü3.1
> ```js
> const vorname = "Anna";
> const stadt = "Wunsiedel";
> const alter = 34;
> let punkte = 0;
> const fertig = false;
>
> console.log(vorname);
> console.log(stadt);
> console.log(alter);
> console.log(punkte);
> console.log(fertig);
> ```
>
> Beim Überschreiben:
> ```js
> vorname = "Bernd";
> ```
> Die Meldung lautet sinngemäß: *Assignment to constant variable* – Zuweisung an eine unveränderliche Variable.
>
> **Das eigentliche Lernziel:** Die Meldung sagt genau, was los ist. Sie muss nur gelesen werden. Wer sie übersetzt bekommt, liest die nächste selbst.
>
> `punkte = 10;` funktioniert dagegen, weil es ein `let` ist.

---

## Ü3.2 Zahl oder Text?

Sagen Sie **vorher** voraus, was herauskommt. Dann ausprobieren.

| Ausdruck | Vorhersage | Tatsächlich |
|---|---|---|
| `3 + 4` | | |
| `"3" + "4"` | | |
| `"Hallo" + "Welt"` | | |
| `"Hallo " + "Welt"` | | |
| `3 + "4"` | | |

> [!success]- Lösung Ü3.2
> | Ausdruck | Ergebnis |
> |---|---|
> | `3 + 4` | `7` – zwei Zahlen, es wird gerechnet |
> | `"3" + "4"` | `"34"` – zwei Texte, sie werden aneinandergehängt |
> | `"Hallo" + "Welt"` | `"HalloWelt"` – ohne Leerzeichen |
> | `"Hallo " + "Welt"` | `"Hallo Welt"` – das Leerzeichen steht im ersten Text |
> | `3 + "4"` | `"34"` – sobald ein Text beteiligt ist, wird angehängt statt gerechnet |
>
> Die letzte Zeile ist die interessanteste und die Quelle vieler Merkwürdigkeiten. Im Kurs reicht die Regel: **Sobald Anführungszeichen im Spiel sind, wird angehängt.**
>
> **Zusatzfrage:** „Wo fehlt in Zeile 3 das Leerzeichen – am Ende des ersten oder am Anfang des zweiten Textes?" Beides geht. Hauptsache, es steht innerhalb der Anführungszeichen.

---

## Ü3.3 Ihre erste Funktion

Schreiben Sie eine Funktion, die einen Namen entgegennimmt und einen Gruß zurückgibt. Rufen Sie sie auf und geben Sie das Ergebnis aus.

Beantworten Sie danach die drei Fragen zu Ihrer eigenen Funktion:

1. Was geht hinein? `________________________`
2. Was kommt heraus? `________________________`
3. Wann passiert etwas? `________________________`

> [!success]- Lösung Ü3.3
> ```js
> function begruessung(name) {
>   return "Hallo " + name + "!";
> }
>
> console.log(begruessung("Anna"));
> ```
>
> 1. Hinein geht ein Text – der Parameter `name`.
> 2. Heraus kommt ein Text: „Hallo Anna!"
> 3. Etwas passiert beim **Aufruf** in der letzten Zeile, nicht beim Aufschreiben.
>
> **Prüfschritt der Kursleitung:** Letzte Zeile auskommentieren, speichern, neu laden. Es passiert nichts, ohne Fehlermeldung. Das ist der häufigste Fehler des Kurses und wird hier einmal absichtlich erzeugt.

---

## Ü3.4 `return` oder `console.log`?

Gegeben:

```js
function variante1(zahl) {
  return zahl * 2;
}

function variante2(zahl) {
  console.log(zahl * 2);
}

const a = variante1(5);
const b = variante2(5);
console.log(a);
console.log(b);
```

Was steht am Ende in der Konsole? Schreiben Sie **jede** Zeile auf, in der richtigen Reihenfolge.

```
_______________________
_______________________
_______________________
```

> [!success]- Lösung Ü3.4
> ```
> 10        ← aus dem console.log in variante2
> 10        ← aus console.log(a)
> undefined ← aus console.log(b)
> ```
>
> **Die Reihenfolge ist Teil der Aufgabe.** Die `10` aus `variante2` erscheint schon beim Aufruf, also vor beiden anderen Zeilen.
>
> `b` ist `undefined`, weil `variante2` zwar etwas ausgibt, aber nichts **zurückgibt**. Es fehlt das `return`.
>
> **Merksatz:** `console.log` ist Reden, `return` ist Abliefern. Beide Funktionen zeigen eine 10 – nur mit einer kann man weiterarbeiten.

---

## Ü3.5 Entscheidungen

Schreiben Sie eine Funktion `bewertung(anzahl)`, die zurückgibt:

- „schon ein guter Stapel", wenn mehr als 10 Karten da sind
- „da geht noch mehr" sonst

Rufen Sie sie dreimal mit unterschiedlichen Zahlen auf.

**Zusatzfrage:** Was passiert bei genau 10?

> [!success]- Lösung Ü3.5
> ```js
> function bewertung(anzahl) {
>   if (anzahl > 10) {
>     return "schon ein guter Stapel";
>   } else {
>     return "da geht noch mehr";
>   }
> }
>
> console.log(bewertung(3));    // da geht noch mehr
> console.log(bewertung(10));   // da geht noch mehr
> console.log(bewertung(25));   // schon ein guter Stapel
> ```
>
> **Bei genau 10** greift der `else`-Zweig, weil `>` echt größer bedeutet. Wer auch die 10 einschließen will, schreibt die Bedingung anders – zum Beispiel `anzahl > 9`.
>
> Das ist der klassische Grenzfall. Er lohnt fünf Minuten: Bei jeder Bedingung mit `>` oder `<` einmal fragen, was am Rand passiert.

---

## Ü3.6 Fehler finden

In jedem Schnipsel steckt genau ein Fehler.

**a)**
```js
function doppelt(zahl) {
  zahl * 2;
}
console.log(doppelt(5));
```

**b)**
```js
function doppelt(zahl) {
  return zahl * 2;
}
```

**c)**
```js
let punkte = 5;
if (punkte = 10) {
  console.log("genau zehn");
}
```

**d)**
```js
const name = "Anna";
name = "Bernd";
```

**e)**
```js
const farben = ["rot", "gruen", "blau"];
console.log(farben[3]);
```

> [!success]- Lösungen Ü3.6
> **a)** `return` fehlt. Die Rechnung läuft, aber das Ergebnis wird nicht abgeliefert. Ausgabe: `undefined`.
> ```js
> return zahl * 2;
> ```
>
> **b)** Die Funktion wird nie aufgerufen. Es passiert nichts, ohne Fehlermeldung.
> ```js
> console.log(doppelt(5));
> ```
>
> **c)** `=` statt `===`. Das weist zu, statt zu vergleichen – `punkte` wird auf 10 gesetzt und die Bedingung gilt als erfüllt. **Keine Fehlermeldung**, das Programm tut nur etwas anderes als gedacht.
> ```js
> if (punkte === 10) {
> ```
>
> **d)** Zuweisung an eine `const`. Fehlermeldung. Entweder `let` verwenden oder nicht überschreiben.
>
> **e)** Der Index ist zu groß. Drei Einträge haben die Nummern 0, 1 und 2. Ausgabe: `undefined`.
> ```js
> console.log(farben[2]);
> ```
>
> **Für die Kursleitung:** a), b) und e) enden alle in `undefined` beziehungsweise Stille – drei verschiedene Ursachen, ein Erscheinungsbild. Genau deshalb existiert die Diagnosetabelle.

---

## Ü3.7 Listen

1. Legen Sie eine Liste mit vier Ihrer Lieblingsdinge an.
2. Geben Sie die Anzahl aus.
3. Geben Sie den **ersten** und den **letzten** Eintrag aus.
4. Hängen Sie einen fünften an und geben Sie die Anzahl erneut aus.
5. Geben Sie alle Einträge einzeln aus.

> [!success]- Lösung Ü3.7
> ```js
> const dinge = ["Kaffee", "Fahrrad", "Musik", "Regen"];
>
> console.log(dinge.length);      // 4
> console.log(dinge[0]);          // Kaffee
> console.log(dinge[3]);          // Regen
>
> dinge.push("Schnee");
> console.log(dinge.length);      // 5
>
> for (const ding of dinge) {
>   console.log(ding);
> }
> ```
>
> **Die Stolperfalle steckt in Punkt 3:** Der letzte von vier Einträgen ist `dinge[3]`, nicht `dinge[4]`. Wer `[4]` schreibt, bekommt `undefined`.
>
> **Nachfrage:** „Wie heißt der letzte Eintrag, wenn Sie die Anzahl nicht kennen?" → `dinge[dinge.length - 1]`. Das ist eine Zusatzinformation und **keine Pflicht** – nur ausgeben, wenn jemand von selbst darauf kommt.

---

## Ü3.8 Objekte

1. Legen Sie ein Objekt an, das eine Person mit drei Feldern beschreibt.
2. Geben Sie zwei Felder einzeln aus.
3. Ändern Sie ein Feld und geben Sie es erneut aus.
4. Legen Sie ein viertes Feld an, das vorher nicht existierte.
5. Geben Sie das ganze Objekt aus.

> [!success]- Lösung Ü3.8
> ```js
> const person = {
>   name: "Anna",
>   ort: "Wunsiedel",
>   lernt: "Webtechniken"
> };
>
> console.log(person.name);
> console.log(person.ort);
>
> person.ort = "Bayreuth";
> console.log(person.ort);
>
> person.stimmung = "gut";
>
> console.log(person);
> ```
>
> **Zu Punkt 4:** Wer ein Fach beschriftet, das es noch nicht gibt, legt es an. Das ist kein Fehler.
>
> **Zu Punkt 3 und `const`:** Das Ändern eines Feldes ist erlaubt, obwohl das Objekt `const` ist – genau wie bei `push` in einer Liste. Verboten wäre nur `person = { … }`, also ein **anderes** Objekt hineinzulegen.

---

## Ü3.9 Liste oder Objekt?

Kreuzen Sie an, welche Form besser passt.

| Was gespeichert werden soll | Liste | Objekt |
|---|---|---|
| Die Namen aller Wochentage | ☐ | ☐ |
| Frage und Antwort einer Karte | ☐ | ☐ |
| Alle bisher angelegten Karten | ☐ | ☐ |
| Name, Ort und Alter einer Person | ☐ | ☐ |
| Die letzten fünf Suchbegriffe | ☐ | ☐ |

> [!success]- Lösung Ü3.9
> | Was gespeichert werden soll | Antwort | Begründung |
> |---|---|---|
> | Wochentage | Liste | gleichartige Dinge, Reihenfolge zählt |
> | Frage und Antwort | Objekt | verschiedene Dinge, jedes braucht einen Namen |
> | Alle Karten | Liste | viele gleichartige Dinge |
> | Name, Ort, Alter | Objekt | verschiedene Dinge |
> | Letzte fünf Suchbegriffe | Liste | gleichartig, Reihenfolge zählt |
>
> > [!tip] Die Faustregel
> > **Gleichartige Dinge in einer Reihe → Liste.
> > Verschiedene Angaben zu einer Sache → Objekt.**
>
> Und der Übergang zu morgen: „Alle Karten" ist eine Liste, „eine Karte" ist ein Objekt. Zusammen ergibt das eine **Liste aus Objekten** – genau der Datenbestand der Anwendung.

---

# Block B – Tag 3

## Ü3.10 Der Datenbestand

1. Legen Sie in `app.js` die Liste `karten` mit drei Objekten an, jedes mit `frage` und `antwort`.
2. Geben Sie alle Fragen einzeln aus.
3. Lösen Sie diese vier Ausdrücke in Worte auf, **bevor** Sie sie ausprobieren:

| Ausdruck | Was kommt heraus? |
|---|---|
| `karten` | |
| `karten.length` | |
| `karten[1]` | |
| `karten[1].antwort` | |

> [!success]- Lösung Ü3.10
> ```js
> const karten = [
>   { frage: "Was ist HTML?", antwort: "Die Struktur einer Seite" },
>   { frage: "Was ist CSS?", antwort: "Das Aussehen einer Seite" },
>   { frage: "Was ist eine id?", antwort: "Der Name eines Elements" }
> ];
>
> for (const karte of karten) {
>   console.log(karte.frage);
> }
> ```
>
> | Ausdruck | Ergebnis | Sorte |
> |---|---|---|
> | `karten` | die ganze Liste mit drei Objekten | Liste |
> | `karten.length` | `3` | Zahl |
> | `karten[1]` | die zweite Karte, komplett | Objekt |
> | `karten[1].antwort` | `"Das Aussehen einer Seite"` | Text |
>
> **Die vierte Zeile ist der Verständnistest des ganzen Bausteins.** In Worte: „Nimm aus der Liste das Fach mit der Nummer eins – das ist ein Objekt – und hole daraus das beschriftete Fach `antwort`."
>
> Wer `karten[1]` für die erste Karte hält, hat den Nullpunkt noch nicht verinnerlicht. Dann noch einmal gemeinsam abzählen.

---

## Ü3.11 Zwei Funktionen für die Anwendung

Schreiben Sie:

1. `anzahlKarten()` – gibt zurück, wie viele Karten es gibt. Kein Parameter.
2. `karteAnlegen(frage, antwort)` – baut ein neues Objekt, hängt es an die Liste und gibt es zurück.

Testen Sie beides in der Konsole.

Legen Sie außerdem eine Variable `aktuelleKarte` mit dem Wert 0 an. **Frage: `const` oder `let`? Warum?**

> [!success]- Lösung Ü3.11
> ```js
> let aktuelleKarte = 0;
>
> function anzahlKarten() {
>   return karten.length;
> }
>
> function karteAnlegen(frage, antwort) {
>   const neueKarte = { frage: frage, antwort: antwort };
>   karten.push(neueKarte);
>   return neueKarte;
> }
> ```
>
> Test:
> ```js
> console.log(anzahlKarten());                                  // 3
> karteAnlegen("Was ist eine Funktion?", "Eine Maschine");
> console.log(anzahlKarten());                                  // 4
> ```
>
> **`aktuelleKarte` braucht `let`**, weil sich die Nummer der angezeigten Karte dauernd ändert, sobald morgen der Knopf „Nächste" funktioniert. Das ist der Musterfall für `let`.
>
> **Zur Zeile `{ frage: frage, antwort: antwort }`:** Links steht der Feldname des Objekts, rechts der Parameter der Funktion. Dass beide gleich heißen, ist bequem, aber nicht nötig – es sind zwei verschiedene Dinge. Wer stutzt, dem hilft eine Variante mit anderen Parameternamen:
> ```js
> function karteAnlegen(f, a) {
>   const neueKarte = { frage: f, antwort: a };
>   …
> }
> ```

---

## Ü3.12 Absichtlich kaputt machen

```js
console.log(karten[5]);
console.log(karten[5].frage);
```

1. Was gibt die **erste** Zeile aus? `________________`
2. Was passiert bei der **zweiten**? `________________`
3. Welche Zeilennummer nennt die Meldung? `________________`

> [!success]- Lösung Ü3.12
> **Zeile 1:** `undefined`. Es wird nach einem Fach gefragt, das es nicht gibt. Kein Fehler – nur eine leere Antwort.
>
> **Zeile 2:** Eine echte Fehlermeldung in Rot, sinngemäß *Cannot read properties of undefined*. Das Nichts aus Zeile 1 wird nach seiner Frage gefragt, und Nichts hat keine Frage.
>
> **Zeile 3:** Die Meldung nennt die Zeilennummer in `app.js`. Genau dort anfangen zu suchen.
>
> **Der Unterschied ist das Lernziel:** Ein zu großer Index allein ist harmlos und still. Erst der Zugriff **auf** das Ergebnis bricht ab. Wer eine solche Meldung sieht, sucht also nicht die Zeile mit dem Punkt – sondern die Stelle, an der das `undefined` entstanden ist.

---

## Zusatzaufgaben für Schnellere

> [!note] Freiwillig
> Kein Zugriff auf das Fenster. Wer `document.querySelector` ausprobieren möchte: Das ist genau der nächste Baustein und die Belohnung für heute.

**Z1 – Zählen mit Bedingung.** Schreiben Sie eine Funktion, die zurückgibt, wie viele Karten eine Frage haben, die länger als 15 Zeichen ist. Hinweis: Auch Texte haben `.length`.

**Z2 – Suchen.** Schreiben Sie eine Funktion `frageSuchen(text)`, die die erste Karte zurückgibt, deren Frage genau diesem Text entspricht – und `false`, wenn es keine gibt.

**Z3 – Alles ausgeben.** Schreiben Sie eine Funktion, die für jede Karte eine Zeile der Form „Frage → Antwort" in die Konsole schreibt.

> [!success]- Lösungen Z1 bis Z3
> **Z1:**
> ```js
> function langeFragen() {
>   let anzahl = 0;
>   for (const karte of karten) {
>     if (karte.frage.length > 15) {
>       anzahl = anzahl + 1;
>     }
>   }
>   return anzahl;
> }
>
> console.log(langeFragen());
> ```
> Die Zähler-Variable braucht `let`. `anzahl = anzahl + 1` ist bewusst ausgeschrieben – `anzahl++` gehört nicht zum Sprachumfang und wäre eine zweite Schreibweise für dasselbe.
>
> **Z2:**
> ```js
> function frageSuchen(text) {
>   for (const karte of karten) {
>     if (karte.frage === text) {
>       return karte;
>     }
>   }
>   return false;
> }
>
> console.log(frageSuchen("Was ist CSS?"));
> console.log(frageSuchen("Gibt es nicht"));
> ```
> Interessant ist hier das `return` **innerhalb** der Schleife: Sobald etwas zurückgegeben wird, ist die Funktion beendet – der Rest der Liste wird nicht mehr angesehen. Das darf man erwähnen, wenn jemand fragt, muss aber nicht.
>
> **Z3:**
> ```js
> function alleAusgeben() {
>   for (const karte of karten) {
>     console.log(karte.frage + " → " + karte.antwort);
>   }
> }
>
> alleAusgeben();
> ```
> Diese Funktion ist die direkte Vorstufe von `listeAnzeigen()` aus [[K4 JavaScript im Fenster]]. Dort wird aus `console.log` ein Listeneintrag im Fenster – der Rest bleibt gleich. Das lohnt sich zu erwähnen, wenn jemand Z3 löst.

---

## Abschlusskontrolle

- [ ] Ü3.1 Konsole offen, fünf Variablen, `const`-Fehlermeldung gesehen
- [ ] Ü3.2 Zahl und Text unterschieden
- [ ] Ü3.3 Eigene Funktion geschrieben und aufgerufen
- [ ] Ü3.4 `return` und `console.log` unterschieden
- [ ] Ü3.5 Funktion mit `if` und `return`
- [ ] Ü3.6 Fünf Fehler gefunden
- [ ] Ü3.7 Liste angelegt, ergänzt, durchlaufen
- [ ] Ü3.8 Objekt angelegt, Feld geändert und ergänzt
- [ ] Ü3.9 Liste und Objekt zugeordnet
- [ ] Ü3.10 Datenbestand angelegt, vier Ausdrücke aufgelöst
- [ ] Ü3.11 `anzahlKarten` und `karteAnlegen` geschrieben
- [ ] Ü3.12 `undefined` erzeugt und die Fehlermeldung gelesen

## Verknüpfung

Handout: [[K3b Handout]] · Trainerskript: [[K3a Trainerskript]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

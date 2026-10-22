---
title: JavaScript – die Bausteine – Übungen
modul: K3
typ: uebungsblatt
aliases:
  - K3c Übungsblatt
tags: [tauri/kompaktkurs/uebung, javascript]
status: active
---

# K3 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Zahl oder Text
- F2 `const` oder `let`
- F3 Die drei Fragen an einer Funktion
- F4 `return` oder `console.log`
- F5 Fünf Fehlerschnipsel
- F6 Der Nullpunkt
- F7 Liste oder Objekt
- F8 Der Datenbestand
- F9 Der Grenzfall
- F10 Die Diagnosetabelle

---

## F1 Was kommt bei diesen Ausdrücken heraus?

| Ausdruck | Ergebnis |
|---|---|
| `3 + 4` | |
| `"3" + "4"` | |
| `"Hallo" + "Welt"` | |
| `"Hallo " + "Welt"` | |
| `3 + "4"` | |

> [!success]- Antwort F1
> | Ausdruck | Ergebnis |
> |---|---|
> | `3 + 4` | `7` – zwei Zahlen, es wird gerechnet |
> | `"3" + "4"` | `"34"` – zwei Texte, sie werden aneinandergehängt |
> | `"Hallo" + "Welt"` | `"HalloWelt"` – ohne Leerzeichen |
> | `"Hallo " + "Welt"` | `"Hallo Welt"` – das Leerzeichen steht im ersten Text |
> | `3 + "4"` | `"34"` – sobald ein Text beteiligt ist, wird angehängt statt gerechnet |
>
> Die letzte Zeile ist die interessanteste. Die Kursregel: **Sobald Anführungszeichen im Spiel sind, wird angehängt.**
>
> **Nachfrage:** „Wo fehlt in Zeile 3 das Leerzeichen – am Ende des ersten oder am Anfang des zweiten Textes?" Beides geht. Hauptsache, es steht innerhalb der Anführungszeichen.

---

## F2 Was passiert bei diesen beiden Zuweisungen?

```js
const name = "Anna";
name = "Bernd";
```

```js
let punkte = 0;
punkte = 10;
```

> [!success]- Antwort F2
> Die erste Zeile erzeugt eine **Fehlermeldung** – sinngemäß *Assignment to constant variable*, also Zuweisung an eine unveränderliche Variable. `name` ist eine `const` und darf danach nicht überschrieben werden.
>
> Die zweite Zeile funktioniert: `punkte` ist ein `let`, der Inhalt darf wechseln.
>
> **Das eigentliche Lernziel:** Die Meldung sagt genau, was los ist. Sie muss nur gelesen werden. Wer sie übersetzt bekommt, liest die nächste selbst.
>
> **Kursregel:** Im Zweifel `const`. Das Programm sagt Ihnen, wenn es nicht geht – dann ändern Sie es in `let`. Andersherum merkt es niemand.

---

## F3 Beantworten Sie die drei Fragen an dieser Funktion.

```js
function doppelt(zahl) {
  return zahl * 2;
}
```

1. Was geht hinein? `________________________________`
2. Was kommt heraus? `________________________________`
3. Wann passiert etwas? `________________________________`

> [!success]- Antwort F3
> 1. Hinein geht eine Zahl – der Parameter `zahl`.
> 2. Heraus kommt eine Zahl: das Doppelte.
> 3. Etwas passiert beim **Aufruf**, nicht beim Aufschreiben.
>
> **Der häufigste Fehler des ganzen Kurses:** Wird die Funktion nie aufgerufen, passiert nichts – und es gibt **keine Fehlermeldung**. Merksatz: **Eine Funktion aufschreiben heißt nicht, sie zu benutzen.**

---

## F4 Gegeben ist:

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

> [!success]- Antwort F4
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

## F5 In jedem Schnipsel steckt genau ein Fehler. Was ist es, und wie lautet die richtige Fassung?

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

> [!success]- Antwort F5
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
> **Der Zusammenhang:** a), b) und e) enden alle in `undefined` beziehungsweise Stille – drei verschiedene Ursachen, ein Erscheinungsbild. Genau deshalb existiert die Diagnosetabelle.

---

## F6 Eine Liste hat vier Einträge. Wie heißen die Indizes? Wie heißt der letzte Eintrag, wenn die Anzahl nicht bekannt ist?

> [!success]- Antwort F6
> **Der Index beginnt bei null.** Bei vier Einträgen sind es `0`, `1`, `2`, `3` – der letzte Eintrag ist `[3]`, nicht `[4]`. Wer `[4]` schreibt, bekommt `undefined`.
>
> Ohne bekannte Anzahl: `liste[liste.length - 1]`.
>
> Zählen Sie einmal laut mit: null, eins, zwei.

---

## F7 Kreuzen Sie an: Liste oder Objekt?

| Was gespeichert werden soll | Liste | Objekt |
|---|---|---|
| Die Namen aller Wochentage | ☐ | ☐ |
| Frage und Antwort einer Karte | ☐ | ☐ |
| Alle bisher angelegten Karten | ☐ | ☐ |
| Name, Ort und Alter einer Person | ☐ | ☐ |
| Die letzten fünf Suchbegriffe | ☐ | ☐ |

> [!success]- Antwort F7
> | Was gespeichert werden soll | Antwort | Begründung |
> |---|---|---|
> | Wochentage | Liste | gleichartige Dinge, Reihenfolge zählt |
> | Frage und Antwort | Objekt | verschiedene Dinge, jedes braucht einen Namen |
> | Alle Karten | Liste | viele gleichartige Dinge |
> | Name, Ort, Alter | Objekt | verschiedene Dinge |
> | Letzte fünf Suchbegriffe | Liste | gleichartig, Reihenfolge zählt |
>
> **Die Faustregel:** Gleichartige Dinge in einer Reihe → Liste. Verschiedene Angaben zu einer Sache → Objekt.
>
> Und der Übergang zum nächsten Modul: „Alle Karten" ist eine Liste, „eine Karte" ist ein Objekt. Zusammen ergibt das eine **Liste aus Objekten** – genau der Datenbestand der Anwendung.

---

## F8 Der Datenbestand der Anwendung sieht so aus:

```js
const karten = [
  { frage: "Was ist HTML?", antwort: "Die Struktur einer Seite" },
  { frage: "Was ist CSS?", antwort: "Das Aussehen einer Seite" },
  { frage: "Was ist eine id?", antwort: "Der Name eines Elements" }
];
```

Lösen Sie diese vier Ausdrücke in Worte auf.

| Ausdruck | Was kommt heraus? | Sorte |
|---|---|---|
| `karten` | | |
| `karten.length` | | |
| `karten[1]` | | |
| `karten[1].antwort` | | |

> [!success]- Antwort F8
> | Ausdruck | Ergebnis | Sorte |
> |---|---|---|
> | `karten` | die ganze Liste mit drei Objekten | Liste |
> | `karten.length` | `3` | Zahl |
> | `karten[1]` | die zweite Karte, komplett | Objekt |
> | `karten[1].antwort` | `"Das Aussehen einer Seite"` | Text |
>
> **Die letzte Zeile ist der Verständnistest des ganzen Moduls.** In Worte: „Nimm aus der Liste das Fach mit der Nummer eins – das ist ein Objekt – und hole daraus das beschriftete Fach `antwort`."
>
> Wer `karten[1]` für die erste Karte hält, hat den Nullpunkt noch nicht verinnerlicht.

---

## F9 Was passiert bei genau 10, wenn die Bedingung `anzahl > 10` lautet?

> [!success]- Antwort F9
> Der `else`-Zweig greift, weil `>` echt größer bedeutet. Die 10 ist nicht größer als 10.
>
> Wer auch die 10 einschließen will, schreibt die Bedingung anders – zum Beispiel `anzahl > 9`.
>
> Das ist der klassische Grenzfall. Bei jeder Bedingung mit `>` oder `<` einmal fragen, was **am Rand** passiert.

---

## F10 Was bedeutet das, was Sie sehen?

| Beobachtung | Bedeutung |
|---|---|
| Gar nichts passiert, keine Meldung | |
| `undefined` | |
| Rote Meldung in der Konsole | |
| `if` verhält sich unlogisch | |
| Ein Zugriff auf ein Listenfeld liefert nichts | |
| Eine Änderung in `app.js` wirkt nicht | |

> [!success]- Antwort F10
> | Beobachtung | Bedeutung |
> |---|---|
> | Gar nichts passiert, keine Meldung | Funktion nie aufgerufen |
> | `undefined` | da war nichts, wo etwas sein sollte: `return` vergessen, Index zu groß, Feldname falsch |
> | Rote Meldung in der Konsole | erste Zeile lesen, Zeilennummer merken, dort anfangen |
> | `if` verhält sich unlogisch | `=` statt `===` |
> | Zugriff liefert nichts | `liste.feld` statt `liste[0]`, oder umgekehrt |
> | Änderung wirkt nicht | nach dem Speichern nicht neu geladen |
>
> **Bei einer Fehlermeldung nur die erste Zeile lesen.** Der Rest darunter ist für Leute, die den Browser gebaut haben.

---

## Verknüpfung

Leitfaden: [[K3 JavaScript – die Bausteine]] · Merkblatt: [[K3 Merkblatt]]
Weiter mit [[K4 JavaScript im Fenster]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

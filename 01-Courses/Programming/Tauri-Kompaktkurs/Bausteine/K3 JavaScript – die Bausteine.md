---
baustein: K3
title: JavaScript – die Bausteine
ue: 6
kurstag: 2-3
tags: [tauri/kompaktkurs/baustein, javascript]
status: entwurf
---

# K3 – JavaScript – die Bausteine

> [!abstract] Ziel des Bausteins
> Der schwerste Baustein des Kurses. Hier wird noch nichts im Fenster sichtbar, alle Ergebnisse erscheinen in der Konsole. Das ist bewusst so: erst die Sprache, dann die Wirkung.

> [!danger] Hinweis für die Kursleitung
> Erfahrungsgemäß bricht hier das Tempo ein. Sechs UE sind knapp bemessen. Reichen sie nicht, wird eine UE aus [[K6 Feinschliff]] hierher verschoben, nicht der Stoff gekürzt.

## Lernziele

- Werte in Variablen ablegen und wieder auslesen
- Die vier im Kurs benutzten Datentypen unterscheiden
- Eine Funktion schreiben, aufrufen und ein Ergebnis zurückgeben
- Mit `if` Entscheidungen treffen
- Ein Array anlegen, ergänzen und durchlaufen
- Ein Objekt anlegen und auf seine Felder zugreifen
- Ein Array aus Objekten als Datenmodell verstehen

## Sprachumfang

Bewusst eng. Siehe [[Anhang Sprachumfang JavaScript]].

- `const` und `let`, kein `var`
- Zahl, Text, Wahrheitswert, Liste, Objekt
- `function name(param) { ... return ... }`, keine Pfeilfunktionen
- `if` und `else`, kein `switch`
- `.push()`, `.length`, Zugriff über Index
- `for (const x of liste)`, kein klassisches `for`, kein `.map()`, kein `.filter()`
- `console.log()`

## Ablauf

### 1. Variablen und die Konsole (45 min)

```js
const name = "Anna";
let punkte = 0;
console.log(name, punkte);
```

Die Konsole wird geöffnet: Rechtsklick im Fenster, Element untersuchen, Reiter Konsole. Ab jetzt ist sie ständig sichtbar.

`const` gegen `let`: Ein Wert, der sich nie ändert, bekommt `const`. Im Zweifel `const`, das Programm sagt einem, wenn es nicht geht.

### 2. Die vier Datentypen (30 min)

Zahl, Text, Wahrheitswert, dazu die beiden Sammelformen Liste und Objekt. Jeweils ein Beispiel, jeweils ein `console.log`.

### 3. Funktionen (60 min)

Der schwierigste Abschnitt. Langsam.

```js
function begruessung(name) {
  return "Hallo " + name;
}
console.log(begruessung("Anna"));
```

Drei Fragen, die jede Person beantworten können muss:
1. Was geht hinein?
2. Was kommt heraus?
3. Wann passiert etwas?

Danach reihum: jede Person schreibt eine eigene Funktion mit einem Parameter.

### 4. Entscheidungen mit `if` (30 min)

```js
if (punkte > 10) {
  console.log("geschafft");
} else {
  console.log("weiter üben");
}
```

Vergleiche: `>`, `<`, `===`, `!==`. Ausdrücklich `===` und nie `==`, ohne den Unterschied zu erklären. Kursregel.

### 5. Listen (45 min)

```js
const farben = ["rot", "grün", "blau"];
farben.push("gelb");
console.log(farben.length);
console.log(farben[0]);

for (const farbe of farben) {
  console.log(farbe);
}
```

Der Index beginnt bei null. Das ausdrücklich hinschreiben und einmal gemeinsam abzählen.

### 6. Objekte (45 min)

```js
const karte = {
  frage: "Was ist HTML?",
  antwort: "Die Struktur einer Seite"
};
console.log(karte.frage);
```

Vergleich: Eine Liste ist ein Regal mit nummerierten Fächern, ein Objekt ist ein Regal mit beschrifteten Fächern.

### 7. Beides zusammen (30 min)

Der Datenbestand der Anwendung:

```js
const karten = [
  { frage: "Was ist HTML?", antwort: "Die Struktur" },
  { frage: "Was ist CSS?", antwort: "Das Aussehen" }
];

for (const karte of karten) {
  console.log(karte.frage);
}
```

Ab hier ist klar, wie die Anwendung ihre Daten hält. Das ist der Übergang zu [[K4 JavaScript im Fenster]].

### 8. Absichtlicher Fehler (15 min)

Zugriff auf `karten[5]` bei drei Einträgen. `undefined` anschauen und benennen.

## Praxisteil

- [ ] Konsole öffnen und dauerhaft sichtbar halten
- [ ] Fünf Variablen mit unterschiedlichen Datentypen anlegen und ausgeben
- [ ] Drei eigene Funktionen schreiben, davon eine mit `if`
- [ ] Eine Liste anlegen, erweitern, durchlaufen
- [ ] Ein Objekt mit drei Feldern anlegen
- [ ] Den Kartenbestand als Liste aus Objekten aufbauen und alle Fragen ausgeben
- [ ] Zusatzaufgabe: Funktion, die die Anzahl der Karten zurückgibt

## Typische Stolpersteine

> [!warning]
> - Funktion wird definiert, aber nie aufgerufen. Nichts passiert, kein Fehler. Häufigster Fall.
> - `return` vergessen. Ergebnis ist `undefined`.
> - Gleichheitszeichen: `=` zuweisen, `===` vergleichen. In `if` regelmäßig verwechselt.
> - Punkt und Klammer verwechselt: `karte.frage` beim Objekt, `farben[0]` bei der Liste.
> - Konsole geschlossen, dadurch scheinbar keine Ausgabe.

## Verknüpfung

Weiter mit [[K4 JavaScript im Fenster]] · [[Anhang Sprachumfang JavaScript]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

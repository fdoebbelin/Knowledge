---
baustein: K4
titel: JavaScript im Fenster
ue: 4
tag: 3
tags: [tauri/kompaktkurs/baustein, javascript, dom]
status: entwurf
---

# K4 – JavaScript im Fenster

> [!abstract] Ziel des Bausteins
> Der Moment, in dem alles zusammenkommt. Knöpfe reagieren, Karten erscheinen, die Anwendung funktioniert. Nach K3 ist das die Belohnung.

## Lernziele

- Ein Element über seine `id` im Programm ansprechen
- Auf einen Klick reagieren
- Text eines Elements lesen und ändern
- Den Wert eines Eingabefelds auslesen
- Aus einer Liste eine Anzeige erzeugen
- Den Zusammenhang zwischen `id` in HTML und Zugriff in JavaScript erklären

## Sprachumfang

- `document.querySelector("#id")`
- `.textContent`
- `.value` bei Eingabefeldern
- `.addEventListener("click", funktion)`
- `.innerHTML = ""` zum Leeren einer Liste
- `document.createElement("li")` und `.appendChild()`

## Ablauf

### 1. Ein Element greifen (30 min)

```js
const ueberschrift = document.querySelector("#karte-frage");
console.log(ueberschrift.textContent);
```

Die `id`-Liste aus [[K1 HTML – die Struktur]] wird jetzt gebraucht. Genau dafür wurde sie angelegt.

### 2. Text verändern (30 min)

```js
ueberschrift.textContent = "Neuer Text";
```

Sofort sichtbar. Reihum, jede Person ändert drei Elemente.

### 3. Auf Klicks reagieren (45 min)

```js
const knopf = document.querySelector("#knopf-umdrehen");

knopf.addEventListener("click", function () {
  console.log("geklickt");
});
```

Erst nur `console.log`, dann eine echte Wirkung. Der Zwischenschritt über die Konsole ist wichtig, sonst sind bei einem Fehler zwei Dinge gleichzeitig unklar.

### 4. Eingaben lesen (30 min)

```js
const frageFeld = document.querySelector("#frage-feld");
console.log(frageFeld.value);
```

Unterschied `textContent` gegen `value` ausdrücklich benennen: Anzeigen haben Text, Eingabefelder haben einen Wert.

### 5. Aus Daten wird Anzeige (60 min)

Die zentrale Funktion des Kurses. Gemeinsam entwickeln, Zeile für Zeile.

```js
function listeAnzeigen() {
  const liste = document.querySelector("#karten-liste");
  liste.innerHTML = "";

  for (const karte of karten) {
    const eintrag = document.createElement("li");
    eintrag.textContent = karte.frage;
    liste.appendChild(eintrag);
  }
}
```

Das Muster dahinter, an die Tafel:
**Erst leeren, dann aus den Daten neu aufbauen.**

Danach: Karte anlegen ruft `karten.push(...)` und anschließend `listeAnzeigen()` auf.

### 6. Absichtlicher Fehler (15 min)

`listeAnzeigen()` wird nach dem Anlegen nicht aufgerufen. Die Karte ist da, aber nicht sichtbar. Gemeinsam suchen. Das ist die lehrreichste Fehlersituation des Kurses.

## Praxisteil

- [ ] Alle Elemente der Oberfläche im Programm greifen und in der Konsole ausgeben
- [ ] Knopf „Umdrehen" funktionsfähig machen
- [ ] Knopf „Nächste" funktionsfähig machen
- [ ] Knopf „Karte anlegen" mit Auslesen der Eingabefelder
- [ ] `listeAnzeigen()` schreiben und an den richtigen Stellen aufrufen
- [ ] Eingabefelder nach dem Anlegen leeren
- [ ] Zusatzaufgabe: Zähler „Karte 3 von 12" anzeigen

## Typische Stolpersteine

> [!warning]
> - `querySelector` liefert `null`, weil das `#` fehlt oder die `id` falsch geschrieben ist. Fehlermeldung nennt `null`, nicht die Ursache.
> - Nach einer Änderung an den Daten wird die Anzeigefunktion nicht aufgerufen.
> - `textContent` bei einem Eingabefeld statt `.value`.
> - Beim `addEventListener` werden Klammern gesetzt: `("click", meineFunktion())` statt `("click", meineFunktion)`. Die Funktion läuft dann sofort statt beim Klick.
> - Das Skript steht vor dem HTML und findet die Elemente noch nicht. In der vorbereiteten Datei ist das gelöst, beim eigenen Anbauen fällt es zurück.

## Verknüpfung

Weiter mit [[K5 Daten behalten]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

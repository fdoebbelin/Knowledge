---
title: JavaScript im Fenster
modul: K4
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, javascript, dom]
status: active
---

# K4 – JavaScript im Fenster

## Inhaltsübersicht

- Was jetzt passiert
- Ein Element greifen
- Text verändern
- Anzeige gegen Eingabefeld: `textContent` und `value`
- Auf Klicks reagieren
- Aus Daten wird Anzeige
- Die drei Knöpfe
- Absichtlicher Fehler: der fehlende Aufruf
- Typische Stolperstellen
- Stand am Ende des Moduls

Hier kommt alles zusammen. Die Knöpfe reagieren, die Karten erscheinen, die Anwendung funktioniert. Nach [[K3 JavaScript – die Bausteine]] ist das die Belohnung.

> [!tip] Was jetzt gebraucht wird
> Die `id`-Liste aus [[K1 HTML – die Struktur]]. Jetzt wird sie zum ersten Mal benutzt – sie ist der Grund, warum sie angelegt wurde. Wer sie nicht hat, sucht die Namen einzeln in der Datei zusammen.

## Was jetzt passiert

Bisher hatte die Anwendung einen Datenbestand, der nur in der Konsole existierte. Ab jetzt spricht das Programm das Fenster an:

| Bisher | Ab jetzt |
|---|---|
| `console.log(karten[0].frage)` | Der Text steht im Fenster |
| Die Konsole zeigt alles | Das Fenster zeigt alles |
| Das Programm rechnet nur | Das Programm verändert, was sichtbar ist |

> „In den letzten Modulen haben Sie eine Sprache gelernt. Jetzt kommt das letzte Stück: Diese Sprache kann etwas ansprechen. Und das Stück, das gefehlt hat, ist erstaunlich klein."

## Ein Element greifen

```js
const ueberschrift = document.querySelector("#karte-frage");
console.log(ueberschrift.textContent);
```

`document.querySelector` ist der einzige Weg, den das Programm braucht, um ein Element zu finden. Das Argument ist ein **Selektor** – genau dieselbe Schreibweise wie in CSS:

| Gesucht | Selektor |
|---|---|
| Element mit der `id` `karte-frage` | `#karte-frage` |
| alle Knöpfe | `button` |
| Elemente mit der Klasse `knopf-anzeige` | `.knopf-anzeige` |

> [!important] Der Name muss derselbe sein
> Das `#karte-frage` hier und das `id="karte-frage"` in der HTML-Datei müssen **exakt** gleich sein. Groß- und Kleinschreibung zählt. Das ist der Grund für die Kursregel „alles klein, kein Leerzeichen".
>
> **Diagnose:** Funktioniert der Zugriff nicht, den Namen **laut** nebeneinander vorlesen – Selektor aus JavaScript und `id` aus HTML. Fast immer hört man es.

## Text verändern

```js
ueberschrift.textContent = "Neuer Text";
```

Sofort sichtbar. Reihum: jede Person verändert drei Elemente aus ihrer `id`-Liste und schaut nach jedem Schritt hin.

> [!note] `textContent` ersetzt den gesamten Inhalt
> Steht im Element vorher „Noch keine Karte", steht danach nur noch der neue Text. Es wird nichts angehängt, nichts entfernt.

## Anzeige gegen Eingabefeld: `textContent` und `value`

Das ist der Unterschied, den man sich merken muss:

```js
const frageFeld = document.querySelector("#frage-feld");
console.log(frageFeld.value);
```

| | Angezeigte Elemente | Eingabefelder |
|---|---|---|
| Was drinsteht | Text | Wert |
| Lesen | `.textContent` | `.value` |
| Schreiben | `.textContent = "…"` | `.value = "…"` |

> „Anzeigen haben **Text**, Eingabefelder haben einen **Wert**. Das ist keine Eselsbrücke, das sind zwei verschiedene Wörter für zwei verschiedene Dinge."

Schreiben funktioniert genauso:

```js
frageFeld.value = "";
```

Damit wird das Feld geleert – das wird später gebraucht, wenn eine Karte angelegt wurde.

## Auf Klicks reagieren

```js
const knopf = document.querySelector("#knopf-umdrehen");

knopf.addEventListener("click", function () {
  console.log("geklickt");
});
```

`addEventListener` bedeutet: „Wenn das passiert, tu das." Zwei Angaben:

1. **Was passiert** – `"click"`
2. **Was dann passiert** – eine Funktion

> [!danger] Die Klammern sind der Fehler
> ```js
> knopf.addEventListener("click", meineFunktion());   // falsch
> knopf.addEventListener("click", meineFunktion);     // richtig
> ```
> Mit Klammern läuft die Funktion **sofort** beim Aufbau des Programms – einmal, und dann nie wieder. Ohne Klammern läuft sie jedes Mal, wenn geklickt wird.
>
> Merksatz: **Der Name einer Funktion, ohne Klammern, ist die Sache selbst. Mit Klammern ist es ein Aufruf.**

Der Zwischenschritt über die Konsole ist wichtig: Erst nur `console.log`, dann eine echte Wirkung. Sonst ist bei einem Fehler gleichzeitig unklar, ob der Klick angekommen ist oder die Wirkung nicht funktioniert.

## Aus Daten wird Anzeige

Das ist die zentrale Funktion des Kurses. Gemeinsam entwickeln, Zeile für Zeile.

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

Zeile für Zeile:

| Zeile | Was sie tut |
|---|---|
| `const liste = document.querySelector("#karten-liste");` | die leere Liste aus dem HTML holen |
| `liste.innerHTML = "";` | alles Vorhandene entfernen |
| `for (const karte of karten)` | jede Karte durchgehen |
| `document.createElement("li")` | einen neuen Listeneintrag bauen |
| `eintrag.textContent = karte.frage;` | seinen Inhalt setzen |
| `liste.appendChild(eintrag);` | ihn an die Liste hängen |

Das Muster dahinter, an die Tafel:

> **Erst leeren, dann aus den Daten neu aufbauen.**

Warum nicht einfach anhängen? Weil dann beim zweiten Anlegen die alten Einträge doppelt dastehen. Wer leert und neu aufbaut, kann es so oft wiederholen, wie er will.

> [!note] Warum `createElement` und nicht ein Text im HTML?
> Im HTML steht nur `<ul id="karten-liste"></ul>` – ein leerer Rahmen. Der Inhalt entsteht zur Laufzeit im Programm. Deshalb ist die Liste zu Beginn unsichtbar, und das war so geplant.

## Die drei Knöpfe

Jetzt wird die Oberfläche funktionsfähig. Der Datenbestand aus [[K3 JavaScript – die Bausteine]] liegt bereits in `app.js`.

### Knopf „Karte anlegen"

```js
const knopfNeu = document.querySelector("#knopf-neu");

knopfNeu.addEventListener("click", function () {
  const frage = document.querySelector("#frage-feld").value;
  const antwort = document.querySelector("#antwort-feld").value;

  if (frage === "" || antwort === "") {
    console.log("Bitte Frage und Antwort ausfüllen");
    return;
  }

  karteAnlegen(frage, antwort);
  listeAnzeigen();

  document.querySelector("#frage-feld").value = "";
  document.querySelector("#antwort-feld").value = "";
});
```

Der Ablauf in dieser Reihenfolge:

1. **Werte holen** – aus beiden Eingabefeldern
2. **Prüfen** – ist etwas leer? Dann abbrechen
3. **Anlegen** – `karteAnlegen(frage, antwort)` hängt die Karte an die Liste
4. **Anzeigen** – `listeAnzeigen()` baut die Liste neu auf
5. **Leeren** – beide Felder zurücksetzen

> [!important] Schritt 3 und Schritt 4 dürfen nicht vertauscht werden
> Wird zuerst angezeigt und danach angelegt, sieht man die neue Karte erst beim nächsten Klick. Wird nur angelegt und nicht angezeigt, passiert überhaupt nichts.
>
> Das ist der häufigste Fehler in diesem Modul – und der Grund, warum er gleich als absichtlicher Fehler vorkommt.

### Knopf „Umdrehen"

```js
const knopfUmdrehen = document.querySelector("#knopf-umdrehen");

knopfUmdrehen.addEventListener("click", function () {
  const karte = karten[aktuelleKarte];
  if (!karte) {
    console.log("Noch keine Karte da");
    return;
  }

  const frageElement = document.querySelector("#karte-frage");
  const antwortElement = document.querySelector("#karte-antwort");

  if (frageElement.textContent === karte.frage) {
    antwortElement.textContent = karte.antwort;
  } else {
    frageElement.textContent = karte.frage;
  }
});
```

Hier wird ein Feld **gelesen** und **geschrieben** – das `textContent` steht links und rechts. Das ist die erste Stelle, an der das nötig wird.

### Knopf „Nächste"

```js
const knopfWeiter = document.querySelector("#knopf-weiter");

knopfWeiter.addEventListener("click", function () {
  if (karten.length === 0) {
    console.log("Noch keine Karte da");
    return;
  }

  aktuelleKarte = (aktuelleKarte + 1) % karten.length;

  document.querySelector("#karte-frage").textContent = karten[aktuelleKarte].frage;
  document.querySelector("#karte-antwort").textContent = "";
});
```

Das `%` am Ende ist der Rest beim Teilen: Nach der letzten Karte kommt wieder die erste. Das `%` steht für „modulo".

> [!note] Warum `aktuelleKarte` ein `let` ist
> Der Wert ändert sich bei jedem Klick. Genau dafür gibt es `let` – in [[K3 JavaScript – die Bausteine]] wurde es so angelegt.

### Die Anzeige zu Beginn

Damit beim Start etwas zu sehen ist, wird einmal am Ende der Datei aufgerufen:

```js
listeAnzeigen();
```

## Absichtlicher Fehler: der fehlende Aufruf

In `karteAnlegen` wird die Zeile `listeAnzeigen();` entfernt:

```js
function karteAnlegen(frage, antwort) {
  const neueKarte = { frage: frage, antwort: antwort };
  karten.push(neueKarte);
  return neueKarte;
}
```

**Beobachtbar:** Die Karte wird angelegt – die Konsole zeigt, dass sie in der Liste ist – aber im Fenster erscheint nichts. Die Liste bleibt leer.

> „Die Daten sind da, die Anzeige nicht. Das ist die lehrreichste Fehlersituation des Kurses: Das Programm macht beides richtig, aber es macht nicht beides. Das eine ohne das andere ist nichts."

**Diagnoseweg:**

1. In der Konsole prüfen: `console.log(karten.length)` – ist die Zahl gestiegen? Dann sind die Daten da.
2. Dann die Frage stellen: *Was fehlt jetzt noch?* → der Aufruf der Anzeigefunktion.

Der Fehler wird von jeder Person selbst eingebaut, gesucht und repariert.

## Typische Stolperstellen

> [!warning]
> - `querySelector` liefert `null`, weil das `#` fehlt oder die `id` falsch geschrieben ist. Die Fehlermeldung nennt `null`, nicht die Ursache.
> - Nach einer Änderung an den Daten wird die Anzeigefunktion nicht aufgerufen.
> - `.textContent` bei einem Eingabefeld statt `.value`.
> - Beim `addEventListener` werden Klammern gesetzt: `("click", meineFunktion())` statt `("click", meineFunktion)`. Die Funktion läuft dann sofort statt beim Klick.
> - `liste.innerHTML = "";` vergessen – die Einträge stehen dann doppelt da.
> - Das Skript steht vor dem HTML und findet die Elemente noch nicht. In der vorbereiteten Datei ist das gelöst, beim eigenen Anbauen fällt es zurück.

## Stand am Ende des Moduls

- [ ] Alle Elemente der Oberfläche im Programm gegriffen und in der Konsole ausgegeben
- [ ] Den Knopf „Umdrehen" funktionsfähig gemacht
- [ ] Den Knopf „Nächste" funktionsfähig gemacht
- [ ] Den Knopf „Karte anlegen" mit Auslesen der Eingabefelder und Leeren der Felder
- [ ] `listeAnzeigen()` geschrieben und an den richtigen Stellen aufgerufen
- [ ] Den fehlenden Aufruf von `listeAnzeigen()` selbst eingebaut, gesucht und repariert
- [ ] Beide Zugriffsarten benannt: `.textContent` für Anzeigen, `.value` für Eingabefelder

## Verknüpfung

Merkblatt: [[K4 Merkblatt]] · Übungen: [[K4 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K5 Daten behalten]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

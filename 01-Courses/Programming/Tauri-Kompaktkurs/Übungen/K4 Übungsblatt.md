---
title: JavaScript im Fenster – Übungen
modul: K4
typ: uebungsblatt
tags: [tauri/kompaktkurs/uebung, javascript, dom]
status: active
---

# K4 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Der Selektor
- F2 Text oder Wert
- F3 Auf einen Klick reagieren
- F4 Aus Daten wird Anzeige
- F5 Die Reihenfolge beim Anlegen
- F6 `null` und die leere Liste
- F7 Der fehlende Aufruf
- F8 Zustände und Zuständigkeiten

---

## F1 Welchen Selektor braucht das Programm, um das Element mit der `id` `karte-antwort` zu finden? Und welcher für alle Knöpfe?

> [!success]- Antwort F1
> ```js
> const antwort = document.querySelector("#karte-antwort");
> const knopf = document.querySelector("button");
> ```
> Das Argument von `document.querySelector` ist ein **Selektor** – dieselbe Schreibweise wie in CSS: `#id` für ein einzelnes Element, `.klasse` für eine Gruppe, `element` für alle dieser Sorte.
>
> **Der Name muss exakt derselbe sein** wie das `id` in der HTML-Datei. Groß- und Kleinschreibung zählt.

---

## F2 Welche der beiden Formen passt zu welchem Element? Begründen Sie die Zuordnung.

| Element | `.textContent` | `.value` |
|---|---|---|
| Der Absatz `#karte-frage` | ☐ | ☐ |
| Das Eingabefeld `#frage-feld` | ☐ | ☐ |
| Die mehrzeilige Antwort `#antwort-feld` | ☐ | ☐ |

> [!success]- Antwort F2
> | Element | Richtige Form |
> |---|---|
> | Der Absatz `#karte-frage` | `.textContent` |
> | Das Eingabefeld `#frage-feld` | `.value` |
> | Die mehrzeilige Antwort `#antwort-feld` | `.value` |
>
> **Anzeigen haben Text, Eingabefelder haben einen Wert.** Der Unterschied steckt in der Sache selbst, nicht in der Schreibweise.
>
> Beim Lesen: `el.textContent` bzw. `el.value`. Beim Schreiben genauso mit `=`.

---

## F3 Was ist der Unterschied zwischen diesen beiden Zeilen? Wann läuft die Funktion jeweils?

```js
knopf.addEventListener("click", meineFunktion);
knopf.addEventListener("click", meineFunktion());
```

> [!success]- Antwort F3
> **Ohne Klammern** (richtig): Die Funktion läuft jedes Mal, wenn geklickt wird.
>
> **Mit Klammern** (falsch): Die Funktion läuft **sofort**, beim Aufbau des Programms – einmal. Danach passiert beim Klicken nichts mehr.
>
> **Merksatz:** Der Name einer Funktion, ohne Klammern, ist die Sache selbst. Mit Klammern ist es ein Aufruf.

---

## F4 Welche Zeile in dieser Funktion leert die Liste, und welche baut sie neu auf? Was passiert, wenn die leere Zeile fehlt?

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

> [!success]- Antwort F4
> **Leeren:** `liste.innerHTML = "";` – entfernt alles, was bisher in der Liste steht.
>
> **Neu aufbauen:** die `for`-Schleife mit `document.createElement("li")`, `textContent` und `appendChild`.
>
> **Ohne die Leerzeile:** Die Einträge stehen beim zweiten Anlegen doppelt da – einmal aus dem ersten Durchlauf, einmal aus dem zweiten.
>
> Das Muster dahinter: **Erst leeren, dann aus den Daten neu aufbauen.** Dann kann die Funktion so oft wiederholt werden, wie man will.

---

## F5 In welcher Reihenfolge müssen diese Schritte stehen, wenn eine Karte angelegt wird? Begründen Sie die Reihenfolge.

| Schritt | |
|---|---|
| A | Beide Eingabefelder leeren |
| B | Prüfen, ob Frage und Antwort ausgefüllt sind |
| C | `karteAnlegen(frage, antwort)` aufrufen |
| D | `listeAnzeigen()` aufrufen |
| E | Die Werte aus beiden Eingabefeldern holen |

> [!success]- Antwort F5
> Richtige Reihenfolge: **E → B → C → D → A**
>
> 1. **E** – Werte holen. Man kann nicht prüfen, was man nicht geholt hat.
> 2. **B** – prüfen, ob etwas leer ist. Sonst legt das Programm leere Karten an.
> 3. **C** – die Karte anlegen. Sie landet in der Liste `karten`.
> 4. **D** – die Anzeige neu aufbauen. **Erst danach darf angezeigt werden** – sonst sieht man die neue Karte erst beim nächsten Klick.
> 5. **A** – die Felder leeren, damit die nächste Karte sauber eingegeben werden kann.
>
> **Schritt C und D dürfen nicht vertauscht werden.** Wer zuerst anzeigt und danach anlegt, sieht die neue Karte nicht.

---

## F6 Beim Zugriff auf ein Element kommt `null` zurück. Woran kann das liegen?

> [!success]- Antwort F6
> Zwei naheliegende Ursachen:
>
> - Das **`#` fehlt** im Selektor – dann sucht das Programm nach einem Elementtyp namens `karte-frage` und findet nichts.
> - Die **`id` ist falsch geschrieben** – groß statt klein, oder ein Tippfehler.
>
> Die Fehlermeldung nennt `null`, nicht die Ursache. Deshalb der Handgriff: Den Namen **laut** nebeneinander vorlesen – Selektor aus JavaScript und `id` aus der HTML-Datei. Fast immer hört man es.

---

## F7 Die Karte wird angelegt – in der Konsole ist sie zu sehen, im Fenster erscheint nichts. Was fehlt?

> [!success]- Antwort F7
> Der Aufruf von **`listeAnzeigen()`** an der passenden Stelle fehlt.
>
> **Diagnoseweg:**
> 1. In der Konsole `console.log(karten.length)` prüfen. Ist die Zahl gestiegen? Dann sind die Daten da.
> 2. Dann die Frage stellen: *Was fehlt jetzt noch?* → die Anzeige.
>
> Das Programm macht beides richtig, aber es macht nicht beides. Das eine ohne das andere ist nichts. Das ist die lehrreichste Fehlersituation des Kurses.

---

## F8 Welche Aufgabe gehört zu welchem Objekt? Ordnen Sie zu.

| Aufgabe | `textContent` | `value` | `innerHTML` | `querySelector` | `createElement` | `addEventListener` |
|---|---|---|---|---|---|---|
| Die leere Liste im Fenster finden | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |
| Den Hinweistext eines Knopfes ändern | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |
| Den Inhalt des Eingabefelds auslesen | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |
| Die Kartenliste leeren | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |
| Einen neuen Listeneintrag bauen | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |
| Auf den Klick reagieren | ☐ | ☐ | ☐ | ☐ | ☐ | ☐ |

> [!success]- Antwort F8
> | Aufgabe | Richtige Form |
> |---|---|
> | Die leere Liste im Fenster finden | `querySelector` |
> | Den Hinweistext eines Knopfes ändern | `textContent` |
> | Den Inhalt des Eingabefelds auslesen | `value` |
> | Die Kartenliste leeren | `innerHTML` |
> | Einen neuen Listeneintrag bauen | `createElement` |
> | Auf den Klick reagieren | `addEventListener` |
>
> **Und die Verbindungsformen:**
> - `liste.innerHTML = "";` – der Liste einen leeren Inhalt geben
> - `liste.appendChild(eintrag);` – einen Eintrag an die Liste hängen
> - `eintrag.textContent = karte.frage;` – dem Eintrag seinen Text geben
> - `el.value = "";` – ein Eingabefeld leeren

---

## Verknüpfung

Leitfaden: [[K4 JavaScript im Fenster]] · Merkblatt: [[K4 Merkblatt]]
Weiter mit [[K5 Daten behalten]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

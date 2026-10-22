---
title: JavaScript im Fenster – Merkblatt
modul: K4
typ: merkblatt
tags: [tauri/kompaktkurs/merkblatt, javascript, dom]
status: active
---

# K4 – Merkblatt

## Ein Element greifen

```js
const ueberschrift = document.querySelector("#karte-frage");
```

Das Argument ist ein **Selektor** – dieselbe Schreibweise wie in CSS:

| Gesucht | Selektor |
|---|---|
| Element mit der `id` `karte-frage` | `#karte-frage` |
| alle Knöpfe | `button` |
| Elemente mit der Klasse `knopf-anzeige` | `.knopf-anzeige` |

> **Der Name muss exakt derselbe sein** wie das `id` in der HTML-Datei. Groß- und Kleinschreibung zählt.

## Text und Wert

| | Angezeigte Elemente | Eingabefelder |
|---|---|---|
| Was drinsteht | Text | Wert |
| Lesen | `.textContent` | `.value` |
| Schreiben | `.textContent = "…"` | `.value = "…"` |

> **Anzeigen haben Text, Eingabefelder haben einen Wert.**

## Auf Klicks reagieren

```js
knopf.addEventListener("click", function () {
  // passiert beim Klick
});
```

```js
knopf.addEventListener("click", meineFunktion);    // richtig
knopf.addEventListener("click", meineFunktion());   // falsch
```

> **Der Name einer Funktion, ohne Klammern, ist die Sache selbst. Mit Klammern ist es ein Aufruf** – die Funktion läuft dann sofort statt beim Klick.

## Aus Daten wird Anzeige

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

| Zeile | Was sie tut |
|---|---|
| `document.querySelector("#karten-liste")` | die Liste aus dem HTML holen |
| `liste.innerHTML = "";` | alles Vorhandene entfernen |
| `document.createElement("li")` | einen neuen Listeneintrag bauen |
| `eintrag.textContent = karte.frage;` | seinen Inhalt setzen |
| `liste.appendChild(eintrag);` | ihn an die Liste hängen |

> **Erst leeren, dann aus den Daten neu aufbauen.**
> Sonst stehen die alten Einträge beim zweiten Anlegen doppelt da.

## Der Ablauf beim Anlegen einer Karte

1. **Werte holen** – `.value` aus beiden Eingabefeldern
2. **Prüfen** – ist etwas leer? Dann abbrechen
3. **Anlegen** – `karteAnlegen(frage, antwort)`
4. **Anzeigen** – `listeAnzeigen()`
5. **Leeren** – beide Felder auf `""` setzen

> **Schritt 3 und 4 dürfen nicht vertauscht werden.** Wird zuerst angezeigt und danach angelegt, sieht man die neue Karte erst beim nächsten Klick.

## Die verwendeten Formen

| Form | Wofür |
|---|---|
| `document.querySelector("#id")` | ein Element finden |
| `.textContent` | Text eines Elements lesen oder setzen |
| `.value` | Inhalt eines Eingabefelds lesen oder setzen |
| `.addEventListener("click", funktion)` | auf einen Klick reagieren |
| `.innerHTML = ""` | einen Bereich leeren |
| `document.createElement("li")` | ein neues Element bauen |
| `.appendChild(element)` | ein Element einhängen |
| `%` | Rest beim Teilen – nach der letzten Karte kommt die erste |

## Diagnose

| Beobachtung | Ursache |
|---|---|
| `null` bei `querySelector` | `#` fehlt oder `id` falsch geschrieben |
| Nichts passiert, keine Meldung | Funktion nie aufgerufen – oder der Aufruf von `listeAnzeigen()` fehlt |
| Karte ist in der Konsole, aber nicht im Fenster | `listeAnzeigen()` wurde nicht aufgerufen |
| Einträge stehen doppelt da | `liste.innerHTML = "";` fehlt |
| Eingabefeld liefert `undefined` | `.textContent` statt `.value` |
| Funktion läuft nur einmal | Klammern beim `addEventListener` |

> **Wenn der Zugriff nicht klappt:** Den Namen **laut** nebeneinander vorlesen – Selektor aus JavaScript und `id` aus HTML. Fast immer hört man es.

## Verknüpfung

Leitfaden: [[K4 JavaScript im Fenster]] · Übungen: [[K4 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K5 Daten behalten]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

---
title: Daten behalten – Übungen
modul: K5
typ: uebungsblatt
tags: [tauri/kompaktkurs/uebung, tauri, javascript]
status: active
---

# K5 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Die Rollenverteilung
- F2 Warum darf eine Webseite das nicht
- F3 Das Rezept
- F4 Der Aufruf und seine Teile
- F5 Wo muss gespeichert werden
- F6 `Promise` statt Liste
- F7 Die Datei finden

---

## F1 Welche Aufgabe gehört zu welchem Teil der Anwendung?

| Aufgabe | Fenster (`index.html`, `app.js`) | Programmkern (`main.rs`) |
|---|---|---|
| Den Knopf „Karte anlegen" anzeigen | ☐ | ☐ |
| Die Karte in eine Datei schreiben | ☐ | ☐ |
| Die Frage aus dem Eingabefeld lesen | ☐ | ☐ |
| Die Datei lesen und die Liste zurückgeben | ☐ | ☐ |
| Die Karte in der Liste anzeigen | ☐ | ☐ |

> [!success]- Antwort F1
> | Aufgabe | Teil |
> |---|---|
> | Den Knopf anzeigen | Fenster |
> | Die Karte in eine Datei schreiben | Programmkern |
> | Die Frage aus dem Eingabefeld lesen | Fenster |
> | Die Datei lesen und die Liste zurückgeben | Programmkern |
> | Die Karte in der Liste anzeigen | Fenster |
>
> **Merksatz:** Das Fenster kann sehen und reagieren, aber nicht auf die Festplatte zugreifen. Der Programmkern kann auf die Festplatte zugreifen, aber man sieht ihn nicht.

---

## F2 Warum darf eine Webseite keine Dateien auf dem Rechner schreiben, eine installierte Anwendung aber schon?

> [!success]- Antwort F2
> Eine **Webseite** kommt von einem fremden Server und soll nicht in die Dateien des Rechners schreiben können. Eine **installierte Anwendung** darf es, weil sie bewusst installiert wurde.
>
> Der Unterschied ist nicht die Technik, sondern die Erlaubnis: Eine Webseite ist ein Gastsucher, eine installierte Anwendung ist eingezogen und hat einen Schlüssel für die Schränke.

---

## F3 Was bedeuten diese drei Wörter? Füllen Sie die Rezeptregeln aus.

| Wort | Rezeptregel |
|---|---|
| `invoke` | |
| `await` | |
| `async` | |

> [!success]- Antwort F3
> | Wort | Rezeptregel |
> |---|---|
> | `invoke` | „Ruf den Programmkern" |
> | `await` | „Warte, bis er fertig ist" |
> | `async` | „Diese Funktion darf warten" |
>
> **Merksatz:** **Wo `await` steht, muss `async` davorstehen.** Wer das vergisst, bekommt eine Fehlermeldung mit genau diesem Hinweis.

---

## F4 Zerlegen Sie den Aufruf in seine Teile.

```js
await window.__TAURI__.core.invoke("karten_speichern", { karten: karten });
```

1. Der Weg zum Programmkern: `________________________________`
2. Der Name der Funktion dort drüben: `________________________________`
3. Die mitgegebenen Daten: `________________________________`

> [!success]- Antwort F4
> 1. `window.__TAURI__.core.invoke`
> 2. `"karten_speichern"`
> 3. `{ karten: karten }`
>
> **Bei Teil 3:** Links steht der Name, den die Rust-Funktion erwartet, rechts der Wert, der hingeschickt wird. Das ist **n** das Objekt aus [[K3 JavaScript – die Bausteine]] – es ist die Argumentliste für den Aufruf.
>
> Der Name in Teil 2 muss **exakt** zum Rust-Namen passen. Groß- und Kleinschreibung zählt.

---

## F5 An welchen Stellen muss `speichern()` aufgerufen werden? Begründen Sie jede.

> [!success]- Antwort F5
> An jeder Stelle, an der sich die Daten ändern:
>
> | Stelle | Nach was |
> |---|---|
> | Nach dem Anlegen einer Karte | eine Karte kam dazu |
> | Nach dem Löschen einer Karte | eine Karte ist weg |
> | Nach dem Ändern einer Karte | der Inhalt ist anders |
>
> **Speichern an nur einer Stelle reicht nicht.** Wird nur nach dem Anlegen gespeichert, kommen gelöschte Karten beim nächsten Start wieder zurück. Der Fehler ist beim Ausprobieren harmlos und fällt erst später auf.

---

## F6 Was bedeutet es, wenn in der Konsole `Promise` statt der Liste steht?

> [!success]- Antwort F6
> Das `await` wurde weggelassen. Das Programm war **zu schnell** und hat nicht gewartet: Der Programmkern arbeitet im Hintergrund, aber das Fenster wollte sofort weiter – und hatte die Antwort noch nicht.
>
> **Merksatz:** `await` bedeutet „warte, bis er fertig ist". Fehlt es, kommt das `Promise`-Objekt statt des Ergebnisses.
>
> Die Reparatur ist eine Zeile: `await` wieder hineinsetzen. Und falls die Fehlermeldung stattdessen `async` sagt: **Wo `await` steht, muss `async` davorstehen.**

---

## F7 Wo liegt die Datei mit den Karten? Wie findet man sie?

> [!success]- Antwort F7
> Der Programmkern schreibt in den **Anwendungsdatenordner**, nicht in den Projektordner:
>
> ```nu
> ls ~/.local/share/de.metarow.Lernkarten
> open ~/.local/share/de.metarow.Lernkarten/lernkarten.json
> ```
>
> Der Dateiname ist `lernkarten.json`, weil die Rust-Funktion so benannt ist.

---

## Verknüpfung

Leitfaden: [[K5 Daten behalten]] · Merkblatt: [[K5 Merkblatt]]
Weiter mit [[K6 Feinschliff]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

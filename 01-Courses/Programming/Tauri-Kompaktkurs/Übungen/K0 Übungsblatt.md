---
title: Ankommen und erste eigene Änderung – Übungen
modul: K0
typ: uebungsblatt
aliases:
  - K0c Übungsblatt
tags: [tauri/kompaktkurs/uebung]
status: active
---

# K0 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Die drei Startbefehle
- F2 Im Container oder auf dem Host
- F3 Welche Datei ist zuständig
- F4 Bedeutung der Marken
- F5 Ein fehlendes Ende-Tag
- F6 Fenstertitel und Fensterinhalt
- F7 Der Ablauf beim Arbeiten

---

## F1 Welche drei Befehle starten die Anwendung, und was tut jeder davon?

> [!success]- Antwort F1
> ```nu
> toolbox enter tauri-dev     # in den Container wechseln
> cd ~/Projekte/lernkarten    # in den Projektordner wechseln
> cargo tauri dev             # bauen und das Fenster öffnen
> ```
> `cd` steht für *change directory*. Beendet wird mit `Strg` + `C`, danach `exit`.

---

## F2 Woran erkennt man, dass man sich im Container befindet – und wie lässt sich das sicher prüfen?

> [!success]- Antwort F2
> Am **Sechseck** ⬢ vorne in der Eingabezeile. Sicher prüfbar mit:
> ```nu
> if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
> ```
> Im Container liegen die Werkzeuge zum Bauen; das eigentliche System bleibt unberührt. Die Frage wird in [[K7 Als Anwendung ausliefern]] wieder wichtig, weil dort bewusst außerhalb des Containers gearbeitet wird.

---

## F3 Welche der drei Dateien wird angefasst? Ordnen Sie zu.

| Vorhaben | `index.html` | `style.css` | `app.js` |
|---|---|---|---|
| Die Überschrift soll rot werden | ☐ | ☐ | ☐ |
| Es soll einen Knopf mehr geben | ☐ | ☐ | ☐ |
| Beim Klick soll eine Karte erscheinen | ☐ | ☐ | ☐ |
| Die Schrift soll größer werden | ☐ | ☐ | ☐ |
| Es soll ein Eingabefeld für die Frage geben | ☐ | ☐ | ☐ |
| Die Karten sollen gezählt werden | ☐ | ☐ | ☐ |

> [!success]- Antwort F3
> | Vorhaben | Datei | Begründung |
> |---|---|---|
> | Überschrift soll rot werden | `style.css` | Aussehen |
> | Ein Knopf mehr | `index.html` | was da ist |
> | Beim Klick erscheint eine Karte | `app.js` | was passiert |
> | Schrift größer | `style.css` | Aussehen |
> | Eingabefeld für die Frage | `index.html` | was da ist |
> | Karten zählen | `app.js` | was passiert |
>
> **Eselsbrücke:** *was da ist* – *wie es aussieht* – *was passiert*.
>
> Ein Knopf lässt sich auch aus `app.js` erzeugen, das passiert in [[K4 JavaScript im Fenster]] tatsächlich. Für den Einstieg gilt die einfache Zuordnung.

---

## F4 Wo steht der Text, der im Fenster erscheinen soll?

```html
<h1>Lernkarten</h1>
```

> [!success]- Antwort F4
> **Zwischen** den beiden Marken. Aus `<h1>Lernkarten</h1>` wird zum Beispiel `<h1>Lernkarten von Anna</h1>`.
>
> **Typischer Fehler:** `<h1 Lernkarten von Anna>` – der Text landet in der Marke selbst. Im Fenster erscheint dann gar nichts.

---

## F5 Was passiert, wenn das schließende `</h1>` fehlt – und warum?

> [!success]- Antwort F5
> **Beobachtung:** Der gesamte folgende Inhalt wird groß und fett dargestellt. Nichts stürzt ab.
>
> **Erklärung:** Es fehlt die Angabe, wo die Überschrift aufhört. Also nimmt das Programm an, sie hört nie auf, und behandelt alles Folgende als Teil der Überschrift. Es rät, statt zu versagen.
>
> **Reparatur:** `</h1>` wieder einfügen – der Zustand ist vollständig wiederhergestellt.
>
> Akzeptierte Formulierungen: „Ich habe das Ende vergessen", „Die Überschrift hört nicht auf", „Alles ist Überschrift geworden".

---

## F6 An welcher Stelle im Quelltext steht der Fenstertitel, und wo erscheint eine Änderung daran?

> [!success]- Antwort F6
> Im Kopfbereich der Datei:
> ```html
> <title>Lernkarten</title>
> ```
> Die Änderung erscheint **nicht** im Fensterinhalt, sondern in der Fensterleiste beziehungsweise in der Fensterliste von Sway. Nicht alles im Quelltext ist Inhalt des Fensters.

---

## F7 Wie lautet der Ablauf beim Arbeiten am Quelltext, und warum genau in dieser Reihenfolge?

> [!success]- Antwort F7
> **Ändern → Speichern → Hinsehen.** Nach jeder einzelnen Änderung.
>
> Wer fünf Dinge auf einmal ändert und dann hinschaut, weiß bei einem Fehler nicht mehr, welche der fünf Änderungen ihn verursacht hat. Erscheint die Änderung nicht: Rechtsklick ins Anwendungsfenster → **Neu laden**.

---

## F8 Was unterscheidet einen Fehler wie das fehlende `</h1>` von einem abgestürzten Programm?

> [!success]- Antwort F8
> Nichts stürzt ab, nichts geht verloren. Das Programm rät und arbeitet mit der wahrscheinlichsten Annahme weiter. Deshalb gilt: **Kaputtmachen ist erlaubt.** Reparabel ist es immer, und der Rechner sagt meistens, wo das Problem liegt.
>
> Dieselbe Erfahrung wird später bewusst wiederholt – in [[K1 HTML – die Struktur]] mit einem nicht geschlossenen `<div>` und in [[K2 CSS – das Aussehen]] mit einem fehlenden Semikolon.

---

## Verknüpfung

Leitfaden: [[K0 Ankommen und erste eigene Änderung]] · Merkblatt: [[K0 Merkblatt]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

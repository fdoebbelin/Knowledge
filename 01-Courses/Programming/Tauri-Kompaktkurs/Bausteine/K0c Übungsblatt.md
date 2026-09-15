---
baustein: K0
typ: uebungsblatt
title: Ankommen und erste eigene Änderung – Übungen
ue: 2
kurstag: 1
tags: [tauri/kompaktkurs/uebung]
status: entwurf
---

# K0 – Übungsblatt

> [!info] Hinweis zu den Lösungen
> Die Lösungen stehen jeweils direkt unter der Aufgabe in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen. Auf dem gedruckten Teilnehmerblatt werden die Lösungskästen entfernt – die Kursleitungsfassung behält sie.

> [!tip] Die Regel für alle Aufgaben
> **Ändern → Speichern → Hinsehen.** Immer nur eine Sache auf einmal.

---

## Ü0.1 Umgebung starten

Starten Sie Ihre Anwendung. Haken Sie ab, was erledigt ist:

- [ ] Terminal geöffnet
- [ ] In den Container gewechselt, das Sechseck ⬢ ist sichtbar
- [ ] In den Projektordner gewechselt
- [ ] Anwendung gestartet, das Fenster zeigt die Überschrift „Lernkarten"
- [ ] Editor und Anwendungsfenster liegen nebeneinander

> [!success]- Lösung Ü0.1
> ```nu
> toolbox enter tauri-dev
> cd ~/Projekte/lernkarten
> cargo tauri dev
> ```
> Fenster nebeneinander anordnen, in einem zweiten Terminal oder vor dem Start:
> ```nu
> swaymsg splith
> ```
> **Prüffrage der Kursleitung:** „Wo sind Sie gerade – im Container oder auf dem Host?"
> Antwort: im Container. Erkennbar am Sechseck vorne in der Eingabezeile, sicher prüfbar mit:
> ```nu
> if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
> ```

---

## Ü0.2 Ihr Name in der Überschrift

Öffnen Sie `src/index.html` im Editor. Suchen Sie die Zeile mit der Überschrift und schreiben Sie Ihren eigenen Namen hinein.

Speichern. Ins Fenster schauen.

> [!success]- Lösung Ü0.2
> Vorher:
> ```html
> <h1>Lernkarten</h1>
> ```
> Nachher, zum Beispiel:
> ```html
> <h1>Lernkarten von Anna</h1>
> ```
> Der Name steht **zwischen** den beiden Marken, nicht innerhalb der spitzen Klammern.
>
> **Typischer Fehler:** `<h1 Lernkarten von Anna>` – der Name landet in der Marke selbst. Im Fenster erscheint dann gar nichts.

---

## Ü0.3 Drei eigene Änderungen

Denken Sie sich **drei** Änderungen selbst aus und setzen Sie sie um. Nach jeder Änderung ins Fenster schauen.

Falls Ihnen nichts einfällt, wählen Sie aus diesen Vorschlägen:

1. Einen zweiten Satz unter der Überschrift einfügen
2. Die Überschrift kleiner machen
3. Einen eingefügten Satz wieder löschen
4. Zwei Sätze untereinander einfügen und ihre Reihenfolge tauschen

Notieren Sie in Ihrem Heft, welche drei Änderungen Sie gemacht haben. Sie stellen eine davon nachher der Gruppe vor.

> [!success]- Lösung Ü0.3
> **Vorschlag 1 – Satz einfügen.** Ein Absatz wird mit `<p>` geschrieben:
> ```html
> <h1>Lernkarten von Anna</h1>
> <p>Diese Anwendung baue ich gerade selbst.</p>
> ```
>
> **Vorschlag 2 – Überschrift kleiner machen.** `<h1>` durch `<h2>` ersetzen, **beide** Marken:
> ```html
> <h2>Lernkarten von Anna</h2>
> ```
> Wird nur die vordere Marke geändert, passen Anfang und Ende nicht mehr zusammen. Die Darstellung ist dann unvorhersehbar.
>
> **Vorschlag 3 – löschen.** Die komplette Zeile entfernen, einschließlich `<p>` und `</p>`.
>
> **Vorschlag 4 – Reihenfolge tauschen.** Die beiden vollständigen Zeilen vertauschen:
> ```html
> <p>Zweiter Satz.</p>
> <p>Erster Satz.</p>
> ```
> Lerneffekt: Die Reihenfolge im Quelltext ist die Reihenfolge im Fenster. Von oben nach unten.
>
> **Hinweis für die Kursleitung:** Kommt der Wunsch nach einer Farbänderung, wird auf [[K2 CSS – das Aussehen]] verwiesen. Heute wird nur geändert, **was** dasteht, noch nicht, wie es aussieht.

---

## Ü0.4 Absichtlich kaputt machen

1. Löschen Sie das schließende `</h1>` Ihrer Überschrift.
2. Speichern, hinsehen. **Beschreiben Sie in einem Satz, was passiert ist.**
3. Reparieren Sie den Fehler.

Notieren Sie Ihren Satz aus Schritt 2 im Heft:

`_______________________________________________________________`

> [!success]- Lösung Ü0.4
> **Beobachtung:** Der gesamte Text unterhalb der Überschrift wird groß und fett dargestellt.
>
> **Erklärung in Kurssprache:** Es fehlt die Angabe, wo die Überschrift aufhört. Also nimmt das Programm an, sie hört nie auf, und behandelt alles Folgende als Teil der Überschrift.
>
> **Wichtiger als die Erklärung:** Nichts ist abgestürzt, nichts ist verloren. Das Zurückschreiben des `</h1>` stellt den Zustand vollständig wieder her.
>
> **Reparatur:**
> ```html
> <h1>Lernkarten von Anna</h1>
> ```
>
> Akzeptierte Formulierungen der Teilnehmenden: „Ich habe das Ende vergessen", „Die Überschrift hört nicht auf", „Alles ist Überschrift geworden". Alle drei zeigen, dass es verstanden wurde.

---

## Ü0.5 Zuordnung

Welche Datei würden Sie anfassen? Kreuzen Sie an.

| Vorhaben | `index.html` | `style.css` | `app.js` |
|---|---|---|---|
| Die Überschrift soll rot werden | ☐ | ☐ | ☐ |
| Es soll einen Knopf mehr geben | ☐ | ☐ | ☐ |
| Beim Klick soll eine Karte erscheinen | ☐ | ☐ | ☐ |
| Die Schrift soll größer werden | ☐ | ☐ | ☐ |
| Es soll ein Eingabefeld für die Frage geben | ☐ | ☐ | ☐ |
| Die Karten sollen gezählt werden | ☐ | ☐ | ☐ |

> [!success]- Lösung Ü0.5
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
> **Für die Kursleitung:** Wenn jemand einwendet, ein Knopf ließe sich auch aus `app.js` erzeugen, ist das sachlich richtig und passiert in [[K4 JavaScript im Fenster]] tatsächlich. Antwort: „Stimmt, das machen wir am dritten Tag. Bis dahin gilt die einfache Aufteilung."

---

## Zusatzaufgaben für Schnellere

> [!note] Freiwillig
> Diese Aufgaben führen keinen neuen Stoff ein. Sie vertiefen nur, was schon dran war.

**Z1 – Verschachtelung ausprobieren.** Bauen Sie einen Absatz **innerhalb** eines Bereichs. Was ändert sich im Fenster, was nicht?

**Z2 – Der Fenstertitel.** Suchen Sie im Quelltext die Stelle, an der der Titel des Fensters steht, und ändern Sie ihn. Wo erscheint diese Änderung?

**Z3 – Nummerierte Überschriften.** Schreiben Sie `<h1>` bis `<h2>` untereinander mit gleichem Text. Was fällt auf?

> [!success]- Lösungen Z1 bis Z3
> **Z1:** Ein `<div>` ist ein Bereich zum Gruppieren. Optisch ändert sich zunächst nichts – der Absatz sieht gleich aus.
> ```html
> <div>
>   <p>Dieser Absatz steht in einem Bereich.</p>
> </div>
> ```
> Genau das ist die Lernpointe: `<div>` ist unsichtbar und wird erst in [[K2 CSS – das Aussehen]] nützlich, wenn ein ganzer Bereich einen Rahmen oder eine Hintergrundfarbe bekommt.
>
> **Z2:** Die Zeile steht im Kopfbereich der Datei:
> ```html
> <title>Lernkarten</title>
> ```
> Die Änderung erscheint **nicht** im Fensterinhalt, sondern in der Fensterleiste beziehungsweise in der Fensterliste von Sway. Lernpointe: Nicht alles im Quelltext ist Inhalt des Fensters.
>
> **Z3:**
> ```html
> <h1>Lernkarten</h1>
> <h2>Lernkarten</h2>
> ```
> Die zweite Überschrift ist kleiner. Die Zahl gibt die Rangfolge an: `h1` ist die wichtigste Überschrift der Seite, `h2` eine Unterüberschrift. Ausführlich in [[K1 HTML – die Struktur]].

---

## Abschlusskontrolle

Haken Sie ab, wenn Sie es **selbst** gemacht haben – nicht, wenn Sie zugeschaut haben:

- [ ] Ü0.1 Anwendung selbst gestartet
- [ ] Ü0.2 Eigener Name steht in der Überschrift
- [ ] Ü0.3 Drei eigene Änderungen umgesetzt und im Heft notiert
- [ ] Ü0.4 Fehler eingebaut, beschrieben und repariert
- [ ] Ü0.5 Zuordnungstabelle ausgefüllt

## Verknüpfung

Handout: [[K0b Handout]] · Trainerskript: [[K0a Trainerskript]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

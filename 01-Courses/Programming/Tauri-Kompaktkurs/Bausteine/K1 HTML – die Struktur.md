---
baustein: K1
title: HTML – die Struktur
ue: 4
kurstag: 1
tags: [tauri/kompaktkurs/baustein, html]
status: entwurf
---

# K1 – HTML – die Struktur

> [!abstract] Ziel des Bausteins
> Am Ende steht die vollständige Oberfläche der Lernkarten-Anwendung. Sie sieht noch schlicht aus und tut noch nichts, aber alle Bestandteile sind da.

## Lernziele

- Den Aufbau eines HTML-Elements aus Start-Tag, Inhalt und End-Tag beschreiben
- Verschachtelung lesen und selbst korrekt schreiben
- Die im Kurs benutzten Elemente einsetzen
- Attribute setzen, insbesondere `id`
- Ein Formularelement einbauen und seinen Zweck benennen

## Sprachumfang

Nur diese Elemente. Mehr braucht die Anwendung nicht.

| Element | Wofür |
|---|---|
| `<h1>`, `<h2>` | Überschriften |
| `<p>` | Textabsatz |
| `<div>` | Bereich zum Gruppieren |
| `<button>` | Knopf |
| `<input>` | einzeiliges Eingabefeld |
| `<textarea>` | mehrzeiliges Eingabefeld |
| `<ul>`, `<li>` | Liste und Listeneintrag |
| `<span>` | kleiner Textbereich innerhalb eines Absatzes |

Attribute: `id`, `class`, `placeholder`, `type`.

## Ablauf

### 1. Wie ein Element aussieht (30 min)

Am lebenden Objekt im laufenden Fenster. Öffnendes Tag, Inhalt, schließendes Tag. Danach Verschachtelung an einem `<div>` mit zwei `<p>` darin.

### 2. Die Elemente durchgehen (45 min)

Jedes Element einmal einbauen, Wirkung im Fenster ansehen, wieder entfernen. Reihum, jede Person zwei Elemente.

### 3. `id` als Name (30 min)

Warum ein Element einen Namen braucht: Damit wir es später ansprechen können. Der Zusammenhang zu K4 wird angekündigt, aber nicht erklärt.

Regel im Kurs: Jede `id` wird kleingeschrieben, ohne Leerzeichen, auf Deutsch. `karten-liste`, `frage-feld`, `knopf-neu`.

### 4. Die Oberfläche bauen (60 min)

Gemeinsam, Schritt für Schritt, mit Zwischenstand nach jedem Bereich:

```html
<div id="eingabe">
  <input id="frage-feld" placeholder="Frage" />
  <textarea id="antwort-feld" placeholder="Antwort"></textarea>
  <button id="knopf-neu">Karte anlegen</button>
</div>

<div id="anzeige">
  <p id="karte-frage">Noch keine Karte</p>
  <p id="karte-antwort"></p>
  <button id="knopf-umdrehen">Umdrehen</button>
  <button id="knopf-weiter">Nächste</button>
</div>

<ul id="karten-liste"></ul>
```

### 5. Absichtlicher Fehler (15 min)

Ein `<div>` wird nicht geschlossen. Anschauen, was mit dem Layout passiert, reparieren.

## Praxisteil

- [ ] Alle acht Elemente einmal selbst einbauen und wieder entfernen
- [ ] Die Oberfläche vollständig nachbauen
- [ ] Alle `id`-Namen in einer Liste im eigenen Notizheft festhalten. Diese Liste wird in K4 gebraucht.
- [ ] Zusatzaufgabe für Schnellere: eine Überschrift und einen erklärenden Absatz ergänzen

## Typische Stolpersteine

> [!warning]
> - `<textarea>` braucht ein schließendes Tag, `<input>` nicht. Das ist inkonsequent und irritiert regelmäßig.
> - Anführungszeichen um Attributwerte werden vergessen.
> - `id` wird doppelt vergeben. Fällt hier nicht auf, bricht in K4.
> - Groß- und Kleinschreibung bei `id` ist relevant. Deshalb die Kursregel: immer klein.

## Verknüpfung

Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

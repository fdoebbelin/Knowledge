---
title: HTML – die Struktur – Übungen
modul: K1
typ: uebungsblatt
aliases:
  - K1c Übungsblatt
tags: [tauri/kompaktkurs/uebung, html]
status: active
---

# K1 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Ein Element zerlegen
- F2 Sechs Fehlerschnipsel
- F3 `id`-Namen beurteilen
- F4 Zwei unsichtbare Elemente
- F5 Warum eine `id` nur einmal
- F6 Das nicht geschlossene `<div>`

---

## F1 Zerlegen Sie das Element in seine Bestandteile.

```html
<button id="knopf-neu">Karte anlegen</button>
```

1. Start-Tag: `________________________________`
2. Inhalt: `________________________________`
3. Ende-Tag: `________________________________`
4. Attributname: `________________________________`
5. Attributwert: `________________________________`

> [!success]- Antwort F1
> 1. Start-Tag: `<button id="knopf-neu">`
> 2. Inhalt: `Karte anlegen`
> 3. Ende-Tag: `</button>`
> 4. Attributname: `id`
> 5. Attributwert: `knopf-neu`
>
> **Häufiger Fehler:** Das Attribut wird nicht zum Start-Tag gezählt. Es gehört hinein – ein Attribut steht immer im Start-Tag, nie im Ende-Tag und nie im Inhalt.

---

## F2 In jedem Schnipsel steckt genau ein Fehler. Markieren Sie ihn und schreiben Sie die richtige Fassung daneben.

**a)**
```html
<p>Das ist ein Absatz.</div>
```

**b)**
```html
<div>
  <p>Text im Bereich.
</div>
```

**c)**
```html
<textarea placeholder="Antwort" />
```

**d)**
```html
<button id=knopf-neu>Karte anlegen</button>
```

**e)**
```html
<ul>
  Erster Eintrag
  Zweiter Eintrag
</ul>
```

**f)**
```html
<div>
  <p>Erster</p>
  <p>Zweiter</p>
```

> [!success]- Antwort F2
> **a)** Start- und Ende-Tag gehören zusammen. Ende-Tag falsch.
> ```html
> <p>Das ist ein Absatz.</p>
> ```
>
> **b)** Dem Absatz fehlt das Ende-Tag. Der Bereich schließt, bevor der Absatz geschlossen ist.
> ```html
> <div>
>   <p>Text im Bereich.</p>
> </div>
> ```
>
> **c)** `<textarea>` braucht ein Ende-Tag – das ist die Ausnahme. Nur `<input>` darf sich selbst schließen.
> ```html
> <textarea placeholder="Antwort"></textarea>
> ```
>
> **d)** Der Attributwert steht ohne Anführungszeichen.
> ```html
> <button id="knopf-neu">Karte anlegen</button>
> ```
>
> **e)** Einträge einer Liste müssen in `<li>` stehen. Loser Text in einer `<ul>` gehört dort nicht hin.
> ```html
> <ul>
>   <li>Erster Eintrag</li>
>   <li>Zweiter Eintrag</li>
> </ul>
> ```
>
> **f)** Dem `<div>` fehlt das Ende-Tag. Erkennbar daran, dass die Einrückung nach rechts wandert und nicht zurückkommt.
> ```html
> <div>
>   <p>Erster</p>
>   <p>Zweiter</p>
> </div>
> ```
>
> **Hinweis:** b) und f) sind derselbe Fehlertyp auf zwei Ebenen. Wer beide findet, hat das Prinzip verstanden; wer nur einen findet, braucht den Einrückungs-Handgriff noch einmal gezeigt.

---

## F3 Welche dieser Namen entsprechen den Kursregeln? Kreuzen Sie an und begründen Sie kurz bei den falschen.

| Name | in Ordnung | verstößt gegen |
|---|---|---|
| `frage-feld` | ☐ | |
| `Karten-Liste` | ☐ | |
| `knopf neu` | ☐ | |
| `deleteButton` | ☐ | |
| `karte-antwort` | ☐ | |
| `eingabe` | ☐ | |

> [!success]- Antwort F3
> | Name | in Ordnung | verstößt gegen |
> |---|---|---|
> | `frage-feld` | ✔ | – |
> | `Karten-Liste` | ✘ | Regel 1: alles klein |
> | `knopf neu` | ✘ | Regel 2: kein Leerzeichen, Bindestrich verwenden |
> | `deleteButton` | ✘ | Regel 1 (Großbuchstabe) und Regel 3 (Deutsch) |
> | `karte-antwort` | ✔ | – |
> | `eingabe` | ✔ | – |
>
> **Nachfrage:** „Welche der Regeln ist keine Kursregel, sondern eine echte Vorschrift?" → Regel 4: jede `id` nur einmal im Dokument. Die anderen drei sind Vereinbarungen, damit alle dasselbe schreiben.

---

## F4 Welche zwei der acht Elemente sind im Fenster unsichtbar, obwohl sie da sind?

> [!success]- Antwort F4
> **`<div>` und `<span>`.** Beide sind reine Bereiche ohne eigenes Aussehen. Sie werden erst in [[K2 CSS – das Aussehen]] nützlich, wenn ein ganzer Bereich auf einmal Rahmen oder Farbe bekommt.
>
> Ebenfalls akzeptabel: ein leeres `<p></p>`. Es ist zwar sichtbar veranlagt, ohne Inhalt aber nicht wahrnehmbar.

---

## F5 Warum darf eine `id` nur einmal im ganzen Dokument vorkommen? Was passiert, wenn sie doppelt vergeben wird?

> [!success]- Antwort F5
> Eine `id` ist der **eigene Name** eines Elements. Ein Name, der zweimal vergeben ist, ist kein Name mehr – es bleibt keine eindeutige Zuordnung.
>
> **Im Fenster verändert sich dabei nichts.** Genau das ist das Problem: Der Fehler ist unsichtbar und schlägt erst in [[K4 JavaScript im Fenster]] zu, wenn das Programm stumm das falsche Element erwischt – ohne Fehlermeldung.
>
> Die `class` ist der andere Fall: Sie ist der Gruppenname und darf mehrfach vorkommen.

---

## F6 In der fertigen Oberfläche fehlt ein `</div>`. Beschreiben Sie in einem Satz, was sich im Fenster verändert, und wie Sie den Fehler über die Einrückung wiederfinden.

> [!success]- Antwort F6
> **Beobachtung:** Der Anzeigebereich liegt jetzt innerhalb des Eingabebereichs. Optisch ist der Unterschied klein, weil noch keine Rahmen und Farben gesetzt sind.
>
> **Das ist der eigentliche Lerninhalt:** Der Fehler tut jetzt nicht weh. Sobald in [[K2 CSS – das Aussehen]] die Bereiche Rahmen bekommen, sitzt plötzlich der halbe Bildschirm im falschen Kasten – und der Fehler wurde vorher gemacht.
>
> **Fund über die Einrückung:** Ab der Zeile mit `<div id="anzeige">` steht alles zwei Stufen weiter rechts, als es sollte, und kommt bis zum Dateiende nicht zurück. Genau dort fehlt das Ende-Tag.
>
> **Reparatur:** `</div>` hinter dem Knopf „Karte anlegen" wieder einfügen.
>
> **Zweiter Handgriff:** Im Editor auf eine spitze Klammer klicken – er hebt die zugehörige hervor. Findet er keine, ist das der Beweis.

---

## Verknüpfung

Leitfaden: [[K1 HTML – die Struktur]] · Merkblatt: [[K1 Merkblatt]]
Weiter mit [[K2 CSS – das Aussehen]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

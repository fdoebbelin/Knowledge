---
baustein: K2
title: CSS – das Aussehen
ue: 5
kurstag: 1-2
tags: [tauri/kompaktkurs/baustein, css]
status: draft
---

# K2 – CSS – das Aussehen

> [!abstract] Ziel des Bausteins
> Aus der nackten Struktur wird etwas, das wie eine Anwendung aussieht. Der Sprung ist optisch groß und motivatorisch der wichtigste des ganzen Kurses.

## Lernziele

- Eine CSS-Regel aus Selektor, Eigenschaft und Wert aufbauen
- Elemente über Typ, `class` und `id` ansprechen
- Das Boxmodell aus Innenabstand, Rahmen und Außenabstand erklären
- Farben, Schrift und Abstände setzen
- Mit Flexbox nebeneinander anordnen

> [!note] CSS Grid kommt nicht vor
> Flexbox reicht für diese Oberfläche vollständig aus. Zwei Layoutsysteme parallel zu lernen überfordert bei 30 UE. Grid wird genannt und auf den Anschlusskurs verwiesen.

## Sprachumfang

| Eigenschaft | Wofür |
|---|---|
| `color`, `background-color` | Farben |
| `font-family`, `font-size`, `font-weight` | Schrift |
| `padding`, `margin` | Innen- und Außenabstand |
| `border`, `border-radius` | Rahmen und runde Ecken |
| `width`, `max-width` | Breite |
| `display: flex`, `gap`, `justify-content`, `align-items` | Anordnung |
| `cursor: pointer` | Mauszeiger über Knöpfen |

Selektoren: `element`, `.klasse`, `#id`, `element:hover`.

## Ablauf

### 1. Die erste Regel (30 min)

```css
body {
  background-color: #f4f4f4;
}
```

Speichern, hinsehen. Danach reihum: jede Person ändert eine Farbe.

### 2. Drei Wege, ein Element zu treffen (45 min)

Am eigenen Projekt: alle `<button>` gemeinsam, dann eine Gruppe über `class`, dann ein einzelnes über `#id`. Die Frage „Warum drei Wege?" ausdrücklich stellen und beantworten.

### 3. Boxmodell (45 min)

Ein `<div>` bekommt nacheinander Rahmen, Innenabstand, Außenabstand. Nach jedem Schritt hinsehen. Das ist der Abschnitt, der bei Anfängern am meisten Zeit braucht und ihn auch bekommen soll.

Merksatz für die Tafel: `padding` schiebt den Inhalt vom Rahmen weg, `margin` schiebt den Rahmen von den Nachbarn weg.

### 4. Flexbox (60 min)

Nur der eine Fall, den die Anwendung braucht: Knöpfe nebeneinander.

```css
#anzeige {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
```

Dann `flex-direction: row` ausprobieren, Unterschied ansehen, wieder zurück.

### 5. Die Anwendung gestalten (45 min)

Die Karte bekommt Rahmen, runde Ecken, Innenabstand und eine eigene Hintergrundfarbe. Die Knöpfe bekommen `cursor: pointer` und einen `:hover`-Zustand.

### 6. Absichtlicher Fehler (15 min)

Ein Semikolon fehlt. Alle folgenden Regeln greifen nicht mehr. Gemeinsam suchen.

## Praxisteil

- [ ] `style.css` einbinden und die erste Regel schreiben
- [ ] Alle Knöpfe über den Typselektor gestalten
- [ ] Die Karte über `#id` gestalten
- [ ] Boxmodell an einem eigenen Element durchspielen
- [ ] Anzeige mit Flexbox anordnen
- [ ] Eigene Farbwahl treffen. Bewusst frei, jede Person gestaltet anders.
- [ ] Zusatzaufgabe: `:hover` auch für Listeneinträge

## Typische Stolpersteine

> [!warning]
> - Fehlendes Semikolon oder fehlende geschweifte Klammer. Alles darunter wirkt dann nicht. Häufigste Fehlerquelle des Bausteins.
> - `#` und `.` werden verwechselt.
> - Der Selektorname stimmt nicht mit der `id` in der HTML-Datei überein. Die Liste aus K1 zum Abgleich benutzen.
> - Farben als Namen und als Hex-Werte gemischt. Im Kurs auf Hex festlegen, das ist einheitlicher.

## Verknüpfung

Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

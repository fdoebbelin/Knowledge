---
typ: anhang
title: Sprachumfang für den Kompaktkurs
tags: [tauri/kompaktkurs/anhang, javascript]
status: draft
---

# Anhang – Sprachumfang für den Kompaktkurs

> [!important] Verbindlich für die Kursleitung
> Was hier nicht steht, kommt im Kurs nicht vor. Auch dann nicht, wenn es eleganter wäre. Jede zusätzliche Sprachform kostet bei Anfängern mehr, als sie einspart.

## Erlaubt

### HTML

`<h1>` `<h2>` `<p>` `<div>` `<span>` `<button>` `<input>` `<textarea>` `<ul>` `<li>`

Attribute: `id`, `class`, `placeholder`, `type`

### CSS

Selektoren: `element`, `.klasse`, `#id`, `element:hover`

Eigenschaften: `color`, `background-color`, `font-family`, `font-size`, `font-weight`, `padding`, `margin`, `border`, `border-radius`, `box-shadow`, `width`, `max-width`, `display: flex`, `flex-direction`, `gap`, `justify-content`, `align-items`, `cursor`

Farben ausschließlich als Hex-Wert.

### JavaScript

| Bereich | Erlaubt |
|---|---|
| Variablen | `const`, `let` |
| Werte | Zahl, Text, `true`/`false`, Liste, Objekt |
| Funktionen | `function name(param) { return ... }` |
| Entscheidungen | `if`, `else`, `>`, `<`, `===`, `!==` |
| Listen | `[]`, `.push()`, `.length`, `liste[0]` |
| Schleifen | `for (const x of liste)` |
| Objekte | `{ feld: wert }`, `objekt.feld` |
| Text | `+` zum Verbinden, `.trim()` |
| Ausgabe | `console.log()`, `confirm()` |
| Dokument | `document.querySelector`, `.textContent`, `.value`, `.innerHTML = ""`, `document.createElement`, `.appendChild`, `.addEventListener("click", ...)` |
| Tauri | `window.__TAURI__.core.invoke`, `async`, `await` |

## Bedingt erlaubt

Nur in [[K6 Feinschliff]] und nur, wenn die jeweilige Verbesserung gewählt wurde. Wird die Form einmal erklärt, ist sie eine vollständige Zeile – kein Selbstbauen, keine Erweiterung.

| Form | Wann | Wie |
|---|---|---|
| `liste.indexOf(element)` | Löschknopf pro Listeneintrag | Rezept: die Stelle des Elements in der Liste finden |
| `liste.splice(pos, 1)` | Löschknopf pro Listeneintrag | Rezept: ein Element an der Stelle `pos` entfernen |
| `element.className` / `element.classList` | Karte je nach Zustand einfärben | Rezept: die Klasse eines Elements setzen |

## Nicht erlaubt

| Nicht verwenden | Grund |
|---|---|
| `var` | drei Formen für dasselbe verwirren |
| Pfeilfunktionen `=>` | zweite Schreibweise für Funktionen, unnötig |
| `==` | Erklärung des Unterschieds kostet mehr, als sie bringt |
| `.map()`, `.filter()`, `.forEach()` | setzt Funktionen als Werte voraus |
| klassisches `for (let i = 0; ...)` | drei Konzepte in einer Zeile |
| `class`, `this` | Objektorientierung ist ein eigener Kurs |
| `switch` | `if` reicht |
| Template-Literale mit Backticks | zusätzliche Schreibweise für dasselbe |
| `import` / `export` | braucht einen Bundler, den es hier nicht gibt |
| `.then()` | `await` reicht als einziges Rezept |
| CSS Grid | ein Layoutsystem genügt |
| `position: absolute` | erzeugt mehr Probleme, als es löst |

## Begründung des Zuschnitts

Der Umfang ist so gewählt, dass die Lernkarten-Anwendung vollständig damit gebaut werden kann. Nichts Erlaubtes ist überflüssig, nichts Fehlendes wird gebraucht. Wer in der Vorbereitung eine Stelle findet, an der etwas Verbotenes nötig scheint, sollte die Aufgabe ändern statt die Liste.

## Verknüpfung

[[00 Kompaktkurs Tauri Grundlagen]] · [[K3 JavaScript – die Bausteine]]

---
title: CSS – das Aussehen – Übungen
modul: K2
typ: uebungsblatt
aliases:
  - K2c Übungsblatt
tags: [tauri/kompaktkurs/uebung, css]
status: active
---

# K2 – Übungsblatt

> [!info] Hinweis zu den Antworten
> Die Antwort steht jeweils direkt unter der Frage in einem zugeklappten Kasten. In Obsidian mit einem Klick auf die Überschrift aufklappen.

## Inhaltsübersicht

- F1 Eine Regel zerlegen
- F2 Hex-Farben lesen
- F3 Welcher Selektor
- F4 Welche Regel gewinnt
- F5 `padding` oder `margin`
- F6 Was bewegt sich
- F7 Warum `gap` und nicht `margin`
- F8 Ausrichten
- F9 Semikolon und Klammer
- F10 Fehlerbild zuordnen

---

## F1 Zerlegen Sie die Regel in ihre Bestandteile.

```css
#karte-frage {
  font-size: 20px;
}
```

1. Selektor: `________________________________`
2. Welcher der drei Selektortypen ist das? `________________________________`
3. Eigenschaft: `________________________________`
4. Wert: `________________________________`
5. Wie viele Elemente trifft diese Regel? `________________________________`

> [!success]- Antwort F1
> 1. Selektor: `#karte-frage`
> 2. `id`-Selektor, erkennbar an der Raute
> 3. Eigenschaft: `font-size`
> 4. Wert: `20px`
> 5. Genau eines – eine `id` darf nur einmal vergeben werden.
>
> **Nachfrage:** „Wie hieße der Selektor, wenn wir alle Absätze treffen wollten?" → `p`, ohne Zeichen davor.

---

## F2 Was bedeuten die Farbanteile in `#f4f4f4`? Welche Farbe ist das?

> [!success]- Antwort F2
> ```
> #f4f4f4
>  └┬┘└┬┘└┬┘
>   │  │  └─ Blau
>   │  └──── Grün
>   └─────── Rot
> ```
> Zwei Stellen Rot, zwei Stellen Grün, zwei Stellen Blau, jeweils von `00` (nichts davon) bis `ff` (voll). `#f4f4f4` ist ein sehr helles Grau, `#ffffff` Weiß, `#000000` Schwarz.
>
> **Kursregel:** ausschließlich Hex-Werte, keine Farbnamen wie `red`.

---

## F3 Welchen Selektor würden Sie schreiben?

| Vorhaben | Selektor |
|---|---|
| Alle Absätze bekommen dieselbe Schriftgröße | |
| Nur die Frage der aktuellen Karte wird fett | |
| Die beiden Blätterknöpfe werden grün | |
| Alle Eingabefelder bekommen einen Rahmen | |
| Der Kartenbereich bekommt runde Ecken | |
| Knöpfe werden heller, solange die Maus darauf steht | |

> [!success]- Antwort F3
> | Vorhaben | Selektor |
> |---|---|
> | Alle Absätze | `p` |
> | Nur die Frage | `#karte-frage` |
> | Die beiden Blätterknöpfe | `.knopf-anzeige` |
> | Alle Eingabefelder | `input` (bzw. `input, textarea` für beide Sorten) |
> | Der Kartenbereich | `#anzeige` |
> | Knöpfe bei Mausberührung | `button:hover` |
>
> **Zur letzten Zeile:** Zwei Selektoren durch Komma getrennt bedeuten „und". `input, textarea { … }` gilt für beide Sorten. Das ist die einzige Kombinationsform, die im Kurs vorkommt.

---

## F4 Zwei Regeln treffen dasselbe Element und sagen beide etwas über die Hintergrundfarbe. Welche gewinnt – und warum?

> [!success]- Antwort F4
> Die **genauere** gewinnt.
>
> ```
> Je genauer der Selektor, desto stärker.
> #id   schlägt   .klasse   schlägt   element
> ```
>
> `button` meint alle Knöpfe, `.knopf-anzeige` meint zwei bestimmte – also ist die Klasse genauer und setzt sich durch. Bei gleich genauen Selektoren gewinnt die Regel, die **weiter unten** in der Datei steht.
>
> **Nur die widersprüchliche Angabe** wird überschrieben, nicht die ganze Regel: Runde Ecken, weiße Schrift und Handzeiger der allgemeinen Knopf-Regel gelten weiter.

---

## F5 Kreuzen Sie an: `padding` oder `margin`?

| Vorhaben | `padding` | `margin` |
|---|---|---|
| Der Text soll nicht am Rahmen kleben | ☐ | ☐ |
| Zwischen Karte und Überschrift soll Luft sein | ☐ | ☐ |
| Die Beschriftung im Knopf soll seitlich mehr Platz haben | ☐ | ☐ |
| Die beiden Bereiche sollen weiter auseinander liegen | ☐ | ☐ |
| Der Kasten soll insgesamt größer wirken, ohne mehr Text | ☐ | ☐ |

> [!success]- Antwort F5
> | Vorhaben | Antwort |
> |---|---|
> | Text klebt am Rahmen | `padding` |
> | Luft zwischen Karte und Überschrift | `margin` |
> | Beschriftung im Knopf | `padding` |
> | Bereiche weiter auseinander | `margin` |
> | Kasten größer ohne mehr Text | `padding` |
>
> **Prüffrage bei falscher Antwort:** „Soll sich der Rahmen bewegen oder der Inhalt?" Bewegt sich der Inhalt → `padding`. Bewegt sich der Rahmen → `margin`.

---

## F6 Welche der beiden Aussagen beschreibt den Unterschied zwischen `padding` und `margin` richtig?

> A. `padding` schiebt den Inhalt vom Rahmen weg, `margin` schiebt den Rahmen von den Nachbarn weg.
> B. `margin` schiebt den Inhalt vom Rahmen weg, `padding` schiebt den Rahmen von den Nachbarn weg.

> [!success]- Antwort F6
> **A ist richtig.**
>
> **Merksatz:** `padding` schiebt den Inhalt vom Rahmen weg. `margin` schiebt den Rahmen von den Nachbarn weg.
>
> Bildvergleich: Ein gerahmtes Bild an der Wand. Das Passepartout zwischen Bild und Rahmen ist `padding`, der Rahmen ist `border`, der Abstand zum Nachbarbild ist `margin`.

---

## F7 Warum gibt es `gap`, wenn es doch auch `margin` gibt?

> [!success]- Antwort F7
> Mit `margin` müsste jedem Element einzeln ein Außenabstand gegeben werden – und beim letzten wieder weggenommen, weil sonst ein Absatz zu viel nach unten steht. `gap` erledigt das in einer Zeile und gilt nur **zwischen** den Kindern.
>
> Genau dafür gibt es Flexbox.

---

## F8 Wofür sind `justify-content` und `align-items` zuständig? Welche Richtung wirken sie?

> [!success]- Antwort F8
> | Eigenschaft | Wirkt | Werte |
> |---|---|---|
> | `justify-content` | **in** Laufrichtung (bei `row`: links ↔ rechts) | `flex-start`, `center`, `flex-end`, `space-between` |
> | `align-items` | **quer** zur Laufrichtung (bei `row`: oben ↔ unten) | `flex-start`, `center`, `flex-end` |
>
> Die beiden werden ständig verwechselt, auch von Fortgeschrittenen. Die ehrliche Empfehlung: hinschreiben, hinsehen, notfalls das andere nehmen.

---

## F9 Was passiert, wenn in einer Regel mit mehreren Zeilen ein Semikolon fehlt – und was, wenn die schließende geschweifte Klammer fehlt?

> [!success]- Antwort F9
> **Fehlendes Semikolon:** **Zwei** Erklärungen wirken nicht – die mit dem fehlenden Semikolon und die direkt darunter.
> ```css
> #anzeige {
>   background-color: #ffffff     ← Semikolon fehlt
>   border: 2px solid #cccccc;    ← wirkt deshalb ebenfalls nicht
>   padding: 20px;                ← wirkt wieder
> }
> ```
> Ohne Semikolon weiß das Programm nicht, wo die eine Erklärung aufhört, und liest die nächste Zeile als Teil derselben. Das Ergebnis ergibt keinen Sinn, also wird beides verworfen. Danach geht es normal weiter.
>
> **Fehlende Klammer:** **Alles** darunter verschwindet. Die Regel hört nie auf, also wird der gesamte Rest der Datei als ihr Inhalt gelesen.
>
> **Die daraus folgende Diagnoseregel:** Wenn die letzten fünf Änderungen alle nicht wirken, suchen Sie nicht bei den fünf Änderungen. Suchen Sie **darüber**.

---

## F10 Welche Ursache passt zu welchem Fehlerbild?

| Fehlerbild | Ursache |
|---|---|
| Nichts passiert, keine Fehlermeldung | |
| Falsches Element ändert sich | |
| Zwei Regeln, die stärkere gewinnt nicht wie erwartet | |
| Kasten wird beim Verkleinern abgeschnitten | |
| Zu viel steht nebeneinander | |
| Abstand innen gewünscht, außen entstanden | |

> [!success]- Antwort F10
> | Fehlerbild | Ursache |
> |---|---|
> | Nichts passiert, keine Fehlermeldung | Selektorname stimmt nicht mit der `id` überein |
> | Falsches Element ändert sich | `#` und `.` vertauscht |
> | Die stärkere Regel gewinnt nicht wie erwartet | Spezifität: `#id` > `.klasse` > `element` |
> | Kasten wird abgeschnitten | `width` statt `max-width` |
> | Zu viel steht nebeneinander | `display: flex` sitzt auf dem falschen Bereich |
> | Abstand außen statt innen | `margin` statt `padding` |
>
> **Und die zwei Diagnosefragen dazu:**
> Wirkt **eine** Regel nicht → Namen im CSS und im HTML laut nebeneinander vorlesen, `#` und `.` prüfen.
> Wirken **alle** Regeln ab einer Stelle nicht → **darüber** suchen: Semikolon oder Klammer.

---

## Verknüpfung

Leitfaden: [[K2 CSS – das Aussehen]] · Merkblatt: [[K2 Merkblatt]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

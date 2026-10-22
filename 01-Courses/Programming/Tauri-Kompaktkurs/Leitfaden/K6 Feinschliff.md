---
title: Feinschliff
modul: K6
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden, css, ux]
status: active
---

# K6 – Feinschliff

## Inhaltsübersicht

- Was hier passiert
- Eigene Gestaltung
- Eine eigene Verbesserung
- Vorstellen
- Typische Stolperstellen
- Stand am Ende des Moduls

Jetzt wird die Anwendung zur eigenen. Kein neuer Stoff, sondern Anwenden und Festigen des Gelernten.

> [!note] Die Reserve dieses Moduls
> Hier wird bewusst nichts eingeführt, was für [[K7 Als Anwendung ausliefern]] nötig wäre. Wenn anderswo im Kurs Zeit fehlt, wird dieses Modul gekürzt – und nur dieses. Die eigene Gestaltung ist der einzige Inhalt, der später nicht noch einmal vorkommt.

## Was hier passiert

Die Anwendung kann inzwischen: Karten anlegen, anzeigen, durchblättern, speichern, laden. Sie sieht aus wie eine Anwendung, die jemand anderes gebaut hat.

Dieses Modul dreht sich darum, sie zu **einer eigenen** zu machen. Zwei Aufgaben:

1. **Gestalten** – dem Ganzen einen eigenen Look geben
2. **Verbessern** – eine Sache auswählen, die einem auffällt, und sie umsetzen

> [!tip] Die eine Regel für dieses Modul
> **Eine Verbesserung, nicht fünf.** Wer fünf Sachen auf einmal angeht, hat am Ende fünf halbe Sachen und eine kaputte Datei. Lieber eine Sache fertig machen.

Vor der ersten Änderung eine Kopie der Dateien anlegen. Nicht aus Misstrauen, sondern weil der Stand von [[K5 Daten behalten]] sonst nicht wiederherstellbar ist.

## Eigene Gestaltung

Freie Arbeit an `style.css`. Die Vorgabe ist bewusst knapp:

- Die Anwendung muss **bedienbar** bleiben
- Die drei Farben müssen **zueinander passen**
- Der Text muss aus zwei Metern Entfernung lesbar sein

Anregungen, aus denen gewählt wird – nicht alle, eine oder zwei:

| Anregung | Wofür |
|---|---|
| eigenes Farbschema | `background-color`, `color`, `border-color` |
| andere Schriftgröße für Frage und Antwort | `font-size` |
| Karte optisch hervorheben, etwa mit Rahmen und Schatten | `border`, `border-radius`, `box-shadow` |
| wichtigsten Knopf auffälliger machen | `font-weight`, `padding`, `#id` statt `.klasse` |
| Abstand zwischen Frage und Antwort | `margin`, `gap` |
| die ganze Anwendung auf eine Breite begrenzen | `max-width` |

> [!important] Was hier nicht kommt
> Keine neuen CSS-Eigenschaften, kein Grid, kein `position: absolute`. Alles, was gebraucht wird, steht im [[K2 Merkblatt]] – die Liste ist verbindlich, siehe [[Anhang Sprachumfang JavaScript]].
>
> Wer etwas Neues ausprobiert, bekommt keine Erklärung, sondern den Satz: „Das steht nicht auf unserer Liste. Wenn es klappt, behalten wir es – wenn nicht, zurück zur Liste."

## Eine eigene Verbesserung

Jede Person wählt **genau eine** Verbesserung aus und setzt sie selbst um:

| Verbesserung | Was dafür gebraucht wird |
|---|---|
| Anzahl der Karten anzeigen | `karten.length`, `textContent` |
| Löschknopf pro Listeneintrag | `createElement`, `addEventListener` |
| Leere Eingabe abfangen | `if`, `.value`, `.trim()` |
| Antwort erst nach Klick zeigen | `if`, `textContent` |
| Zählen, wie viele Karten schon gezeigt wurden | Zähler-Variable, `if` |

Die vollständige Zuordnung „Wunsch → Werkzeug" steht im [[K6 Merkblatt]].

Der Ablang bei jeder Verbesserung:

1. **Formulieren** – Was genau soll passieren? Ein Satz, der ein „wenn … dann" enthält.
2. **Nachschlagen** – Welche Bausteine aus den bisherigen Modulen werden gebraucht?
3. **Umsetzen** – klein anfangen, nach jeder Änderung hinsehen
4. **Prüfen** – Stimmt das Ergebnis? Bleibt der Rest heil?

> [!warning] Die häufigste Art, sich hier zu verlieren
> Aus „ich will einen Löschknopf" wird schnell „ich will auch noch eine Rückfrage, wenn man alle löscht, und eine Animation, und eine Warnung, wenn die Liste leer ist". Das sind drei Verbesserungen.
>
> Gegenmittel: Der Satz „Wenn das fertig ist, habe ich **eine** Verbesserung." Und wenn die eine fertig ist, darf die zweite kommen – aber als eigenes Modul, nicht mittendrin.

### Der Löschknopf als Beispiel

An diesem Beispiel lässt sich zeigen, was „eine Verbesserung" bedeutet – und wie viel dahintersteckt:

```js
function listeAnzeigen() {
  const liste = document.querySelector("#karten-liste");
  liste.innerHTML = "";

  for (const karte of karten) {
    const eintrag = document.createElement("li");
    eintrag.textContent = karte.frage;

    const loeschKnopf = document.createElement("button");
    loeschKnopf.textContent = "Löschen";
    loeschKnopf.addEventListener("click", function () {
      const pos = karten.indexOf(karte);
      if (pos >= 0) {
        karten.splice(pos, 1);
        listeAnzeigen();
        await speichern();
      }
    });

    eintrag.appendChild(loeschKnopf);
    liste.appendChild(eintrag);
  }
}
```

Drei neue Bausteine stecken darin – alle aus den bisherigen Modulen:

| Baustein | Woher |
|---|---|
| `document.createElement("button")` | [[K4 JavaScript im Fenster]] |
| `karten.indexOf(karte)` und `karten.splice(pos, 1)` | Liste, [[K3 JavaScript – die Bausteine]] |
| `await speichern();` | [[K5 Daten behalten]] |

> [!note] `splice` ist bedingt erlaubt
> `indexOf` und `splice` stehen nicht in der allgemeinen Liste des [[Anhang Sprachumfang JavaScript]], sondern nur unter „Bedingt erlaubt“. Wer diese eine Verbesserung wählt, bekommt beide Formen hier als Rezept erklärt – genau einmal, als vollständige Zeile. Das ist die Ausnahme, und sie wird angekündigt.

## Vorstellen

Jede Person zeigt der Gruppe ihre Anwendung und erklärt **eine** getroffene Entscheidung.

Die Frage, die gestellt wird, ist immer dieselbe:

> „Warum genau diese Entscheidung? Was wäre schlechter geworden, wenn Sie es anders gemacht hätten?"

Eine Begründung ist wertvoller als fünf nachgemachte Regeln. Deshalb wird hier nicht die beste Lösung gesucht, sondern die eigene.

> [!tip] Der Kontrast-Check
> Beim Vorstellen gleich mitprüfen: Ist der Text aus zwei Metern Entfernung lesbar? Das ist die Miniatur-Lektion in Barrierefreiheit, die in [[K2 CSS – das Aussehen]] begonnen hat.
>
> Nicht verbieten, sondern hinsehen lassen: „Können Sie das aus zwei Metern Entfernung lesen?"

## Typische Stolperstellen

> [!warning]
> - Zu viel auf einmal vorgenommen. Auf **eine** Verbesserung bestehen.
> - Bestehender Code wird beim Umbauen beschädigt. Deshalb vorher die Kopie anlegen.
> - Kontrast zwischen Text und Hintergrund wird zu gering.
> - Eine Verbesserung wirkt, aber die Anwendung merkt es nicht: Nach dem Ändern der Daten muss `listeAnzeigen()` aufgerufen werden, nach dem Ändern muss `speichern()` aufgerufen werden.
> - Der Löschknopf verschwindet beim ersten Klick – weil die Liste nach dem Löschen neu aufgebaut wird und der Knopf dabei verschwindet. Das ist richtig so: Beim Neuaufbau wird jeder Knopf neu erzeugt.

## Stand am Ende des Moduls

- [ ] Ein eigenes Farbschema umgesetzt, die drei Farben passen zueinander
- [ ] Der Kontrast aus zwei Metern geprüft
- [ ] **Genau eine** Verbesserung ausgewählt, umgesetzt und begründet
- [ ] Die Anwendung der Gruppe vorgestellt
- [ ] Der bestehende Code ist heil geblieben
- [ ] Der Stand ist gesichert, bevor [[K7 Als Anwendung ausliefern]] beginnt

## Verknüpfung

Merkblatt: [[K6 Merkblatt]] · Übungen: [[K6 Übungsblatt]] · [[Anhang Sprachumfang JavaScript]]
Weiter mit [[K7 Als Anwendung ausliefern]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

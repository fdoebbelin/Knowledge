---
baustein: K2
typ: uebungsblatt
titel: CSS – das Aussehen – Übungen
ue: 5
tag: 1-2
tags: [tauri/kompaktkurs/uebung, css]
status: entwurf
---

# K2 – Übungsblatt

> [!info] Hinweis zu den Lösungen
> Die Lösungen stehen jeweils direkt unter der Aufgabe in einem zugeklappten Kasten. Auf dem gedruckten Teilnehmerblatt werden die Lösungskästen entfernt – die Kursleitungsfassung behält sie.

> [!tip] Die zwei Diagnosefragen
> Wirkt **eine** Regel nicht → Namen laut vorlesen, `#` und `.` prüfen.
> Wirken **alle** Regeln ab einer Stelle nicht → darüber suchen: Semikolon oder Klammer.

---

# Block A – Tag 1

## Ü2.1 Eine Regel zerlegen

Gegeben:

```css
#karte-frage {
  font-size: 20px;
}
```

1. Selektor: `________________________`
2. Welcher der drei Selektortypen ist das? `________________________`
3. Eigenschaft: `________________________`
4. Wert: `________________________`
5. Wie viele Elemente trifft diese Regel? `________________________`

> [!success]- Lösung Ü2.1
> 1. Selektor: `#karte-frage`
> 2. `id`-Selektor, erkennbar an der Raute
> 3. Eigenschaft: `font-size`
> 4. Wert: `20px`
> 5. Genau eines – eine `id` darf nur einmal vergeben werden.
>
> **Nachfrage:** „Wie hieße der Selektor, wenn wir alle Absätze treffen wollten?" → `p`, ohne Zeichen davor.

---

## Ü2.2 Die erste eigene Regel

1. Öffnen Sie `src/style.css`. Sie ist leer.
2. Schreiben Sie eine Regel, die den Seitenhintergrund einfärbt.
3. Speichern, hinsehen.
4. Ändern Sie die Farbe dreimal und notieren Sie Ihren Favoriten im Heft.

> [!success]- Lösung Ü2.2
> ```css
> body {
>   background-color: #f4f4f4;
> }
> ```
> `body` ist der gesamte sichtbare Bereich des Fensters. Ein Typselektor – ohne Raute, ohne Punkt.
>
> **Häufiger Fehler:** `#body` oder `.body`. Beides trifft nichts, weil `body` weder eine `id` noch eine Klasse ist, sondern ein Elementtyp.

---

## Ü2.3 Alle Knöpfe auf einmal

Gestalten Sie **alle** Knöpfe mit einer einzigen Regel: eigene Hintergrundfarbe, weiße Schrift, kein Rahmen, runde Ecken, Handzeiger.

Prüfen Sie danach: Wie viele Knöpfe haben sich verändert?

> [!success]- Lösung Ü2.3
> ```css
> button {
>   background-color: #2a4d69;
>   color: #ffffff;
>   border: none;
>   border-radius: 6px;
>   cursor: pointer;
> }
> ```
> **Drei Knöpfe** verändern sich: „Karte anlegen", „Umdrehen", „Nächste".
>
> `cursor: pointer` macht aus dem Textzeiger eine Hand. Ohne das wirkt ein Knopf wie ein Bild – die billigste Verbesserung, die es gibt.
>
> **Nachfrage:** „Was passiert mit einem Knopf, den Sie morgen neu einbauen?" → Er sieht sofort genauso aus. Genau dafür ist der Typselektor da.

---

## Ü2.4 Eine Gruppe herausheben

Die beiden Knöpfe „Umdrehen" und „Nächste" tragen seit K1 die Klasse `knopf-anzeige`. Geben Sie **nur diesen beiden** eine andere Hintergrundfarbe – ohne die Regel aus Ü2.3 anzufassen und ohne die Knöpfe einzeln anzusprechen.

Beobachten Sie: Welche der beiden Regeln gewinnt? Warum?

> [!success]- Lösung Ü2.4
> ```css
> .knopf-anzeige {
>   background-color: #6b8f71;
> }
> ```
> **Die Klassenregel gewinnt.** Beide Regeln treffen zu, beide sagen etwas über die Hintergrundfarbe – dann setzt sich die genauere durch.
>
> Merksatz: `#id` schlägt `.klasse` schlägt `element`.
>
> Alle übrigen Eigenschaften aus Ü2.3 – runde Ecken, weiße Schrift, Handzeiger – gelten weiter. Es wird nur die eine widersprüchliche Angabe überschrieben, nicht die ganze Regel.
>
> **Häufiger Fehler:** `knopf-anzeige` ohne Punkt. Trifft nichts, weil das Programm nach einem Elementtyp dieses Namens sucht.

---

## Ü2.5 Ein einzelnes Element treffen

Schlagen Sie Ihre `id`-Liste aus dem Heft auf. Suchen Sie sich **drei** Einträge aus und geben Sie jedem eine Eigenschaft.

Vorschläge: die Frage größer und fett, die Antwort in gedämpftem Grau, der Anzeigebereich mit weißem Hintergrund.

> [!success]- Lösung Ü2.5
> ```css
> #karte-frage {
>   font-size: 20px;
>   font-weight: 700;
> }
>
> #karte-antwort {
>   color: #555555;
> }
>
> #anzeige {
>   background-color: #ffffff;
> }
> ```
> **Der Kern der Aufgabe ist nicht das CSS, sondern die Heftliste.** Wer sie in K1 sauber geführt hat, tippt hier flüssig ab. Wer sie nicht hat, sucht die Namen einzeln in der `index.html` zusammen – das ist die Erfahrung, die den Aufwand von gestern rechtfertigt.
>
> **`font-weight`:** `400` ist normal, `700` ist fett. Andere Werte kommen im Kurs nicht vor.

---

## Ü2.6 Zuordnung: welcher Selektor?

Welchen Selektor würden Sie schreiben?

| Vorhaben | Selektor |
|---|---|
| Alle Absätze bekommen dieselbe Schriftgröße | |
| Nur die Frage der aktuellen Karte wird fett | |
| Die beiden Blätterknöpfe werden grün | |
| Alle Eingabefelder bekommen einen Rahmen | |
| Der Kartenbereich bekommt runde Ecken | |
| Knöpfe werden heller, solange die Maus darauf steht | |

> [!success]- Lösung Ü2.6
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

# Block B – Tag 2

## Ü2.7 Boxmodell Schritt für Schritt

Bauen Sie am Anzeigebereich **eine Eigenschaft nach der anderen** ein. Nach jedem Schritt speichern und hinsehen. Notieren Sie in einem Stichwort, was sich verändert hat.

| Schritt | Eigenschaft | Was hat sich verändert? |
|---|---|---|
| 1 | Rahmen, 2px, durchgezogen, hellgrau | |
| 2 | Innenabstand 20px | |
| 3 | Außenabstand 24px | |
| 4 | Runde Ecken 12px | |
| 5 | Höchstbreite 400px | |

> [!success]- Lösung Ü2.7
> ```css
> #anzeige {
>   background-color: #ffffff;
>   border: 2px solid #cccccc;
>   padding: 20px;
>   margin: 24px;
>   border-radius: 12px;
>   max-width: 400px;
> }
> ```
>
> | Schritt | Beobachtung |
> |---|---|
> | 1 | Die Kiste wird als Kiste sichtbar |
> | 2 | Der Inhalt rückt vom Rahmen weg, die Kiste wird größer |
> | 3 | Die ganze Kiste rückt von Überschrift und Rand weg, innen bleibt alles gleich |
> | 4 | Die Ecken werden rund |
> | 5 | Die Kiste hört bei 400px auf, statt bis zum Fensterrand zu laufen |
>
> **Die Prüffrage der Kursleitung:** „Bei welchem Schritt hat sich der Inhalt bewegt, bei welchem die Kiste?" → Schritt 2 bewegt den Inhalt, Schritt 3 die Kiste. Genau das ist der Merksatz.

---

## Ü2.8 `padding` oder `margin`?

Kreuzen Sie an.

| Vorhaben | `padding` | `margin` |
|---|---|---|
| Der Text soll nicht am Rahmen kleben | ☐ | ☐ |
| Zwischen Karte und Überschrift soll Luft sein | ☐ | ☐ |
| Die Beschriftung im Knopf soll seitlich mehr Platz haben | ☐ | ☐ |
| Die beiden Bereiche sollen weiter auseinander liegen | ☐ | ☐ |
| Der Kasten soll insgesamt größer wirken, ohne mehr Text | ☐ | ☐ |

> [!success]- Lösung Ü2.8
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

## Ü2.9 Untereinander anordnen

Ordnen Sie den Eingabebereich mit Flexbox an: Felder und Knopf untereinander, gleichmäßiger Abstand, höchstens 400px breit.

Probieren Sie danach `flex-direction: row` aus, sehen Sie hin, und nehmen Sie es wieder zurück.

> [!success]- Lösung Ü2.9
> ```css
> #eingabe {
>   display: flex;
>   flex-direction: column;
>   gap: 12px;
>   max-width: 400px;
> }
> ```
> Bei `row` stehen Überschrift, beide Felder und der Knopf in einer Reihe und werden schmal gequetscht. Das ist unbrauchbar – und genau die Anschauung, die `column` verständlich macht.
>
> **Warum kein `margin`?** Man könnte jedem Element einen Außenabstand geben, müsste ihn aber beim letzten wieder wegnehmen. `gap` erledigt das in einer Zeile und gilt nur zwischen den Elementen.

---

## Ü2.10 Zwei Knöpfe nebeneinander

Die beiden Knöpfe „Umdrehen" und „Nächste" sollen nebeneinander stehen, die Absätze darüber weiterhin untereinander.

1. Überlegen Sie zuerst: Warum reicht es **nicht**, `flex-direction: row` auf `#anzeige` zu setzen?
2. Ändern Sie die `index.html` so, dass es funktioniert.
3. Schreiben Sie die passende Regel.
4. Tragen Sie den neuen Namen in Ihre Heftliste ein.

> [!success]- Lösung Ü2.10
> **Zu 1:** Flexbox wirkt auf **alle** Kinder des Bereichs. Bei `row` auf `#anzeige` stünden Frage, Antwort und beide Knöpfe gemeinsam in einer Reihe. Gebraucht wird eine Kiste um genau die zwei Knöpfe.
>
> **Zu 2 – `index.html`:**
> ```html
> <div id="anzeige">
>   <p id="karte-frage">Noch keine Karte</p>
>   <p id="karte-antwort"></p>
>   <div id="knopf-leiste">
>     <button id="knopf-umdrehen" class="knopf-anzeige">Umdrehen</button>
>     <button id="knopf-weiter" class="knopf-anzeige">Nächste</button>
>   </div>
> </div>
> ```
>
> **Zu 3 – `style.css`:**
> ```css
> #anzeige {
>   display: flex;
>   flex-direction: column;
>   gap: 12px;
> }
>
> #knopf-leiste {
>   display: flex;
>   gap: 12px;
> }
> ```
> Bei `#knopf-leiste` steht keine Richtung, weil `row` die Voreinstellung ist.
>
> **Zu 4:** `knopf-leiste` ist der elfte Eintrag der Heftliste.
>
> **Das ist die Pointe des Bausteins:** In [[K1 HTML – die Struktur]] war das `<div>` unsichtbar und schien überflüssig. Hier bekommt es seinen Zweck.

---

## Ü2.11 Ausrichten

Probieren Sie an der Knopfleiste alle vier Werte durch und notieren Sie in einem Stichwort, was passiert:

```css
#knopf-leiste {
  display: flex;
  gap: 12px;
  justify-content: ________;
}
```

`flex-start` · `center` · `flex-end` · `space-between`

> [!success]- Lösung Ü2.11
> | Wert | Wirkung bei einer Reihe |
> |---|---|
> | `flex-start` | beide Knöpfe links, Voreinstellung |
> | `center` | beide Knöpfe mittig |
> | `flex-end` | beide Knöpfe rechts |
> | `space-between` | einer ganz links, einer ganz rechts, Abstand dazwischen |
>
> **Der Unterschied zu `align-items`:** `justify-content` arbeitet **in** Laufrichtung, `align-items` **quer** dazu. Bei einer Reihe heißt das: `justify-content` verschiebt links/rechts, `align-items` oben/unten.
>
> Die beiden werden ständig verwechselt, auch von Fortgeschrittenen. Die ehrliche Empfehlung im Kurs: hinschreiben, hinsehen, notfalls das andere nehmen.

---

## Ü2.12 Die Anwendung fertig gestalten

**Pflicht:**

- [ ] Eingabefelder gestalten: Rahmen, Innenabstand, Schriftgröße
- [ ] Ein `:hover` für die Knöpfe
- [ ] Die drei eigenen Farben aus Block A umsetzen

**Frei:** Alles Weitere nach eigenem Geschmack. Bedingung: Es muss lesbar bleiben.

> [!success]- Lösung Ü2.12
> ```css
> input, textarea {
>   font-size: 16px;
>   padding: 8px;
>   border: 1px solid #cccccc;
>   border-radius: 6px;
> }
>
> button:hover {
>   background-color: #3d6b91;
> }
>
> .knopf-anzeige:hover {
>   background-color: #85a88a;
> }
> ```
> Die vollständige Referenzfassung steht in [[K2b Handout]], Abschnitt 8.
>
> **Wichtig für die Kursleitung:** Am Ende sollen sich die drei Anwendungen deutlich unterscheiden. Wer alles gleich haben möchte, hat den Baustein missverstanden – ab hier ist es **die eigene** Anwendung.
>
> **Kontrastprüfung:** Text aus zwei Metern Entfernung lesen lassen. Nicht verbieten, sondern hinsehen lassen.

---

## Ü2.13 Absichtlich kaputt machen

**Teil 1 – Semikolon.** Löschen Sie in einer Regel mit mehreren Zeilen ein Semikolon in der Mitte. Speichern, hinsehen.

Wie viele Erklärungen wirken nicht mehr? `______`

**Teil 2 – Klammer.** Löschen Sie die schließende geschweifte Klammer einer Regel weit oben in der Datei. Speichern, hinsehen.

Was passiert mit allem, was darunter steht? `_________________________`

Reparieren Sie beides.

> [!success]- Lösung Ü2.13
> **Teil 1:** **Zwei** Erklärungen wirken nicht – die mit dem fehlenden Semikolon und die direkt darunter. Ohne Semikolon weiß das Programm nicht, wo die eine aufhört, und liest die nächste Zeile als Teil derselben. Das Ergebnis ergibt keinen Sinn, also wird beides verworfen. Danach geht es normal weiter.
>
> ```css
> #anzeige {
>   background-color: #ffffff     ← Semikolon fehlt
>   border: 2px solid #cccccc;    ← wirkt deshalb ebenfalls nicht
>   padding: 20px;                ← wirkt wieder
> }
> ```
>
> **Teil 2:** **Alles** darunter verschwindet. Die Regel hört nie auf, also wird der gesamte Rest der Datei als ihr Inhalt gelesen.
>
> **Die daraus folgende Diagnoseregel – das eigentliche Lernziel:**
> Wenn Ihre letzten fünf Änderungen alle nicht wirken, suchen Sie nicht bei den fünf Änderungen. Suchen Sie **darüber**.

---

## Zusatzaufgaben für Schnellere

> [!note] Freiwillig
> Kein JavaScript. Wer damit anfangen möchte: Das ist genau der nächste Baustein, und er beginnt in Kürze.

**Z1 – Listeneinträge reagieren lassen.** Die Kartenliste ist heute leer, füllt sich aber ab K4. Bereiten Sie vor, dass ein Listeneintrag sich färbt, solange die Maus darauf steht. Testen Sie es, indem Sie zwei `<li>` vorübergehend einbauen.

**Z2 – Den wichtigsten Knopf hervorheben.** „Karte anlegen" ist die Hauptaktion. Machen Sie ihn auffälliger als die beiden Blätterknöpfe – ohne die Klasse `knopf-anzeige` anzufassen.

**Z3 – Selbstversuch Spezifität.** Schreiben Sie drei Regeln, die dasselbe Element auf drei Wegen treffen und widersprüchliche Farben setzen. Sagen Sie **vorher** voraus, welche gewinnt. Dann prüfen.

> [!success]- Lösungen Z1 bis Z3
> **Z1:**
> ```css
> li:hover {
>   background-color: #eeeeee;
>   cursor: pointer;
> }
> ```
> Zum Testen vorübergehend in die `index.html`:
> ```html
> <ul id="karten-liste">
>   <li>Testeintrag</li>
>   <li>Noch einer</li>
> </ul>
> ```
> **Wichtig: Beide `<li>` danach wieder entfernen.** Die Liste muss leer in K4 gehen, sonst stehen die Testeinträge dauerhaft über den echten Karten.
>
> **Z2 –** über die `id`, die stärker ist als die Klasse:
> ```css
> #knopf-neu {
>   font-weight: 700;
>   padding: 12px 24px;
> }
> ```
>
> **Z3 –** Beispiel:
> ```css
> button        { background-color: #aa0000; }
> .knopf-anzeige { background-color: #00aa00; }
> #knopf-umdrehen { background-color: #0000aa; }
> ```
> Der Knopf „Umdrehen" wird **blau**: `#id` schlägt `.klasse` schlägt `element`. Der Knopf „Nächste" wird grün, „Karte anlegen" rot.
>
> Danach wieder aufräumen.

---

## Abschlusskontrolle

- [ ] Ü2.1 Regel zerlegt
- [ ] Ü2.2 Erste eigene Regel geschrieben
- [ ] Ü2.3 Alle Knöpfe über den Typselektor gestaltet
- [ ] Ü2.4 Gruppe über die Klasse herausgehoben
- [ ] Ü2.5 Drei Elemente über `id` gestaltet
- [ ] Ü2.6 Zuordnung ausgefüllt
- [ ] Ü2.7 Boxmodell Schritt für Schritt durchgespielt
- [ ] Ü2.8 `padding`/`margin` zugeordnet
- [ ] Ü2.9 Eingabebereich mit Flexbox angeordnet
- [ ] Ü2.10 Knopfleiste gebaut, `knopf-leiste` im Heft
- [ ] Ü2.11 Ausrichtungswerte durchprobiert
- [ ] Ü2.12 Anwendung fertig gestaltet, eigene Farbwahl
- [ ] Ü2.13 Beide Fehlerarten eingebaut und repariert

## Verknüpfung

Handout: [[K2b Handout]] · Trainerskript: [[K2a Trainerskript]]
Weiter mit [[K3 JavaScript – die Bausteine]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

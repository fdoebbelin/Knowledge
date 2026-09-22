---
baustein: K0
typ: trainerskript
title: Ankommen und erste eigene Änderung – Trainerskript
ue: 2
kurstag: 1
dauer: 90 min
zielgruppe: 3 Teilnehmende ohne Vorkenntnisse
tags: [tauri/kompaktkurs/trainerskript]
status: draft
---

# K0 – Trainerskript

> [!abstract] Zweck dieses Dokuments
> Zum Mitlesen während des Unterrichts. Alles in Zitatform ist **Sprechtext** und kann wörtlich verwendet werden. Alles andere sind Handlungsanweisungen an die Kursleitung.

> [!danger] Der Zeitplan hat keinen Puffer
> 15 + 15 + 20 + 25 + 15 = 90 Minuten. Wenn Abschnitt 3 (Starten) länger dauert, wird Abschnitt 1 beim nächsten Durchlauf gekürzt, **nicht** Abschnitt 4. Abschnitt 4 ist das Erfolgserlebnis, mit dem die Teilnehmenden aus der Einheit gehen sollen.

## Zeitraster

| Zeit | Abschnitt | Format |
|---|---|---|
| 00–15 | 1. Was wir bauen | Vorführung, Teilnehmende schauen zu |
| 15–30 | 2. Die drei Ebenen | Tafelbild, Gespräch |
| 30–50 | 3. Starten | alle tippen mit |
| 50–75 | 4. Die erste Änderung | selbstständig, reihum |
| 75–90 | 5. Absichtlicher Fehler | gemeinsam |

---

## Vor dem Kurs – 10 Minuten Vorlauf

Diese Punkte sind bereits über [[Anhang Vorbereitung durch die Kursleitung]] erledigt, werden aber am Morgen noch einmal an **jedem** Gerät geprüft:

- [ ] `toolbox enter tauri-dev` funktioniert, der Prompt zeigt das Sechseck
- [ ] `cargo tauri dev` im Ordner `~/Projekte/lernkarten` öffnet ein Fenster mit der Überschrift „Lernkarten"
- [ ] Das Fenster ist **nicht** weiß
- [ ] Der Editor ist geöffnet, `src/index.html` ist bereits geladen
- [ ] Die fertige Referenzanwendung liegt startbereit auf dem Gerät der Kursleitung
- [ ] Die [[Anhang Befehlskarte]] liegt ausgedruckt neben jeder Tastatur

> [!warning] Neu laden vorher testen
> Ob eine Änderung an `index.html` sofort im Fenster erscheint, hängt davon ab, wie der Entwicklungslauf die Dateien beobachtet. **Testen Sie das am Vortag an allen drei Geräten.**
>
> Falls die Änderung nicht von allein erscheint, gilt für den ganzen Kurs die Hausregel: Rechtsklick ins Fenster → **Neu laden**. Nehmen Sie diesen Schritt dann von Anfang an mit auf und sagen Sie ihn als normalen Arbeitsschritt an, nicht als Panne.

**Ausgangszustand von `src/index.html`** – so und nicht anders, damit die Übungen passen:

```html
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="UTF-8" />
    <title>Lernkarten</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <h1>Lernkarten</h1>

    <script src="app.js"></script>
  </body>
</html>
```

`style.css` und `app.js` sind leer und bleiben es bis K1 bzw. K3.

---

## 1. Was wir bauen (15 min)

**Ziel:** Bild vom Ergebnis. Kein einziger Fachbegriff.

Starten Sie auf Ihrem Gerät die fertige Lernkarten-Anwendung aus dem Anwendungsmenü – nicht aus dem Terminal. Das ist wichtig, weil es genau der Zustand ist, den die Teilnehmenden am vierten Tag selbst erreichen.

Führen Sie vor, in dieser Reihenfolge:

1. Eine Karte anlegen: Frage eintippen, Antwort eintippen, Knopf drücken.
2. Die Karte erscheint in der Liste.
3. „Umdrehen" – die Antwort erscheint.
4. „Nächste" – die nächste Karte.
5. Anwendung schließen, neu starten. Die Karten sind noch da.

> „Das hier ist Ihr Kursziel. In vier Tagen steht diese Anwendung bei Ihnen im Menü, gebaut aus drei Dateien, die Sie selbst geschrieben haben. Ich habe sie eben nicht aus einem Terminal gestartet, sondern ganz normal aus dem Menü – wie einen Taschenrechner oder einen Texteditor."

Dann das leere Projekt daneben starten lassen. Fenster an Fenster stehen lassen.

> „Und das ist Ihr Ausgangspunkt: ein leeres Fenster mit einer Überschrift. Der Abstand zwischen diesen beiden Fenstern ist das gesamte Kursprogramm."

**Eine Frage stellen, reihum beantworten lassen:**

> „Was, glauben Sie, ist der schwierigste Teil davon?"

Antworten sammeln, nicht bewerten. Die Antwort der Kursleitung:

> „Das Schwierigste kommt am zweiten Tag und heißt JavaScript. Alles davor ist leichter, als Sie denken. Ich sage Ihnen das jetzt, damit Sie am zweiten Tag wissen: Das ist normal und war eingeplant."

> [!tip] Was hier **nicht** gesagt wird
> Keine Erklärung von Tauri, Rust, Container, Flatpak, WebView. Nichts davon hilft in Minute 5. Die Begriffe kommen dann, wenn sie gebraucht werden – „Container" in Abschnitt 3, „Flatpak" erst in [[K7 Als Anwendung ausliefern]].

---

## 2. Die drei Ebenen (15 min)

**Ziel:** Das Hausbild sitzt. Es trägt den gesamten Kurs.

An die Tafel, während Sie sprechen:

| Datei | Vergleich | Zuständig für |
|---|---|---|
| `index.html` | Rohbau eines Hauses | **was** da ist |
| `style.css` | Anstrich und Möbel | **wie** es aussieht |
| `app.js` | Bewohner | **was passiert** |

> „Jede Anwendung, die aussieht wie diese hier, besteht aus drei Sorten Text. Der Rohbau legt fest, dass es einen Knopf gibt. Der Anstrich legt fest, dass der Knopf blau ist und runde Ecken hat. Und die Bewohner legen fest, was passiert, wenn jemand draufdrückt."

Dann die Kontrollfrage, reihum, jede Person eine:

- „Ich möchte, dass die Überschrift grün wird. Welche Datei?" → `style.css`
- „Ich möchte einen zweiten Knopf hinzufügen. Welche Datei?" → `index.html`
- „Ich möchte, dass beim Klick eine Karte erscheint. Welche Datei?" → `app.js`

> [!note] Die Grenze ist unscharf, das wird nicht thematisiert
> Man kann Farben auch in HTML setzen und Elemente auch aus JavaScript erzeugen. Beides kommt später (K4 erzeugt Listeneinträge). Jetzt gilt die einfache Zuordnung. Wenn eine Person nachfragt: „Es geht auch anders, das sehen wir am dritten Tag. Bis dahin ist die Aufteilung genau so."

Zum Abschluss den Editor zeigen, alle drei Dateien im Ordner `src/` aufmachen, zwei davon sind leer.

> „Zwei von drei Dateien sind noch leer. Die füllen wir in den nächsten Tagen. Heute fassen wir nur die erste an."

---

## 3. Starten (20 min)

**Ziel:** Jede Person hat das Fenster selbst gestartet und weiß, wo sie ist.

Alle drei tippen mit. Sie tippen sichtbar mit. **Nicht vorher fertig tippen und dann warten** – im gleichen Takt.

Befehl für Befehl, mit Pause dazwischen:

```nu
toolbox enter tauri-dev
```

> „Das ist der Container. Stellen Sie sich einen zweiten, kleineren Computer im Computer vor, in dem alle Werkzeuge liegen, die wir zum Bauen brauchen. Ihr eigentliches System bleibt dabei sauber. Sie erkennen ihn an dem Sechseck vorne in der Zeile."

Auf das Sechseck im Prompt zeigen lassen. Jede Person nennt laut, was bei ihr in der Zeile steht.

```nu
cd ~/Projekte/lernkarten
```

> „Damit wechseln wir in den Ordner mit unserem Projekt. `cd` heißt „change directory", Verzeichnis wechseln."

```nu
cargo tauri dev
```

> „Und jetzt wird gebaut. Das dauert jetzt einmalig ein paar Minuten und sieht aus, als würde der Rechner sich aufhängen. Er hängt sich nicht auf. Er übersetzt gerade das Programm. Beim nächsten Mal geht es in Sekunden."

> [!danger] Diese Ansage kommt **vor** dem Enter, nicht danach
> Ein dreiminütiger Textstrom ohne Vorwarnung wirkt bei Anfängern wie ein Absturz. Wer erst hinterher beruhigt, hat drei Minuten Unsicherheit erzeugt, die nicht sein müssten.

Die Wartezeit sinnvoll nutzen: Befehlskarte gemeinsam durchgehen, Abschnitt „Jeden Morgen" und „Wenn etwas nicht geht".

> „Diese Karte liegt die ganze Woche neben Ihnen. Nichts davon müssen Sie auswendig können. Ich kann es übrigens auch nicht auswendig."

Wenn das Fenster steht: Fenster nebeneinander anordnen.

```nu
swaymsg splith
```

> „Editor links, Anwendung rechts. So bleibt das die ganze Woche. Sie sollen die Änderung sehen, ohne ein Fenster suchen zu müssen."

Zum Schluss den Ort-Test, gemeinsam eintippen – der steht auch auf der Befehlskarte:

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

> „Diese eine Zeile beantwortet die Frage ‚Wo bin ich eigentlich?'. Sie werden sie am vierten Tag noch einmal brauchen, weil wir dann bewusst **außerhalb** des Containers arbeiten."

**Kontrollpunkt vor Abschnitt 4:** Alle drei Fenster stehen und zeigen die Überschrift. Wenn ein Gerät klemmt: Kursleitungsgerät teilen, nicht die Gruppe warten lassen.

---

## 4. Die erste Änderung (25 min)

**Ziel:** Jede Person hat mindestens vier eigene Änderungen gemacht und im Fenster wiedergefunden. Das ist der Kern der Einheit.

### 4a Gemeinsam, einmal (5 min)

Im Editor, `src/index.html`, Zeile mit `<h1>`:

```html
<h1>Lernkarten</h1>
```

wird zu

```html
<h1>Lernkarten von Anna</h1>
```

Speichern. Ins Fenster schauen. (Falls nötig: Rechtsklick → Neu laden, siehe Vorlauf.)

> „Der Text, den Sie zwischen die beiden Marken schreiben, erscheint im Fenster. Was links und rechts davon steht – dieses `h1` in den spitzen Klammern – erklären wir morgen früh. Heute reicht: Dazwischen ist Ihr Text."

Jede Person schreibt jetzt ihren **eigenen** Namen hinein. Warten, bis alle drei es haben. Reihum vorlesen lassen, was jetzt in ihrem Fenster steht.

### 4b Selbstständig, reihum (20 min)

Jetzt das Übungsblatt austeilen: [[K0c Übungsblatt]], Aufgaben Ü0.2 bis Ü0.4.

Vorgabe an die Gruppe:

> „Drei Änderungen, die Sie sich selbst ausdenken. Nach jeder Änderung schauen Sie ins Fenster. Wenn Sie nicht wissen, was Sie ändern sollen, stehen auf dem Blatt Vorschläge."

Sie gehen herum. Ihre Aufgabe hier ist **nicht** Erklären, sondern:

- darauf achten, dass wirklich nach **jeder** Änderung ins Fenster geschaut wird
- Tippfehler ohne Kommentar mitreparieren, wenn sonst Frust entsteht
- eine Person, die schneller ist, an der Zusatzaufgabe halten, nicht am nächsten Stoff

Nach etwa 15 Minuten: reihum zeigt jede Person der Gruppe ihr Fenster und nennt eine Änderung, die sie gemacht hat. Drei Personen, je zwei Minuten.

> [!warning] Farbe ändern gehört **nicht** hierher
> Naheliegend wäre, jemanden eine Textfarbe ändern zu lassen. Dafür bräuchte es CSS, und CSS ist der große Moment von [[K2 CSS – das Aussehen]] – dort ist die allererste Regel `background-color`. Wenn heute schon jemand eine Farbe gesetzt hat, ist dieser Moment verbraucht.
>
> Wenn die Frage kommt: „Sehr gute Frage. Das ist genau der Punkt, an dem morgen Nachmittag die zweite Datei dazukommt. Heute ändern wir nur, **was** dasteht, noch nicht, wie es aussieht."
>
> Sichtbare Änderung ohne CSS für Schnellere: `<h1>` in `<h2>` ändern. Der Text wird kleiner, ganz ohne Anstrich.

---

## 5. Absichtlicher Fehler (15 min)

**Ziel:** Die wichtigste Botschaft des ganzen Tages – Kaputtmachen ist Teil der Arbeit.

### 5a Vorführung (5 min)

Sie machen es zuerst auf Ihrem Gerät, die Gruppe schaut zu. In `index.html`:

```html
<h1>Lernkarten von Anna
```

Das `</h1>` ist weg. Speichern, neu laden.

Beobachtbar: Der gesamte folgende Inhalt wird groß und fett. Nichts stürzt ab.

> „Schauen Sie, was passiert ist. Das Programm ist nicht abgestürzt und der Rechner ist nicht kaputt. Es hat geraten. Ich habe vergessen zu sagen, wo die Überschrift aufhört – also hat es angenommen, sie hört nie auf. Alles danach ist jetzt Überschrift."

Fragen lassen: Was müsste man tun, damit es wieder stimmt? Antwort abwarten, dann reparieren.

### 5b Jede Person selbst (7 min)

> „Jetzt bauen Sie den Fehler selbst ein. Absichtlich. Anschauen. Reparieren."

Das ist keine Spielerei. Wer einmal absichtlich kaputt gemacht und selbst repariert hat, ruft beim nächsten unabsichtlichen Fehler seltener sofort nach Hilfe.

### 5c Abschluss (3 min)

Die drei Sätze, die stehen bleiben sollen – langsam, einzeln:

> „Erstens: Kaputtmachen ist erlaubt. Es geht nichts verloren.
> Zweitens: Der Rechner sagt Ihnen meistens, wo das Problem liegt. Wir lernen diese Woche, das zu lesen.
> Drittens: Jeder von uns baut Fehler ein. Ich auch, jeden Tag. Der Unterschied ist nur, wie schnell man sie findet."

Ausblick in einem Satz:

> „Morgen früh nehmen wir uns die spitzen Klammern vor und bauen die vollständige Oberfläche. Bis dahin läuft bei Ihnen ein Fenster mit Ihrem Namen darin – das ist mehr, als die meisten am ersten Tag haben."

---

## Kontrollpunkte

| Nach Abschnitt | Woran Sie erkennen, dass es sitzt |
|---|---|
| 2 | Jede Person ordnet drei Beispielfragen der richtigen Datei zu |
| 3 | Jede Person hat das Fenster **selbst** gestartet, nicht zugeschaut |
| 4 | Jede Person hat mindestens vier Änderungen gemacht und jeweils ins Fenster geschaut |
| 5 | Jede Person hat einen Fehler selbst eingebaut und selbst repariert |

---

## Wenn es klemmt

| Symptom | Wahrscheinliche Ursache | Sofortmaßnahme |
|---|---|---|
| Weißes Fenster | Grafikausgabe, sollte durch Vorbereitung erledigt sein | `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }`, danach dauerhaft eintragen |
| Änderung erscheint nicht | nicht gespeichert, falsche Datei, oder kein automatisches Neuladen | Rechtsklick → Neu laden; notfalls `Strg`+`C` und `cargo tauri dev` erneut |
| Fenster öffnet nicht, Terminal zeigt roten Text | meist ein Tippfehler im Ordnernamen | erste Zeile der Meldung gemeinsam lesen |
| „Ich bin im falschen Verzeichnis" | `cd` vergessen | `pwd` zeigt, wo man ist |
| Eine Person hängt fest | Tippfehler an unauffindbarer Stelle | Stand aus [[Anhang Vorbereitung durch die Kursleitung]] kopieren, nicht suchen |
| Eine Person ist deutlich schneller | – | Zusatzaufgabe Ü0.5, **kein** neuer Stoff |

> [!tip] Die 3-Minuten-Regel
> Niemand steht länger als drei Minuten still. Bei drei Teilnehmenden fällt das sofort auf, und es demotiviert am ersten Tag stärker als an jedem anderen. Lieber den fertigen Zwischenstand kopieren und die Fehlersuche vertagen.

## Verknüpfung

Konzept: [[K0 Ankommen und erste eigene Änderung]] · Handout: [[K0b Handout]] · Übungen: [[K0c Übungsblatt]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

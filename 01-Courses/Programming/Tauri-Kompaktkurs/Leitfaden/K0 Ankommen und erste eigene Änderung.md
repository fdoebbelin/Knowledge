---
title: Ankommen und erste eigene Änderung
modul: K0
typ: leitfaden
tags: [tauri/kompaktkurs/leitfaden]
status: active
---

# K0 – Ankommen und erste eigene Änderung

## Inhaltsübersicht

- Das Ziel des Kurses
- Die drei Ebenen: Struktur, Aussehen, Verhalten
- Die Anwendung starten
- Die erste eigene Änderung
- Absichtlicher Fehler: das fehlende Ende-Tag
- Typische Stolperstellen
- Stand am Ende des Moduls

## Das Ziel des Kurses

Gebaut wird eine **Lernkarten-Anwendung**: Karten mit Frage und Antwort anlegen, durchblättern, umdrehen, löschen. Am Ende steht diese Anwendung im Anwendungsmenü und startet ohne Terminal.

Zu Beginn stehen zwei Fenster nebeneinander: die fertige Anwendung und das eigene, noch leere Projekt. Der Abstand dazwischen ist das Kursprogramm.

Die fertige Anwendung wird über das Anwendungsmenü gestartet – nicht aus dem Terminal. Genau das ist der Zustand, den die Teilnehmenden am Ende selbst erreichen:

1. Eine Karte anlegen: Frage eintippen, Antwort eintippen, Knopf drücken.
2. Die Karte erscheint in der Liste.
3. „Umdrehen" – die Antwort erscheint.
4. „Nächste" – die nächste Karte.
5. Anwendung schließen, neu starten. Die Karten sind noch da.

> [!tip] Was an dieser Stelle **nicht** erklärt wird
> Kein Tauri, kein Rust, kein Container, kein Flatpak, keine WebView. Nichts davon wird jetzt gebraucht. Die Begriffe kommen dann, wenn sie gebraucht werden – „Container" beim Starten, „Flatpak" erst in [[K7 Als Anwendung ausliefern]].

Eine Frage an die Gruppe, reihum beantwortet: *Was ist wohl der schwierigste Teil davon?* Antworten werden gesammelt, nicht bewertet. Die Auflösung:

> [!note] Die ehrliche Vorwarnung
> Das Schwierigste kommt mit JavaScript in [[K3 JavaScript – die Bausteine]]. Alles davor ist leichter, als es aussieht. Das wird vorher gesagt, damit es später als eingeplant und nicht als persönliches Scheitern erlebt wird.

## Die drei Ebenen: Struktur, Aussehen, Verhalten

Jede Anwendung dieser Art besteht aus drei Sorten Text. Sie liegen im Ordner `src/`:

| Datei | Vergleich | Zuständig für |
|---|---|---|
| `index.html` | Rohbau eines Hauses | **was** da ist |
| `style.css` | Anstrich und Möbel | **wie** es aussieht |
| `app.js` | die Bewohner | **was passiert** |

- Der **Rohbau** legt fest, dass es einen Knopf gibt.
- Der **Anstrich** legt fest, dass der Knopf blau ist und runde Ecken hat.
- Die **Bewohner** legen fest, was passiert, wenn jemand daraufdrückt.

Die drei Dateien im Editor öffnen. Zwei davon sind leer und bleiben es vorerst:

| Datei | Gefüllt ab |
|---|---|
| `index.html` | jetzt |
| `style.css` | [[K2 CSS – das Aussehen]] |
| `app.js` | [[K3 JavaScript – die Bausteine]] |

**Zuordnungsübung, reihum:**

- „Ich möchte, dass die Überschrift grün wird." → `style.css`
- „Ich möchte einen zweiten Knopf hinzufügen." → `index.html`
- „Ich möchte, dass beim Klick eine Karte erscheint." → `app.js`

> [!note] Die Grenze ist unscharf
> Farben lassen sich auch in HTML setzen und Elemente auch aus JavaScript erzeugen. Beides kommt später – [[K4 JavaScript im Fenster]] erzeugt tatsächlich Listeneinträge im Programm. Für den Einstieg gilt die einfache Zuordnung.

## Die Anwendung starten

Diese drei Zeilen werden gebraucht, um überhaupt zu arbeiten. Sie stehen auch auf der [[Anhang Befehlskarte]]. Alle tippen mit:

```nu
toolbox enter tauri-dev
```

Der **Container**: eine abgetrennte Umgebung im Rechner, in der alle Werkzeuge zum Bauen liegen. Das eigentliche System bleibt unberührt. Im Container steht ein Sechseck ⬢ vorne in der Eingabezeile.

```nu
cd ~/Projekte/lernkarten
```

`cd` heißt *change directory* – in den Ordner mit dem Projekt wechseln.

```nu
cargo tauri dev
```

> [!warning] Der erste Start dauert spürbar länger
> Dabei läuft viel Text durch das Terminal. Das ist kein Absturz – das Programm wird gerade übersetzt. Jeder weitere Start geht schnell.
>
> Diese Ansage gehört **vor** das Drücken der Eingabetaste. Ein langer Textstrom ohne Vorwarnung wirkt bei Anfängern wie ein Absturz.

Die Wartezeit sinnvoll nutzen: die [[Anhang Befehlskarte]] gemeinsam durchgehen, Abschnitte „Anwendung starten" und „Wenn etwas nicht geht".

**Fenster nebeneinander anordnen:**

```nu
swaymsg splith
```

Editor links, Anwendung rechts. Dieser Aufbau bleibt den ganzen Kurs über bestehen. Die Änderung soll sichtbar sein, ohne ein Fenster suchen zu müssen.

**Ortsprüfung** – diese Zeile steht auch auf der Befehlskarte:

```nu
if ("/run/.toolboxenv" | path exists) { print "im Container" } else { print "auf dem Host" }
```

Sie beantwortet die Frage „Wo bin ich eigentlich?" und wird in [[K7 Als Anwendung ausliefern]] wieder gebraucht, weil dort bewusst **außerhalb** des Containers gearbeitet wird.

**Anwendung beenden:** im Terminal `Strg` + `C`, danach `exit`.

## Die erste eigene Änderung

In `src/index.html` steht diese Zeile:

```html
<h1>Lernkarten</h1>
```

Geändert wird der Text **zwischen** den beiden Marken:

```html
<h1>Lernkarten von Anna</h1>
```

Speichern. Ins Fenster schauen.

> [!tip] Der Ablauf, der den ganzen Kurs gilt
> **Ändern → Speichern → Hinsehen.** Nach jeder einzelnen Änderung. Wer fünf Dinge auf einmal ändert und dann hinschaut, weiß bei einem Fehler nicht mehr, welche der fünf Änderungen ihn verursacht hat.

Falls die Änderung nicht sofort erscheint: Rechtsklick ins Anwendungsfenster → **Neu laden**.

Was `<h1>` und `</h1>` genau bedeuten, klärt [[K1 HTML – die Struktur]]. Für jetzt genügt: Dazwischen steht der eigene Text. Jede Person schreibt ihren **eigenen** Namen hinein und liest der Gruppe vor, was jetzt im Fenster steht.

Danach folgen eigene Änderungen, eine nach der anderen, mit Hinsehen dazwischen. Vorschläge, falls nichts einfällt:

1. Einen zweiten Satz unter der Überschrift einfügen
2. Die Überschrift kleiner machen
3. Einen eingefügten Satz wieder löschen
4. Zwei Sätze untereinander einfügen und ihre Reihenfolge tauschen

> [!warning] Farbe ändern gehört noch nicht hierher
> Naheliegend wäre, eine Textfarbe zu ändern. Dafür braucht es CSS, und CSS hat seinen eigenen großen Moment in [[K2 CSS – das Aussehen]] – dort ist die allererste Regel `background-color`. Wer jetzt schon eine Farbe setzt, verbraucht diesen Moment.
>
> Wenn die Frage kommt: „Sehr gute Frage. Das ist genau der Punkt, an dem die zweite Datei dazukommt. Jetzt ändern wir nur, **was** dasteht, noch nicht, wie es aussieht."
>
> Sichtbare Änderung ohne CSS: `<h1>` in `<h2>` ändern. Der Text wird kleiner, ganz ohne Anstrich.

## Absichtlicher Fehler: das fehlende Ende-Tag

Das schließende `</h1>` wird gelöscht:

```html
<h1>Lernkarten von Anna
```

Speichern, neu laden.

**Beobachtbar:** Der gesamte folgende Inhalt wird groß und fett dargestellt. Nichts stürzt ab.

**Was passiert ist:** Es wurde nicht gesagt, wo die Überschrift **aufhört**. Also nimmt das Programm an, sie hört nie auf – alles danach ist jetzt Überschrift. Das Programm rät, statt zu versagen.

Danach selbst: Fehler einbauen, anschauen, reparieren. Wer einmal absichtlich kaputt gemacht und selbst repariert hat, ruft beim nächsten unabsichtlichen Fehler seltener sofort nach Hilfe.

> [!important] Drei Sätze für den ganzen Kurs
> 1. **Kaputtmachen ist erlaubt.** Es geht nichts verloren.
> 2. **Der Rechner sagt meistens, wo das Problem liegt.** Diese Meldungen zu lesen wird geübt.
> 3. **Jeder baut Fehler ein**, auch nach Jahren. Der Unterschied ist nur, wie schnell man sie findet.

## Typische Stolperstellen

> [!warning]
> - **Weißes Fenster.** Bekanntes Problem der Grafikausgabe. Sollte durch die Vorbereitung erledigt sein. Falls doch: `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }`
> - **Nichts ändert sich.** Meist wurde nicht gespeichert oder die falsche Datei geändert.
> - **Der erste Start dauert.** Vorher ansagen, sonst wirkt es wie ein Absturz.
> - **Der Name landet in der Marke.** `<h1 Lernkarten von Anna>` statt `<h1>Lernkarten von Anna</h1>`. Im Fenster erscheint dann gar nichts.

## Stand am Ende des Moduls

- [ ] Container betreten und die Anwendung selbst gestartet
- [ ] Die drei Dateien benannt und ihre Zuständigkeit erklärt
- [ ] Eine Änderung im Quelltext gemacht und im Fenster wiedergefunden
- [ ] Einen Fehler eingebaut, beschrieben und behoben
- [ ] Das Fenster ist **nicht** weiß, Editor und Anwendung liegen nebeneinander

## Verknüpfung

Merkblatt: [[K0 Merkblatt]] · Übungen: [[K0 Übungsblatt]] · [[Anhang Befehlskarte]]
Weiter mit [[K1 HTML – die Struktur]] · zurück zu [[00 Kompaktkurs Tauri Grundlagen]]

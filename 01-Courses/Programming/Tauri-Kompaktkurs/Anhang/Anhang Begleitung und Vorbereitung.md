---
title: Begleitung und Vorbereitung
aliases:
  - Anhang Vorbereitung durch die Kursleitung
typ: anhang
tags: [tauri/kompaktkurs/anhang, vorbereitung]
status: active
---

# Anhang – Begleitung und Vorbereitung

> [!danger] Ohne diese Vorbereitung trägt der Kurs nicht
> Alles hier Genannte muss vor Kursbeginn fertig und auf allen drei Geräten getestet sein. Der Kurs beginnt mit einer laufenden Anwendung, nicht mit einer Installation.

## Inhaltsübersicht

- Umgebung je Gerät
- Projekt im Ausgangszustand
- Die vorbereiteten Rust-Commands
- Zwischenstände
- Material auf dem Tisch
- Ablaufbegleitung: Was die Kursleitung je Modul beobachtet
- Was tun, wenn es klemmt
- Puffer ohne Zeitplan
- Verknüpfung

## Umgebung je Gerät

Vollständiger Durchlauf des Leitfadens [[Von der leeren Toolbx zur installierten Flatpak-App]], Phasen 0 und 1, plus:

```nu
# dauerhaft im if-Block aus Leitfaden-Abschnitt 9 ergänzen
$env.WEBKIT_DISABLE_DMABUF_RENDERER = "1"
```

Damit ist das weiße Fenster zu Beginn ausgeschlossen.

Prüfliste je Gerät:

- [ ] Nushell ist Login-Shell, funktioniert auf Host und im Container
- [ ] Container `tauri-dev` existiert, `cargo tauri --version` antwortet
- [ ] `org.flatpak.Builder`, `org.gnome.Sdk`, `org.gnome.Platform` und die Rust-Erweiterung installiert
- [ ] Projekt `~/Projekte/lernkarten` liegt im Ausgangszustand
- [ ] Ein vollständiger Probelauf inklusive Flatpak-Bau wurde durchgeführt

## Projekt im Ausgangszustand

```
~/Projekte/lernkarten/
├── src/
│   ├── index.html          leer bis auf Grundgerüst
│   ├── style.css           leer
│   └── app.js              leer
├── src-tauri/
│   ├── src/main.rs         VOLLSTÄNDIG vorbereitet
│   ├── Cargo.toml          mit `[[bin]]`-Block
│   └── tauri.conf.json     withGlobalTauri: true
├── de.metarow.Lernkarten.desktop
├── de.metarow.Lernkarten.metainfo.xml
└── de.metarow.Lernkarten.yml
```

`index.html` enthält nur Grundgerüst, Einbindung von `style.css` und `app.js` am Ende des `<body>`, und eine Überschrift. Mehr nicht.

> [!important] Skript am Ende des Body
> Damit `document.querySelector` in [[K4 JavaScript im Fenster]] funktioniert, muss `<script src="app.js"></script>` **hinter** dem Inhalt stehen. Das ist vorbereitet und wird im Kurs nicht thematisiert.

## Die vorbereiteten Rust-Commands

`src-tauri/src/main.rs` enthält zwei Funktionen, die in [[K5 Daten behalten]] gemeinsam gelesen werden. Anforderungen an die Umsetzung:

- `karten_speichern(karten)` schreibt die Liste als JSON in `lernkarten.json` im Anwendungsdatenordner
- `karten_laden()` liest die Datei und gibt die Liste zurück; fehlt die Datei, gibt sie eine leere Liste zurück
- Beide Funktionen sind kurz und lesbar, ohne Fehlerbehandlung, die vom Wesentlichen ablenkt
- Deutsche Funktionsnamen, damit der Bezug zum Aufruf im Frontend offensichtlich ist

> [!note] Warum nicht das FS-Plugin?
> Die Tauri-Plugins liegen als npm-Pakete vor und brauchen einen Bundler. Der Kurs kommt ohne Node aus. Zwei vorbereitete Rust-Commands sind der einfachere und für die Teilnehmenden verständlichere Weg.

## Zwischenstände

Für jeden Baustein ein fertiger Stand als Ordner oder Git-Tag:

| Stand | Inhalt |
|---|---|
| `stand-k1` | HTML vollständig, CSS und JS leer |
| `stand-k2` | zusätzlich CSS vollständig |
| `stand-k3` | zusätzlich Datenbestand in `app.js`, noch ohne DOM |
| `stand-k4` | zusätzlich funktionierende Oberfläche |
| `stand-k5` | zusätzlich Speichern und Laden |
| `stand-k6` | Referenzfassung mit Gestaltung |

Zweck: Wenn eine Person durch einen Tippfehler blockiert ist, wird nicht gesucht, sondern der Stand kopiert. Bei drei Personen darf niemand lange stillstehen.

## Material auf dem Tisch

- [ ] [[Anhang Befehlskarte]] gedruckt, je Person ein Exemplar
- [ ] Liste der `id`-Namen aus [[K1 HTML – die Struktur]] als Vorlage zum Ausfüllen
- [ ] Notizheft je Person, Papier, nicht digital
- [ ] Farbwähler oder ausgedruckte Hex-Palette für [[K2 CSS – das Aussehen]]

## Ablaufbegleitung: Was die Kursleitung je Modul beobachtet

Die Leitfäden beschreiben den Stoff für die Teilnehmenden. Hier steht, woran die Kursleitung erkennt, dass ein Abschnitt sitzt, und was sie beim Vortippen besonders beachten muss.

### K0 – Ankommen und erste eigene Änderung

**Vorlauf:** Alle drei Geräte sind gestartet, `src/index.html` ist im Editor geöffnet, die fertige Referenzanwendung liegt startbereit, die Befehlskarte liegt ausgedruckt neben jeder Tastatur.

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

> [!warning] Neu laden vorher testen
> Ob eine Änderung an `index.html` sofort im Fenster erscheint, hängt davon ab, wie der Entwicklungslauf die Dateien beobachtet. **Das vor Kursbeginn an allen drei Geräten testen.**
>
> Falls die Änderung nicht von allein erscheint, gilt für den ganzen Kurs die Hausregel: Rechtsklick ins Fenster → **Neu laden**. Diesen Schritt dann von Anfang an als normalen Arbeitsschritt ansagen, nicht als Panne.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Die drei Ebenen | Jede Person ordnet drei Beispielfragen der richtigen Datei zu |
| Starten | Jede Person hat das Fenster **selbst** gestartet, nicht zugeschaut |
| Erste Änderung | Jede Person hat mehrere Änderungen gemacht und jeweils ins Fenster geschaut |
| Absichtlicher Fehler | Jede Person hat einen Fehler selbst eingebaut und selbst repariert |

### K1 – HTML – die Struktur

**Vorlauf:** Ergebnis aus K0 läuft, Notizhefte liegen aufgeschlagen daneben, Vorlage „Liste der `id`-Namen" ist ausgeteilt, Zwischenstand `stand-k1` liegt bereit.

> [!important] Das eigentliche Ergebnis dieses Moduls
> Nicht die fertige Oberfläche – die könnte man auch austeilen. Das Ergebnis ist die **`id`-Liste im Notizheft jeder Person**. Ohne sie steht [[K4 JavaScript im Fenster]] still. Der `id`-Abschnitt und der Gegenlese-Schritt sind deshalb nicht verhandelbar.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Elementanatomie | Jede Person zeigt Start-Tag, Inhalt und Ende-Tag an einem beliebigen Element |
| Die acht Elemente | Jede Person nennt aus dem Kopf den Unterschied zwischen `<input>` und `<textarea>` |
| `id` und `class` | Jede Person erklärt in eigenen Worten, warum eine `id` nur einmal vorkommen darf |
| Die Oberfläche | Alle `id`-Namen stehen im Heft und stimmen mit der Datei überein |
| Absichtlicher Fehler | Jede Person findet den Fehler an der Einrückung und repariert ihn |

> [!tip] Der Gegenlese-Schritt
> Jede Person liest ihre Heftliste vor, die Nachbarperson sucht jeden Namen in der Datei. Er ersetzt in K4 eine lange Fehlersuche und wird deshalb nicht gekürzt.

### K2 – CSS – das Aussehen

**Vorlauf:** Oberfläche aus K1 steht, `src/style.css` ist im Editor geöffnet, Hex-Palette liegt auf dem Tisch, die `id`-Liste liegt bereit.

> [!tip] Zwei Dateien nebeneinander
> Spätestens hier lohnt der zweite Editor-Bereich: `index.html` und `style.css` gleichzeitig sichtbar. Wer zwischen Tabs wechseln muss, verliert den Zusammenhang zwischen `id` und Selektor.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Die erste Regel | Jede Person benennt Selektor, Eigenschaft und Wert an einer beliebigen Regel |
| Die drei Selektoren | Jede Person sagt, welcher der drei Selektoren gewinnt, wenn zwei zutreffen |
| Boxmodell | Jede Person erklärt den Unterschied zwischen `padding` und `margin` in eigenen Worten |
| Flexbox | Jede Person kann sagen, warum die Knopfleiste ein eigenes `div` braucht |
| Absichtlicher Fehler | Jede Person kennt die zwei Diagnosefragen |

**Lernstandsgespräch nach K2:**

> „Ändern Sie die Hintergrundfarbe der Karte und erklären Sie, welche Datei Sie dafür anfassen."

Erwartet: `style.css`, Regel `#anzeige`, Eigenschaft `background-color`. Wer stattdessen in die `index.html` geht, hat die Aufteilung aus [[K0 Ankommen und erste eigene Änderung]] nicht verinnerlicht – dann hier nacharbeiten, das trägt bis K7.

> [!tip] Kontrastprüfung nebenbei
> Wenn jemand hellgrauen Text auf weißem Grund wählt: nicht verbieten, sondern hinsehen lassen. „Können Sie das aus zwei Metern Entfernung lesen?" Das ist die Miniatur-Lektion in Barrierefreiheit, die in [[K6 Feinschliff]] wieder aufgegriffen wird.

### K3 – JavaScript – die Bausteine

**Vorlauf:** Ergebnis aus K2 läuft, `src/app.js` ist im Editor geöffnet, Zwischenstand `stand-k3` liegt bereit.

> [!danger] Die Konsole vorher prüfen
> Rechtsklick im Anwendungsfenster → „Element untersuchen" → Reiter „Konsole". Das ist der Web-Inspektor von WebKit und steht nur im Entwicklungslauf zur Verfügung. Funktioniert er auf einem Gerät nicht, ist der gesamte Baustein blockiert – es gibt hier keine andere Rückmeldung.
>
> Notfallplan: Zwei Personen an einem Gerät arbeiten lassen, statt den Baustein ohne Konsole zu versuchen.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Variablen und Konsole | Konsole ist offen, jede Person hat die `const`-Fehlermeldung gesehen |
| Funktionen | Jede Person beantwortet die drei Fragen an einer fremden Funktion |
| Funktionen | Jede Person nennt den Unterschied zwischen `return` und `console.log` |
| Entscheidungen | Jede Person sagt, was `=` und was `===` tut |
| Listen | Jede Person zählt die Indizes einer Liste korrekt ab |
| Objekte | Jede Person unterscheidet `liste[0]` von `objekt.feld` |
| Datenbestand | Jede Person löst `karten[0].frage` in Worte auf |

### K4 – JavaScript im Fenster

**Vorlauf:** Datenbestand aus K3 liegt in `app.js`, die `id`-Liste liegt aufgeschlagen bereit, Zwischenstand `stand-k4` liegt bereit.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Ein Element greifen | Jede Person erklärt, dass die `id` im HTML und der Selektor im JavaScript derselbe Name sein müssen |
| Auf Klicks reagieren | Jede Person kann die Reihenfolge im `addEventListener` erklären: erst Ereignis, dann Funktion ohne Klammern |
| Aus Daten wird Anzeige | Jede Person nennt das Muster „Erst leeren, dann aus den Daten neu aufbauen" |
| Absichtlicher Fehler | Jede Person findet den fehlenden Aufruf von `listeAnzeigen()` selbst |

**Lernstandsgespräch nach K4:**

> „Was passiert zwischen dem Klick auf den Knopf und der Änderung im Fenster?"

Erwartet in Kurssprache: Der Klick löst die Funktion aus, die Funktion liest die Eingabefelder, hängt ein Objekt an die Liste und baut die Anzeige neu auf.

### K5 – Daten behalten

**Vorlauf:** Oberfläche aus K4 funktioniert, `src-tauri/src/main.rs` ist im Editor geöffnet, Zwischenstand `stand-k5` liegt bereit.

**Kontrollpunkte:**

| Nach Abschnitt | Woran zu erkennen ist, dass es sitzt |
|---|---|
| Die zwei Teile | Jede Person benennt die Rollen von Fenster und Programmkern in einem Satz |
| Der erste Aufruf | Jede Person erklärt den Merksatz „Wo `await` steht, muss `async` davorstehen" |
| Laden beim Start | Jede Person findet die Datei `lernkarten.json` im Dateisystem |
| Speicherstellen | Jede Person nennt beide Stellen, an denen gespeichert werden muss |

### K6 – Feinschliff

**Kontrollpunkte:**

| Woran zu erkennen ist, dass es sitzt |
|---|
| Jede Person hat genau **eine** Verbesserung umgesetzt und kann begründen, warum gerade diese |
| Der Kontrast ist aus zwei Metern Entfernung lesbar |
| Der bestehende Code ist heil geblieben |

### K7 – Als Anwendung ausliefern

**Vorlauf:** Stand aus K6 ist gesichert, Manifest und Metadaten sind vollständig vorbereitet, die Befehlskarte liegt bereit.

**Kontrollpunkte:**

| Woran zu erkennen ist, dass es sitzt |
|---|
| Jede Person hat die Anwendung ohne Terminal aus dem Menü gestartet |
| Jede Person benennt den Unterschied zwischen Entwicklungslauf und installierter Anwendung |
| Jede Person erklärt, warum die Karten aus dem Entwicklungslauf fehlen |

**Lernstandsgespräch nach K7:**

> „Beschreiben Sie den Weg von Ihrer `index.html` bis zum Eintrag im Anwendungsmenü."

## Was tun, wenn es klemmt

| Symptom | Wahrscheinliche Ursache | Sofortmaßnahme |
|---|---|---|
| Weißes Fenster | Grafikausgabe, sollte durch Vorbereitung erledigt sein | `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }`, danach dauerhaft eintragen |
| Änderung erscheint nicht | nicht gespeichert, falsche Datei, oder kein automatisches Neuladen | Rechtsklick → Neu laden; notfalls `Strg`+`C` und `cargo tauri dev` erneut |
| Fenster öffnet nicht, Terminal zeigt roten Text | meist ein Tippfehler im Ordnernamen | erste Zeile der Meldung gemeinsam lesen |
| „Ich bin im falschen Verzeichnis" | `cd` vergessen | `pwd` zeigt, wo man ist |
| Nach dem Eingabefeld ist die ganze Seite verrutscht | `<textarea>` ohne Ende-Tag | Tafelbild `<input>` gegen `<textarea>` zeigen, nicht neu erklären |
| Ein Element erscheint gar nicht | Attributwert ohne Anführungszeichen oder Tippfehler im Tag-Namen | Zeile laut vorlesen lassen – beim Vorlesen fällt es meist selbst auf |
| Der `placeholder`-Text ist weg | Es wurde hineingetippt | Feld leeren, Text kommt zurück. Guter Moment für „Hinweis, kein Inhalt" |
| Die Liste ist unsichtbar | `<ul>` ist leer – korrekt | Nicht als Fehler behandeln |
| Eine CSS-Regel wirkt nicht | `#`/`.` vertauscht oder Name stimmt nicht | Namen im CSS und im HTML **laut** nebeneinander vorlesen |
| Alle CSS-Regeln ab einer Stelle wirken nicht | fehlendes Semikolon oder fehlende `}` | oberhalb der ersten wirkungslosen Regel suchen |
| Zwei CSS-Regeln widersprechen sich | Spezifität | Merksatz: `#id` schlägt `.klasse` schlägt `element` |
| Kasten wird beim Verkleinern abgeschnitten | `width` statt `max-width` | Kursregel: immer `max-width` |
| Gar nichts passiert, keine Meldung | Funktion nie aufgerufen | Merksatz zeigen: Eine Funktion aufschreiben heißt nicht, sie zu benutzen |
| `undefined` als Ergebnis | `return` vergessen, Index zu groß oder Feldname falsch | Diagnosetabelle |
| Rote Meldung in der Konsole, Person erstarrt | Meldung nicht gelesen | Erste Zeile **laut vorlesen** lassen |
| `if` verhält sich unlogisch | `=` statt `===` | Kursregel wiederholen |
| Zugriff liefert nichts | `liste.feld` oder `objekt[0]` verwechselt | Regalbild zeigen: nummerierte gegen beschriftete Fächer |
| Konsole zeigt nach jedem Befehl `undefined` | normales Verhalten | einmal erklären, dann ignorieren |
| Ausgabe nicht auffindbar | im Terminal gesucht statt in der Konsole | auf die Konsole zeigen |
| `querySelector` liefert `null` | das `#` fehlt oder die `id` ist falsch geschrieben | Selektornamen vorlesen |
| Änderung an `app.js` wirkt nicht | nach dem Bearbeiten nicht neu geladen | Rechtsklick → Neu laden |
| `await` ohne `async` | Merksatz vergessen | Fehlermeldung laut lesen, sie sagt es wörtlich |
| Flatpak-Bau bricht ab | Bau läuft im Container statt auf dem Host | `exit` nicht vergessen |
| Anwendung erscheint nicht im Menü | kurze Verzögerung | kurz warten, dann neu anmelden |
| Eine Person hängt fest | Tippfehler an unauffindbarer Stelle | Stand aus dem Abschnitt Zwischenstände kopieren, nicht suchen |
| Eine Person ist deutlich schneller | – | Zusatzaufgabe des Moduls, **kein** neuer Stoff |
| Tempo bricht in K3 ein | normal für diesen Baustein | Reserve aus [[K6 Feinschliff]] ziehen, Stoff **nicht** kürzen |

> [!tip] Die Kurzregel
> Niemand steht lange still. Bei drei Teilnehmenden fällt das sofort auf, und es demotiviert stärker als jeder Stoffverlust. Lieber den fertigen Zwischenstand kopieren und die Fehlersuche vertagen.

> [!warning] Die Versuchung, vorzugreifen
> Eine schnelle Person will `document.querySelector` ausprobieren, weil sie es irgendwo gesehen hat, oder Farben ausprobieren, bevor CSS dran ist. Das nimmt dem jeweiligen Modul den Aufhänger. Formulierung: „Das ist genau der nächste Abschnitt. Halten Sie den Gedanken fest."

> [!warning] Wenn Eingaben aus dem Netz kopiert werden
> Freundlich einfangen: „Alles, was Sie brauchen, steht auf Ihrem Merkblatt. Was Sie kopieren, können Sie später nicht reparieren."

## Puffer ohne Zeitplan

Der Kurs ist stofflich dicht gepackt. Puffer entsteht ausschließlich aus:

- [[K6 Feinschliff]] kann auf die halbe Länge gekürzt werden – er enthält bewusst nichts, was für [[K7 Als Anwendung ausliefern]] nötig ist
- die Zusatzaufgaben sind optional und werden nur bei Vorsprung ausgegeben

Reicht das nicht, wird [[K7 Als Anwendung ausliefern]] auf eine reine Vorführung durch die Kursleitung verkürzt. Das kostet den Höhepunkt des Kurses und ist deshalb die letzte Reserve.

## Verknüpfung

[[00 Kompaktkurs Tauri Grundlagen]] · [[Anhang Befehlskarte]] · [[Anhang Sprachumfang JavaScript]] · [[Von der leeren Toolbx zur installierten Flatpak-App]]

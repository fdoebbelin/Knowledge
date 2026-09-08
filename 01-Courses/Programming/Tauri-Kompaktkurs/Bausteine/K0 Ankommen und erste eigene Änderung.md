---
baustein: K0
titel: Ankommen und erste eigene Änderung
ue: 2
tag: 1
tags: [tauri/kompaktkurs/baustein]
status: entwurf
---

# K0 – Ankommen und erste eigene Änderung

> [!abstract] Ziel des Bausteins
> Nach 90 Minuten hat jede Person ein laufendes Fenster mit ihrem eigenen Namen darin. Kein Setup, keine Theorie, sofort ein Ergebnis.

## Lernziele

- Den Container betreten und die Anwendung starten
- Die drei Dateien des Projekts benennen
- Eine Änderung im Quelltext machen und sie im Fenster wiederfinden

## Ablauf

### 1. Was wir bauen (15 min)

Die fertige Lernkarten-Anwendung wird vorgeführt. Danach das laufende Fenster daneben, mit dem noch leeren Projekt. Der Abstand dazwischen ist das Kursprogramm.

### 2. Die drei Ebenen (15 min)

Ohne Fachbegriffe, an einem Bild:

| Datei | Vergleich | Zuständig für |
|---|---|---|
| `index.html` | Rohbau eines Hauses | was da ist |
| `style.css` | Anstrich und Möbel | wie es aussieht |
| `app.js` | Bewohner | was passiert |

### 3. Starten (20 min)

```nu
toolbox enter tauri-dev
cd ~/Projekte/lernkarten
cargo tauri dev
```

Was dabei zu erklären ist: Der erste Start dauert lange, weil das Programm gebaut wird. Beim zweiten Mal geht es schnell. Das Fenster bleibt offen, Änderungen an `index.html` erscheinen sofort.

> [!tip] Zwei Fenster nebeneinander
> Editor links, Anwendung rechts. Unter Sway:
> ```nu
> swaymsg splith
> ```
> Dieser Aufbau bleibt den ganzen Kurs über bestehen.

### 4. Die erste Änderung (25 min)

In `index.html` die Überschrift ändern. Speichern. Ins Fenster schauen.

Danach reihum: Farbe eines Textes ändern, Text hinzufügen, Text löschen. Jede Person macht mindestens drei Änderungen selbst.

### 5. Absichtlicher Fehler (15 min)

Die Kursleitung löscht ein schließendes `</h1>`. Gemeinsam anschauen, was passiert. Dann reparieren.

Botschaft: Kaputtmachen ist erlaubt, es geht nichts verloren, und die Anwendung sagt einem meistens, wo das Problem liegt.

## Praxisteil

- [ ] Container betreten, Anwendung starten
- [ ] Eigenen Namen in die Überschrift schreiben
- [ ] Drei weitere Änderungen selbst wählen und umsetzen
- [ ] Einen Fehler einbauen, finden und beheben

## Typische Stolpersteine

> [!warning]
> - **Weißes Fenster.** Bekanntes Problem der Grafikausgabe. Sollte durch die Vorbereitung erledigt sein. Falls doch: `with-env { WEBKIT_DISABLE_DMABUF_RENDERER: "1" } { cargo tauri dev }`
> - **Nichts ändert sich.** Meist wurde nicht gespeichert oder die falsche Datei geändert.
> - **Erster Start dauert.** Vorher ansagen, sonst wirkt es wie ein Absturz.

## Verknüpfung

Weiter mit [[K1 HTML – die Struktur]] · [[Anhang Befehlskarte]] · zurück zu [[00 Kompaktkonzept Tauri Grundlagen]]

---
typ: anhang
title: Vorbereitung durch die Kursleitung
tags: [tauri/kompaktkurs/anhang, vorbereitung]
status: draft
---

# Anhang – Vorbereitung durch die Kursleitung

> [!danger] Ohne diese Vorbereitung trägt der Zeitplan nicht
> Alles hier Genannte muss vor dem ersten Kurstag fertig und auf allen drei Geräten getestet sein. Der Kurs beginnt mit einer laufenden Anwendung, nicht mit einer Installation.

## 1. Umgebung je Gerät

Vollständiger Durchlauf des Leitfadens [[Von der leeren Toolbx zur installierten Flatpak-App]], Phasen 0 und 1, plus:

```nu
# dauerhaft im if-Block aus Leitfaden-Abschnitt 9 ergänzen
$env.WEBKIT_DISABLE_DMABUF_RENDERER = "1"
```

Damit ist das weiße Fenster am ersten Tag ausgeschlossen.

Prüfliste je Gerät:

- [ ] Nushell ist Login-Shell, funktioniert auf Host und im Container
- [ ] Container `tauri-dev` existiert, `cargo tauri --version` antwortet
- [ ] `org.flatpak.Builder`, `org.gnome.Sdk`, `org.gnome.Platform` und die Rust-Erweiterung installiert
- [ ] Projekt `~/Projekte/lernkarten` liegt im Ausgangszustand
- [ ] Ein vollständiger Probelauf inklusive Flatpak-Bau wurde durchgeführt

## 2. Projekt im Ausgangszustand

```
~/Projekte/lernkarten/
├── src/
│   ├── index.html          leer bis auf Grundgerüst
│   ├── style.css           leer
│   └── app.js              leer
├── src-tauri/
│   ├── src/main.rs         VOLLSTÄNDIG vorbereitet
│   ├── Cargo.toml          mit [[bin]]-Block
│   └── tauri.conf.json     withGlobalTauri: true
├── de.metarow.Lernkarten.desktop
├── de.metarow.Lernkarten.metainfo.xml
└── de.metarow.Lernkarten.yml
```

`index.html` enthält nur Grundgerüst, Einbindung von `style.css` und `app.js` am Ende des `<body>`, und eine Überschrift. Mehr nicht.

> [!important] Skript am Ende des Body
> Damit `document.querySelector` in [[K4 JavaScript im Fenster]] funktioniert, muss `<script src="app.js"></script>` **hinter** dem Inhalt stehen. Das ist vorbereitet und wird im Kurs nicht thematisiert.

## 3. Die vorbereiteten Rust-Commands

`src-tauri/src/main.rs` enthält zwei Funktionen, die in [[K5 Daten behalten]] gemeinsam gelesen werden. Anforderungen an die Umsetzung:

- `karten_speichern(karten)` schreibt die Liste als JSON in `lernkarten.json` im Anwendungsdatenordner
- `karten_laden()` liest die Datei und gibt die Liste zurück; fehlt die Datei, gibt sie eine leere Liste zurück
- Beide Funktionen sind kurz und lesbar, ohne Fehlerbehandlung, die vom Wesentlichen ablenkt
- Deutsche Funktionsnamen, damit der Bezug zum Aufruf im Frontend offensichtlich ist

> [!note] Warum nicht das FS-Plugin?
> Die Tauri-Plugins liegen als npm-Pakete vor und brauchen einen Bundler. Der Kurs kommt ohne Node aus. Zwei vorbereitete Rust-Commands sind der einfachere und für die Teilnehmenden verständlichere Weg.

## 4. Zwischenstände

Für jeden Baustein ein fertiger Stand als Ordner oder Git-Tag:

| Stand | Inhalt |
|---|---|
| `stand-k1` | HTML vollständig, CSS und JS leer |
| `stand-k2` | zusätzlich CSS vollständig |
| `stand-k3` | zusätzlich Datenbestand in `app.js`, noch ohne DOM |
| `stand-k4` | zusätzlich funktionierende Oberfläche |
| `stand-k5` | zusätzlich Speichern und Laden |
| `stand-k6` | Referenzfassung mit Gestaltung |

Zweck: Wenn eine Person durch einen Tippfehler blockiert ist, wird nicht gesucht, sondern der Stand kopiert. Bei drei Personen darf niemand zwanzig Minuten stillstehen.

## 5. Material auf dem Tisch

- [ ] [[Anhang Befehlskarte]] gedruckt, je Person ein Exemplar
- [ ] Liste der `id`-Namen aus [[K1 HTML – die Struktur]] als Vorlage zum Ausfüllen
- [ ] Notizheft je Person, Papier, nicht digital
- [ ] Farbwähler oder ausgedruckte Hex-Palette für [[K2 CSS – das Aussehen]]

## 6. Zeitpuffer

Der Plan enthält keinen Leerlauf. Puffer entsteht ausschließlich aus:

- [[K6 Feinschliff]] kann von 2 auf 1 UE gekürzt werden
- die Zusatzaufgaben sind optional und werden nur bei Vorsprung ausgegeben

Reicht das nicht, wird [[K7 Als Anwendung ausliefern]] auf eine reine Vorführung durch die Kursleitung verkürzt. Das kostet den Höhepunkt des Kurses und ist deshalb die letzte Reserve.

## Verknüpfung

[[00 Kompaktkonzept Tauri Grundlagen]] · [[Von der leeren Toolbx zur installierten Flatpak-App]]

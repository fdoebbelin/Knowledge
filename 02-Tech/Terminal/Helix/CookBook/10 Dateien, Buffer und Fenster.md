---
title: "Helix-Cookbook – Kapitel 10: Dateien, Buffer und Fenster"
aliases:
  - Helix Cookbook Dateien Buffer Fenster
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]]. Fenster-Aufteilung mit Grafik: [[01-Leitfaden zum Spickzettel#8 Fenster und Ansicht]]. Sprungliste (Lesezeichen-Ersatz): [[01 Navigation und Sprünge#1.12 Zurück zu früheren Positionen (Sprungliste)]].

## Picker (`Space`)

Picker sind durchsuchbare Listen mit Unschärfesuche: Einfach ein paar Buchstaben tippen.

| Befehl | Picker |
|---|---|
| `Space f` / `Space F` | Dateien (Projekt / aktuelles Verzeichnis) |
| `Space b` | offene Buffer |
| `Space j` | Jumplist |
| `Space '` | letzten Picker wieder öffnen |
| `Space ?` | Befehlspalette |

| Im Picker | Wirkung |
|---|---|
| `↑` `↓` | Eintrag wählen |
| `⏎` | öffnen |
| `Strg-v` / `Strg-s` | senkrecht / waagerecht geteilt öffnen |
| `Strg-t` | Vorschau ein / aus |
| `Esc` | schließen |

## Dateien und Buffer

| Befehl | Wirkung |
|---|---|
| `:w` / `:w pfad` | speichern / speichern unter |
| `:wa` | alle Buffer speichern |
| `:u` | nur speichern, wenn geändert |
| `:q` / `:q!` | beenden / ohne Speichern beenden |
| `:wq` = `:x`, `:wqa` = `:xa` | speichern und beenden (eine / alle Dateien) |
| `:o datei` | Datei öffnen |
| `:reload` / `:reload-all` | Änderungen verwerfen, neu von der Platte laden |
| `:bc` / `:bco` / `:bca` | Buffer schließen / alle anderen / alle |
| `gn` / `gp` | nächster / voriger Buffer |

> [!note] Das Ausrufezeichen
> Ein `!` am Ende erzwingt den Befehl trotz ungespeicherter Änderungen: `:q!`, `:bc!`, `:wqa!`.

## Fenster (Splits)

Grafik und Erklärung der Richtungstasten: [[01-Leitfaden zum Spickzettel#8 Fenster und Ansicht]]. Kurzreferenz:

| Befehl | Wirkung |
|---|---|
| `Strg-w v` / `Strg-w s` | senkrecht / waagerecht teilen |
| `Strg-w q` | Fenster schließen |
| `Strg-w o` | alle anderen Fenster schließen |
| `:vs datei` / `:hs datei` | Datei in senkrechtem / waagerechtem Split öffnen |
| `:vnew` / `:hnew` | leeren Buffer im Split öffnen |

## Konfiguration zur Laufzeit

| Befehl | Wirkung |
|---|---|
| `:theme name` | Farbschema wechseln (Tab zeigt Vorschläge) |
| `:set option wert` / `:get option` | Option setzen / anzeigen |
| `:toggle option` | Wahrheitswert umschalten, z. B. `:toggle soft-wrap.enable` |
| `:lang sprache` | Sprache des Buffers festlegen |
| `:config-open` / `:config-reload` | `config.toml` öffnen / neu laden |
| `:config-open-workspace` | `.helix/config.toml` im Projekt öffnen |
| `:cd` / `:pwd` | Arbeitsverzeichnis wechseln / anzeigen |

Nützliche Einzelbefehle: `:char` (Unicode-Infos zum Zeichen), `:encoding` (Kodierung), `:diffg` (Git-Änderung an der Cursorposition zurücksetzen).

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Fenster-Grafik, Ansicht mit z/Z
- [[01 Navigation und Sprünge]] – Sprungliste, Ctrl-o/Ctrl-i
- [[08 Shell-Integration]] – weitere Befehlsmodus-Kommandos rund um Shell-Pipes

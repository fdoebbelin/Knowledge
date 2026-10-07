---
title: Yazi – Einführung
aliases:
  - Yazi Konzept
  - Yazi Übersicht
  - Was ist Yazi
  - Yazi – Einführung
tags:
  - yazi
  - terminal
  - dateimanager
created: 2026-09-30
status: active
---

# Yazi – Einführung

Yazi ist ein Terminal-Dateimanager, in Rust geschrieben, mit vollständig **asynchroner** Vorschau (Kopieren oder ein großes Verzeichnis blockieren die Oberfläche nie), nativer Bildanzeige über Kitty-Graphics/Sixel/iTerm2 und einem eigenen Lua-Plugin-System. Im Geiste ein Nachfolger von `ranger` und `lf`, aber mit dem Ziel, auch bei tausenden Dateien flüssig zu bleiben.

> [!info] Diese Notiz ist die Kurzfassung
> Sie erklärt nur das **Konzept** – wie Yazi zu denken ist, nicht jede Taste. Für die Einrichtung: [[03-Installation und Konfiguration]]. Für alle Befehle mit Grafiken: [[02-Leitfaden zum Spickzettel]].

## Das Bedienkonzept: erst Auswahl, dann Aktion

Wie bei [[Helix-Leitfaden|Helix]] gilt: **erst wird ausgewählt, dann gehandelt.** `Space` markiert Dateien, danach wirkt eine Aktion (`y` kopieren, `d` löschen, `r` umbenennen …) auf **alle** markierten Dateien. Ist nichts markiert, gilt die Datei unter dem Cursor. Man sieht also immer vorher, was eine Aktion betreffen wird, statt es hinterher zu erraten.

## Die Oberfläche: drei Spalten

Yazi zeigt gleichzeitig drei sogenannte *Miller Columns*: links das Elternverzeichnis, in der Mitte der Inhalt des aktuellen Verzeichnisses (hier steht der Cursor, hier wirken Aktionen), rechts eine Vorschau der Datei unter dem Cursor – bei Markdown, Bildern, Archiven und vielem mehr gerendert statt roh. `h`/`l` bewegen zwischen den Spalten, `j`/`k` innerhalb einer Spalte nach oben und unten. Eine Statuszeile unten zeigt Modus, Dateiname, Rechte und Position in der Liste.

## Tabs statt mehrerer Fenster

Ein Tab ist ein eigenes Verzeichnis mit eigenem Cursor und eigener Auswahl. Mehrere Tabs ersetzen das Öffnen mehrerer Terminal-Fenster: Datei in Tab 1 vormerken (`y`/`x`), zu Tab 2 wechseln, einfügen (`p`) – die Vormerkung bleibt beim Tabwechsel erhalten. Damit lassen sich weit auseinanderliegende Verzeichnisse verbinden, ohne ständig hin- und herzunavigieren.

## Erweiterbar über Plugins

Yazi selbst kann wenig mehr als Navigieren, Auswählen und Dateioperationen. Alles, was darüber hinausgeht – Markdown-Vorschau mit Farbe, Mermaid-Diagramme als Bild, Git-Status in der Liste, Rechte ändern per Tastenkürzel – kommt über **Plugins**, die mit dem eingebauten Paketmanager `ya pkg` installiert werden. Das hält den Kern schlank und lässt jeden das Werkzeug auf die eigenen Bedürfnisse zuschneiden. Details: [[03-Installation und Konfiguration#5 Das Plugin-System]].

## Konfiguration nur für Abweichungen

Yazi liest seine Einstellungen aus TOML-Dateien in `~/.config/yazi/`. Keine davon ist Pflicht – nur eingetragen wird, was von der Standardkonfiguration abweichen soll, den Rest liefert Yazi selbst. Das hält eigene Konfigurationen klein und robust gegenüber neuen Yazi-Versionen, die neue Standardwerte mitbringen.

## Wie es weitergeht

| Frage | Notiz |
|---|---|
| Wie installiere und richte ich Yazi ein? | [[03-Installation und Konfiguration]] |
| Welche Taste macht was? | [[02-Leitfaden zum Spickzettel]] |
| Ich will direkt loslegen | `~` oder `F1` in Yazi zeigt alle Tastenbelegungen der installierten Version |

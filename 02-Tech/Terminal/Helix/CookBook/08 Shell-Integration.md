---
title: "Helix-Cookbook – Kapitel 8: Shell-Integration"
aliases:
  - Helix Cookbook Shell-Integration
tags:
  - helix
  - editor
  - cookbook
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]].

Shell-Befehle arbeiten wie Mehrfachauswahl (siehe [[05 Mehrfachauswahl]]): **jede Auswahl** wird einzeln an den Befehl übergeben und einzeln durch dessen Ausgabe ersetzt oder ergänzt. Das macht Konfigurationsdateien und Tabellen elegant bearbeitbar, ohne den Editor zu verlassen.

| Befehl | Eingabe | Ergebnis |
|---|---|---|
| `\|` | Auswahl → Befehl | Ausgabe **ersetzt** die Auswahl |
| `Alt-\|` | Auswahl → Befehl | Ausgabe wird verworfen |
| `!` | nur Befehl | Ausgabe **vor** der Auswahl einfügen |
| `Alt-!` | nur Befehl | Ausgabe **nach** der Auswahl einfügen |
| `$` | Auswahl → Befehl | nur Auswahlen **behalten**, bei denen der Befehl Exit-Code 0 liefert |

> [!example] Praxisbeispiele
> - Zeilen sortieren: `x` `x` `x` `|` `sort` `⏎`
> - Datum einfügen: `!` `date +%F` `⏎`
> - JSON formatieren: `%` `|` `jq .` `⏎`
> - Nur Zeilen mit Zahlen behalten: Zeilen mit `x` … wählen, `Alt-s` (siehe [[05 Mehrfachauswahl]]), dann `$` `grep -q '[0-9]'` `⏎`
> - Spalten ausrichten: `%` `|` `column -t` `⏎`

Weitere Befehlsmodus-Varianten: `:sh befehl` (ausführen, Ausgabe im Popup statt im Puffer), `:pipe` (wie `|`), `:pipe-to` (wie `Alt-|`), `:insert-output`/`:append-output` (wie `!`/`Alt-!`), `:cd`/`:pwd` (Arbeitsverzeichnis wechseln/anzeigen).

> [!note] Welche Shell?
> Das Kommando läuft über die System-Shell (unter Linux die Login-Shell, unter Windows PowerShell/`cmd`). Unter Nushell entsprechend anpassen, z. B. `sort` → `sort` funktioniert, `column -t` aber nicht ohne Weiteres – dort eher `:pipe` mit einem externen `^`-Aufruf nutzen.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[05 Mehrfachauswahl]] – dieselbe „jede Auswahl einzeln“-Logik
- [[10 Dateien, Buffer und Fenster]] – `:cd`, `:pwd` und weitere Befehlsmodus-Kommandos
- [[sudoedit]] – Helix als `$SUDO_EDITOR`, verwandtes Shell-Thema

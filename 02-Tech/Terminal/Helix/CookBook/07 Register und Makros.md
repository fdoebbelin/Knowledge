---
title: "Helix-Cookbook – Kapitel 7: Register und Makros"
aliases:
  - Helix Cookbook Register und Makros
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

## Register

Register sind benannte Zwischenablagen – eine Erweiterung von `y`/`p` aus [[02 Auswahl-Grundlagen]]. Man wählt sie mit `"` und einem Buchstaben, **bevor** man die Aktion auslöst.

| Befehl | Wirkung |
|---|---|
| `"ay` | Auswahl in Register `a` kopieren |
| `"ap` | Register `a` einfügen |
| `"ad` / `"ac` | in `a` speichern, dann löschen / ändern |
| `"_d` | löschen ins „Nichts“ – kein Register wird überschrieben |

| Spezialregister | Inhalt |
|---|---|
| `/` | letzte Suche |
| `:` | letzter Befehl |
| `"` | letzte Kopie (Standard) |
| `_` | Black Hole – schluckt alles |
| `+` / `*` | System-Zwischenablage / Primary Selection (X11, Wayland) |
| `%` | Name der aktuellen Datei |
| `#` | Nummer der jeweiligen Auswahl (1, 2, 3 …) |

> [!example] Nummerierung mit `#`
> Mit mehreren Cursorn (siehe [[05 Mehrfachauswahl]]) fügt `"#p` bei jedem Cursor seine laufende Nummer ein – praktisch für Listen oder Testdaten.

## Makros

| Befehl | Wirkung |
|---|---|
| `Q` | Makro-Aufnahme starten / stoppen |
| `q` | Makro abspielen (`5q` = fünfmal) |
| `"aQ` / `"aq` | Makro in Register `a` aufnehmen / aus `a` abspielen |

> [!warning] Vertauscht gegenüber Vim
> In Vim nimmt `q` auf und `@a` spielt ab. In Helix ist es umgekehrt: `Q` nimmt auf, `q` spielt ab.

> [!tip] Makro oder Mehrfach-Cursor?
> Was in allen Zeilen **gleich** passiert, geht mit Mehrfach-Cursor (siehe [[05 Mehrfachauswahl]]) meist schneller. Makros lohnen sich, wenn jede Stelle erst **gesucht** werden muss oder der Ablauf zu unregelmäßig für eine Regex ist.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[02 Auswahl-Grundlagen]] – das Standardregister bei `y`/`p`
- [[05 Mehrfachauswahl]] – Alternative zu Makros für gleichförmige Änderungen
- [[08 Shell-Integration]] – Auswahl statt Register durch ein Programm schicken

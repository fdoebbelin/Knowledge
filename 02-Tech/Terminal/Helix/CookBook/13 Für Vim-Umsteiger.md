---
title: "Helix-Cookbook – Kapitel 13: Für Vim-Umsteiger"
aliases:
  - Helix Cookbook Vim-Umsteiger
  - Migrating from Vim
tags:
  - helix
  - editor
  - cookbook
  - vim
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Übersicht aller Kapitel: [[02-Cookbook|Helix-Cookbook]].

Helix ist von Vim (und Kakoune) inspiriert, die Tastenbelegung ähnelt sich – aber das Auswahl-→-Aktion-Prinzip dreht die Reihenfolge um: in Vim erst Aktion, dann Ziel (`dw`), in Helix erst Ziel, dann Aktion (`wd`). Die folgende Tabelle übersetzt die typischen Vim-Reflexe.

| Aufgabe | Vim | Helix |
|---|---|---|
| Wort löschen | `dw` | `wd` |
| Wort ändern | `cw` | `wc` (oder `miwc`) |
| Zeichen löschen | `x` | `d` oder `;d` |
| Zeile löschen | `dd` | `xd` |
| Zeile kopieren | `yy` | `Xy` (`X` erweitert auf ganze Zeilen) |
| bis Zeilenende löschen | `D` | `vgld` oder `t⏎d` |
| ans Zeilenende | `$` | `gl` |
| an den Zeilenanfang | `0` / `^` | `gh` / `gs` |
| Dateianfang / -ende | `gg` / `G` | `gg` / `ge` |
| zu Zeile 10 | `10G` | `10G` *(gleich)* |
| Wiederherstellen | `Strg-r` | `U` |
| alles ersetzen | `:%s/a/b/g` | `%` `s` `a` `⏎` `c` `b` `Esc` |
| nur in der Auswahl ersetzen | `:s/foo/bar/g` | `s` `foo` `⏎` `c` `bar` `Esc` `,` |
| passende Klammer | `%` | `mm` |
| ganze Datei wählen | `ggVG` | `%` |
| Visual-Modus | `v` | `v` *(erweitert statt ersetzt)* |
| Blockauswahl | `Strg-v` + Bewegung | kein Block-Modus, siehe [[05 Mehrfachauswahl#Rezept: Blockauswahl simulieren]] |
| umschließen (Plugin `vim-surround`) | `ysiw"` | `miw` `ms"` – kein Plugin nötig, siehe [[01-Leitfaden zum Spickzettel#7 Match & Surround]] |
| Kommentar an/aus | `gc` | `Ctrl-c` |
| Autovervollständigung | `Strg-p` | `Strg-x` |
| Makro aufnehmen/abspielen | `qa … q` / `@a` | `Qa … Q` / `q` – **vertauscht!** |
| Datei neu laden | `:e⏎` | `:reload` (`:reload-all` für alle Buffer) |
| Shell-Befehl ausführen | `:!befehl` | `:sh befehl` (oder `!befehl` fügt Ausgabe ein) |
| Lesezeichen setzen/springen | `ma` … `` `a `` | keine benannten Marken – `Ctrl-s` merkt die Position, `Space j` öffnet die Liste, siehe [[01 Navigation und Sprünge#1.12 Zurück zu früheren Positionen (Sprungliste)]] |

> [!warning] Die drei klassischen Stolperfallen
> - `U` ist **Redo**, nicht Rückgängig – Rückgängig ist `u`, wie gewohnt.
> - `%` wählt die **ganze Datei** aus, nicht den Sprung zur passenden Klammer – der heißt in Helix `mm`.
> - Makros sind **vertauscht**: `Q` nimmt auf, `q` spielt ab.

## Wort unter dem Cursor suchen

Vim: `*`. In Helix braucht es zwei Schritte, weil erst eine Auswahl stehen muss:

> [!example] `A-o * n` oder `be * n`
> - Mit Tree-sitter-Grammatik oder Language Server: `Alt-o` erweitert die Auswahl auf den umschließenden Syntaxknoten (das ganze Wort als Bezeichner), `*` übernimmt es als Suchmuster, `n` springt zum nächsten Vorkommen.
> - Ohne Grammatik: `b` `e` wählt das Wort zeichenweise, Rest wie oben.
>
> Siehe auch [[02 Auswahl-Grundlagen#Entlang des Syntaxbaums auswählen ●]].

## Was in Helix anders ist, nicht nur anders heißt

- **Bewegung im Einfügemodus:** Helix erlaubt eingeschränkte Cursorbewegung im Einfügemodus, ohne in den Normalmodus zu wechseln (Pfeiltasten, Bild hoch/runter) – in Vim meist unüblich.
- **Cursor-Form:** Anders als Vim zeigt Helix standardmäßig im Einfüge- **und** im Normalmodus denselben Block-Cursor. Umstellbar in `config.toml`, siehe [[03-Installation]].
- **`f`/`t` über Zeilengrenzen:** In Vim enden `f`/`t`/`F`/`T` am Zeilenende, in Helix suchen sie über Zeilenumbrüche hinweg.

## Verwandt

- [[02-Cookbook|Helix-Cookbook]] – Übersicht aller Kapitel, Lernpfad und Übungsdatei
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Grundprinzip Auswahl → Aktion
- [[05 Mehrfachauswahl]] – Blockauswahl-Ersatz mit `C`
- [[01 Navigation und Sprünge]] – Sprungliste statt benannter Marken
- Quelle: <https://github.com/helix-editor/helix/wiki/Migrating-from-Vim>

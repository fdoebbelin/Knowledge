---
title: "Helix – Installation und Konfiguration"
aliases:
  - Helix Installation
tags:
  - helix
  - editor
  - terminal
created: 2026-10-13
status: active
type: anleitung
---

> [!info] Zum Cookbook
> Bedienkonzept und Befehle: [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]], [[02-Cookbook|Helix-Cookbook]].

## Windows (Scoop)

```powershell
scoop install helix
hx --health            # Runtime, Clipboard, allgemeiner Status
hx --health python     # zeigt, ob der Language-Server für Python gefunden wird
hx --tutor             # eingebautes Grundkurs-Tutorial
```

> [!tip] Übungsdatei anlegen
> Lege dir eine `uebung.txt` (oder `.py`, `.md`) an und öffne sie mit `hx uebung.txt`. Die Cookbook-Übungsdatei dafür steht in [[02-Cookbook|Helix-Cookbook]]. Verwerfen mit `:q!`.

> [!info] Konfig- und Runtime-Pfad unter Windows
> Konfiguration liegt unter `%AppData%\helix\` (also `C:\Users\<Name>\AppData\Roaming\helix\`). Die Runtime von Scoop findest du unter `%USERPROFILE%\scoop\apps\helix\current\runtime`. Falls `hx --health` „Runtime directory does not exist“ meldet, setze `HELIX_RUNTIME` auf diesen Pfad.

## Windows aus dem Quelltext bauen

Für Windows on ARM oder wenn Scoop kein aktuelles Paket hat: [[Helix aus Quelltext bauen (Windows on ARM, PowerShell)]].

## Linux

> [!todo] Noch nicht dokumentiert
> Für dieses Vault liegt bisher keine verifizierte Linux-Installationsanleitung für Helix vor (anders als bei Yazi, siehe [[03-Installation und Konfiguration]], wo der Homebrew-Weg getestet dokumentiert ist). Üblich sind `rpm-ostree install helix` auf Fedora Atomic, `dnf install helix`/`apt install helix` auf klassischen Distributionen, oder `cargo install helix-term`. Vor Übernahme ins Vault auf dem Referenzsystem prüfen und mit `hx --version` verifizieren.

## Start-Konfiguration

Eine Datei genügt. Unter Windows: `%AppData%\helix\config.toml`; unter Linux: `~/.config/helix/config.toml` (öffnen mit `:config-open`, siehe [[10 Dateien, Buffer und Fenster]]).

```toml
theme = "default"

[editor]
line-number = "relative"   # gut zum Springen mit z. B. 5j / 7k
cursorline = true
bufferline = "multiple"    # offene Buffer als Leiste oben
color-modes = true         # Modus per Farbe erkennbar
true-color = true

[editor.statusline]
left  = ["mode", "spinner", "file-name", "file-modification-indicator"]
right = ["diagnostics", "position", "file-encoding"]

[editor.cursor-shape]
insert = "bar"
normal = "block"
select = "underline"

[editor.lsp]
display-messages = true
display-inlay-hints = true

[editor.file-picker]
hidden = false             # versteckte Dateien im Picker zeigen
```

> [!info] Sprachspezifisches
> Formatter, Language-Server und Einrückung pro Sprache regelst du in `languages.toml` (gleicher Ordner wie `config.toml`). `hx --health <sprache>` sagt dir, was noch fehlt.

> [!note] Cursor-Form
> Anders als Vim zeigt Helix standardmäßig im Einfüge- **und** im Normalmodus denselben Block-Cursor. `[editor.cursor-shape]` wie oben stellt das um.

## Verwandt

- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Bedienkonzept an den Spickzettel-Grafiken
- [[02-Cookbook|Helix-Cookbook]] – Befehlsreferenz als Rezepte
- [[Helix aus Quelltext bauen (Windows on ARM, PowerShell)]] – Build-Anleitung im Detail
- [[sudoedit]] – Helix als `$SUDO_EDITOR`
- [[Nushell Editor setzen]] – Helix als `$EDITOR` unter Nushell

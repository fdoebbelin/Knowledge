---
title: Nushell
aliases:
  - nu
tags:
  - nushell
  - terminal
  - shell
created: 2026-09-22
updated: 2026-09-22
status: draft
---

# Nushell

Struktur-orientierte Shell in Rust: Befehle geben Tabellen statt Text zurück, die sich mit `where`, `select`, `get` und `each` weiterverarbeiten lassen. Standard-Shell auf den hier dokumentierten Systemen; alle Konsolenbefehle in den Leitfäden dieses Vaults sind in Nushell-Syntax geschrieben.

> [!note] Stichwortnotiz
> Einstieg in das Thema. Die Inhalte stehen in den verlinkten Notizen, dieser Ordner ist der Sammelpunkt.

## Eigenheiten, die immer wieder auffallen

- **`^befehl`** ruft ausdrücklich das externe Programm auf, nicht eine gleichnamige Funktion.
- **`def --env`** ist nötig, wenn eine Funktion das Verzeichnis der aufrufenden Shell ändern soll, z. B. beim Yazi-Wrapper `y`.
- **Hooks** laufen nur in interaktiven Sitzungen, nicht bei `nu -c`.
- **`open`** liest TOML, JSON und YAML direkt als Tabelle ein und eignet sich zum Prüfen von Konfigurationsdateien.
- **Autoload:** Dateien in `~/.local/share/nushell/vendor/autoload/` werden bei jedem Start geladen, ohne die `config.nu` anzufassen.

## Notizen in diesem Ordner

- [[00 config.nu]] – Konfiguration
- [[01 Nushell idiomatisch verwenden]] – Denkweise und Muster
- [[Benutzer Kommandos]] – eigene Befehle
- [[Nushell Editor setzen]] – `$env.EDITOR`, Helix
- [[00 Installationsleitfaden für Windows]]

## Verwandt

- [[Yazi – kommentierter Leitfaden]] – Shell-Wrapper `y`, Nushell als Shell in Yazi
- [[00 Werkzeuge ins HOME-Verzeichnis installieren]] – warum `nu` unter `~/.local/bin` liegt

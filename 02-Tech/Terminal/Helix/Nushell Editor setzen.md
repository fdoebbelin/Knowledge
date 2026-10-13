---
title: "Helix als Editor in Nushell setzen"
aliases:
  - Nushell Editor setzen
tags:
  - helix
  - nushell
  - terminal
created: 2026-10-13
status: active
type: anleitung
---

Henne-Ei-Moment: Die Konfiguration soll mit Helix geöffnet werden, aber Nushell weiß noch nicht, dass `hx` der gewählte Editor ist. `config env`/`config nu` scheitern deshalb zunächst am fehlenden Editor-Link. Lösung: die Nushell-Befehle direkt verwenden, dann dauerhaft eintragen.

> [!warning] Programmname ist `hx`, nicht `helix`
> Helix heißt als ausführbares Programm `hx` – auch wenn das Projekt selbst „Helix“ heißt. `helix …` als Befehl existiert nicht, außer man hat selbst einen Alias angelegt.

## 1. Editor in der Umgebung setzen

Öffnet `env.nu` (dort gehören Umgebungsvariablen hin) direkt mit Helix, indem der Programmname vorangestellt wird:

```nu
hx $nu.env-path
```

Am Ende der Datei ergänzen:

```nu
$env.EDITOR = "hx"
$env.VISUAL = "hx"
```

Speichern und schließen: `Esc`, `:wq`, `Enter`.

## 2. Buffer-Editor in der Config setzen

Nushell hat eine eigene Einstellung für den Editor, der bei Tastenkombinationen (z. B. Mehrzeilen-Bearbeitung) genutzt wird:

```nu
hx $nu.config-path
```

In der Datei nach `buffer_editor` suchen (oder ans Ende scrollen) und ergänzen:

```nu
$env.config = ($env.config | upsert buffer_editor "hx")
```

Wieder speichern und schließen: `Esc`, `:wq`, `Enter`.

## 3. Aktivieren

Damit die Änderungen sofort greifen, ohne das Terminal neu zu starten:

```nu
exec nu
```

`config env` bzw. `config nu` öffnen die jeweilige Datei jetzt direkt in Helix.

> [!tip] Unter Windows
> Meldet Windows, dass es `hx` nicht findet: einmal ein neues Terminal öffnen, damit der PATH nach der Installation aktualisiert ist (siehe [[03-Installation]]). Hilft das nicht, den vollständigen Pfad statt `"hx"` eintragen, z. B. `"C:\Program Files\Helix\hx.exe"`.

## Verwandt

- [[03-Installation]] – Helix installieren
- [[sudoedit]] – Helix als `$SUDO_EDITOR`
- [[01-Leitfaden zum Spickzettel|Helix-Leitfaden]] – Bedienung

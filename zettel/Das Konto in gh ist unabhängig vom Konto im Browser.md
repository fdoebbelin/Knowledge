---
id: 202611281433
title: Das Konto in gh ist unabhängig vom Konto im Browser
type: zettel
tags:
  - git/github
created: 2026-11-28
herkunft: 02-Tech/Git/Arbeitsblatt-GitHub-CLI-gh.md
---

Welches GitHub-Konto im Browser gerade aktiv ist, hat keinen Einfluss auf die Kommandozeile. Die GitHub CLI `gh` führt ihre eigene Liste angemeldeter Konten. Je Host ist eines davon **aktiv**. Nutzt Git `gh` als Credential-Helper, entscheidet dieses Konto auch darüber, womit ein Push über HTTPS angemeldet wird.

Typisch ist dieser Fall: Im Browser ist Konto B ausgewählt, in `gh` noch Konto A. Ein Push in ein Repository, auf das nur B zugreifen darf, endet dann so:

```text
remote: Permission to KONTO-B/projekt.git denied to KONTO-A.
fatal: unable to access '...': The requested URL returned error: 403
```

Die Meldung nennt das Konto, mit dem Git sich angemeldet hat. Neu zu klonen ist nicht nötig, man wechselt nur das Konto:

```bash
gh auth login                    # weiteres Konto hinzufügen
gh auth status                   # Konten und aktives Konto anzeigen
gh auth switch                   # aktives Konto wechseln
gh auth switch --user KONTO-B    # gezielt wechseln
```

Sind auf dem Host genau zwei Konten angemeldet, wechselt `gh auth switch` ohne Rückfrage zum anderen. Bei mehr Konten fragt es nach, oder man gibt das Ziel mit `--user` an.

Auch ein privates Repository, das sich trotz richtiger Adresse nicht klonen lässt, ist ein Anlass, zuerst das aktive Konto zu prüfen. Bei Remotes über SSH entscheidet dagegen der SSH-Schlüssel, nicht `gh`.

## Verbindungen

- [[gh liefert Git das Token für HTTPS]] – der Mechanismus, über den das aktive Konto bei Git ankommt
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- GitHub-CLI-Handbuch: [gh auth switch](https://cli.github.com/manual/gh_auth_switch)

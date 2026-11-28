---
id: 202611281434
title: gh repo create bringt ein lokales Repository zu GitHub
type: zettel
tags:
  - git/github
created: 2026-11-28
herkunft: 02-Tech/Git/Arbeitsblatt-GitHub-CLI-gh.md
---

Für ein Projekt, das schon lokal unter Git steht, muss man nicht erst im Browser ein Repository anlegen. Ein Befehl im Projektordner legt es auf GitHub an, verbindet beide und lädt die Commits hoch:

```bash
gh repo create mein-werkzeug --private --source=. --remote=origin --push
```

| Option | Wirkung |
|---|---|
| `--private` | Sichtbarkeit, alternativ `--public` oder `--internal` |
| `--source=.` | dieses lokale Repository ist die Quelle |
| `--remote=origin` | Name des neuen Remotes |
| `--push` | lädt die lokalen Commits hoch |

Ohne Argumente fragt `gh repo create` die Angaben interaktiv ab. Von Hand sind es mehrere Schritte: das leere Repository anlegen, `git remote add origin <URL>` und `git push -u origin main`. Gibt es schon ein Remote namens `origin`, muss man es vorher ändern oder entfernen oder für das neue einen anderen Namen wählen.

## Vor dem ersten Push

Mit `--push` geht die vorhandene Historie sofort hinaus. Vorher gehört geprüft, ob darin Zugangsdaten, Tokens, `.env`-Dateien oder personenbezogene Daten stecken, besonders bei `--public`. Eine passende `.gitignore` liefert `gh` als Vorlage:

```bash
gh repo gitignore list
gh repo gitignore view Python > .gitignore
```

Der zweite Befehl überschreibt eine vorhandene `.gitignore`. Außerdem wirkt die Datei nicht rückwirkend auf bereits Committetes.

## Verbindungen

- [[Ein gepushtes Geheimnis muss man austauschen]] – was folgt, wenn die Prüfung vor dem Push ausbleibt
- [[Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern]] – wie man vor dem Push prüft
- [[gh liefert Git das Token für HTTPS]] – damit der Push ohne Passwortabfrage läuft
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- GitHub-CLI-Handbuch: [gh repo create](https://cli.github.com/manual/gh_repo_create)

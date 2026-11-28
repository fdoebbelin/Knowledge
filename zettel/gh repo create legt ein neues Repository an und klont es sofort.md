---
id: 202611281453
title: gh repo create legt ein neues Repository an und klont es sofort
type: zettel
tags:
  - git/github
created: 2026-11-28
---

Beginnt ein Projekt erst, kann man es zuerst auf GitHub anlegen und von dort auf den Rechner holen. Mit der GitHub CLI `gh` ist das ein Befehl. Er wird in dem Ordner ausgeführt, unter dem der Klon entstehen soll:

```bash
gh repo create mein-projekt --private --add-readme --clone
```

| Option | Wirkung |
|---|---|
| `--private` | Sichtbarkeit, alternativ `--public` oder `--internal` |
| `--add-readme` | das neue Repository bekommt eine README-Datei |
| `--clone` | klont es in einen Unterordner des aktuellen Verzeichnisses |

Durch die README hat das Repository sofort einen ersten Commit und einen Standardbranch. Der Klon ist also nicht leer, und man kann gleich darin arbeiten. Eine Beschreibung gibt man mit `--description` mit.

## Ergebnis prüfen

Im Ordner des Klons lässt sich nachsehen, was angelegt wurde:

```bash
gh repo view --json name,visibility,defaultBranchRef
```

Mit `--json` gibt `gh repo view` statt Beschreibung und README nur die genannten Felder als JSON aus. Das eignet sich, um vor dem ersten Inhalt die Sichtbarkeit zu kontrollieren: Bei einem privaten Repository steht unter `visibility` der Wert `PRIVATE`.

## Verbindungen

- [[gh repo create bringt ein lokales Repository zu GitHub]] – derselbe Befehl für ein Projekt, das lokal schon existiert
- [[gh repo clone richtet bei Forks ein upstream-Remote ein]] – so kommt das Repository später auf weitere Rechner
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- [[Anleitung zum Aufbau einer Poststelle für Projektdateien]]
- GitHub-CLI-Handbuch: [gh repo create](https://cli.github.com/manual/gh_repo_create)

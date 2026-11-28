---
id: 202611281435
title: gh repo clone richtet bei Forks ein upstream-Remote ein
type: zettel
tags:
  - git/github
created: 2026-11-28
herkunft: 02-Tech/Git/Arbeitsblatt-GitHub-CLI-gh.md
---

`gh repo clone` klont ein GitHub-Repository und kennt dabei Zusammenhänge, die `git clone` allein nicht auswertet. Ist das Repository ein **Fork**, trägt `gh` zusätzlich zu `origin` das Ursprungs-Repository als Remote `upstream` ein. Außerdem setzt es das Ursprungs-Repository als Standard-Repository für `gh`.

```bash
gh repo clone KONTO/projekt
gh repo clone KONTO/projekt zielordner
```

Mit `--upstream-remote-name` bekommt das zweite Remote einen anderen Namen, `--no-upstream` unterdrückt es.

## Kurzform und Protokoll

Es genügt die Form `KONTO/REPO`. Fehlt auch das Konto, nimmt `gh` das eigene. Ob dabei über HTTPS oder SSH geklont wird, bestimmt die Einstellung `git_protocol`:

```bash
gh config get git_protocol
gh config set git_protocol https
```

Gibt man dagegen eine vollständige Adresse an, gilt deren Protokoll. `git remote -v` zeigt das Ergebnis: Adressen mit `https://` laufen über HTTPS, Adressen der Form `git@github.com:…` über SSH. Weitere Optionen für Git stehen hinter `--`, etwa `-- --depth=1`.

## Verbindungen

- [[gh liefert Git das Token für HTTPS]] – die Anmeldung, wenn über HTTPS geklont wird
- [[gh repo create bringt ein lokales Repository zu GitHub]] – der umgekehrte Weg, vom Rechner zu GitHub
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- GitHub-CLI-Handbuch: [gh repo clone](https://cli.github.com/manual/gh_repo_clone)

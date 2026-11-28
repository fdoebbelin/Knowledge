---
id: 202611281432
title: gh liefert Git das Token für HTTPS
type: zettel
tags:
  - git/github
  - sicherheit
created: 2026-11-28
herkunft: 02-Tech/Git/Arbeitsblatt-GitHub-CLI-gh.md
---

Die GitHub CLI `gh` kann für Git die Anmeldung über HTTPS übernehmen. Sie dient dann als **Credential-Helper**: Braucht Git Zugangsdaten, fragt es bei `gh` nach und bekommt das Token. `git push` und `git pull` laufen so ohne Passwortabfrage.

Eingerichtet wird das entweder bei `gh auth login`, wenn man HTTPS wählt und die Frage nach der Anmeldung für Git bejaht, oder nachträglich:

```bash
gh auth setup-git
```

In der Git-Konfiguration steht danach je Host ein Eintrag, der auf `gh auth git-credential` verweist. Meldet Git `could not read Username for 'https://github.com'`, fehlt vermutlich diese Einrichtung.

## Wo das Token liegt

`gh` legt das Token im Schlüsselbund des Systems ab. Gibt es keinen oder lässt er sich nicht nutzen, schreibt `gh` es **im Klartext** in eine Datei. `gh auth status` nennt den Speicherort.

Ein Passkey ersetzt diese Anmeldung nicht. Er meldet an der Website an und kann so den Browser-Schritt von `gh auth login` erleichtern. Git selbst benutzt über HTTPS das Token.

## Verbindungen

- [[Das Konto in gh ist unabhängig vom Konto im Browser]] – welches Konto das Token liefert
- [[Ein gepushtes Geheimnis muss man austauschen]] – auch das Token ist ein Geheimnis
- [[Git und Dateiablage]] – Strukturzettel zu diesem Thema

## Quellen

- GitHub-CLI-Handbuch: [gh auth setup-git](https://cli.github.com/manual/gh_auth_setup-git)
- GitHub-CLI-Handbuch: [gh auth login](https://cli.github.com/manual/gh_auth_login)

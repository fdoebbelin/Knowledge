### Schritt 1: Userinformationen setzen

Stelle sicher, dass Name und Mail global oder repository-spezifisch gesetzt sind:

```bash
git config user.name "Fritz-Rainer Döbbelin"
git config user.email "frd@doebbelin.net"
git config credential.helper store
git remote add origin https://github.com/fdoebbelin/MINTlab.git
git remote add origin https://github.com/fdoebbelin/MINTlab.git
```

Diese Infos erscheinen in jedem Commit.[^4][^5]

### Schritt 2: Token in der Plattform generieren

- **GitHub:** Gehe zu Einstellungen → Entwickler-Einstellungen → Tokens → „Generate new token“.
```text
github_pat_<TOKEN>
```

- **GitLab/Bitbucket:** Ähnliche Menüpunkte, dort „Personal Access Token“ oder „App Password“ erzeugen.
- Das Token wie ein Passwort aufbewahren! Am besten gleich kopieren und sicher speichern.[^6][^1]


### Schritt 3: Repository klonen oder pushen

Beim ersten Zugriff per HTTPS (Push, Pull, Klonen), z. B.:

```bash
git clone https://github.com/DeinBenutzername/DeinRepo.git
```

fordert Git einen Benutzernamen und ein Passwort. **Hier gibst du als Benutzernamen deinen Accountnamen, als Passwort das Token ein.** Moderne Plattformen akzeptieren keine klassischen Passwörter mehr, nur noch Token.[^3][^1]

### Schritt 4: Zugangsdatenmanager einrichten

Damit du nicht jedes Mal Benutzername/Token neu eingeben musst, nutzt du einen Credential Helper. Für Ubuntu 24.04 empfohlen:

```bash
git config --global credential.helper libsecret
# oder
git config --global credential.helper store
```

Git speichert die Zugangsdaten dann sicher im GNOME-Keyring.[^7][^1]
oder
Dabei werden die Zugangsdaten unverschlüsselt gespeichert, nur geeignet für Testsysteme.

### Schritt 5: Zugangsdaten prüfen und verwalten

Im GNOME-Keyring oder mit

```bash
git credential fill
```

lassen sich gespeicherte Zugangsdaten anzeigen bzw. testen. Ein neues Token überschreibt alte Zugangsdaten beim nächsten Push oder Pull.[^3]

***

#### Hinweise

- Tokens haben ein Ablaufdatum und können verschiedene Rechte vergeben. Ein verlorenes Token sollte auf der jeweiligen Plattform sofort widerrufen werden.
- Die Ablage im Schlüsselbund ist verschlüsselt und systemweit sicher; lediglich ein Zugriff mit gesperrtem Bildschirm oder Fremdzugriff muss geschützt werden.[^7][^3]

***

Mit diesen Schritten ist die Authentifizierung für moderne Git-Workflows per HTTPS und Token eingerichtet und einfach nutzbar.[^1][^3][^7]

<div align="center">⁂</div>

[^1]: https://labex.io/de/tutorials/git-how-to-set-up-git-personal-access-token-configuration-393036

[^2]: https://www.reddit.com/r/Ubuntu/comments/1agjqzk/how_to_store_github_username_and_password/

[^3]: https://git-scm.com/docs/gitcredentials

[^4]: https://www.nobledesktop.com/learn/git/setup-email

[^5]: https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-set-git-config-username-and-email-fields-in-global-and-local-configuration-files

[^6]: https://docs.github.com/de/authentication

[^7]: https://www.baeldung.com/linux/gnome-keyring-git-credentials-provider


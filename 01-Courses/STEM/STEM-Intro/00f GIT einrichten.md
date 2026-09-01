
```bash
git config --global user.name "Fritz-Rainer Döbbelin"
git config --global user.email "frd@doebbelin.net"
```


```bash
sudo apt install libsecret-1-0 libsecret-1-dev
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret

```

Hier ist ein Leitfaden für die sichere Git-Authentifizierung per HTTPS mit Zugangsdaten oder einem Personal Access Token (PAT) unter Ubuntu 24.04:[labex+2](https://labex.io/de/tutorials/git-how-to-set-up-git-personal-access-token-configuration-393036)​

## Schritt 1: Userinformationen setzen

Stelle sicher, dass Name und Mail global oder repository-spezifisch gesetzt sind:

bash


```
git config user.name "Dein Name"
git config user.email "dein@email.de"`
```


Diese Infos erscheinen in jedem Commit.[nobledesktop+1](https://www.nobledesktop.com/learn/git/setup-email)​

## Schritt 2: Token in der Plattform generieren

- **GitHub:** Gehe zu Einstellungen → Entwickler-Einstellungen → Tokens → „Generate new token“.
    
- **GitLab/Bitbucket:** Ähnliche Menüpunkte, dort „Personal Access Token“ oder „App Password“ erzeugen.
    
- Das Token wie ein Passwort aufbewahren! Am besten gleich kopieren und sicher speichern.[github+1](https://docs.github.com/de/authentication)​
    

## Schritt 3: Repository klonen oder pushen

Beim ersten Zugriff per HTTPS (Push, Pull, Klonen), z. B.:

bash

`git clone https://github.com/DeinBenutzername/DeinRepo.git`

fordert Git einen Benutzernamen und ein Passwort. **Hier gibst du als Benutzernamen deinen Accountnamen, als Passwort das Token ein.** Moderne Plattformen akzeptieren keine klassischen Passwörter mehr, nur noch Token.[git-scm+1](https://git-scm.com/docs/gitcredentials)​

## Schritt 4: Zugangsdatenmanager einrichten

Damit du nicht jedes Mal Benutzername/Token neu eingeben musst, nutzt du einen Credential Helper. Für Ubuntu 24.04 empfohlen:

bash

`git config --global credential.helper libsecret`

Git speichert die Zugangsdaten dann sicher im GNOME-Keyring.[baeldung+1](https://www.baeldung.com/linux/gnome-keyring-git-credentials-provider)​

## Schritt 5: Zugangsdaten prüfen und verwalten

Im GNOME-Keyring oder mit

bash

`git credential fill`

lassen sich gespeicherte Zugangsdaten anzeigen bzw. testen. Ein neues Token überschreibt alte Zugangsdaten beim nächsten Push oder Pull.[git-scm](https://git-scm.com/docs/gitcredentials)​

---

## Hinweise

- Tokens haben ein Ablaufdatum und können verschiedene Rechte vergeben. Ein verlorenes Token sollte auf der jeweiligen Plattform sofort widerrufen werden.
    
- Die Ablage im Schlüsselbund ist verschlüsselt und systemweit sicher; lediglich ein Zugriff mit gesperrtem Bildschirm oder Fremdzugriff muss geschützt werden.[baeldung+1](https://www.baeldung.com/linux/gnome-keyring-git-credentials-provider)​
    

---

Mit diesen Schritten ist die Authentifizierung für moderne Git-Workflows per HTTPS und Token eingerichtet und einfach nutzbar.[labex+2](https://labex.io/de/tutorials/git-how-to-set-up-git-personal-access-token-configuration-393036)​

1. [https://labex.io/de/tutorials/git-how-to-set-up-git-personal-access-token-configuration-393036](https://labex.io/de/tutorials/git-how-to-set-up-git-personal-access-token-configuration-393036)
2. [https://www.reddit.com/r/Ubuntu/comments/1agjqzk/how_to_store_github_username_and_password/](https://www.reddit.com/r/Ubuntu/comments/1agjqzk/how_to_store_github_username_and_password/)
3. [https://git-scm.com/docs/gitcredentials](https://git-scm.com/docs/gitcredentials)
4. [https://www.nobledesktop.com/learn/git/setup-email](https://www.nobledesktop.com/learn/git/setup-email)
5. [https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-set-git-config-username-and-email-fields-in-global-and-local-configuration-files](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-set-git-config-username-and-email-fields-in-global-and-local-configuration-files)
6. [https://docs.github.com/de/authentication](https://docs.github.com/de/authentication)
7. [https://www.baeldung.com/linux/gnome-keyring-git-credentials-provider](https://www.baeldung.com/linux/gnome-keyring-git-credentials-provider)
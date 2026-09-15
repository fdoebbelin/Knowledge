---
title: "Arbeitsblatt: GitHub CLI (gh) – Repository klonen und lokales Repo verbinden"
thema: Versionsverwaltung
kurs: Fachinformatiker (FISI/FIAE)
typ: Arbeitsblatt
protokoll: HTTPS
authentifizierung: Browser (Device Flow) + Passkey
tags:
  - git
  - github
  - gh-cli
  - versionsverwaltung
  - arbeitsblatt
created: 2026-08-18
version: "1.0"
---

# Arbeitsblatt: GitHub CLI (`gh`)

> [!abstract] Worum geht es?
> Zwei vollständige Abläufe mit der GitHub CLI:
> 1. Ein bestehendes GitHub-Repository in ein lokales Verzeichnis **klonen**
> 2. Ein bereits vorhandenes lokales Repository mit GitHub **verbinden**
>
> Durchgängig mit **HTTPS** als Git-Protokoll, Authentifizierung über den **Browser** (Device Flow), abgesichert durch einen im Browser gespeicherten **Passkey**.

## Lernziele

Nach Bearbeitung dieses Arbeitsblatts können Sie …

- [ ] die GitHub CLI installieren und deren Authentifizierungsstatus prüfen
- [ ] einen Passkey für Ihr GitHub-Konto anlegen und im Browser speichern
- [ ] auf github.com zwischen mehreren Benutzerkonten wechseln
- [ ] `gh` per Browser-Login mit HTTPS als Git-Protokoll einrichten
- [ ] ein Repository mit `gh repo clone` in ein Zielverzeichnis klonen
- [ ] ein lokales Verzeichnis mit `gh repo create --source` zu einem GitHub-Repo machen
- [ ] typische Fehlerbilder bei HTTPS-Authentifizierung einordnen und beheben

## Voraussetzungen

| Voraussetzung | Prüfbefehl |
|---|---|
| Git ist installiert | `git --version` |
| GitHub CLI ist installiert | `gh --version` |
| GitHub-Konto vorhanden | Login auf `https://github.com` |
| Browser mit Passkey-Unterstützung | Chrome, Edge, Firefox, Safari (aktuelle Version) |

> [!note] Shell-Hinweis
> Die Befehle sind für POSIX-Shells (bash/zsh) notiert. In **Nushell** gilt:
> - `&&` gibt es nicht → Befehle mit `;` trennen oder `and` verwenden
> - Umgebungsvariablen: `$env.GH_TOKEN = "…"` statt `export GH_TOKEN=…`
> - `mkdir` legt Elternverzeichnisse automatisch an (kein `-p` nötig)
> - `~` wird expandiert, Pfade mit Leerzeichen in Anführungszeichen setzen

---

## Teil 0 – Vorbereitung

### 0.1 GitHub CLI installieren

```bash
# Fedora / RHEL
sudo dnf install gh

# Debian / Ubuntu (offizielles Repo, gekürzt)
sudo apt install gh

# Arch / CachyOS
sudo pacman -S github-cli

# Windows
winget install --id GitHub.cli

# macOS
brew install gh
```

Prüfen:

```bash
gh --version
```

```text
gh version 2.x.x (2026-xx-xx)
https://github.com/cli/cli/releases/latest
```

### 0.2 Passkey für GitHub anlegen und im Browser speichern

Ein **Passkey** ist ein kryptografisches Schlüsselpaar. Der private Schlüssel verlässt das Gerät bzw. den Passwortmanager nie, der öffentliche liegt bei GitHub. Das ersetzt Passwort + 2FA-Code beim Web-Login und ist phishing-resistent.

1. Im Browser auf `https://github.com` anmelden (Passwort + 2FA)
2. Avatar oben rechts → **Settings**
3. Linke Navigation → **Password and authentication**
4. Abschnitt **Passkeys** → Schaltfläche **Add a passkey**
5. Der Browser öffnet den WebAuthn-Dialog. Speicherort wählen:
   - *Windows Hello* / *Touch ID* (Plattform-Authenticator)
   - **Browser-Profil bzw. Passwortmanager** ← für dieses Arbeitsblatt
   - Sicherheitsschlüssel (FIDO2-Stick)
6. Biometrie oder PIN bestätigen
7. Passkey benennen, z. B. `Chrome Schulungs-Notebook`
8. Test: Abmelden und über **Sign in with a passkey** neu anmelden

> [!warning] Wichtig für den Unterricht
> Ein im Browserprofil gespeicherter Passkey ist an **genau dieses Browserprofil auf diesem Gerät** gebunden. Wird das Profil gelöscht oder ein anderer Rechner benutzt, ist der Passkey nicht verfügbar.
> → Immer eine zweite Anmeldemethode behalten (zweiter Passkey, TOTP-App oder Recovery-Codes).

> [!tip] Passkey ≠ Git-Authentifizierung
> Der Passkey authentifiziert Sie gegenüber der **Website**. Für `git push`/`git pull` über HTTPS wird ein **OAuth-Token** verwendet, das `gh` verwaltet. Der Passkey macht lediglich den Browser-Schritt in Ablauf 0.4 schnell und sicher.

### 0.3 Benutzer auf der GitHub-Website wechseln

GitHub kann mehrere Konten gleichzeitig angemeldet halten.

**Zweiten Account hinzufügen**

1. Avatar oben rechts anklicken
2. Im Menü unten **Switch account** wählen
3. **Add account** anklicken
4. Anmeldeseite: Zugangsdaten des zweiten Kontos eingeben — oder **Sign in with a passkey**, falls für dieses Konto ein Passkey hinterlegt ist
5. Nach dem Login ist das zweite Konto aktiv

**Zwischen Konten umschalten**

1. Avatar → **Switch account**
2. Gewünschtes Konto aus der Liste anklicken

**Abmelden**

- Avatar → **Sign out** meldet nur das aktive Konto ab
- **Sign out of all accounts** beendet alle Sitzungen

> [!info] Oberflächensprache
> Die GitHub-Oberfläche ist standardmäßig englisch. Umstellen unter **Settings → Appearance → Language**. Die Menüpunkte heißen dann sinngemäß *Konto wechseln* / *Abmelden*. Beschriftungen können je nach Release leicht abweichen.

> [!danger] Stolperfalle
> Der auf der Website aktive Benutzer und der in `gh` aktive Benutzer sind **unabhängig voneinander**. Ein Wechsel im Browser ändert nichts an den Git-Zugangsdaten auf der Kommandozeile — dafür ist `gh auth switch` zuständig (siehe [[#Teil 3 – Mehrere Accounts in gh]]).

### 0.4 `gh` per Browser authentifizieren (HTTPS)

```bash
gh auth login
```

Der interaktive Dialog wird wie folgt beantwortet:

```text
? Where do you use GitHub?                                    GitHub.com
? What is your preferred protocol for Git operations?         HTTPS
? Authenticate Git with your GitHub credentials?              Yes
? How would you like to authenticate GitHub CLI?              Login with a web browser

! First copy your one-time code: A1B2-C3D4
Press Enter to open https://github.com/login/device in your browser...
```

Ablauf im Browser:

1. Einmalcode notieren bzw. aus der Zwischenablage einfügen
2. `Enter` drücken → Browser öffnet `https://github.com/login/device`
3. Falls nicht angemeldet: **Sign in with a passkey** → Biometrie/PIN
4. Code eingeben → **Continue**
5. Berechtigungen prüfen → **Authorize github**
6. Zurück im Terminal:

```text
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as fritz-rainer
```

Status prüfen:

```bash
gh auth status
```

```text
github.com
  ✓ Logged in to github.com account fritz-rainer (keyring)
  - Active account: true
  - Git operations protocol: https
  - Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

Git-Credential-Helper sicherstellen (falls Frage 3 oben mit *No* beantwortet wurde):

```bash
gh auth setup-git
```

Ergebnis in `~/.gitconfig`:

```ini
[credential "https://github.com"]
	helper =
	helper = !/usr/bin/gh auth git-credential
```

> [!note] Wo liegt das Token?
> Bevorzugt im System-Schlüsselbund (gnome-keyring, KWallet, Windows Credential Manager, macOS Keychain). Ist keiner verfügbar, landet es im Klartext in `~/.config/gh/hosts.yml`.

**Kontrolle:** HTTPS als Standardprotokoll gesetzt?

```bash
gh config get git_protocol
```

```text
https
```

Falls nicht:

```bash
gh config set git_protocol https
```

---

## Ablauf 1 – GitHub-Repository klonen

**Ziel:** Ein auf GitHub bestehendes Repository liegt anschließend als Arbeitskopie in einem lokalen Verzeichnis, mit HTTPS-Remote und funktionierendem Push.

### Schritt 1 – Zielverzeichnis vorbereiten

```bash
mkdir -p ~/projekte
cd ~/projekte
```

### Schritt 2 – Verfügbare Repositories auflisten

```bash
gh repo list
```

```text
fritz-rainer/schulung-sql      Übungsmaterial SQL   private   2026-08-12
fritz-rainer/dabrec            DAB+ Recorder        public    2026-07-30
```

Repositories einer Organisation oder eines anderen Kontos:

```bash
gh repo list metarow --limit 30
```

### Schritt 3 – Repository klonen

```bash
gh repo clone fritz-rainer/schulung-sql
```

Mit abweichendem Zielverzeichnis:

```bash
gh repo clone fritz-rainer/schulung-sql ~/projekte/sql-kurs
```

```text
Cloning into 'sql-kurs'...
remote: Enumerating objects: 142, done.
remote: Counting objects: 100% (142/142), done.
Receiving objects: 100% (142/142), 38.11 KiB | 3.81 MiB/s, done.
```

> [!tip] `gh repo clone` vs. `git clone`
> `gh repo clone` setzt automatisch das in `git_protocol` konfigurierte Protokoll ein und ergänzt bei Forks zusätzlich ein `upstream`-Remote. Ein `git clone https://github.com/…` funktioniert genauso, erfordert die URL aber vollständig.

### Schritt 4 – Ergebnis prüfen

```bash
cd ~/projekte/sql-kurs
git remote -v
```

```text
origin  https://github.com/fritz-rainer/schulung-sql.git (fetch)
origin  https://github.com/fritz-rainer/schulung-sql.git (push)
```

Die URL beginnt mit `https://` — nicht mit `git@github.com:`. Damit ist das HTTPS-Protokoll bestätigt.

```bash
git status
git log --oneline -5
gh repo view
```

### Schritt 5 – Schreibzugriff testen

```bash
echo "# Notizen" >> NOTIZEN.md
git add NOTIZEN.md
git commit -m "docs: Notizdatei angelegt"
git push
```

```text
Enumerating objects: 4, done.
To https://github.com/fritz-rainer/schulung-sql.git
   a1b2c3d..e4f5g6h  main -> main
```

Es erscheint **keine Passwortabfrage** — der Credential-Helper von `gh` liefert das Token automatisch. Das ist der entscheidende Nachweis, dass Schritt 0.4 korrekt war.

Optional im Browser kontrollieren:

```bash
gh repo view --web
```

> [!success] Ablauf 1 abgeschlossen
> - [ ] Repo liegt lokal
> - [ ] `git remote -v` zeigt eine `https://`-URL
> - [ ] `git push` läuft ohne Anmeldedialog

---

## Ablauf 2 – Vorhandenes lokales Repository mit GitHub verbinden

**Ziel:** Ein bereits existierendes lokales Projekt bekommt ein neues Repository auf GitHub, ein `origin`-Remote über HTTPS und einen ersten Push.

### Schritt 1 – Ausgangslage prüfen

```bash
cd ~/projekte/mein-werkzeug
ls -la
git status
```

Fall A – noch keine Versionsverwaltung (`fatal: not a git repository`):

```bash
git init -b main
```

Fall B – bereits ein Git-Repo: weiter mit Schritt 2.

### Schritt 2 – `.gitignore` anlegen

```bash
gh repo gitignore list          # verfügbare Vorlagen anzeigen
gh repo gitignore view Python > .gitignore
```

Alternativ von Hand:

```gitignore
__pycache__/
.venv/
*.log
.env
```

> [!warning] Vor dem ersten Push prüfen
> Keine Zugangsdaten, Tokens, `.env`-Dateien oder personenbezogenen Daten committen. Was einmal gepusht wurde, bleibt in der Historie.

### Schritt 3 – Ersten Commit erzeugen

```bash
git add .
git status
git commit -m "chore: initialer Commit"
```

```bash
git log --oneline
```

```text
9f3c1ab (HEAD -> main) chore: initialer Commit
```

### Schritt 4 – Kein `origin` vorhanden?

```bash
git remote -v
```

Gibt der Befehl nichts aus, ist alles vorbereitet. Existiert bereits ein `origin`, siehe [[#Troubleshooting]].

### Schritt 5 – GitHub-Repository erzeugen und verbinden

**Variante A – ein Befehl (empfohlen):**

```bash
gh repo create mein-werkzeug \
  --private \
  --source=. \
  --remote=origin \
  --push \
  --description "Werkzeugsammlung für die Schulung"
```

```text
✓ Created repository fritz-rainer/mein-werkzeug on GitHub
  https://github.com/fritz-rainer/mein-werkzeug
✓ Added remote https://github.com/fritz-rainer/mein-werkzeug.git
✓ Pushed commits to https://github.com/fritz-rainer/mein-werkzeug.git
```

| Option | Bedeutung |
|---|---|
| `--private` | Sichtbarkeit; Alternativen: `--public`, `--internal` |
| `--source=.` | Aktuelles Verzeichnis ist die Quelle des Repos |
| `--remote=origin` | Name des angelegten Remotes |
| `--push` | Aktuellen Branch direkt hochladen |
| `--description` | Kurzbeschreibung auf der Repo-Seite |

**Variante B – interaktiv:**

```bash
gh repo create
```

```text
? What would you like to do?  Push an existing local repository to GitHub
? Path to local repository     .
? Repository name              mein-werkzeug
? Repository owner             fritz-rainer
? Description                  Werkzeugsammlung für die Schulung
? Visibility                   Private
? Add a remote?                Yes
? What should the new remote be called?  origin
? Would you like to push commits from the current branch?  Yes
```

**Variante C – manuell (zum Verständnis der Mechanik):**

```bash
gh repo create mein-werkzeug --private
git remote add origin https://github.com/fritz-rainer/mein-werkzeug.git
git branch -M main
git push -u origin main
```

### Schritt 6 – Ergebnis prüfen

```bash
git remote -v
git branch -vv
gh repo view
```

```text
origin  https://github.com/fritz-rainer/mein-werkzeug.git (fetch)
origin  https://github.com/fritz-rainer/mein-werkzeug.git (push)

* main 9f3c1ab [origin/main] chore: initialer Commit
```

Die Angabe `[origin/main]` belegt, dass der Upstream-Tracking-Branch gesetzt ist. Ab jetzt genügt `git push` ohne weitere Argumente.

```bash
gh repo view --web
```

> [!success] Ablauf 2 abgeschlossen
> - [ ] Repository ist auf GitHub sichtbar
> - [ ] `origin` verweist auf eine `https://`-URL
> - [ ] `git branch -vv` zeigt den Upstream `[origin/main]`
> - [ ] `.gitignore` ist vorhanden und wirksam

---

## Teil 3 – Mehrere Accounts in `gh`

Die GitHub CLI kann mehrere Konten parallel verwalten. Genau eines ist **aktiv** und bestimmt, welches Token der Git-Credential-Helper liefert.

```bash
# zweites Konto hinzufügen (erneut Browser-Login)
gh auth login

# alle Konten anzeigen
gh auth status

# aktives Konto wechseln
gh auth switch

# gezielt wechseln
gh auth switch --hostname github.com --user zweiter-account

# Konto entfernen
gh auth logout --hostname github.com --user zweiter-account
```

```text
github.com
  ✓ Logged in to github.com account fritz-rainer (keyring)
  - Active account: true
  ✓ Logged in to github.com account metarow-training (keyring)
  - Active account: false
```

> [!danger] Häufigster Fehler in der Praxis
> Im Browser ist Konto B aktiv, in `gh` aber noch Konto A. Ein Push in ein Repo von Konto B endet dann mit:
> ```text
> remote: Permission to metarow-training/projekt.git denied to fritz-rainer.
> fatal: unable to access '...': The requested URL returned error: 403
> ```
> Lösung: `gh auth switch` — **nicht** neu klonen.

---

## Troubleshooting

| Fehlermeldung / Symptom | Ursache | Behebung |
|---|---|---|
| `could not read Username for 'https://github.com'` | Credential-Helper nicht eingerichtet | `gh auth setup-git` |
| `403 ... denied to <user>` | falsches aktives Konto | `gh auth switch` |
| `remote origin already exists` | `origin` war schon gesetzt | `git remote set-url origin <URL>` oder `git remote remove origin` |
| Passwortabfrage beim Push | veraltete Credentials im Schlüsselbund | Eintrag `github.com` im Credential Manager / Keyring löschen, dann `gh auth setup-git` |
| `HTTP 404` beim Klonen eines privaten Repos | fehlende Berechtigung oder falsches Konto | `gh auth status` prüfen, ggf. wechseln |
| Push mit Workflow-Datei schlägt fehl | Scope `workflow` fehlt | `gh auth refresh -h github.com -s workflow` |
| Einmalcode wird nicht akzeptiert | Code abgelaufen (ca. 15 min) | `gh auth login` erneut starten |
| Passkey wird nicht angeboten | anderes Browserprofil/Gerät | Passwort + 2FA nutzen, danach neuen Passkey anlegen |
| Remote-URL beginnt mit `git@` | SSH statt HTTPS | `git remote set-url origin https://github.com/<user>/<repo>.git` |

Diagnosebefehle:

```bash
gh auth status
gh config list
git config --get-regexp '^credential'
git remote -v
```

---

## Übungsaufgaben

> [!question] Aufgabe 1
> Klonen Sie das Repository `cli/cli` in das Verzeichnis `~/uebung/gh-quellcode`. Weisen Sie mit einem Befehl nach, dass das HTTPS-Protokoll verwendet wird.

> [!question] Aufgabe 2
> Legen Sie lokal ein Verzeichnis `~/uebung/notizen` mit einer Datei `README.md` an. Machen Sie daraus ein **privates** GitHub-Repository — mit genau einem `gh`-Befehl nach dem ersten Commit.

> [!question] Aufgabe 3
> Ändern Sie `README.md`, committen und pushen Sie. Dokumentieren Sie, an welcher Stelle des Vorgangs eine Anmeldung erfolgt und warum keine Eingabe nötig ist.

> [!question] Aufgabe 4
> Wechseln Sie auf github.com zu einem zweiten Konto und stellen Sie fest, ob sich dadurch die Ausgabe von `gh auth status` ändert. Begründen Sie das Ergebnis.

> [!question] Aufgabe 5
> Setzen Sie die Remote-URL eines geklonten Repos versuchsweise auf die SSH-Form und wieder zurück auf HTTPS. Notieren Sie beide Befehle.

---

## Kontrollfragen

> [!question]- Welche drei Angaben werden bei `gh auth login` für den hier genutzten Weg gewählt?
> `GitHub.com` als Host, `HTTPS` als Git-Protokoll, `Login with a web browser` als Authentifizierungsmethode. Zusätzlich wird die Frage nach dem Git-Credential-Helper mit *Yes* beantwortet.

> [!question]- Warum ersetzt der Passkey nicht die Git-Authentifizierung?
> Ein Passkey ist ein WebAuthn-Verfahren für den Browser-Login. Git kommuniziert über HTTPS mit dem GitHub-API-Endpunkt und benötigt ein OAuth-Token im `Authorization`-Header. Dieses Token stellt `gh` über den Credential-Helper bereit.

> [!question]- Wozu dient `gh auth setup-git`?
> Es trägt `gh auth git-credential` als Credential-Helper in die Git-Konfiguration ein. Git fragt bei jeder HTTPS-Operation dort das Token ab, statt Benutzername und Passwort zu verlangen.

> [!question]- Was bewirkt `--source=.` bei `gh repo create`?
> Das aktuelle Verzeichnis wird als Quelle des neuen Repositories verwendet: `gh` legt das Repo auf GitHub an und richtet es passend zum bestehenden lokalen Git-Repo ein, statt ein leeres Verzeichnis zu erzeugen.

> [!question]- Welche Bedeutung hat `-u` in `git push -u origin main`?
> `-u` (`--set-upstream`) verknüpft den lokalen Branch dauerhaft mit `origin/main`. Danach genügen `git push` und `git pull` ohne weitere Argumente.

> [!question]- Ein Push endet mit HTTP 403 und dem Hinweis auf einen fremden Benutzernamen. Was ist zu tun?
> In `gh` ist ein anderes Konto aktiv als das berechtigte. Mit `gh auth status` prüfen und mit `gh auth switch` umschalten. Ein erneutes Klonen ist nicht erforderlich.

> [!question]- Wodurch erkennt man an `git remote -v` das verwendete Protokoll?
> HTTPS-Remotes beginnen mit `https://github.com/`, SSH-Remotes mit `git@github.com:`.

---

## Befehlsübersicht

| Befehl | Zweck |
|---|---|
| `gh auth login` | Anmeldung, Protokoll- und Methodenwahl |
| `gh auth status` | Konten, aktives Konto, Protokoll, Scopes |
| `gh auth switch` | aktives Konto wechseln |
| `gh auth refresh -s <scope>` | Token um Berechtigungen erweitern |
| `gh auth setup-git` | Git-Credential-Helper einrichten |
| `gh auth logout` | Konto abmelden |
| `gh config set git_protocol https` | Standardprotokoll festlegen |
| `gh repo list [owner]` | Repositories auflisten |
| `gh repo clone <owner>/<repo> [ziel]` | Repository klonen |
| `gh repo create <name> --source=. --push` | lokales Repo auf GitHub anlegen und pushen |
| `gh repo view [--web]` | Repo-Informationen bzw. Browser-Ansicht |
| `gh repo gitignore view <Vorlage>` | `.gitignore`-Vorlage ausgeben |
| `git remote -v` | Remotes und URLs anzeigen |
| `git remote set-url origin <URL>` | Remote-URL ändern |
| `git branch -vv` | Upstream-Zuordnung prüfen |

---

## Verwandte Notizen

- [[Git Grundlagen]]
- [[Git Branching und Merging]]
- [[HTTPS vs SSH bei Git]]
- [[Passkeys und WebAuthn]]
- [[Zwei-Faktor-Authentifizierung]]
- [[Nushell Grundlagen]]

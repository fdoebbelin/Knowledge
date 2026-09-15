---
title: Obsidian-Vault-Synchronisation über eigenes Git-Repo auf All-Inkl
created: 2026-08-13
tags:
  - obsidian
  - git
  - ssh
  - all-inkl
  - 1password
  - sync
status: Arbeitsanleitung
plattformen:
  - Linux
  - Windows
  - macOS
  - iOS
---

# Obsidian-Sync über eigenes Git-Repo bei All-Inkl

> [!abstract] Ziel
> Ein zentrales, bares Git-Repository auf dem All-Inkl-Webspace als „Sync-Server" für einen oder mehrere Obsidian-Vaults. Authentifizierung ausschließlich per Ed25519-Public-Key, der Private Key liegt in 1Password und wird über den 1Password-SSH-Agent auf allen Desktop-Systemen bereitgestellt — nirgends als Datei auf der Platte.

---

## 1. Architektur und Überblick

```
                    ┌──────────────────────────────────┐
                    │  All-Inkl Webspace (Premium)     │
                    │  wXXXXXXX.kasserver.com          │
                    │                                  │
                    │  ~/git/obsidian-vault.git        │
                    │  (bare repository)               │
                    └──────────────┬───────────────────┘
                                   │ SSH / Port 22
                                   │ Ed25519 Public Key
          ┌────────────────┬───────┴────────┬─────────────────┐
          │                │                │                 │
    ┌─────▼─────┐    ┌─────▼─────┐    ┌─────▼─────┐    ┌──────▼──────┐
    │  CachyOS  │    │  Fedora   │    │ Win ARM64 │    │    iOS      │
    │  Desktop  │    │  Laptop   │    │  XPS 13   │    │  iPhone     │
    │           │    │           │    │           │    │             │
    │ 1P-Agent  │    │ 1P-Agent  │    │ 1P-Agent  │    │ Working Copy│
    │ Obsidian  │    │ Obsidian  │    │ Obsidian  │    │ + Obsidian  │
    │ Git-Plugin│    │ Git-Plugin│    │ Git-Plugin│    │ (Ordner-Link)│
    └───────────┘    └───────────┘    └───────────┘    └─────────────┘
```

**Warum bare?** Ein bares Repository hat keinen Arbeitsbaum. Damit gibt es keinen „ausgecheckten Stand" auf dem Server, in den gepusht wird und der dann kollidiert. Der Server ist reiner Austauschpunkt.

**Was dieser Ansatz nicht ist:** Kein Echtzeit-Sync. Änderungen werden bei Commit/Push sichtbar, nicht sekündlich. Für Notizen ist das in der Praxis vollkommen ausreichend, wenn man das Pull-vor-Bearbeiten diszipliniert einhält.

---

## 2. Voraussetzungen

| Komponente | Anforderung | Prüfen |
|---|---|---|
| All-Inkl-Tarif | mindestens **Premium** | KAS → Tools → SSH-Zugänge sichtbar? |
| Git auf dem Server | vorinstalliert | `git --version` nach SSH-Login |
| 1Password | Version 8 mit aktiviertem SSH-Agent | Einstellungen → Entwickler |
| Working Copy | Pro-Freischaltung für Push (Einmalkauf) | — |
| Obsidian | Desktop + iOS-App | — |

> [!warning] Tarifgrenze
> <cite index="17-1">Der SSH-Zugang steht erst ab dem Tarif ALL-INKL Premium zur Verfügung.</cite> Ohne SSH gibt es keinen Git-Transport — SFTP oder WebDAV sind hier keine brauchbare Alternative.

---

## 3. Teil 1 — Schlüsselpaar erzeugen und in 1Password verankern

### 3.1 Konzept: „ohne Passwort" heißt nicht „ungeschützt"

Ein SSH-Key mit Passphrase erzwingt bei jeder Operation eine Eingabe. Das ist auf dem Handy und bei automatischen Commits unbrauchbar. Der 1Password-Ansatz löst das anders:

- Der Private Key liegt **verschlüsselt im 1Password-Tresor**, nicht als Datei in `~/.ssh/`.
- Der SSH-Agent von 1Password gibt ihn nie an den Client heraus — er signiert nur die Challenge und liefert die Signatur zurück.
- Jede Nutzung wird per Touch ID / Windows Hello / Systemauthentifizierung freigegeben.

Das ist sicherheitstechnisch **besser** als ein passphrase-geschützter Key auf der Platte, weil der Key gar nicht erst im Dateisystem existiert.

### 3.2 Schlüssel direkt in 1Password erzeugen (empfohlener Weg)

1. 1Password öffnen → **Neues Element** → **SSH-Schlüssel**
2. Titel: `SSH – All-Inkl Obsidian Sync`
3. Schlüsseltyp: **Ed25519**
4. Speichern im Tresor **Persönlich / Private** (Standard-Tresor des Agents)
5. Feld *Öffentlicher Schlüssel* → kopieren, für Abschnitt 4 bereithalten

> [!info] Warum Ed25519
> Kurz, schnell, moderne Kurve, keine Parametrisierungsfallen wie bei RSA. All-Inkl akzeptiert Ed25519 problemlos.

<cite index="20-1">Damit der Agent den Schlüssel anbietet, muss das 1Password-Element vom Typ „SSH Key" sein, in einem der Tresore liegen, die der Agent nutzt (standardmäßig Persönlich/Privat/Mitarbeiter), und aktiv sein — nicht archiviert oder gelöscht.</cite>

### 3.3 Alternative: lokal erzeugen und importieren

Falls du den Key lieber selbst erzeugst (z. B. weil du ihn im OpenSSH-Textformat brauchst — siehe iOS-Abschnitt):

```bash
ssh-keygen -t ed25519 -a 100 \
  -C "obsidian-sync@metarow" \
  -f ~/.ssh/id_ed25519_allinkl \
  -N ""
```

Dann:

1. In 1Password → **Neues Element → SSH-Schlüssel → Privaten Schlüssel importieren**
2. Datei `~/.ssh/id_ed25519_allinkl` auswählen
3. **Danach die lokalen Dateien löschen:**

```bash
shred -u ~/.ssh/id_ed25519_allinkl
rm ~/.ssh/id_ed25519_allinkl.pub   # Public Key darf bleiben, siehe 6.1
```

Nushell:

```nu
ssh-keygen -t ed25519 -a 100 -C "obsidian-sync@metarow" -f $"($nu.home-path)/.ssh/id_ed25519_allinkl" -N ""
```

### 3.4 Agent in 1Password aktivieren

**Alle Desktop-Plattformen:** 1Password → Einstellungen → **Entwickler** → *SSH-Agent verwenden* aktivieren.

> [!bug] Linux-Fallstrick
> <cite index="20-1">Der 1Password-SSH-Agent funktioniert nicht mit Flatpak- oder Snap-Installationen von 1Password.</cite> Auf CachyOS also `1password` aus dem AUR bzw. das offizielle `.deb`/`.rpm` verwenden, nicht die Flatpak-Variante.
>
> Auf immutablen Systemen (Fedora Sway Atomic, Silverblue, bootc-Images) ist die native Installation nur per Layering möglich — dort geht **Abschnitt 6.3** einen anderen Weg.

---

## 4. Teil 2 — All-Inkl vorbereiten

### 4.1 SSH im KAS aktivieren

<cite index="31-1">Im KAS (technische Verwaltung) des **Hauptaccounts** anmelden, links im Menü auf **Tools** klicken, dann auf **SSH-Zugänge**. Beim entsprechenden Account auf **Bearbeiten** klicken und die Option auf *aktiv* setzen, anschließend speichern.</cite>

Notiere dir aus dieser Maske:

| Feld             | Wert                     |
| ---------------- | ------------------------ |
| Loginname (KAS)  | `w017ef42`               |
| SSH-Login        | `ssh-w017ef42`           |
| Host             | `w017ef42.kasserver.com` |
| Home-Verzeichnis | `/www/htdocs/w017ef42`   |

### 4.2 Public Key hinterlegen

<cite index="30-1">Den entsprechenden SSH-Benutzer im KAS unter **Tools → SSH-Zugänge** bearbeiten und den Public Key in das Feld **SSH-Schlüssel** einfügen. Dabei steht in einer Zeile immer nur ein Schlüssel.</cite>

Der Eintrag sieht so aus (eine Zeile, kein Umbruch):

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIL6yg6jAE2fj51zaVh9eYImRRQxI4zApBgw3NgnXpdE obsidian-sync@metarow
```

> [!tip] Mehrere Geräte, mehrere Zeilen
> Das Feld nimmt beliebig viele Schlüssel auf — je Zeile einen. Das ist der Hebel für die iOS-Variante B in Abschnitt 7.4.

Speichern. Die Freischaltung braucht in der Regel wenige Minuten.

### 4.3 Erste Verbindung testen

```bash
ssh ssh-w017ef42@w017ef42.kasserver.com
```

Beim ersten Mal die Host-Key-Abfrage mit `yes` bestätigen. Wenn 1Password nach Freigabe fragt und du danach ohne Passworteingabe im Shell-Prompt landest: Key funktioniert.

> [!failure] Falls doch nach Passwort gefragt wird
> Dann greift der Key nicht. Prüfe mit `ssh -v ssh-w017ef42@w017ef42.kasserver.com 2>&1 | grep -i "offering\|identity"`, ob der Agent überhaupt Schlüssel anbietet. Siehe auch Abschnitt 6.1 (`IdentityAgent`).

### 4.4 Bares Repository anlegen

Auf dem Server (also in der SSH-Session):

```bash
mkdir -p ~/git
cd ~/git
git init --bare obsidian-vault.git
cd obsidian-vault.git
git symbolic-ref HEAD refs/heads/main
```

Die letzte Zeile setzt `main` als Default-Branch — die Git-Version auf dem Server nutzt sonst je nach Alter noch `master`.

Prüfen:

```bash
git --version
ls -la ~/git/obsidian-vault.git
```

### 4.5 Repository vor Web-Zugriff schützen

> [!danger] Wichtig
> Lege das Repo **niemals** in ein Verzeichnis, das einer Domain zugeordnet ist. Sonst sind deine Notizen über HTTP abrufbar. `~/git/` liegt bei All-Inkl im Home-Verzeichnis und ist per Default nicht webseitig erreichbar — aber prüfe das.

Zusätzliche Absicherung als Gürtel-und-Hosenträger:

```bash
cat > ~/git/.htaccess << 'EOF'
Require all denied
EOF
```

Und dann von einem Browser aus verifizieren, dass `https://deine-domain.de/git/` nichts liefert.

### 4.6 Der Clone-Pfad

Zwei Schreibweisen funktionieren:

**Absolut (empfohlen, funktioniert überall zuverlässig):**
```
ssh://ssh-w017ef42@w017ef42.kasserver.com/www/htdocs/w017ef42/git/obsidian-vault.git
```

**SCP-Kurzform (relativ zum Home):**
```
ssh-w017ef42@w017ef42.kasserver.com:git/obsidian-vault.git
```

Working Copy und einige GUI-Clients kommen mit der `ssh://`-Form besser klar. Nutze durchgängig diese.

---

## 5. Teil 3 — Vault vorbereiten und initial pushen

Das machst du **einmalig** auf deinem Hauptrechner.

### 5.1 `.gitignore` anlegen

Im Vault-Wurzelverzeichnis:

```gitignore
# Obsidian – gerätespezifischer Zustand, niemals synchronisieren
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/workspace
.obsidian/cache
.obsidian/graph.json

# Plugin-Laufzeitdaten, die Konflikte erzeugen
.obsidian/plugins/obsidian-git/data.json

# Papierkorb
.trash/

# Betriebssystem
.DS_Store
Thumbs.db
desktop.ini

# Optional: große Binärdateien ausschließen, wenn Webspace knapp ist
# *.mp4
# *.zip
```

> [!question] Warum nicht `.obsidian/` komplett ignorieren?
> Weil du dann auf jedem Gerät Themes, Plugins und Hotkeys neu einrichten musst. Der Kompromiss oben synchronisiert die Konfiguration, aber nicht den *Fensterzustand* — und genau der ist die Konfliktquelle Nummer eins.

### 5.2 `.gitattributes` anlegen

Wegen des Windows-Rechners essenziell:

```gitattributes
* text=auto eol=lf
*.md text eol=lf
*.png binary
*.jpg binary
*.pdf binary
*.canvas text eol=lf
```

Damit landen im Repo immer LF-Zeilenenden, unabhängig davon, welches System committet. Ohne das erzeugt jeder Wechsel zwischen Windows und Linux Pseudo-Änderungen an jeder Datei.

### 5.3 Initialer Push

```bash
cd ~/Projekte/NoctaRow/doc

git init -b main
git add .
git commit -m "Initialer Import des Vaults"

git remote add origin ssh://ssh-w017ef42@w017ef42.kasserver.com/www/htdocs/w017ef42/git/NoctaRow.git
git push -u origin main
```

### 5.4 Größe im Blick behalten

```bash
du -sh .git
git count-objects -vH
```

Ein reiner Text-Vault bleibt jahrelang im zweistelligen Megabyte-Bereich. Wenn du viele Bilder oder PDFs einbindest, wächst das Repo linear und irreversibel — Git speichert jede Version. `git-lfs` steht auf All-Inkl **nicht** zur Verfügung. Bei bildlastigen Vaults also entweder Bilder per `.gitignore` ausklammern und separat sichern, oder von vornherein komprimieren.

---

## 6. Teil 4 — Desktop-Clients einrichten

### 6.1 Gemeinsame Basis: `~/.ssh/config`

Die zentrale Datei, die auf allen Desktops praktisch gleich aussieht:

```sshconfig
Host allinkl
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentitiesOnly yes
    IdentityAgent ~/.1password/agent.sock
    IdentityFile ~/.ssh/all-inkl.com
    ServerAliveInterval 60
```

Mit dieser Config verkürzt sich der Clone-Pfad auf:

```
allinkl:/www/htdocs/w017ef42/git/NoctaRow.git
```

### 6.2 Fedora Sway Atomic — gerätespezifischer Schlüssel ohne 1Password

Dieses Gerät bekommt einen eigenen Schlüssel, der es nie verlässt. 1Password verwaltet dann nicht mehr *den einen* Schlüssel, sondern die *Liste* der berechtigten Geräte.

#### Warum das auf Atomic sogar besser passt

| Aspekt | 1Password-Agent (6.2) | Gerätespezifischer Key (6.3) |
|---|---|---|
| Image-Eingriff | Layering nötig | keiner |
| Schlüssel liegt in | 1Password-Tresor | `/var/home/<user>/.ssh/` |
| Überlebt Rebase | — | ja, `/var` ist persistent |
| Bei Geräteverlust | Key überall tauschen | eine KAS-Zeile löschen |
| Zusätzliche Abhängigkeit | 1Password muss laufen | keine |

Das Home-Verzeichnis liegt auf Fedora Atomic unter `/var/home` und ist damit ausdrücklich **nicht** Teil des Images. Ein Schlüssel dort ist genauso persistent wie deine Vault-Dateien selbst.

#### Schritt 1 — Schlüssel erzeugen

```nu
ssh-keygen -t ed25519 -a 100 -C "sway-atomic@metarow" -f $"($nu.home-path)/.ssh/id_ed25519_allinkl"
```

**Passphrase setzen.** Anders als in 6.2 liegt der Schlüssel hier als Datei vor — die Passphrase ist die einzige Hürde, falls jemand an das Dateisystem kommt. Sie wird dank Agent nur einmal pro Sitzung abgefragt. Die Passphrase selbst legst du in 1Password ab, dort wo sie hingehört.

Rechte prüfen:

```nu
chmod 600 $"($nu.home-path)/.ssh/id_ed25519_allinkl"
chmod 700 $"($nu.home-path)/.ssh"
```

#### Schritt 2 — ssh-agent als User-Unit

Sway startet keinen Agent von sich aus, und `openssh` bringt auf Fedora keine fertige User-Unit mit. Eine eigene ist schnell geschrieben und liegt ebenfalls außerhalb des Images.

`~/.config/systemd/user/ssh-agent.service`:

```ini
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Aktivieren:

```nu
systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.service
systemctl --user status ssh-agent.service
```

`%t` expandiert zu `$XDG_RUNTIME_DIR`, der Socket landet also unter `/run/user/1000/ssh-agent.socket` — tmpfs, wird beim Abmelden sauber weggeräumt.

#### Schritt 3 — Socket bekannt machen

In `$nu.env-path` (`env.nu`):

```nu
$env.SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join "ssh-agent.socket")
```

Für grafische Anwendungen, die keine Nushell-Umgebung erben (Obsidian selbst, wenn das Git-Plugin `git push` aufruft), zusätzlich in der Sway-Konfiguration:

```
# ~/.config/sway/config
exec systemctl --user import-environment SSH_AUTH_SOCK
```

Beziehungsweise generischer über `~/.config/environment.d/ssh-agent.conf`:

```
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket
```

Diese Variante wird von systemd-User-Sessions automatisch gelesen und gilt damit auch für Flatpak-Obsidian.

> [!warning] Flatpak-Obsidian braucht Zugriff auf den Socket
> Läuft Obsidian selbst als Flatpak, sieht es den Agent-Socket nicht ohne Freigabe:
> ```nu
> flatpak override --user --filesystem=xdg-run/ssh-agent.socket md.obsidian.Obsidian
> ```
> Einfacher ist es, Obsidian auf diesem Gerät ebenfalls nicht als Flatpak zu betreiben, oder das Git-Plugin wegzulassen und über ein Nushell-Kommando zu synchronisieren (siehe unten).

#### Schritt 4 — `~/.ssh/config`

Ohne `IdentityAgent` — der Standard-Agent aus Schritt 2 greift:

```sshconfig
Host allinkl
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_ed25519_allinkl
    AddKeysToAgent yes
    ServerAliveInterval 60
```

`AddKeysToAgent yes` sorgt dafür, dass die Passphrase beim ersten Zugriff einmal abgefragt und der entschlüsselte Schlüssel danach im Agent gehalten wird. Kein manuelles `ssh-add` nötig.

> [!note] Unterschied zu 6.1
> Hier zeigt `IdentityFile` auf den **privaten** Schlüssel, nicht auf den `.pub`. Der Selektor-Trick aus 6.1 ist nur beim Agent-Betrieb ohne lokale Datei nötig.

Passphrase-Abfrage im Terminal ist auf Sway der Normalfall. Wer eine grafische Abfrage will, braucht ein `SSH_ASKPASS`-Programm — auf Sway Atomic ist das aber ein weiteres Paket, also wieder ein Layering-Kandidat. Terminal-Abfrage einmal pro Sitzung ist der pragmatischere Weg.

#### Schritt 5 — Public Key im KAS eintragen

```nu
open $"($nu.home-path)/.ssh/id_ed25519_allinkl.pub"
```

Diese Zeile im KAS unter **Tools → SSH-Zugänge** als **zusätzliche Zeile** ins Feld *SSH-Schlüssel* einfügen — die bestehenden Zeilen bleiben unangetastet.

#### Schritt 6 — In 1Password dokumentieren

1Password verwaltet für dieses Gerät keinen privaten Schlüssel mehr, aber es bleibt die Inventarstelle. Lege ein Element an:

- **Titel:** `SSH – All-Inkl Sway Atomic (Device Key)`
- **Passphrase:** die aus Schritt 1
- **Public Key:** zur Wiedererkennung im KAS-Feld
- **Fingerprint:** `ssh-keygen -lf ~/.ssh/id_ed25519_allinkl.pub`
- **Notiz:** Hostname, Anlagedatum, wo der Key eingetragen ist

Damit kannst du bei Geräteverlust auf einen Blick sagen, welche Zeile im KAS zu löschen ist. Genau das ist der Grund, warum diese Architektur der geteilten überlegen ist.

#### Schritt 7 — Verifizieren und klonen

```nu
ssh -T allinkl
ssh-add -l
cd ~/Projekte
git clone allinkl:/www/htdocs/w017ef42/git/NoctaRow.git NoctaRow/doc
```

#### Sync ohne Git-Plugin

Falls du das Obsidian-Git-Plugin auf diesem Gerät wegen der Flatpak-Sandbox weglässt, tut es ein Nushell-Kommando in `config.nu`:

```nu
def vault-sync [] {
    let vault = ($nu.home-path | path join "Obsidian" "MeinVault")
    cd $vault
    git pull --no-rebase
    if (git status --porcelain | is-not-empty) {
        git add -A
        git commit -m $"vault backup: (date now | format date '%Y-%m-%d %H:%M')"
        git push
    } else {
        print "Keine Änderungen."
    }
}
```

Optional als systemd-User-Timer alle 15 Minuten:

`~/.config/systemd/user/vault-sync.service`:

```ini
[Unit]
Description=Obsidian Vault Sync
After=ssh-agent.service

[Service]
Type=oneshot
WorkingDirectory=%h/Obsidian/MeinVault
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/bash -lc 'git pull --no-rebase && git add -A && git diff --cached --quiet || git commit -m "vault backup: $(date -Iseconds)"; git push'
```

`~/.config/systemd/user/vault-sync.timer`:

```ini
[Unit]
Description=Obsidian Vault Sync alle 15 Minuten

[Timer]
OnBootSec=5min
OnUnitActiveSec=15min
Persistent=true

[Install]
WantedBy=timers.target
```

```nu
systemctl --user enable --now vault-sync.timer
```

> [!caution] Timer und Passphrase
> Der Timer schlägt fehl, solange der Schlüssel nicht im Agent liegt. Nach jedem Neustart also einmal `ssh -T allinkl` oder `ssh-add ~/.ssh/id_ed25519_allinkl` ausführen. Wer das nicht will, erzeugt den Schlüssel ohne Passphrase und verlässt sich auf die LUKS-Vollverschlüsselung der Platte — vertretbar, wenn das Gerät verschlüsselt ist und nicht unbeaufsichtigt entsperrt herumsteht.

#### Wenn du 1Password doch als zentrale Stelle behalten willst

Alternative ohne Layering: die 1Password-CLI ist ein einzelnes statisches Binary und passt nach `~/.local/bin` — ebenfalls außerhalb des Images.

```nu
op read "op://Private/SSH – All-Inkl Obsidian Sync/private key?ssh-format=openssh" | ssh-add -t 8h -
```

Der Schlüssel existiert dann nur im Speicher des Agents. Der Preis: ohne Desktop-App keine biometrische Entsperrung, du meldest dich per `op account add` mit Account-Passwort und Secret Key an. <cite index="43-1">Sitzungstokens laufen nach 30 Minuten Inaktivität ab.</cite> Für „einmal beim Hochfahren den Key laden" ist das verschmerzbar, für einen automatischen Timer nicht.

### 6.3 Windows ARM64 — Dell XPS 13

**Agent:** 1Password nutzt unter Windows die Named Pipe `\\.\pipe\openssh-ssh-agent`. Der Windows-eigene `ssh-agent`-Dienst muss deshalb **deaktiviert** sein, sonst konkurrieren beide um dieselbe Pipe.

In einer Admin-PowerShell:

```powershell
Stop-Service ssh-agent
Set-Service ssh-agent -StartupType Disabled
```

**`C:\Users\<DeinName>\.ssh\config`:**

```sshconfig
Host allinkl
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentitiesOnly yes
    IdentityAgent \\.\pipe\openssh-ssh-agent
    IdentityFile ~/.ssh/id_ed25519_allinkl.pub
```

**Git auf den Windows-OpenSSH-Client zwingen** — Git for Windows bringt ein eigenes `ssh.exe` mit, das die Named Pipe nicht kennt:

```powershell
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"
```

**Zeilenenden:**

```powershell
git config --global core.autocrlf false
```

In Kombination mit der `.gitattributes` aus 5.2 bleiben die Dateien konsistent.

**Klonen (Nushell auf Windows):**

```nu
cd ~/Documents/Obsidian
git clone "allinkl:/www/htdocs/w017ef42/git/obsidian-vault.git" MeinVault
```

**Agent-Konfiguration** liegt hier unter `%LOCALAPPDATA%\1Password\config\ssh\agent.toml`.

> [!note] ARM64-Hinweis
> `C:\Windows\System32\OpenSSH\ssh.exe` ist auf ARM64-Windows nativ vorhanden. Git for Windows läuft ggf. über Emulation, das ist für Repos dieser Größe irrelevant.

### 6.5 macOS

**Agent-Socket:**

```
~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock
```

`~/.ssh/config`:

```sshconfig
Host allinkl
    HostName w017ef42.kasserver.com
    User ssh-w017ef42
    IdentitiesOnly yes
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    IdentityFile ~/.ssh/id_ed25519_allinkl.pub
```

Die Anführungszeichen sind wegen der Leerzeichen im Pfad nötig.

### 6.6 Headless-Systeme (Mac mini mit Ubuntu Server)

Auf Servern ohne 1Password-GUI funktioniert der Agent nicht. Zwei saubere Wege:

**Variante A — Agent-Forwarding vom Desktop:**

```sshconfig
Host macmini
    HostName macmini.local
    User fritz
    ForwardAgent yes
```

Dann greift die Session auf dem Mac mini über den weitergereichten Agent auf deinen 1Password-Key zu. Nur für interaktive Nutzung, nicht für Cronjobs.

**Variante B — dedizierter Deploy-Key:**

Eigenes Schlüsselpaar auf dem Server, Public Key als zusätzliche Zeile im KAS-Feld. Für automatisierte Pulls (Cron/systemd-Timer) der einzig gangbare Weg.

```bash
ssh-keygen -t ed25519 -a 100 -C "macmini-deploy" -f ~/.ssh/id_ed25519_allinkl -N ""
cat ~/.ssh/id_ed25519_allinkl.pub
```

---

## 7. Teil 5 — iOS mit Working Copy

### 7.1 Das grundlegende Prinzip

Working Copy klont nicht in seinen eigenen Sandkasten, sondern verknüpft das Repo mit dem Ordner, den die Obsidian-App nutzt. <cite index="5-1">Im Repo öffnest du das Share-Menü oben rechts und wählst „Setup Folder Sync" (in aktuellen Versionen „Link Repository to Folder"), dann navigierst du unter *Auf meinem iPhone* in den Obsidian-Ordner.</cite> Danach arbeiten beide Apps auf denselben Dateien.

### 7.2 Vault-Ordner in Obsidian iOS anlegen

**Reihenfolge ist wichtig** — der Zielordner muss existieren, bevor du verlinkst.

1. Obsidian iOS öffnen
2. **Neuen Vault erstellen** → Name exakt wie später gewünscht, z. B. `MeinVault`
3. Speicherort: **Auf meinem iPhone** (nicht iCloud!)
4. Vault einmal öffnen, damit der Ordner tatsächlich angelegt wird
5. Obsidian schließen

> [!warning] Nicht iCloud wählen
> iCloud Drive und Git auf denselben Dateien führt zu Doppelsynchronisation mit unvorhersehbaren Konflikten. Entscheide dich für genau einen Mechanismus.

### 7.3 Variante A — dein 1Password-Schlüssel auf dem iPhone

Das ist der Weg, den du beschrieben hast: *ein* Schlüssel für alles.

**Einschränkung, die du kennen musst:** 1Password hat auf iOS **keinen SSH-Agent**. <cite index="23-1">Die Schlüssel werden in der iOS-App zwar angezeigt, aber nur als passive Einträge.</cite> Du musst den privaten Schlüssel also einmalig aus 1Password kopieren und in Working Copy importieren — er liegt danach zusätzlich im Keychain-geschützten Speicher von Working Copy.

**Schritte:**

1. 1Password iOS → Element `SSH – All-Inkl Obsidian Sync` öffnen
2. Beim Feld *Privater Schlüssel* → **Kopieren** → Format **OpenSSH** wählen
3. Working Copy → **Einstellungen → SSH-Schlüssel → Schlüssel importieren → Aus Zwischenablage**
4. Zwischenablage danach überschreiben (irgendetwas Harmloses kopieren)

> [!bug] Formatfalle
> Wird der Schlüssel als PKCS#8 statt OpenSSH kopiert, meldet Working Copy einen Parse-Fehler. Achte auf den Header `-----BEGIN OPENSSH PRIVATE KEY-----`. Wenn 1Password dir das Format nicht anbietet, nimm den Weg über Abschnitt 3.3: lokal mit `ssh-keygen` erzeugen, Textdatei sicher aufs iPhone bringen, importieren, Datei löschen.

### 7.4 Variante B — eigener Schlüssel für das iPhone (empfohlen)

Sicherheitstechnisch die deutlich bessere Wahl, und kaum mehr Aufwand:

1. Working Copy → **Einstellungen → SSH-Schlüssel → Schlüssel generieren** → Ed25519
2. Public Key kopieren (Share-Menü)
3. Im KAS unter **Tools → SSH-Zugänge** als **zusätzliche Zeile** im Feld *SSH-Schlüssel* einfügen
4. Public Key zur Dokumentation in 1Password ablegen (als Notiz beim bestehenden Element)

**Der Vorteil:** Geht das iPhone verloren, entfernst du genau eine Zeile im KAS. Alle anderen Geräte laufen weiter. Bei Variante A müsstest du den Schlüssel überall austauschen.

Der private Schlüssel verlässt in dieser Variante nie das Gerät — genau wie beim 1Password-Agent auf dem Desktop. Das Prinzip bleibt also konsistent, nur die Verwaltungsstelle ist der KAS statt 1Password.

### 7.5 Repository klonen und verlinken

1. Working Copy → **+** → **Clone repository**
2. URL:
   ```
   ssh://ssh-w017ef42@w017ef42.kasserver.com/www/htdocs/w017ef42/git/NoctaRow.git
   ```
3. Authentifizierung: den in 7.3/7.4 eingerichteten Schlüssel wählen
4. Host-Key-Abfrage bestätigen
5. Nach dem Klonen: Repo öffnen → **Share-Symbol** oben rechts → **Link Repository to Folder**
6. Navigieren zu: **Auf meinem iPhone → Obsidian → MeinVault**
7. **Fertig** antippen

> [!tip] Push braucht Working Copy Pro
> Klonen und Lesen funktionieren in der kostenlosen Version. Für `push` ist der Einmalkauf nötig. Wer den Vault nur unterwegs lesen will, kommt ohne aus.

### 7.6 Erste Kontrolle

Obsidian öffnen. Deine Notizen müssen da sein.

<cite index="1-1">Nach dem Sync auf ein neues Gerät kann es nötig sein, das Theme in den Einstellungen unter *Erscheinungsbild* neu zu aktivieren. Außerdem sollte man in Working Copy prüfen, ob doppelte Konfigurationsdateien entstanden sind — etwa `app.json` und `app.json-2` — und diese manuell zusammenführen.</cite>

### 7.7 Automatisierung per Kurzbefehle

Working Copy stellt Shortcuts-Aktionen bereit. Zwei Kurzbefehle genügen:

**Kurzbefehl „Vault Pull":**
1. Aktion *Working Copy → Pull* → Repository auswählen
2. Optional: *Warten* 2 Sekunden
3. Aktion *App öffnen → Obsidian*

**Kurzbefehl „Vault Push":**
1. Aktion *Working Copy → Commit* → Repository, Nachricht z. B. `Mobile: [Aktuelles Datum]`
2. Aktion *Working Copy → Push*

**Automationen** (Kurzbefehle-App → Automation → Persönliche Automation → App):
- *Obsidian wird geöffnet* → „Vault Pull" ausführen
- *Obsidian wird geschlossen* → „Vault Push" ausführen

„Vor Ausführung fragen" deaktivieren, sonst nervt es.

> [!caution] Realistische Erwartung
> iOS beendet Hintergrundprozesse aggressiv. Die „App geschlossen"-Automation feuert nicht immer zuverlässig. Rechne damit, gelegentlich manuell zu pushen — und pull **immer** bevor du auf einem anderen Gerät weiterarbeitest.

### 7.8 Warum nicht das Obsidian-Git-Plugin auf iOS?

Es existiert, läuft aber über `isomorphic-git` in JavaScript. Kein SSH-Support (nur HTTPS mit Token), und bei Vaults jenseits weniger hundert Dateien wird es spürbar zäh. Working Copy nutzt natives libgit2 und ist auf iOS klar der robustere Weg.

---

## 8. Teil 6 — Obsidian Git Plugin auf dem Desktop

Auf Linux/Windows/macOS nimmst du das Community-Plugin **Obsidian Git**, damit du nicht ständig ins Terminal wechselst.

**Installation:** Einstellungen → Community-Plugins → Durchsuchen → *Obsidian Git*

**Empfohlene Konfiguration:**

| Einstellung | Wert | Begründung |
|---|---|---|
| Vault backup interval | `10` Minuten | Häufig genug, um Arbeit nicht zu verlieren |
| Auto pull interval | `10` Minuten | Holt Änderungen anderer Geräte |
| Pull updates on startup | ✅ | Verhindert Divergenz direkt beim Start |
| Push on backup | ✅ | Sonst bleibt alles lokal |
| Commit message | `vault backup: {{date}}` | — |
| Disable notifications | ✅ | Sonst Dauerfeuer |
| Sync method | `merge` | `rebase` bricht bei Konflikten unangenehm ab |

> [!important] Auf genau einem Gerät reicht ein kurzes Intervall
> Wenn drei Rechner alle zehn Minuten committen, produzierst du Merge-Commits ohne Ende. Setze das aktive Arbeitsgerät auf 10 Minuten, die anderen auf 60 oder manuell.

---

## 9. Konfliktbehandlung

### 9.1 Vorbeugen ist alles

1. **Pull vor dem Bearbeiten.** Immer. Auf jedem Gerät.
2. **Push nach dem Bearbeiten.** Bevor du das Gerät weglegst.
3. **Nicht gleichzeitig auf zwei Geräten in derselben Notiz arbeiten.**

Wer diese drei Regeln einhält, sieht praktisch nie einen Konflikt.

### 9.2 Wenn doch einer auftritt

Auf dem Desktop:

```bash
cd ~/Obsidian/MeinVault
git status
```

Konfliktdateien enthalten die üblichen Marker. Da Markdown reiner Text ist, lässt sich das in Obsidian selbst auflösen — die Datei öffnen, `<<<<<<<`, `=======`, `>>>>>>>` bereinigen, speichern.

```bash
git add .
git commit -m "Konflikt aufgelöst"
git push
```

In Working Copy: das Repo zeigt Konflikte an, tippen öffnet einen dreispaltigen Merge-Editor.

### 9.3 Notausstieg

Wenn ein Gerät hoffnungslos divergiert ist und du weißt, dass der Server den richtigen Stand hat:

```bash
git fetch origin
git reset --hard origin/main
```

> [!danger] Datenverlust
> `reset --hard` verwirft alle lokalen, nicht gepushten Änderungen unwiderruflich. Vorher mit `git stash` oder einer Kopie des Ordners absichern.

---

## 10. Wartung

### 10.1 Repository auf dem Server komprimieren

Alle paar Monate per SSH:

```bash
cd ~/git/obsidian-vault.git
git gc --aggressive --prune=now
git count-objects -vH
```

Lässt sich auch als Cronjob im KAS einrichten (Tools → Cronjobs), monatlich reicht völlig.

### 10.2 Backup des Backups

Ein Git-Remote ist **kein Backup** — ein versehentliches `push --force` propagiert überall hin. Zusätzlich empfehlenswert:

```bash
# Auf dem Mac mini, wöchentlich per systemd-Timer
git clone --mirror allinkl:/www/htdocs/w017ef42/git/obsidian-vault.git \
  /srv/backup/obsidian-vault-$(date +%Y%m%d).git
```

### 10.3 Schlüssel rotieren

Einmal jährlich oder bei Geräteverlust:

1. Neuen Ed25519-Key in 1Password erzeugen
2. Public Key im KAS **zusätzlich** eintragen (alter bleibt vorerst drin)
3. Alle Geräte testen
4. Alte Zeile im KAS löschen
5. Altes 1Password-Element archivieren

---

## 11. Fehlerdiagnose

| Symptom | Ursache | Lösung |
|---|---|---|
| `Permission denied (publickey)` | Key nicht im KAS oder Agent inaktiv | `ssh -v` prüfen, KAS-Feld kontrollieren |
| `Error connecting to agent` | 1Password läuft nicht / Flatpak-Version | Native Installation, Agent in Einstellungen aktivieren |
| Windows: Agent wird ignoriert | Git nutzt eigenes `ssh.exe` | `core.sshCommand` setzen (6.4) |
| Sway Atomic: `Could not open a connection to your authentication agent` | User-Unit läuft nicht oder `SSH_AUTH_SOCK` fehlt | `systemctl --user status ssh-agent`, `environment.d` prüfen (6.3) |
| Flatpak-Obsidian: Git-Plugin kann nicht pushen | Socket nicht in die Sandbox durchgereicht | `flatpak override --filesystem=xdg-run/ssh-agent.socket` (6.3) |
| Jede Datei erscheint geändert | CRLF/LF-Mischung | `.gitattributes` + `core.autocrlf false`, dann `git add --renormalize .` |
| `app.json-2` und ähnliche Dubletten | Konflikt in `.obsidian/` | Manuell zusammenführen, ggf. mehr in `.gitignore` |
| Working Copy: „invalid format" beim Key-Import | PKCS#8 statt OpenSSH | Format umstellen, siehe 7.3 |
| Push extrem langsam | Repo aufgebläht durch Binärdateien | `git gc`, Bilder auslagern |
| iOS: Obsidian sieht Dateien nicht | Ordner-Link falsch gesetzt | Link Repository to Folder wiederholen, Zielordner prüfen |

**Diagnosebefehl, der fast alles zeigt:**

```bash
ssh -vvv allinkl 2>&1 | grep -iE "offering|identity|authenticated|agent"
```

---

## 12. Sicherheitsbewertung

**Was gut ist:**
- Private Key existiert auf Desktops nicht als Datei
- Jede Nutzung erfordert biometrische Freigabe
- Ed25519, keine Passwortauthentifizierung nötig
- Repo liegt außerhalb des Web-Roots

**Was du im Blick behalten solltest:**
- **Der Webspace ist kein Zero-Knowledge-Speicher.** All-Inkl kann technisch auf die Dateien zugreifen. Für hochsensible Inhalte wäre zusätzlich [git-crypt](https://github.com/AGWA/git-crypt) oder ein verschlüsselter Teil-Vault sinnvoll — allerdings unterstützt Working Copy das nicht, du verlierst also den iOS-Zugriff darauf.
- **Variante A (ein Key überall)** bedeutet: ein kompromittiertes Gerät kompromittiert den Zugang aller. Variante B ist deshalb die bessere Architektur, auch wenn sie mehr KAS-Zeilen bedeutet. Auf Fedora Sway Atomic ergibt sich diese Variante ohnehin zwangsläufig (6.3) — was ein Hinweis darauf ist, dass sie der eigentlich richtige Default für die ganze Flotte wäre.
- **Ein Gerätekey auf Platte hängt an der Vollverschlüsselung.** Ohne LUKS ist eine Passphrase auf dem Schlüssel Pflicht, nicht Kür.
- **Der SSH-Zugang bei All-Inkl ist nicht auf Git beschränkt.** Wer den Key hat, hat eine volle Shell auf deinem Webspace — inklusive der Verzeichnisse von t3md.de. Das ist ein Argument mehr für gerätespezifische Schlüssel.

---

## 13. Checkliste zum Abhaken

- [ ] All-Inkl-Tarif Premium bestätigt
- [ ] SSH im KAS aktiviert
- [ ] Ed25519-Key in 1Password erzeugt
- [ ] Public Key im KAS hinterlegt
- [ ] SSH-Login ohne Passwort erfolgreich
- [ ] Bares Repo `~/git/obsidian-vault.git` angelegt
- [ ] `.htaccess`-Schutz gesetzt und im Browser verifiziert
- [ ] `.gitignore` und `.gitattributes` im Vault
- [ ] Initialer Push vom Hauptrechner
- [ ] CachyOS: geklont, Agent-Socket konfiguriert
- [ ] Fedora: geklont, Agent-Socket konfiguriert
- [ ] Sway Atomic: Gerätekey erzeugt, `ssh-agent.service` aktiv, KAS-Zeile ergänzt, in 1Password dokumentiert
- [ ] Windows ARM64: `ssh-agent`-Dienst deaktiviert, `core.sshCommand` gesetzt, geklont
- [ ] iOS: Vault-Ordner lokal angelegt
- [ ] iOS: Working Copy Schlüssel eingerichtet
- [ ] iOS: Repo geklont und mit Ordner verlinkt
- [ ] iOS: Shortcuts-Automationen angelegt
- [ ] Obsidian-Git-Plugin auf allen Desktops konfiguriert
- [ ] Testnotiz auf jedem Gerät erstellt und auf allen anderen gesehen
- [ ] Backup-Mirror eingerichtet

---

## Verwandte Notizen

- [[Git-Server Mac mini Ubuntu]]
- [[t3md.de Deployment-Pipeline]]
- [[1Password SSH-Agent Grundlagen]]

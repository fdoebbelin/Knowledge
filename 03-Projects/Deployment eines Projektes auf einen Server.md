---
title: Git-Deploy auf eigenem Server (Bare-Repo + Auto-Checkout), Bash
created: 2026-06-10
tags:
  - git
  - deployment
  - ssh
  - self-hosted
  - bash
  - ubuntu-server
---
# Git-Deploy auf eigenem Server – Bare-Repo + Auto-Deploy (Bash)

> [!info] Topologie
> - **Server** = der Ubuntu-Rechner (macmini), `sshd` läuft bereits. Hier liegen das **Bare-Repo** und der **Auto-Deploy-Hook**.
> - **Client** = der Rechner, von dem du pushst. Bei jedem `git push` checkt der Server automatisch ins Webverzeichnis aus.
> - Shell ist **Bash** auf beiden Seiten.

> [!tip] Server = Client?
> Wenn du direkt auf dem macmini entwickelst, brauchst du **Phase 1 (SSH) nicht**. Setze dann in Phase 3 einfach einen lokalen Pfad als Remote:
> ```bash
> git remote add origin "${GIT_DIR}"
> ```

---

## Variablen

> [!important] In **jeder** Shell-Sitzung setzen (oder in Datei legen und `source ./vars.sh`). Sind Server und Client verschiedene Rechner, müssen die **geteilten** Werte (`GIT_USER`, `SERVER_HOST`, `REPO`, `GIT_HOME`) auf beiden Seiten identisch sein.

```bash
# ── Server (Ziel) ─────────────────────────────────────────
GIT_USER="git"                      # User auf dem Server, dem Repo + SSH gehören
SERVER_HOST="macmini.local"         # Hostname oder IP des Servers
REPO="webprojekt"                   # Projekt-/Repo-Name
GIT_HOME="/home/${GIT_USER}/git"    # Basisverzeichnis für Bare-Repos
WEB_ROOT="/var/www/${REPO}"         # Auscheck-/Deploy-Ziel

# ── Client (lokal) ────────────────────────────────────────
SSH_ALIAS="deploy"                  # frei wählbarer Host-Alias in ~/.ssh/config
KEY_EMAIL="user@example.com"        # Kommentar im SSH-Key
KEY_FILE="${HOME}/.ssh/${SSH_ALIAS}"

# ── Abgeleitet (unverändert lassen) ───────────────────────
GIT_DIR="${GIT_HOME}/${REPO}.git"
LOCAL_PROJECT="${HOME}/projects/${REPO}"
```

---

## Phase 1: SSH-Zugang einrichten (Client → Server)

> [!note] `sshd` ist bereits konfiguriert – es geht hier nur darum, deinen Client per Schlüssel zu autorisieren.

### 1.1 SSH-Schlüsselpaar erzeugen (auf dem Client)

```bash
ssh-keygen -t ed25519 -C "${KEY_EMAIL}" -f "${KEY_FILE}"

# Berechtigungen prüfen
ls -l "${KEY_FILE}" "${KEY_FILE}.pub"
# privat → 600, öffentlich → 644
```

> [!tip] Für unbeaufsichtigte Pushes einen Schlüssel **ohne Passphrase** (`-N ""`) oder einen `ssh-agent` verwenden.

### 1.2 SSH-Config anlegen (auf dem Client)

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh

cat >> ~/.ssh/config <<EOF

Host ${SSH_ALIAS}
    HostName ${SERVER_HOST}
    User ${GIT_USER}
    IdentityFile ${KEY_FILE}
    IdentitiesOnly yes
EOF

chmod 600 ~/.ssh/config
```

### 1.3 Public Key auf den Server übertragen

```bash
# Einfachste Variante (fragt einmalig nach dem Passwort von ${GIT_USER})
ssh-copy-id -i "${KEY_FILE}.pub" "${SSH_ALIAS}"

oder

# 1. Public Key ins Home-Verzeichnis des Servers kopieren
scp "${KEY_FILE}.pub" "${SSH_ALIAS}:newkey.pub"

# 2. Auf dem Server anhängen, Rechte setzen, aufräumen
ssh "${SSH_ALIAS}" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && tr -d '\r' < newkey.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && rm newkey.pub"

# Test – sollte ohne Passwort durchlaufen
ssh "${SSH_ALIAS}" 'echo "SSH-Key funktioniert!"'
```

> [!note] Ist auf dem Server die Passwort-Anmeldung deaktiviert, trägst du den Inhalt von `${KEY_FILE}.pub` direkt auf dem Server in `/home/${GIT_USER}/.ssh/authorized_keys` ein (lokal an der Konsole oder über einen bestehenden Zugang).

---

## Phase 2: Bare-Repository + Auto-Deploy-Hook (auf dem Server)

> [!info] Diese Befehle laufen **auf dem macmini** als `${GIT_USER}` in Bash.

```bash
# Bare-Repo anlegen
mkdir -p "${GIT_DIR}"
cd "${GIT_DIR}"
git init --bare -b main

# Deploy-Ziel vorbereiten
mkdir -p "${WEB_ROOT}"

# Post-Receive-Hook: bei jedem Push ins Webverzeichnis auschecken
cat > hooks/post-receive <<HOOK
#!/bin/sh
echo "▸ Deployment gestartet..."
git --work-tree="${WEB_ROOT}" --git-dir="${GIT_DIR}" checkout -f
echo "▸ Deployment abgeschlossen."
HOOK

chmod +x hooks/post-receive
```

> [!warning] Schreibrechte auf `${WEB_ROOT}`
> Der Hook läuft als `${GIT_USER}` – dieser User muss in `${WEB_ROOT}` schreiben dürfen, sonst schlägt der Checkout fehl. Bei einem Pfad wie `/var/www/...` einmalig anpassen:
> ```bash
> sudo chown -R "${GIT_USER}:${GIT_USER}" "${WEB_ROOT}"
> ```
> Wird `${WEB_ROOT}` von einem Webserver (nginx/Apache) ausgeliefert, ggf. stattdessen Gruppenrechte (`www-data`) setzen.

> [!note] Sehr alte Git-Version ohne `-b`-Flag:
> ```bash
> cd "${GIT_DIR}" && git symbolic-ref HEAD refs/heads/main
> ```

---

## Phase 3: Lokales Repository + Push (auf dem Client)

```bash
mkdir -p "${LOCAL_PROJECT}"
cd "${LOCAL_PROJECT}"
git init -b main

# Remote über den SSH-Alias (absoluter Pfad zum Bare-Repo)
git remote add origin "${SSH_ALIAS}:${GIT_DIR}"
```

### Erster Push & Deploy

```bash
echo "<h1>${REPO}</h1>" > index.html

git add -A
git commit -m "Initiales Deployment"
git push -u origin main
# → der post-receive-Hook checkt automatisch nach ${WEB_ROOT} aus
```

---

## Schnellreferenz

```bash
# Verbindung testen
ssh "${SSH_ALIAS}" 'echo ok'

# Deploy = einfach pushen
git push origin main

# Auf dem Server prüfen, was deployt wurde
ssh "${SSH_ALIAS}" "ls -la '${WEB_ROOT}'"
```

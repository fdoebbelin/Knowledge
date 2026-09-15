### Variante 1: SSH-Verbindung einrichten

Einmalige Einrichtung, um ohne Passwort mit GitHub zu arbeiten.

```bash
# SSH-Key generieren
ssh-keygen -t ed25519 -C "deine@email.de"

# SSH-Agent starten und Key hinzufügen
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Öffentlichen Key anzeigen und bei GitHub hinterlegen
# → github.com > Settings > SSH and GPG keys > New SSH key
cat ~/.ssh/id_ed25519.pub

# Verbindung testen
ssh -T git@github.com
```

Remote-URL mit SSH (statt HTTPS) verwenden:

```bash
git remote add origin git@github.com:username/repo-name.git
```

---

### Variante 2: Neues Repository anlegen

Lokales Verzeichnis initialisieren und mit GitHub verknüpfen.

```bash
echo "# repo-name" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/username/repo-name.git
git push -u origin main
```

---

### Variante 3: Bestehendes Repository pushen

Bereits vorhandenes lokales Git-Repo mit einem neuen GitHub-Repo verbinden.

```bash
git remote add origin https://github.com/username/repo-name.git
git branch -M main
git push -u origin main
```

### Problem: Kein HTTPS-Login mehr unter GitHub

Seit dem 13. August 2021 akzeptiert GitHub keine normalen Account-Passwörter mehr
für Git-Operationen.  Der Grund: Passwort-basierte Authentifizierung birgt
Risiken wie Phishing oder gestohlene Passwörter.  Stattdessen sind
token-basierte Verfahren erforderlich – also SSH-Keys oder Personal Access Tokens (PAT).

**Alternativen auf der Kommandozeile:**
- **SSH** (empfohlen): einmalig einrichten, danach passwortlos arbeiten
- **Personal Access Token**: Token statt Passwort bei HTTPS-Verbindungen verwenden

**Für Windows ohne Kommandozeile:** [GitHub Desktop](https://desktop.github.com)
übernimmt die Authentifizierung grafisch und erspart die manuelle SSH-Einrichtung.
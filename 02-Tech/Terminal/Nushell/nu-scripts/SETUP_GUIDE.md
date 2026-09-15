# 🔐 Setup-Anleitung & Git-Authentifizierung

## Schritt 1: Repository klonen

#### Option A: SSH (Empfohlen für häufige Updates)

**Vorteile:**
- ✅ Keine Passwort-Prompts nach Setup
- ✅ Höhere Sicherheit (Public-Key-Kryptographie)
- ✅ Ideal für tägliche Synchronisation

**Setup:**

1. **SSH-Key generieren** (falls noch nicht vorhanden):
```
ssh-keygen -t ed25519 -C "frd@doebbelin.net"
```
- Dateiname: `~/.ssh/id_ed25519` (default, Enter drücken)
- Passphrase: Optional, aber empfohlen

2. **SSH-Agent starten** (macOS/Linux):
```
eval "\$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

3. **Öffentlichen Schlüssel zu GitHub hinzufügen**:
```
cat ~/.ssh/id_ed25519.pub
```
- Kopiere den Output
- Gehe zu **GitHub → Settings → SSH and GPG keys**
- Klicke **New SSH key**
- Füge deinen Public Key ein und speichere

4. **Test der SSH-Verbindung**:
```
ssh -T git@github.com
# Erwartet: "Hi fdoebbelin! You've successfully authenticated..."
```

5. **Repository mit SSH klonen**:
```
git clone git@github.com:fdoebbelin/nu-scripts.git ~/.config/nushell/scripts
```

---
#### Option B: HTTPS (Einfacher für Anfänger)

**Vorteile:**
- ✅ Keine Schlüssel-Verwaltung nötig
- ✅ Funktioniert überall (auch hinter Firewalls)
- ❌ Token muss regelmäßig eingegeben werden (mit Caching)

**Setup:**

1. **GitHub Personal Access Token (PAT) erstellen**:
- Gehe zu **GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)**
- Klicke **Generate new token (classic)**
- Gib einen Namen ein (z.B. `nu-scripts`)
- Wähle Scopes: ✓ `repo` (vollständiger Zugriff auf Repos)
- Klicke **Generate token**
- **Speichere den Token sicher** (nur einmal sichtbar!)

2. **Git Credentials Caching aktivieren** (optional, empfohlen):
```
# Credentials für 1 Stunde speichern

git config --global credential.helper cache
git config --global credential.helper timeout 3600

# Oder für macOS (verschlüsselter):

git config --global credential.helper osxkeychain
```

3. **Repository mit HTTPS klonen**:
```
git clone https://github.com/fdoebbelin/nu-scripts.git ~/.config/nushell/scripts
```
- Username: `fdoebbelin`
- Password: *Dein GitHub Personal Access Token*

---

## Vergleich: SSH vs. HTTPS

| Aspekt | SSH | HTTPS |
|--------|-----|-------|
| **Setup-Komplexität** | Mittel (Key-Generierung) | Niedrig (nur Token) |
| **Sicherheit** | Sehr Hoch (Cryptographic Keys) | Hoch (TLS + Token) |
| **Passwordlose Ops** | ✅ Ja (nach ssh-agent Setup) | ❌ Nein (Token nötig) |
| **Firewalls** | Kann Port 22 blockieren | ✅ Funktioniert überall (Port 443) |
| **Best für** | Daily Workflows, mehrere Machines | Schneller Start, Anfänger |
| **Empfohlen** | 🏆 Ja | Fallback |

---

## Schritt 2: Automatische Synchronisation einrichten

Füge dies zu `~/.config/nushell/env.nu` hinzu:

```
# ============================================
# Auto-sync custom scripts on first start
# ============================================

let scripts_dir = $"($nu.default-config-dir)/scripts"
let repo_url = "git@github.com:fdoebbelin/nu-scripts.git"

# Beim ersten Start: Repo klonen

if not (\$scripts_dir | path exists) {
	print "🔄 Initiale Synchronisation von nu-scripts..."
	try {
		mkdir \$scripts_dir
		cd \$scripts_dir
		if \$env.OS == "Windows" {
			git clone \$repo_url .
		} else {
			git clone \$repo_url . 2>\&1 | null
		}
		print "✅ Scripts erfolgreich synchronisiert!"
	} catch { |err|
		print $"⚠️  Git-Synchronisation fehlgeschlagen: ($err.msg)"
	}
}
```

---

## Schritt 3: Update-Funktion hinzufügen

Füge dies zu `~/.config/nushell/config.nu` hinzu:

```
# ============================================
# Update custom scripts from GitHub
# ============================================

def nu-scripts-update [] {
	let scripts_dir = $"($nu.default-config-dir)/scripts"
	
	if ($scripts_dir | path exists) {
		print "🔄 Aktualisiere Scripts..."
		try {
			git -C $scripts_dir pull --quiet
			print "✅ Scripts aktualisiert!"
		} catch { |err|
			print $"❌ Update fehlgeschlagen: ($err.msg)"
		}
	} else {
		print "❌ Scripts-Verzeichnis nicht gefunden"
	}
}
```

---

# SSH-Tipps für häufige Probleme

## Problem: "Permission denied (publickey)"

```
# 1. Prüfe, ob SSH-Key existiert
ls -la ~/.ssh/id_ed25519

# 2. Prüfe SSH-Agent
ssh-add -l

# 3. Wenn leer: ssh-agent starten
eval "\$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 4. Test
ssh -T git@github.com
```

## Problem: SSH-Key Passphrase wird immer abgefragt

**Lösung 1: SSH-Agent automatisch starten** (~/.zshrc oder ~/.bashrc):
```
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
```

**Lösung 2: SSH-Key ohne Passphrase** (weniger sicher):
```
ssh-keygen -t ed25519 -C "deine.email@example.com" -N ""
```

## Problem: "Port 22 blocked" (Corporate Firewall)

SSH über HTTPS-Port (443) verwenden:

```
# Erstelle ~/.ssh/config
cat >> ~/.ssh/config << EOF
Host github.com
Hostname ssh.github.com
Port 443
User git
IdentityFile ~/.ssh/id_ed25519
EOF

# Test
ssh -T git@github.com

```

---

# Empfehlung für dich (fdoebbelin)

**SSH + SSH-Agent** 🏆

1. Einmalig SSH-Key generieren
2. SSH-Agent in Shell-RC automatisieren
3. Never, ever Passphrase eingeben müssen
4. Höchste Sicherheit ohne Reibung

```
# Schnell-Setup:
ssh-keygen -t ed25519 -C "deine.email@example.com"

# → GitHub → Settings → SSH keys → Add key
# → Done! 🚀
```
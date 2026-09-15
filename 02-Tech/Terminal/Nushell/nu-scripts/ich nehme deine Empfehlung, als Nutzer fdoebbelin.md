<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# ich nehme deine Empfehlung, als Nutzer fdoebbelin verwenden und das Vorgehen für den Aufbau und die Verwendung des Repos beschreiben mit README und 3 sinnvollen Custom Commands für Punkt 4 deiner Empfehlung, gehe bitte auch auf die Möglichkeiten der Authentifizierung für den git push

Perfekt! Ich erstelle dir jetzt ein vollständiges Projekt-Setup mit README, 3 praktischen Custom Commands für die empfohlenen Module und Details zur Git-Authentifizierung.

# 📦 Vollständiges Projekt-Setup: `fdoebbelin/nu-scripts`


***

## 1. Repository-Struktur

```
nu-scripts/
├── README.md                    # Hauptdokumentation
├── SETUP_GUIDE.md              # Detaillierte Setup-Anleitung
├── CONTRIBUTING.md              # Beitrags-Richtlinien
├── LICENSE                      # MIT License
├── .gitignore
├── setup.sh                     # Installationsskript
├── scripts/
│   ├── utils/
│   │   ├── module.nu           # Allgemeine Utilities
│   │   └── README.md
│   ├── git/
│   │   ├── module.nu           # Git-Helper & Shortcuts
│   │   └── README.md
│   └── system/
│       ├── module.nu           # System-Commands
│       └── README.md
└── examples/
    └── config-snippet.nu       # Wie man die Scripts lädt
```


***

## 2. README.md

```markdown
# nu-scripts

Persönliche Nushell Custom Commands und Module für `fdoebbelin`, organisiert und über GitHub synchronisiert.

## 📋 Features

- **`utils`** - Hilfsfunktionen und allgemeine Utilities
- **`git`** - Git-Workflows und Shortcuts
- **`system`** - Systemverwaltungs-Commands

Alle Module werden automatisch beim ersten Start synchronisiert und können jederzeit aktualisiert werden.

## 🚀 Schnellstart

### 1. Automatische Installation (Empfohlen)

Die Scripts synchronisieren sich automatisch beim ersten Start von Nushell:

```


# Kein Setup notwendig – einfach Nushell starten!

# Die Synchronisation findet automatisch statt.

```

### 2. Manuelle Installation

```


# Clone das Repository

git clone https://github.com/fdoebbelin/nu-scripts.git ~/.config/nushell/scripts

# Oder verwende das Setup-Skript

bash ~/.config/nushell/scripts/setup.sh

```

### 3. In config.nu einbinden

Füge folgendes zu deiner `~/.config/nushell/config.nu` hinzu:

```


# Load custom scripts modules

let scripts_dir = $"($nu.default-config-dir)/scripts"
use ($"($scripts_dir)/utils/module.nu")
use ($"($scripts_dir)/git/module.nu")
use ($"($scripts_dir)/system/module.nu")

```

## 📚 Verfügbare Commands

### Utils Modul
- `llm [path]` - Detaillierte Dateigrößen-Analyse
- `tree [--max-depth N]` - Schöne Verzeichnis-Struktur
- `uuid` - Generiere UUID v4

### Git Modul
- `gs` - Git Status mit verbesserter Anzeige
- `gc [message]` - Schneller Git Commit
- `grh [n]` - Letzte N Commits zurücksetzen

### System Modul
- `sysinfo` - Umfassende Systeminfo
- `lsd` - Enhanced `ls` mit Details
- `portinfo [port]` - Port-Nutzung prüfen

## 🔄 Autom. Synchronisation

Die Scripts synchronisieren sich automatisch beim ersten Start. Um manuell zu aktualisieren:

```


# In deiner Nushell-Session:

nu-scripts-update

```

## 🔐 Git-Authentifizierung

Siehe [SETUP_GUIDE.md](SETUP_GUIDE.md) für Details zur SSH- oder HTTPS-Authentifizierung.

## 🤝 Contributing

Beiträge sind willkommen! Siehe [CONTRIBUTING.md](CONTRIBUTING.md).

## 📄 Lizenz

MIT – siehe [LICENSE](LICENSE) Datei.

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts
```


***

## 3. SETUP_GUIDE.md (Git-Authentifizierung)

```markdown
# 🔐 Setup-Anleitung & Git-Authentifizierung

## Schritt 1: Repository klonen

### Option A: SSH (Empfohlen für häufige Updates)

**Vorteile:**
- ✅ Keine Passwort-Prompts nach Setup
- ✅ Höhere Sicherheit (Public-Key-Kryptographie)
- ✅ Ideal für tägliche Synchronisation

**Setup:**

1. **SSH-Key generieren** (falls noch nicht vorhanden):
```

ssh-keygen -t ed25519 -C "deine.email@example.com"

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

### Option B: HTTPS (Einfacher für Anfänger)

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
let repo_url = "https://github.com/fdoebbelin/nu-scripts.git"  \# SSH: "git@github.com:fdoebbelin/nu-scripts.git"

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

Dann einfach aufrufen:
```

nu-scripts-update

```

---

## SSH-Tipps für häufige Probleme

### Problem: "Permission denied (publickey)"

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

### Problem: SSH-Key Passphrase wird immer abgefragt

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

### Problem: "Port 22 blocked" (Corporate Firewall)

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

## Empfehlung für dich (fdoebbelin)

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
```


***

## 4. Die 3 Custom Command Module

### 4.1 `scripts/utils/module.nu`

```nu
# ============================================
# Utils Module - Allgemeine Hilfsfunktionen
# ============================================

# Detaillierte Dateigrößen-Analyse (Linux/macOS: du-Alternative)
def llm [path: string = "."] {
    let folder_size = if ($path | path exists) {
        du -sh $path | get 0.0
    } else {
        "N/A"
    }
    
    let details = ls -la $path | select name size modified
    
    {
        path: ($path | path expand)
        total_size: $folder_size
        item_count: ($details | length)
        details: $details
    } | table -e
}

# Schöne Verzeichnis-Struktur (tree-Alternative)
def tree [
    --max-depth (-d): int = 3
    path: string = "."
] {
    def _tree_impl [prefix: string, current_depth: int, max_depth: int] {
        if $current_depth > $max_depth {
            return
        }
        
        let items = (ls $in | sort-by name | select name)
        let count = ($items | length)
        
        $items | each { |item|
            let is_last = ($item.name == $items.($count - 1).name)
            let connector = (if $is_last { "└── " } else { "├── " })
            let extension = (if $is_last { "    " } else { "│   " })
            
            print $"($prefix)($connector)($item.name)"
            
            if ($"($in)/($item.name)" | path exists) and (
                ls $"($in)/($item.name)" | length) > 0) {
                _tree_impl $"($prefix)($extension)" ($current_depth + 1) $max_depth
            }
        }
    }
    
    print $path
    (_tree_impl "" 1 $max_depth)
}

# Generiere UUID v4
def uuid [] {
    # Nutzt /dev/urandom für echte Zufälligkeit
    if ($nu.os-info.name == "windows") {
        # Windows: PowerShell-Fallback
        pwsh -NoProfile -Command "[guid]::NewGuid().ToString()"
    } else {
        # Linux/macOS: uuidgen oder openssl
        if (which uuidgen | is-empty) {
            openssl rand -hex 16 | str substring 0..8,9..13,14..18,19..23,24..36
        } else {
            uuidgen | str downcase
        }
    }
}

# Text mit Farben ausgeben
def colored [color: string = "blue"] {
    let text = $in
    match $color {
        "red" => { $text | ansi red }
        "green" => { $text | ansi green }
        "blue" => { $text | ansi blue }
        "yellow" => { $text | ansi yellow }
        "cyan" => { $text | ansi cyan }
        _ => { $text }
    }
}

# Datei-Hash berechnen (MD5, SHA256)
def hash-file [
    --algorithm (-a): string = "sha256"
    path: string
] {
    if not ($path | path exists) {
        error make { msg: $"Datei nicht gefunden: ($path)" }
    }
    
    if $algorithm == "md5" {
        if ($nu.os-info.name == "windows") {
            certutil -hashfile $path MD5 | lines | get 1 | str trim
        } else {
            open --raw $path | md5sum | get 0
        }
    } else {
        if ($nu.os-info.name == "windows") {
            certutil -hashfile $path SHA256 | lines | get 1 | str trim
        } else {
            open --raw $path | sha256sum | get 0
        }
    }
}
```


***

### 4.2 `scripts/git/module.nu`

```nu
# ============================================
# Git Module - Git-Helper & Shortcuts
# ============================================

# Git Status mit Farben und Icons
def gs [] {
    let status = (git status --porcelain)
    let branch = (git rev-parse --abbrev-ref HEAD)
    let ahead_behind = (git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null || echo "0 0")
    
    print $"📦 Branch: ($branch | ansi green)\n"
    
    if ($status | is-empty) {
        print "✅ Alles clean!"
    } else {
        print "📝 Änderungen:\n"
        print $status
    }
    
    if ($ahead_behind != "0 0") {
        print $"\n🔄 Remote-Status: ($ahead_behind)"
    }
}

# Git Commit mit Nachrichten-Template
def gc [message: string] {
    if ($message | is-empty) {
        error make { msg: "Bitte eine Commit-Message angeben: gc 'Deine Message'" }
    }
    
    try {
        git add --all
        git commit -m $message
        print $"✅ Commit: ($message | ansi green)"
    } catch { |err|
        print $"❌ Fehler: ($err.msg | ansi red)"
    }
}

# Schneller Push mit Fehlerbehandlung
def gp [] {
    try {
        print "🚀 Pushe zu Remote..."
        git push
        print "✅ Push erfolgreich!"
    } catch { |err|
        print $"❌ Push fehlgeschlagen: ($err.msg | ansi red)"
    }
}

# Letzte N Commits anzeigen
def gl [--limit (-n): int = 10] {
    git log --oneline -$limit | table -e
}

# Git Branches anzeigen (mit Highlight des aktuellen)
def gb [] {
    let current = (git rev-parse --abbrev-ref HEAD)
    git branch -a | lines | each { |branch|
        if ($branch | str contains $current) {
            $branch | ansi green
        } else {
            $branch
        }
    } | table -e
}

# Branch erstellen und checken
def gco [branch_name: string] {
    if ($branch_name | is-empty) {
        error make { msg: "Branch-Name erforderlich: gco 'feature/new-feature'" }
    }
    
    try {
        git checkout -b $branch_name
        print $"✅ Branch erstellt: ($branch_name | ansi green)"
    } catch { |err|
        print $"⚠️  Versuche existierenden Branch: ($branch_name)"
        git checkout $branch_name
    }
}

# Letzte N Commits zurücksetzen
def grh [n: int = 1] {
    let commits = (git rev-list --count HEAD)
    
    if $n > $commits {
        error make { msg: $"Nur ($commits) Commits vorhanden" }
    }
    
    try {
        git reset --soft HEAD~$n
        print $"🔄 ($n) Commit(s) zurückgesetzt (Änderungen erhalten)"
    } catch { |err|
        print $"❌ Fehler: ($err.msg | ansi red)"
    }
}

# Ungewollte Änderungen verwerfen
def gcd [] {
    print "⚠️  Verwerfe ALLE lokalen Änderungen..."
    git checkout -- .
    print "✅ Änderungen verworfen"
}

# Git Diff in schöner Darstellung
def gd [] {
    git diff --color | less -R
}
```


***

### 4.3 `scripts/system/module.nu`

```nu
# ============================================
# System Module - Systemverwaltungs-Commands
# ============================================

# Umfassende Systeminfo
def sysinfo [] {
    let os_info = (uname -a)
    let mem = (free -h 2>/dev/null | lines.1 | str trim | split row ' ' | select 1 2 3)
    let disk = (df -h / | lines.1 | str trim | split row ' ' | select 1 2 3 4)
    let uptime = (uptime | str trim)
    let cpu_count = (nproc 2>/dev/null || echo "N/A")
    
    {
        hostname: (hostname)
        os: $os_info
        cpu_cores: $cpu_count
        memory: {
            total: ($mem.0)
            used: ($mem.1)
            available: ($mem.2)
        }
        disk_root: {
            total: ($disk.0)
            used: ($disk.1)
            available: ($disk.2)
            percent: ($disk.3)
        }
        uptime: $uptime
        timestamp: (date now | format date "%Y-%m-%d %H:%M:%S")
    } | to text -t 2
}

# Enhanced `ls` mit Details (Alternative zu `lsd`)
def lsd [
    --all (-a): bool = false
    path: string = "."
] {
    let cmd = if $all { 
        $"ls -lah ($path)" 
    } else { 
        $"ls -lh ($path)" 
    }
    
    let items = (^$nu.shell-path -c $cmd | lines)
    
    if ($items | length) > 0 {
        $items | each { |line|
            print $line
        }
    } else {
        print "Verzeichnis ist leer"
    }
}

# Port-Nutzung prüfen
def portinfo [port: int] {
    if ($port < 1) or ($port > 65535) {
        error make { msg: "Port muss zwischen 1 und 65535 liegen" }
    }
    
    let os = $nu.os-info.name
    
    if $os == "windows" {
        try {
            netstat -ano | grep $port | table -e
        } catch {
            print "❌ Keine Nutzung auf Port ($port) gefunden"
        }
    } else {
        try {
            lsof -i :$port | table -e
        } catch {
            print "❌ Keine Nutzung auf Port ($port) gefunden"
        }
    }
}

# Prozesse nach CPU/Memory sortiert
def top-processes [
    --limit (-n): int = 10
    --sort-by (-s): string = "memory"  # "memory" oder "cpu"
] {
    let ps_output = (ps aux | lines | skip 1)
    
    let sorted = if $sort_by == "cpu" {
        $ps_output | sort -r -k 3
    } else {
        $ps_output | sort -r -k 4
    }
    
    $sorted | first $limit | table -e
}

# Disk-Nutzung nach Verzeichnis
def disk-usage [path: string = "."] {
    if not ($path | path exists) {
        error make { msg: $"Pfad existiert nicht: ($path)" }
    }
    
    du -sh $"($path)/*" 2>/dev/null | lines | each { |line|
        let parts = ($line | split row '\t')
        {
            size: ($parts.0)
            path: ($parts.1)
        }
    } | sort-by size -r | table -e
}

# System neustarten (mit Bestätigung)
def reboot-system [--force (-f): bool = false] {
    if $force {
        sudo reboot now
    } else {
        print "⚠️  System wird in 60 Sekunden neu gestartet."
        print "Abbrechen: CTRL+C"
        sleep 60sec
        sudo reboot now
    }
}

# Network-Status
def net-status [] {
    let interfaces = (ip addr show 2>/dev/null || ifconfig)
    let dns = (cat /etc/resolv.conf 2>/dev/null | grep nameserver)
    let routing = (ip route show 2>/dev/null)
    
    {
        interfaces: $interfaces
        dns: $dns
        routing: $routing
    } | to text -t 2
}
```


***

## 5. `.gitignore`

```
# OS
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# Nushell
.nushell_history
.cache/

# IDE
.vscode/
.idea/
*.code-workspace

# Local overrides
local/
secrets/
.env
.env.local

# Logs
*.log
```


***

## 6. `CONTRIBUTING.md`

```markdown
# 🤝 Contributing

Beiträge sind willkommen! Hier sind die Guidelines:

## Vor dem Commit

1. **Branch erstellen**:
```

git checkout -b feature/my-new-command

```

2. **Code testen** (lokal laden und prüfen):
```

use scripts/utils/module.nu

# Test commands...

```

3. **Commit mit beschreibender Message**:
```

git commit -m "feat: add new-command for X"

```

## Struktur für neue Commands

```


# Kommentar mit Beschreibung

def my-command [param: type = "default"] {
\# Implementierung
\# ...

    # Erfolgs-Output
    print "✅ Erfolgreich!"
    }

```

## Naming Conventions

- `def` Namen: `lowercase-with-dashes`
- Parameter: `lowercase_with_underscores`
- Module: In entsprechenden Ordner (`utils/`, `git/`, `system/`)

## Commit Message Format

```

type(scope): subject

```

Types: `feat`, `fix`, `docs`, `refactor`, `test`

Beispiel:
```

feat(utils): add uuid generator
fix(git): improve gs status display
docs: update README with new commands

```

---

Danke! 🙏
```


***

## 7. `setup.sh` (Installationsskript)

```bash
#!/bin/bash

# Setup script for nu-scripts
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 nu-scripts Setup${NC}\n"

# Detect OS
OS=$(uname -s)

# Script directory
SCRIPTS_DIR="$HOME/.config/nushell/scripts"
REPO_URL="https://github.com/fdoebbelin/nu-scripts.git"

echo -e "${BLUE}📋 System: $OS${NC}"

# Check if scripts directory exists
if [ -d "$SCRIPTS_DIR" ]; then
    echo -e "${YELLOW}⚠️  Scripts-Verzeichnis existiert bereits${NC}"
    read -p "Überschreiben? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$SCRIPTS_DIR"
        echo -e "${GREEN}✅ Altes Verzeichnis gelöscht${NC}"
    else
        echo -e "${RED}❌ Setup abgebrochen${NC}"
        exit 1
    fi
fi

# Create directory
mkdir -p "$SCRIPTS_DIR"
echo -e "${GREEN}✅ Verzeichnis erstellt: $SCRIPTS_DIR${NC}\n"

# Clone repository
echo -e "${BLUE}🔄 Klone Repository...${NC}"

if git clone "$REPO_URL" "$SCRIPTS_DIR"; then
    echo -e "${GREEN}✅ Repository geklont${NC}\n"
else
    echo -e "${RED}❌ Fehler beim Klonen${NC}"
    exit 1
fi

# Print next steps
echo -e "${BLUE}📝 Nächste Schritte:${NC}"
echo ""
echo -e "1. Füge folgendes zu ${BLUE}~/.config/nushell/config.nu${NC} hinzu:"
echo ""
echo "   # Load custom scripts modules"
echo "   let scripts_dir = \$\"(\$nu.default-config-dir)/scripts\""
echo "   use (\$\"(\$scripts_dir)/utils/module.nu\")"
echo "   use (\$\"(\$scripts_dir)/git/module.nu\")"
echo "   use (\$\"(\$scripts_dir)/system/module.nu\")"
echo ""
echo -e "2. Starte Nushell neu: ${GREEN}nu${NC}"
echo ""
echo -e "3. Teste Commands: ${GREEN}gs${NC}, ${GREEN}llm${NC}, ${GREEN}sysinfo${NC}"
echo ""
echo -e "${GREEN}✅ Setup abgeschlossen!${NC}"
```


***

## 8. `examples/config-snippet.nu`

```nu
# ============================================
# Nushell Config Snippet für nu-scripts
# ============================================

# Füge dies zu ~/.config/nushell/config.nu hinzu

# Scripts-Verzeichnis definieren
let scripts_dir = $"($nu.default-config-dir)/scripts"

# ============================================
# Module laden
# ============================================

# Utils: Hilfsfunktionen (llm, tree, uuid, etc.)
use ($"($scripts_dir)/utils/module.nu")

# Git: Git-Shortcuts (gs, gc, gp, etc.)
use ($"($scripts_dir)/git/module.nu")

# System: Systemverwaltung (sysinfo, portinfo, etc.)
use ($"($scripts_dir)/system/module.nu")

# ============================================
# Update-Funktion (optional)
# ============================================

# Aktualisiere Scripts vom GitHub-Repo
def nu-scripts-update [] {
    print "🔄 Aktualisiere Scripts..."
    try {
        git -C $scripts_dir pull --quiet
        print "✅ Scripts aktualisiert!"
    } catch { |err|
        print $"❌ Update fehlgeschlagen: ($err.msg)"
    }
}

# ============================================
# Verfügbare Commands
# ============================================

# Utils:
#   llm [path]                    - Dateigrößen-Analyse
#   tree [--max-depth N]          - Verzeichnis-Struktur
#   uuid                          - UUID v4 generieren
#   hash-file --algorithm sha256  - Datei-Hash

# Git:
#   gs                            - Status mit Farben
#   gc "message"                  - Schneller Commit
#   gp                            - Push
#   gl [-n N]                     - Log (letzte N Commits)
#   gb                            - Branches anzeigen
#   gco "branch"                  - Checkout/Create
#   grh [n]                       - Zurücksetzen (n Commits)
#   gcd                           - Änderungen verwerfen
#   gd                            - Diff anzeigen

# System:
#   sysinfo                       - Systeminfo
#   lsd [-a]                      - Enhanced ls
#   portinfo [port]               - Port-Nutzung
#   top-processes [-n N] [-s cpu|memory]
#   disk-usage [path]             - Disk-Nutzung
#   net-status                    - Network-Status
```


***

## 9. LICENSE

```
MIT License

Copyright (c) 2025 fdoebbelin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```


***

## 📋 Schritt-für-Schritt zum Live-Gehen

### 1️⃣ **Repository auf GitHub erstellen**

```bash
# Gehe zu github.com/new
# Repository-Name: nu-scripts
# Beschreibung: "Custom Nushell commands and modules"
# Public oder Private: Deine Wahl
```


### 2️⃣ **Lokal initialisieren**

```bash
mkdir -p ~/projects/nu-scripts
cd ~/projects/nu-scripts
git init
git remote add origin git@github.com:fdoebbelin/nu-scripts.git
```


### 3️⃣ **Alle Dateien hinzufügen**

```bash
# Kopiere alle oben genannten Dateien in das Verzeichnis
git add .
git commit -m "feat: initial commit with utils, git, and system modules"
git branch -M main
git push -u origin main
```


### 4️⃣ **Auto-Sync in `env.nu` aktivieren**

```bash
# Siehe SETUP_GUIDE.md → Schritt 2
```


### 5️⃣ **Nushell neustarten und testen**

```nu
nu-scripts-update  # Update-Funktion testen
gs                 # Git-Status anzeigen
sysinfo            # Systeminfo anzeigen
```


***

## 🎯 Zusammenfassung

| Teil | Datei | Zweck |
| :-- | :-- | :-- |
| **Docs** | README.md | Überblick \& Schnellstart |
| **Docs** | SETUP_GUIDE.md | Authentifizierung \& SSH/HTTPS |
| **Module** | `utils/module.nu` | Allgemeine Utilities |
| **Module** | `git/module.nu` | Git-Shortcuts |
| **Module** | `system/module.nu` | Systemverwaltung |
| **Setup** | setup.sh | Automatische Installation |
| **Config** | examples/config-snippet.nu | Wie man die Scripts lädt |


***

**Alles bereit? Viel Erfolg mit deinem nu-scripts Projekt! 🚀**
<span style="display:none">[^1][^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^2][^20][^3][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github

[^2]: https://www.reddit.com/r/github/comments/1d4cvy3/is_https_the_future_is_ssh_going_away/

[^3]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

[^4]: https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port

[^5]: https://gist.github.com/thedavidyoungblood/a32ff3c3b536806cf771f19d35130816

[^6]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

[^7]: https://stackoverflow.com/questions/67077837/in-what-ways-is-an-ssh-key-different-from-tokens-for-git-authentication

[^8]: https://stackoverflow.com/questions/18520061/using-https-or-ssh-with-github

[^9]: https://cran.r-project.org/web/packages/credentials/vignettes/intro.html

[^10]: https://dev.to/otumianempire/create-a-github-personal-access-token-and-ssh-for-your-github-repository-3741

[^11]: https://graphite.com/guides/git-clone-ssh-vs-https

[^12]: https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials

[^13]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

[^14]: https://docs.copado.com/articles/copado-ci-cd-publication/https-vs-ssh-authentication

[^15]: https://www.atlassian.com/git/tutorials/git-ssh

[^16]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh

[^17]: https://docs.gitlab.com/user/ssh/

[^18]: https://news.ycombinator.com/item?id=33252099

[^19]: https://stackoverflow.com/questions/1595848/configuring-git-over-ssh-to-login-once

[^20]: https://www.reddit.com/r/github/comments/18tskh9/is_there_any_good_reason_for_using_a_patpersonal/


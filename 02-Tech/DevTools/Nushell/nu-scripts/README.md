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

```nu
# Kein Setup notwendig – einfach Nushell starten!
# Die Synchronisation findet automatisch statt.
```

### 2. Manuelle Installation

```bash
# Clone das Repository
git clone https://github.com/fdoebbelin/nu-scripts.git ~/.config/nushell/scripts

# Oder verwende das Setup-Skript
bash ~/.config/nushell/scripts/setup.sh
```

### 3. In config.nu einbinden

Füge folgendes zu deiner `~/.config/nushell/config.nu` hinzu:

```nu
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
- `hash-file --algorithm sha256 [path]` - Datei-Hash berechnen

### Git Modul
- `gs` - Git Status mit verbesserter Anzeige
- `gc [message]` - Schneller Git Commit
- `gp` - Push zu Remote
- `gl [-n N]` - Letzten N Commits anzeigen
- `gb` - Branches anzeigen
- `gco [branch]` - Branch erstellen/checken
- `grh [n]` - Letzte N Commits zurücksetzen
- `gcd` - Lokale Änderungen verwerfen
- `gd` - Diff anzeigen

### System Modul
- `sysinfo` - Umfassende Systeminfo
- `lsd [-a]` - Enhanced `ls` mit Details
- `portinfo [port]` - Port-Nutzung prüfen
- `top-processes [-n N] [-s cpu|memory]` - Top Prozesse
- `disk-usage [path]` - Disk-Nutzung analysieren
- `net-status` - Network-Status anzeigen

## 🔄 Automatische Synchronisation

Die Scripts synchronisieren sich automatisch beim ersten Start. Um manuell zu aktualisieren:

```nu
# In deiner Nushell-Session:
nu-scripts-update
```

## 🔐 Git-Authentifizierung

Siehe [SETUP_GUIDE](SETUP_GUIDE.md) für Details zur SSH- oder HTTPS-Authentifizierung.

## 🤝 Contributing

Beiträge sind willkommen! Siehe [CONTRIBUTING.md](00%20Nushell/nu-scripts/CONTRIBUTING.md).

## 📄 Lizenz

MIT – siehe [LICENSE](LICENSE.md) Datei.

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts
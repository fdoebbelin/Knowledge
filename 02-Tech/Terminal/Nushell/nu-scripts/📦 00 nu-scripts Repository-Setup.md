## 📁 Repository-Struktur

```
nu-scripts/
├── README.md
├── SETUP_GUIDE.md
├── CONTRIBUTING.md
├── LICENSE
├── .gitignore
├── setup.sh
├── scripts/
│   ├── utils/
│   │   ├── module.nu
│   │   └── README.md
│   ├── git/
│   │   ├── module.nu
│   │   └── README.md
│   └── system/
│       ├── module.nu
│       └── README.md
└── examples/
    └── config-snippet.nu
```


## 📄 .gitignore

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


---

## 🚀 Schritt-für-Schritt Anleitung zum Aufbau

### 1️⃣ Repository lokal erstellen
-   Lege das Git-Repository direkt im Verzeichnis `$nu.default-config-dir/scripts` an (z.B. `~/.config/nushell/scripts` unter Linux/macOS).​
-  Alle folgenden Befehle gehen davon aus, dass sich das Repo im Pfad `$nu.default-config-dir/scripts` befindet.

```nushell
# Repository-Verzeichnis (abhängig vom System)
$nu.default-config-dir
# Beispiel: ~/.config/nushell

# nu-scripts Repository im scripts-Verzeichnis anlegen
mkdir $"($nu.default-config-dir)/scripts"
cd $"($nu.default-config-dir)/scripts"

# Git-Repository initialisieren
git init
```


### 2️⃣ Dateien erstellen und Code einfügen

```bash
# Hauptdateien
touch README.md SETUP_GUIDE.md CONTRIBUTING.md LICENSE .gitignore

# Module mit READMEs
mkdir -p scripts/utils scripts/git scripts/system examples
touch scripts/utils/module.nu scripts/utils/README.md
touch scripts/git/module.nu scripts/git/README.md
touch scripts/system/module.nu scripts/system/README.md
touch examples/config-snippet.nu
```


### 3️⃣ Inhalt in die Dateien kopieren

Kopiere die Inhalte aus den jeweiligen Code-Blöcken oben in die entsprechenden Dateien.

### 4️⃣ Setup-Skript ausführbar machen

```bash
chmod +x setup.sh
```


### 5️⃣ GitHub Repository erstellen

- Gehe zu https://github.com/new
- Repository-Name: `nu-scripts`
- Beschreibung: `Custom Nushell commands and modules`
- Public oder Private: Deine Wahl
- **Nicht** "Initialize this repository with a README" wählen (du hast bereits Dateien)


### 6️⃣ Remote hinzufügen und pushen

```bash
git remote add origin git@github.com:fdoebbelin/nu-scripts.git
git add .
git commit -m "feat: initial commit with utils, git, and system modules"
git branch -M main
git push -u origin main
```


### 7️⃣ Auto-Sync einrichten

Füge zu `~/.config/nushell/env.nu` hinzu (siehe SETUP_GUIDE.md Schritt 2):

```nu
let scripts_dir = $"($nu.default-config-dir)/scripts"
let repo_url = "git@github.com:fdoebbelin/nu-scripts.git"

if not ($scripts_dir | path exists) {
    print "🔄 Initiale Synchronisation von nu-scripts..."
    try {
        mkdir $scripts_dir
        cd $scripts_dir
        git clone $repo_url . 2>&1 | null
        print "✅ Scripts erfolgreich synchronisiert!"
    } catch { |err|
        print $"⚠️  Git-Synchronisation fehlgeschlagen: ($err.msg)"
    }
}
```


### 8️⃣ Module in config.nu laden

Füge zu `~/.config/nushell/config.nu` hinzu:

```nu
let scripts_dir = $"($nu.default-config-dir)/scripts"
use ($"($scripts_dir)/utils/module.nu")
use ($"($scripts_dir)/git/module.nu")
use ($"($scripts_dir)/system/module.nu")

def nu-scripts-update [] {
    print "🔄 Aktualisiere Scripts..."
    try {
        git -C $scripts_dir pull --quiet
        print "✅ Scripts aktualisiert!"
    } catch { |err|
        print $"❌ Update fehlgeschlagen: ($err.msg)"
    }
}
```


### 9️⃣ Testen

```bash
# Nushell neustarten
nu

# Commands testen
gs
sysinfo
llm
uuid
```


***

## ✅ Fertig!

Dein `nu-scripts` Repository ist jetzt live und ready to use! 🚀

**Schritt-Übersicht:**

1. ✅ Repository-Struktur erstellt
2. ✅ Alle Dateien mit Copy-Paste Code vorbereitet
3. ✅ GitHub Repository aufgesetzt
4. ✅ Auto-Sync und Update-Funktion konfiguriert
5. ✅ Module in Nushell geladen

Happy scripting! 💻


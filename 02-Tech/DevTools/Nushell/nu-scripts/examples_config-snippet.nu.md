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
#   colored [color]               - Text färben

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

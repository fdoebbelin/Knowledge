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

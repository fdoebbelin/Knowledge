```nu
# ============================================
# Utils Module - Allgemeine Hilfsfunktionen
# ============================================

# Detaillierte Dateigrößen-Analyse
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

# Schöne Verzeichnis-Struktur
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
    if ($nu.os-info.name == "windows") {
        pwsh -NoProfile -Command "[guid]::NewGuid().ToString()"
    } else {
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

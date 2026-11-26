# Gemeinsame Hilfsfunktionen für die Vault-Skripte.

# Wurzel des Vaults (Elternordner von scripts/)
export def vault-root [] {
    $env.FILE_PWD | path dirname
}

# Ordner, die Notizen enthalten, und der erwartete Typ
export const TYP_ORDNER = {
    inbox: inbox
    quellen: quelle
    zettel: zettel
    struktur: struktur
}

# Alle Notizen als Tabelle: pfad (relativ), stem, ordner, text
export def notizen [] {
    let root = (vault-root)
    let ordner = ($TYP_ORDNER | columns)
    let dateien = (
        $ordner
        | each {|o|
            let dir = ($root | path join $o)
            if ($dir | path exists) { glob $"($dir)/**/*.md" } else { [] }
        }
        | flatten
        | append ($root | path join index.md)
        | where {|p| $p | path exists }
    )
    $dateien | each {|p|
        let rel = ($p | path relative-to $root)
        {
            pfad: $rel
            stem: ($p | path parse | get stem)
            ordner: ($rel | path split | first)
            text: (open --raw $p)
        }
    }
}

# Frontmatter einer Notiz als Record; null, wenn keins oder ungültig
export def frontmatter [text: string] {
    let t = ($text | str replace --all "\r\n" "\n")
    if not ($t | str starts-with "---\n") { return null }
    let rest = ($t | str substring 4..)
    let ende = ($rest | str index-of "\n---")
    if $ende < 0 { return null }
    let yaml = ($rest | str substring 0..<$ende)
    try { $yaml | from yaml | default {} } catch { null }
}

# Text ohne Frontmatter, Codeblöcke und Inline-Code (für die Linksuche)
export def ohne-code [text: string] {
    $text
    | str replace --all "\r\n" "\n"
    | str replace --regex '^---\n(?s:.*?)\n---' ''
    | str replace --all --regex '(?s)```.*?```' ''
    | str replace --all --regex '(?s)~~~.*?~~~' ''
    | str replace --all --regex '`[^`\n]*`' ''
}

# Wikilinks einer Notiz: ziel (ohne Abschnitt/Alias), einbettung, roh
export def wikilinks [text: string] {
    ohne-code $text
    | parse --regex '(?<bang>!?)\[\[(?<inhalt>[^\]\n]*)\]\]'
    | each {|m|
        let ziel = (
            $m.inhalt
            | split row '|' | first
            | split row '#' | first
            | split row '^' | first
            | str trim
            | path basename
        )
        {
            ziel: $ziel
            einbettung: ($m.bang == '!')
            roh: $"($m.bang)[[($m.inhalt)]]"
        }
    }
}

# Ist das Ziel ein Anhang (Endung, aber nicht .md)?
export def ist-anhang [ziel: string] {
    let ext = ($ziel | path parse | get extension)
    ($ext | is-not-empty) and ($ext | str lowercase) != 'md'
}

# Unzulässige Zeichen in Dateinamen
export const VERBOTEN = '[/\\:*?"<>|#^\[\]]'

# Zeitstempel-ID JJJJMMTThhmm
export def neue-id [vorhanden: list<string>] {
    mut t = (date now)
    mut id = ($t | format date '%Y%m%d%H%M')
    while ($id in $vorhanden) {
        $t = ($t + 1min)
        $id = ($t | format date '%Y%m%d%H%M')
    }
    $id
}

#!/usr/bin/env nu
# Neue Notizen anlegen und vorhandene finden.
#
#   nu scripts/neu.nu zettel "Hardlinks teilen sich eine Inode"
#   nu scripts/neu.nu quelle "Linux-Handbuch – Dateisysteme"
#   nu scripts/neu.nu struktur "Linux-Dateisysteme"
#   nu scripts/neu.nu suchen inode

use lib.nu *

const ZIEL = {zettel: zettel, quelle: quellen, struktur: struktur}
const VORLAGE = {zettel: Zettel, quelle: Quelle, struktur: Struktur}

def anlegen [typ: string, titel: string, herkunft?: string] {
    let root = (vault-root)
    let titel = ($titel | str trim)
    if $titel == '' { error make {msg: "Titel fehlt"} }
    if ($titel =~ $VERBOTEN) {
        error make {msg: $"Titel enthält unzulässige Zeichen: ($titel)"}
    }
    let alle = (notizen)
    let gleich = ($alle | where {|n| ($n.stem | str lowercase) == ($titel | str lowercase) })
    if ($gleich | is-not-empty) {
        error make {msg: $"Es gibt schon eine Notiz mit diesem Titel: ($gleich | first | get pfad)"}
    }
    let ids = ($alle | each {|n| frontmatter $n.text | get -o id | default '' | into string })
    let id = (neue-id $ids)
    let jetzt = (date now)

    let vorlage = ($root | path join vorlagen $"($VORLAGE | get $typ).md")
    mut text = (
        open --raw $vorlage
        | str replace --all '{{date:YYYYMMDDHHmm}}' $id
        | str replace --all '{{date:YYYY-MM-DD}}' ($jetzt | format date '%Y-%m-%d')
        | str replace --all '{{title}}' $titel
    )
    if $herkunft != null {
        $text = ($text | str replace --regex '(?m)^created: (.*)$' $"created: $1\nherkunft: ($herkunft)")
    }
    let pfad = ($root | path join ($ZIEL | get $typ) $"($titel).md")
    $text | save $pfad
    print ($pfad | path relative-to $root)
}

# Neuen Zettel anlegen
def "main zettel" [
    titel: string        # Titel als Aussage, wird zum Dateinamen
    --herkunft: string   # Pfad der Altnotiz im Archiv (Migration)
] {
    anlegen zettel $titel $herkunft
}

# Neue Literaturnotiz anlegen
def "main quelle" [titel: string, --herkunft: string] {
    anlegen quelle $titel $herkunft
}

# Neuen Strukturzettel anlegen
def "main struktur" [titel: string] {
    anlegen struktur $titel
}

# Notizen nach Stichwort finden: Titel, Aliase, Tags, dann Volltext
def "main suchen" [stichwort: string] {
    let s = ($stichwort | str lowercase)
    notizen
    | each {|n|
        let fm = (frontmatter $n.text | default {})
        let aliases = ($fm | get -o aliases | default [] | each { into string } | str join ' ')
        let tags = ($fm | get -o tags | default [] | each { into string } | str join ' ')
        let wo = if ($n.stem | str lowercase | str contains $s) { 'titel' } else if ($aliases | str lowercase | str contains $s) { 'alias' } else if ($tags | str lowercase | str contains $s) { 'tag' } else if ($n.text | str lowercase | str contains $s) { 'text' } else { null }
        if $wo != null { {treffer: $wo, typ: ($fm | get -o type | default $n.ordner), titel: $n.stem, pfad: $n.pfad} }
    }
    | compact
    | sort-by {|r| [titel alias tag text] | enumerate | where item == $r.treffer | get 0.index } titel
}

def main [] {
    print (help main)
}

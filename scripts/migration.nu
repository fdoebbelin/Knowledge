#!/usr/bin/env nu
# Übernahme von Altnotizen aus dem archivierten Repository verfolgen.
# Der Pfad zum Archiv-Klon steht in $env.KNOWLEDGE_ARCHIV.
#
#   nu scripts/migration.nu status "02-Tech/Terminal/Helix/01-Helix installieren.md"
#   nu scripts/migration.nu eintragen "02-Tech/…/Notiz.md" uebernommen "Abschnitt X veraltet"
#   nu scripts/migration.nu eintragen "01-Courses/Programming/Tauri-Kurs" uebernommen   # ganzer Ordner
#   nu scripts/migration.nu offen 02-Tech/Terminal
#   nu scripts/migration.nu uebersicht

use lib.nu *

const ERGEBNISSE = [uebernommen teilweise verworfen]

def protokoll-pfad [] { vault-root | path join _meta migration.csv }

def protokoll [] {
    let p = (protokoll-pfad)
    let t = (open --raw $p | from csv)
    if ($t | is-empty) { [] } else { $t }
}

def archiv [] {
    let a = ($env | get -o KNOWLEDGE_ARCHIV | default '')
    if $a == '' or not ($a | path exists) {
        error make {msg: "KNOWLEDGE_ARCHIV ist nicht gesetzt oder zeigt auf keinen Ordner (Klon des alten Repos)"}
    }
    $a | path expand
}

# Ist eine Altnotiz erledigt? Direkt eingetragen oder unter einem eingetragenen Ordner
def erledigt [pfad: string, eintraege: list<string>] {
    $eintraege | any {|e| $pfad == $e or ($pfad | str starts-with $"($e)/") }
}

# Zettel/Quellen, deren herkunft auf die Altnotiz zeigt
def abgeleitet [altpfad: string] {
    notizen
    | each {|n| let fm = (frontmatter $n.text | default {}); {pfad: $n.pfad, id: ($fm | get -o id | default '' | into string), herkunft: ($fm | get -o herkunft | default '')} }
    | where {|r| $altpfad in ([$r.herkunft] | flatten) }   # herkunft: Pfad oder Liste von Pfaden
}

# Stand einer Altnotiz: Protokolleintrag und abgeleitete Notizen
def "main status" [altpfad: string] {
    let eintrag = (protokoll | where {|r| erledigt $altpfad [$r.altpfad] })
    let notizen = (abgeleitet $altpfad)
    if ($eintrag | is-empty) and ($notizen | is-empty) {
        print $"offen: ($altpfad)"
        return
    }
    if ($eintrag | is-not-empty) { print ($eintrag | table --expand) } else { print "Kein Protokolleintrag, aber schon Notizen mit dieser Herkunft:" }
    if ($notizen | is-not-empty) { print ($notizen | select pfad id | table) }
}

# Übernahme protokollieren; die Zettel-IDs werden über `herkunft` gesammelt
def "main eintragen" [
    altpfad: string
    ergebnis: string   # uebernommen | teilweise | verworfen
    notiz?: string     # kurze Bemerkung, z. B. was weggelassen wurde
] {
    if not ($ergebnis in $ERGEBNISSE) {
        error make {msg: $"Ergebnis muss eins von ($ERGEBNISSE | str join ', ') sein"}
    }
    let ids = (abgeleitet $altpfad | get id | where $it != '')
    if $ergebnis != 'verworfen' and ($ids | is-empty) {
        error make {msg: "Keine Notiz trägt diese herkunft – erst Zettel anlegen, dann eintragen"}
    }
    let alt = (protokoll | where altpfad != $altpfad)
    let neu = {altpfad: $altpfad, ergebnis: $ergebnis, zettel: ($ids | str join ' '), datum: (date now | format date '%Y-%m-%d'), notiz: ($notiz | default '')}
    $alt | append $neu | sort-by altpfad | to csv | save --force (protokoll-pfad)
    print $"eingetragen: ($altpfad) → ($ergebnis) \(($ids | length) Notizen\)"
}

# Noch nicht übernommene Altnotizen, optional unter einem Ordner des Archivs
def "main offen" [ordner?: string] {
    let a = (archiv)
    let basis = if $ordner == null { $a } else { $a | path join $ordner }
    let erledigt = (protokoll | get -o altpfad | default [])
    glob $"($basis)/**/*.md" --exclude ['**/.git/**' '**/.obsidian/**']
    | each { path relative-to $a }
    | where {|p| not (erledigt $p $erledigt) }
    | sort
}

# Fortschritt je Hauptordner des Archivs
def "main uebersicht" [] {
    let a = (archiv)
    let erledigt = (protokoll | get -o altpfad | default [])
    glob $"($a)/**/*.md" --exclude ['**/.git/**' '**/.obsidian/**']
    | each { path relative-to $a }
    | each {|p| {ordner: ($p | path split | first), erledigt: (erledigt $p $erledigt)} }
    | group-by ordner
    | items {|k, v| {ordner: $k, gesamt: ($v | length), erledigt: ($v | where erledigt | length)} }
    | insert anteil {|r| $"(($r.erledigt * 100 / $r.gesamt) | math round)%" }
    | sort-by ordner
}

def main [] {
    print (help main)
}

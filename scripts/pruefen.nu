#!/usr/bin/env nu
# Prüft den Vault: Frontmatter, Dateinamen, Links, Vernetzung.
# Fehler brechen ab (Exit-Code 1), Hinweise nicht.
#
#   nu scripts/pruefen.nu               # Bericht mit Fehlern und Hinweisen
#   nu scripts/pruefen.nu --nur-fehler  # nur Fehler (Pre-Commit-Hook, CI)

use lib.nu *

def befund [stufe: string, datei: string, regel: string, meldung: string] {
    {stufe: $stufe, datei: $datei, regel: $regel, meldung: $meldung}
}

def main [
    --nur-fehler   # Hinweise nicht ausgeben
] {
    let root = (vault-root)
    let alle = (notizen | insert fm {|n| frontmatter $n.text })

    let stems = ($alle | get stem)
    let stems_klein = ($stems | each { str lowercase })
    let inbox_stems = ($alle | where ordner == inbox | get stem)
    let entwuerfe = ($alle | where {|n| ($n.fm | get -o draft | default false) == true } | get stem)
    let anhaenge = (
        glob $"($root)/_resources/**/*"
        | where {|p| ($p | path type) == file }
        | each { path basename }
    )

    mut b = []

    # --- Dateinamen ---------------------------------------------------------
    let doppelt = ($alle | group-by stem | items {|k, v| {stem: $k, n: ($v | length), pfade: ($v | get pfad)} } | where n > 1)
    for d in $doppelt {
        for p in $d.pfade {
            $b = ($b | append (befund fehler $p name-doppelt $"Dateiname kommt ($d.n)× vor: ($d.pfade | str join ', ')"))
        }
    }
    for n in $alle {
        if ($n.stem =~ $VERBOTEN) {
            $b = ($b | append (befund fehler $n.pfad name-zeichen "Dateiname enthält unzulässige Zeichen"))
        }
        if $n.ordner in [zettel quellen struktur] and ($n.pfad | path split | length) > 2 {
            $b = ($b | append (befund fehler $n.pfad name-unterordner $"Notizen liegen flach in ($n.ordner)/, ohne Unterordner"))
        }
        if ($n.stem | str lowercase) in [unbenannt untitled] or ($n.stem =~ '\(\d+\)$') {
            $b = ($b | append (befund fehler $n.pfad name-platzhalter "Platzhalter- oder Kopiename"))
        }
    }

    # --- Frontmatter --------------------------------------------------------
    let pflicht = [id title type created]
    let ids = ($alle | where ordner != inbox | each {|n| $n.fm | get -o id | default '' | into string } | where $it != '')
    let doppelte_ids = ($ids | uniq --repeated)

    for n in ($alle | where ordner != inbox) {
        if $n.fm == null {
            $b = ($b | append (befund fehler $n.pfad fm-fehlt "Frontmatter fehlt oder ist kein gültiges YAML"))
            continue
        }
        let fehlend = ($pflicht | where {|k| ($n.fm | get -o $k | default '' | into string) == '' })
        if ($fehlend | is-not-empty) {
            $b = ($b | append (befund fehler $n.pfad fm-pflicht $"Pflichtschlüssel fehlen: ($fehlend | str join ', ')"))
        }
        let erwartet = if $n.pfad == 'index.md' { 'struktur' } else { $TYP_ORDNER | get $n.ordner }
        let typ = ($n.fm | get -o type | default '')
        if $typ != '' and $typ != $erwartet {
            $b = ($b | append (befund fehler $n.pfad fm-typ $"type '($typ)' passt nicht zum Ordner, erwartet '($erwartet)'"))
        }
        let id = ($n.fm | get -o id | default '' | into string)
        if $id != '' and not ($id =~ '^\d{12}$') {
            $b = ($b | append (befund fehler $n.pfad fm-id $"id '($id)' hat nicht das Format JJJJMMTThhmm"))
        }
        if $id in $doppelte_ids {
            $b = ($b | append (befund fehler $n.pfad fm-id-doppelt $"id ($id) ist nicht eindeutig"))
        }
        let titel = ($n.fm | get -o title | default '' | into string)
        if $n.pfad != 'index.md' and $titel != '' and $titel != $n.stem {
            $b = ($b | append (befund fehler $n.pfad fm-titel $"title '($titel)' weicht vom Dateinamen ab"))
        }
    }

    # --- Links --------------------------------------------------------------
    let links = (
        $alle | each {|n|
            wikilinks $n.text | each {|l| $l | insert von $n.pfad | insert von_stem $n.stem | insert von_ordner $n.ordner }
        } | flatten
    )

    for l in $links {
        if $l.ziel == '' {
            if ($l.roh | str contains '#') { continue }   # Link auf eigenen Abschnitt
            $b = ($b | append (befund fehler $l.von link-leer $"Leerer Link ($l.roh)"))
            continue
        }
        if (ist-anhang $l.ziel) and not ($l.ziel in $stems) {   # "p5.js" im Titel ist kein Anhang
            if not ($l.ziel in $anhaenge) {
                let klein = ($anhaenge | where {|a| ($a | str lowercase) == ($l.ziel | str lowercase) })
                let msg = if ($klein | is-not-empty) { $"Anhang anders geschrieben: ($l.roh) → ($klein | first)" } else { $"Anhang fehlt in _resources/: ($l.roh)" }
                $b = ($b | append (befund fehler $l.von link-anhang $msg))
            }
            continue
        }
        let ziel = ($l.ziel | str replace --regex '\.md$' '')
        if not ($ziel in $stems) {
            let idx = ($stems_klein | enumerate | where item == ($ziel | str lowercase) | get -o 0.index)
            if $idx != null {
                $b = ($b | append (befund fehler $l.von link-schreibweise $"Schreibweise weicht ab: ($l.roh) → [[($stems | get $idx)]]"))
            } else {
                $b = ($b | append (befund fehler $l.von link-tot $"Ziel existiert nicht: ($l.roh)"))
            }
            continue
        }
        if $l.von_ordner != 'inbox' and $ziel in $inbox_stems {
            $b = ($b | append (befund fehler $l.von link-inbox $"Verweis auf Inbox-Notiz: ($l.roh)"))
        }
        if $l.von_ordner != 'inbox' and $ziel in $entwuerfe and not ($l.von_stem in $entwuerfe) {
            $b = ($b | append (befund hinweis $l.von link-entwurf $"Ziel ist draft und fehlt auf der Website: ($l.roh)"))
        }
    }

    # --- Vernetzung (nur Hinweise) -------------------------------------------
    let aus_struktur = ($links | where von_ordner == struktur or von == 'index.md' | get ziel | uniq)
    let mit_eingang = ($links | where {|l| $l.ziel != $l.von_stem } | get ziel | uniq)
    for n in ($alle | where ordner == zettel) {
        let raus = ($links | where von == $n.pfad and ziel != '' and ziel != $n.stem and (not (ist-anhang $it.ziel) or ($it.ziel in $stems)))
        if ($raus | is-empty) {
            $b = ($b | append (befund hinweis $n.pfad netz-ohne-links "Zettel verlinkt keinen anderen Zettel"))
        }
        if not ($n.stem in $aus_struktur) {
            $b = ($b | append (befund hinweis $n.pfad netz-ohne-struktur "Zettel steht in keinem Strukturzettel"))
        } else if not ($n.stem in $mit_eingang) {
            $b = ($b | append (befund hinweis $n.pfad netz-verwaist "Kein Zettel verweist hierher"))
        }
    }
    for n in ($alle | where ordner == struktur) {
        if not ($n.stem in $aus_struktur) {
            $b = ($b | append (befund hinweis $n.pfad netz-struktur "Strukturzettel ist nicht in index.md oder einem anderen Strukturzettel verlinkt"))
        }
    }
    let n_inbox = ($alle | where ordner == inbox | length)
    if $n_inbox > 0 {
        $b = ($b | append (befund hinweis inbox/ inbox-voll $"($n_inbox) Notiz\(en\) warten in der Inbox"))
    }

    # --- Befehle für Claude Code und OpenCode gleich? -------------------------
    let cc = ($root | path join .claude commands)
    let oc = ($root | path join .opencode commands)
    if ($cc | path exists) and ($oc | path exists) {
        let namen = (glob $"($cc)/*.md" | append (glob $"($oc)/*.md") | each { path basename } | uniq)
        for name in $namen {
            let a = ($cc | path join $name)
            let o = ($oc | path join $name)
            if not ($a | path exists) or not ($o | path exists) or (open --raw $a) != (open --raw $o) {
                $b = ($b | append (befund hinweis $".claude|.opencode/commands/($name)" befehle-abweichend "Befehl ist in .claude/ und .opencode/ nicht gleich"))
            }
        }
    }

    # --- Bericht ------------------------------------------------------------
    let fehler = ($b | where stufe == fehler)
    let hinweise = ($b | where stufe == hinweis)
    let zeigen = if $nur_fehler { $fehler } else { $b }

    if ($zeigen | is-not-empty) {
        print ($zeigen | sort-by stufe datei | table --expand)
    }
    let zahlen = ($alle | group-by ordner | items {|k, v| $"($k): ($v | length)" } | str join ', ')
    print $"Notizen – ($zahlen)"
    print $"Ergebnis: ($fehler | length) Fehler, ($hinweise | length) Hinweise"

    if ($fehler | is-not-empty) { exit 1 }
}

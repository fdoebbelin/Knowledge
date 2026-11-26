#!/usr/bin/env nu
# Website mit Quartz bauen – lokal und in der GitHub Action gleich.
#
#   nu scripts/website.nu           # bauen nach _build/public
#   nu scripts/website.nu --serve   # bauen und unter http://localhost:8080 anzeigen
#
# Quartz wird in _build/quartz geklont (nicht im Repo). Die Version steht in QUARTZ_REF.

use lib.nu *

const QUARTZ_REF = 'v5.1.0'

def main [
    --serve   # lokale Vorschau mit Live-Reload
] {
    let root = (vault-root)
    let build = ($root | path join _build)
    let quartz = ($build | path join quartz)
    mkdir $build

    if not ($quartz | path exists) {
        git -c advice.detachedHead=false clone --quiet --depth 1 --branch $QUARTZ_REF https://github.com/jackyzha0/quartz.git $quartz
    }
    cp ($root | path join _meta quartz quartz.config.yaml) ($quartz | path join quartz.config.yaml)

    cd $quartz
    if not ('node_modules' | path exists) { npm ci --no-audit --no-fund }
    npx quartz plugin install
    let ausgabe = ($build | path join public)
    if $serve {
        npx quartz build --directory $root --output $ausgabe --serve
    } else {
        npx quartz build --directory $root --output $ausgabe
        print $"Website gebaut: ($ausgabe | path relative-to $root)"
    }
}

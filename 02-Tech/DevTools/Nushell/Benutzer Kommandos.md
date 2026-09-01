<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

## Konfigurationsordner finden

In Nu:

```nu
$nu.default-config-dir
$nu.config-path
```

- `$nu.default-config-dir` zeigt dir das Verzeichnis (z.B. `/home/deinuser/.config/nushell`).
- In diesem Verzeichnis liegen `config.nu` und `env.nu`; dort sollten auch deine eigenen Skripte/Module wohnen.

## Skriptdatei speichern und laden

1. Lege z.B. `scripts/misc.nu` an:

```nu
# let misc = ($nu.default-config-dir | path join "scripts/misc.nu")
# code $misc
export def greet [name] {
  $"Hello, ($name)!"
}
```

2. In `config.nu` das Modul aktivieren, z.B.:

```nu
use misc.nu *
```

Danach ist `greet` in jeder neuen Nu‑Session automatisch verfügbar.

Wenn du stattdessen einzelne Dateien „roh“ sourcen willst, kannst du sie auch direkt neben `config.nu` speichern und in `config.nu` schreiben:

```nu
source greet.nu
```

Solange `greet.nu` im gleichen Verzeichnis wie `config.nu` liegt, wird sie beim Start geladen.
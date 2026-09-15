## Vorgehen

Windows-EXE-Dateien im PE-Format (Portable Executable) enthalten im Header einen
zwei-Byte-Wert (`Machine`), der die Zielarchitektur kodiert. Dieser liegt an einem
festen Offset relativ zum PE-Header-Beginn:

1. **Bytes 60–63** der Datei enthalten den Offset zum PE-Header (`e_lfanew`)
2. **PE-Header-Offset + 4** enthält den `Machine`-Wert (2 Bytes, Little-Endian)

Relevante Werte:

| Hex    | Dezimal | Bedeutung              |
|--------|---------|------------------------|
| 0xAA64 | 43620   | ARM64 – nativ          |
| 0x8664 | 34404   | x64 – emuliert auf WoA |
| 0x014C | 332     | x86 – emuliert auf WoA |

Nushell liest die Binärdaten mit `open --raw` und navigiert per `skip` + `first`
durch den Byte-Stream. Das ist zuverlässiger als `bytes at`, das in manchen
Nushell-Versionen auf Windows nicht korrekt funktioniert.

---

## Funktion

```nu
def check-arch [path: string] {
    let bytes = (open --raw $path | into binary)
    let pe_offset = ($bytes | skip 60 | first 4 | into int --endian little)
    let machine = ($bytes | skip ($pe_offset + 4) | first 2 | into int --endian little)
    match $machine {
        0xAA64 => "ARM64 (nativ)",
        0x8664 => "x64 (emuliert)",
        0x014C => "x86 (emuliert)",
        _ => $"Unbekannt: ($machine)"
    }
}
```

---

## Aufrufe

### Referenztest – Task-Manager (garantiert nativ ARM64)

```nu
check-arch "C:/Windows/System32/taskmgr.exe"
```

Erwartete Ausgabe: `ARM64 (nativ)`

### Helix Editor

```nu
check-arch (which hx | get path.0)
```

`which hx` ermittelt den tatsächlichen Pfad der installierten Helix-Binary
automatisch, unabhängig vom Installationsort.

---

## Einzeiler

Für eine schnelle Prüfung ohne Funktionsdefinition:

```nu
let p = (which hx | get path.0)
let b = (open --raw $p | into binary)
let off = ($b | skip 60 | first 4 | into int --endian little)
let machine = ($b | skip ($off + 4) | first 2 | into int --endian little)
match $machine {
    0xAA64 => "ARM64 (nativ)",
    0x8664 => "x64 (emuliert)",
    0x014C => "x86 (emuliert)",
    _ => $"Unbekannt: ($machine)"
}
```

---

## Hinweis zu System32 vs. SysWOW64

Auf Windows on ARM gilt:

- **`C:\Windows\System32`** – enthält ausschließlich native ARM64-Binaries
- **`C:\Windows\SysWOW64`** – enthält x86-Binaries (laufen unter Emulation)
- **`C:\Windows\SysArm32`** – enthält 32-Bit-ARM-Binaries (selten)

`System32/taskmgr.exe` ist daher immer ein verlässlicher Referenzwert für `ARM64 (nativ)`.

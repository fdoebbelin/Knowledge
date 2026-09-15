Letzten vollständigen Suspend/Resume-Zyklus anzeigen

```
sudo journalctl -b | find "PM:"
```

```log
╭─────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│   0 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]         │
│   1 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]         │
│   2 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]         │
│   3 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x27499000-0x2749afff]         │
│   4 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x28828000-0x29127fff]         │
│   5 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x2cc41000-0x2cd34fff]         │
│   6 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x2ed3e000-0x2fffdfff]         │
│   7 │ Apr 28 11:20:21 cachyos kernel: PM: hibernation: Registered nosave memory: [mem 0x2ffff000-0xffffffff]         │
│   8 │ Apr 28 11:20:21 cachyos kernel: ACPI: PM: Registering ACPI NVS region [mem 0x27499000-0x27499fff] (4096 bytes) │
│   9 │ Apr 28 11:20:21 cachyos kernel: ACPI: PM: Registering ACPI NVS region [mem 0x2f72e000-0x2ff7dfff] (8716288     │
│     │ bytes)                                                                                                         │
│  10 │ Apr 28 11:20:21 cachyos kernel: PM: RTC time: 09:20:19, date: 2026-04-28                                       │
│  11 │ Apr 28 11:20:21 cachyos kernel: ACPI: PM: (supports S0 S3 S4 S5)                                               │
│  12 │ Apr 28 11:20:21 cachyos kernel: PM:   Magic number: 6:317:324                                                  │
│  13 │ Apr 28 11:20:21 cachyos kernel: PM: genpd: Disabling unused power domains                                      │
│  14 │ Apr 28 11:20:22 cachyos kernel: PM: Image not found (code -22)                                                 │
│  15 │ Apr 28 11:24:04 YOGA kernel: PM: hibernation: hibernation entry                                                │
│  16 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]                │
│  17 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]                │
│  18 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x0009e000-0x000fffff]                │
│  19 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x27499000-0x2749afff]                │
│  20 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x28828000-0x29127fff]                │
│  21 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2cc41000-0x2cd34fff]                │
│  22 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2ed3e000-0x2fffdfff]                │
│  23 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2ffff000-0xffffffff]                │
│  24 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Basic memory bitmaps created                                     │
│  25 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Preallocating image memory                                       │
│  26 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Allocated 782946 pages for snapshot                              │
│  27 │ Apr 28 11:24:37 YOGA kernel: PM: hibernation: Allocated 3131784 kbytes in 3.13 seconds (1000.56 MB/s)          │
│  28 │ Apr 28 11:24:38 YOGA kernel: ACPI: PM: Preparing to enter system sleep state S4                                │
│  29 │ Apr 28 11:24:38 YOGA kernel: ACPI: PM: Saving platform NVS memory                                              │
│  30 │ Apr 28 11:24:38 YOGA kernel: PM: hibernation: Normal pages needed: 646198 + 1024, available pages: 1385423     │
│  31 │ Apr 28 11:24:38 YOGA kernel: ACPI: PM: Restoring platform NVS memory                                           │
│  32 │ Apr 28 11:24:38 YOGA kernel: ACPI: PM: Waking up from system sleep state S4                                    │
│  33 │ Apr 28 11:24:38 YOGA kernel: PM: hibernation: Basic memory bitmaps freed                                       │
│  34 │ Apr 28 11:24:38 YOGA kernel: PM: hibernation: hibernation exit                                                 │
│  35 │ Apr 28 11:25:13 YOGA kernel: PM: suspend entry (deep)                                                          │
│  36 │ Apr 28 11:25:38 YOGA kernel: ACPI: PM: Preparing to enter system sleep state S3                                │
│  37 │ Apr 28 11:25:38 YOGA kernel: ACPI: PM: Saving platform NVS memory                                              │
│  38 │ Apr 28 11:25:38 YOGA kernel: ACPI: PM: Low-level resume complete                                               │
│  39 │ Apr 28 11:25:38 YOGA kernel: ACPI: PM: Restoring platform NVS memory                                           │
│  40 │ Apr 28 11:25:38 YOGA kernel: ACPI: PM: Waking up from system sleep state S3                                    │
│  41 │ Apr 28 11:25:38 YOGA kernel: PM: suspend exit                                                                  │
│  42 │ Apr 28 11:26:50 YOGA kernel: PM: hibernation: hibernation entry                                                │
│  43 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]                │
│  44 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x00058000-0x00058fff]                │
│  45 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x0009e000-0x000fffff]                │
│  46 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x27499000-0x2749afff]                │
│  47 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x28828000-0x29127fff]                │
│  48 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2cc41000-0x2cd34fff]                │
│  49 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2ed3e000-0x2fffdfff]                │
│  50 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Marking nosave pages: [mem 0x2ffff000-0xffffffff]                │
│  51 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Basic memory bitmaps created                                     │
│  52 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Preallocating image memory                                       │
│  53 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Allocated 783837 pages for snapshot                              │
│  54 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Allocated 3135348 kbytes in 3.05 seconds (1027.98 MB/s)          │
│  55 │ Apr 28 11:27:25 YOGA kernel: ACPI: PM: Preparing to enter system sleep state S4                                │
│  56 │ Apr 28 11:27:25 YOGA kernel: ACPI: PM: Saving platform NVS memory                                              │
│  57 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Normal pages needed: 686265 + 1024, available pages: 1345358     │
│  58 │ Apr 28 11:27:25 YOGA kernel: ACPI: PM: Restoring platform NVS memory                                           │
│  59 │ Apr 28 11:27:25 YOGA kernel: ACPI: PM: Waking up from system sleep state S4                                    │
│  60 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: Basic memory bitmaps freed                                       │
│  61 │ Apr 28 11:27:25 YOGA kernel: PM: hibernation: hibernation exit                                                 │
│  62 │ Apr 28 11:43:29 YOGA kernel: PM: suspend entry (deep)                                                          │
│  63 │ Apr 28 11:43:47 YOGA kernel: ACPI: PM: Preparing to enter system sleep state S3                                │
│  64 │ Apr 28 11:43:47 YOGA kernel: ACPI: PM: Saving platform NVS memory                                              │
│  65 │ Apr 28 11:43:47 YOGA kernel: ACPI: PM: Low-level resume complete                                               │
│  66 │ Apr 28 11:43:47 YOGA kernel: ACPI: PM: Restoring platform NVS memory                                           │
│  67 │ Apr 28 11:43:47 YOGA kernel: ACPI: PM: Waking up from system sleep state S3                                    │
│  68 │ Apr 28 11:43:47 YOGA kernel: PM: suspend exit                                                                  │
│  69 │ Apr 28 11:44:56 YOGA kernel: PM: suspend entry (deep)                                                          │
│  70 │ Apr 28 11:45:05 YOGA kernel: ACPI: PM: Preparing to enter system sleep state S3                                │
│  71 │ Apr 28 11:45:05 YOGA kernel: ACPI: PM: Saving platform NVS memory                                              │
│  72 │ Apr 28 11:45:05 YOGA kernel: ACPI: PM: Low-level resume complete                                               │
│  73 │ Apr 28 11:45:05 YOGA kernel: ACPI: PM: Restoring platform NVS memory                                           │
│  74 │ Apr 28 11:45:05 YOGA kernel: ACPI: PM: Waking up from system sleep state S3                                    │
│  75 │ Apr 28 11:45:05 YOGA kernel: PM: suspend exit                                                                  │
╰─────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

Das Log ist ein Musterbefund — alles funktioniert exakt wie konfiguriert. Hier die Auswertung:

**11:24:04 — Hibernate (S4)**

```log
PM: hibernation entry
ACPI: Preparing to enter system sleep state S4   ← echter Hibernate
PM: Allocated 3131784 kbytes in 3.13 seconds     ← RAM auf Swap geschrieben
ACPI: Waking up from system sleep state S4
PM: hibernation exit                              ← erfolgreicher Resume
```

**11:25:13 — Suspend (S3)**

```log
PM: suspend entry (deep)                          ← S3, nicht s2idle ✓
ACPI: Preparing to enter system sleep state S3
ACPI: Waking up from system sleep state S3
PM: suspend exit                                  ← sauberer Resume
```

**11:26:50 — zweiter Hibernate-Zyklus, identisch sauber**

**11:43:29 und 11:44:56 — zwei weitere S3-Zyklen, beide mit `(deep)`**

---

Alle drei konfigurierten Zustände sind bestätigt:

|Zustand|Schlüsselzeile im Log|Status|
|---|---|---|
|S3 Suspend|`PM: suspend entry (deep)`|✅ korrekt|
|S4 Hibernate|`ACPI: system sleep state S4`|✅ korrekt|
|Resume aus S3|`Waking up from system sleep state S3`|✅ sauber|
|Resume aus S4|`Waking up from system sleep state S4`|✅ sauber|

Zeile 14 ist noch interessant: `PM: Image not found (code -22)` beim ersten Boot — das ist normal und bedeutet dass beim Start kein Hibernate-Image auf der Swap-Partition lag, also ein regulärer Kaltstart stattfand. Beim nächsten Boot nach einem Hibernate steht dort stattdessen das erfolgreiche Resume.

Die Konfiguration ist vollständig und funktioniert fehlerfrei.
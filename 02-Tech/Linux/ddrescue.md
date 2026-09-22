---
title: ddrescue
aliases:
  - GNU ddrescue
tags:
  - linux
  - datenrettung
  - archivierung
created: 2026-09-22
updated: 2026-09-22
status: draft
---

# ddrescue

Werkzeug zum Auslesen beschädigter Datenträger. Liest zuerst alles Fehlerfreie und hält den Fortschritt in einer Map-Datei fest, sodass sich ein Lauf jederzeit fortsetzen lässt. Für CD/DVD-Images der zuverlässigste Weg, weil defekte Bereiche den Lauf nicht abbrechen.

> [!note] Stichwortnotiz
> Die Erfahrungen stammen aus [[2026-09-21 Lexikothek CD-Archivierung]]; dort steht der vollständige Ablauf samt Nushell-Modul.

## Muster für CD-ROMs

```bash
ddrescue -b 2048 -d -n -N -v /dev/sr0 disc.iso disc.map
ddrescuelog -t disc.map          # Stand der Rettung ansehen
```

| Option | Bedeutung |
| --- | --- |
| `-b 2048` | Sektorgröße einer CD-ROM |
| `-d` | direkter Zugriff am Kernel-Cache vorbei |
| `-n` | kein Scraping, beschädigte Bereiche vorerst überspringen |
| `-N` | keine Wiederholungsversuche |
| `-s <größe>` | nur bis zu dieser Position lesen |
| `-i <position>` | erst ab dieser Position lesen |

## Was sich bewährt hat

- **Kopierschutzbänder überspringen:** Zwei Läufe mit `-s` und `-i` lesen Kopfbereich und Rest und lassen das absichtlich zerstörte Band dazwischen aus. Das spart Stunden.
- **`-T` nicht verwenden:** Die Option beendet ddrescue global, sobald eine Zeit lang nichts gelesen wurde – am Schutzband also sofort.
- **Laufwerk drosseln:** Langsamere Lesegeschwindigkeit senkt die Fehlerquote spürbar.
- **Immer nur ein Lauf gleichzeitig**, sonst blockieren sich die Prozesse am Gerät.

## Verwandt

- [[2026-09-21 Lexikothek CD-Archivierung]]
- [[Bertelsmann Lexikothek]]

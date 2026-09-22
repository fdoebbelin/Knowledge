---
title: Bertelsmann Lexikothek – CD-Archivierung und Datenanalyse
date: 2026-09-21
type: chat-protokoll
quelle: claude.ai
modell: Claude Opus 5
tags:
  - chat-protokoll
  - datenrettung
  - ddrescue
  - nushell
  - retrocomputing
  - urheberrecht
status: offen
---

# Bertelsmann Lexikothek – CD-Archivierung und Datenanalyse

> [!summary] Zusammenfassung
> Ziel war zunächst, die CD-ROM-Ausgabe der [[Bertelsmann Lexikothek]] (11 Discs, Stand 2001/2002) auf einem Windows-11-Notebook ohne Laufwerk nutzbar zu machen; im Verlauf verschob sich das Ziel zur langfristigen Erhaltung der Inhalte. Die Discs werden mit [[ddrescue]] über ein USB-Laufwerk als ISO-Images gesichert, wobei das LaserLock-Schutzband gezielt übersprungen wird; disc0–disc3 sind fertig, disc1 und disc2 auch entpackt. Die Medien (JPG, TGA, WAV, AVI) sind offen zugänglich, die 136.771 Artikeltexte in der Paradox-Datenbank auf disc1 sind dagegen verschlüsselt oder proprietär codiert und ohne den Rechteinhaber nicht erschließbar. Ergebnis sind ein [[Nushell]]-Modul für den Leseablauf, ein Header-Parser für Paradox und eine Erhaltungsnotiz mit Strategie für eine Anfrage bei Bertelsmann. Offen: disc4–disc10, Medienkonvertierung, Kontakt zu Bertelsmann.

> [!warning] Hinweise zur Vollständigkeit
> Der Hostname des Arbeitsrechners ist in Log-Auszügen durch `<HOST>` ersetzt. Einige Erklärungen von Claude im Chat erwiesen sich später als falsch; sie sind unten jeweils als solche gekennzeichnet statt stillschweigend korrigiert.

## Ausgangslage

- **Bestand:** 11 CD-ROMs – disc0 Systeminstallation, disc1 „Lexikodisc", disc2–disc10 Themen-Discs (Natur und Technik, Kultur und Gesellschaft, Geschichte und Geographie, Interactiva, Schätze der Welt, Abenteuer Erde, Menschen Mythen und Legenden, Geheimnis Mensch, Faszination Wissen). Systemvoraussetzung laut Verpackung: Windows ab 95.
- **Rechner:** Windows-11-Notebook ohne Laufwerk; Arbeitsumgebung Fedora [[Bluefin]] (Atomic) mit Nushell, Homebrew und [[Toolbx]].
- **Laufwerk:** externes USB-Laufwerk mit Schublade, 24x, Sunplus-SATA-Bridge `1bcf:0c31`, läuft nur als USB 2.0.
- **Überlegte Nutzungswege:** VM mit Windows XP/7/8 (Lizenzmedien vorhanden), Wine/Bottles unter Bluefin, direkte Extraktion der Inhalte. Letzterer wurde der Hauptweg.

## Problemlösungen

### A · Nutzung und Umgebung

#### 1. Welche Windows-Version für die VM

**Symptom:** Frage, ob XP, 7 oder 8 als Gastsystem dient; zusätzlich Frage nach einem fertigen XP-Image im Netz.

**Ursache:** Alte Multimedia-Software braucht 16-Bit-Installer-Unterstützung (NTVDM), DirectDraw und Indeo-Codecs.

**Lösung:** Windows XP 32-Bit in VirtualBox (nicht Hyper-V wegen fehlender DirectDraw-Beschleunigung), Netzwerk deaktiviert. Ein legales XP-Image aus dem Netz gibt es nicht; Weg über die eigene CD. Alternativ Wine/Bottles mit 32-Bit-Prefix und Windows-98-Modus.

> [!failure]- Verworfene Ansätze
> - VM- und Wine-Weg insgesamt – später hinfällig, weil LaserLock den Start aus einem ISO-Image verhindert (siehe Problem 9).

#### 2. `bsdtar` fehlt auf Bluefin

**Symptom:** Empfohlenes `bsdtar -xf disc1.iso` nicht vorhanden.

**Ursache:** libarchive ist nicht im Bluefin-Image.

**Lösung:** ISO ohne Zusatzwerkzeug über udisks einbinden:

```bash
udisksctl loop-setup -r -f ~/Lexikothek/disc0.iso
# hängt automatisch unter /run/media/$USER/<Label> ein
```

> [!failure]- Verworfene Ansätze
> - `brew install sevenzip` / `libarchive` – möglich, aber unnötig.

### B · Auslesen der Datenträger

#### 3. Extrem langsames Lesen mit vielen Fehlern (disc0)

**Symptom**

```text
current rate: 18841 B/s   average rate: 10910 B/s
read errors: 18   pct rescued: 1.09%   remaining time: 1h 10m
```

Im Kernel-Log:

```text
<HOST> kernel: sr 10:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=38s
<HOST> kernel: sr 10:0:0:0: [sr0] tag#0 Sense Key : Medium Error [current]
<HOST> kernel: sr 10:0:0:0: [sr0] tag#0 Add. Sense: No seek complete
```

**Ursache:** Mischung aus LaserLock-Schutzband (siehe Problem 9) und einem Laufwerk, das im Fehlerband die Spur verliert. `DID_OK` zeigt: kein USB-Problem.

**Lösung:** Laufwerk drosseln, Direktzugriff nutzen, Timeouts kürzen:

```bash
eject -x 4 /dev/sr0
echo 5 | sudo tee /sys/block/sr0/device/timeout
echo 1 | sudo tee /sys/block/sr0/device/eh_timeout
ddrescue -b 2048 -d -n -N -v /dev/sr0 disc2.iso disc2.map
```

> [!failure]- Verworfene Ansätze
> - Wechsel USB 3.0 → 2.0 – irrelevant, Journal zeigte keine Bus-Fehler.
> - Nur `timeout` auf 10 s setzen – die 38-s-Wartezeiten kommen aus dem Error-Handler-Pfad (`flags 0x0`), erst `eh_timeout` greift dort.

**Verifikation:** disc3 lief nach Drosselung und Reset mit 708 kB/s und `read errors: 0`.

#### 4. `-T 5s` bricht den ganzen Lauf ab

**Symptom**

```text
time since last successful read: 38s
Copying non-tried blocks... Pass 1 (forwards)
  Timeout expired
```

**Ursache:** `-T` beendet ddrescue global, sobald so lange nichts gelesen wurde – am Schutzband bei ~4,5 MB sofort. Die Option war von Claude falsch empfohlen.

**Lösung:** Schutzband gar nicht lesen, sondern aussparen:

```bash
ddrescue -b 2048 -d -n -N -s 4MiB  /dev/sr0 disc2.iso disc2.map   # Kopfbereich
ddrescue -b 2048 -d -n -N -i 16MiB /dev/sr0 disc2.iso disc2.map   # Rest
```

**Verifikation**

```bash
isoinfo -f -J -i disc2.iso | wc -l
# erwartet: ca. 8000–9000 Einträge (disc2: 8346)
```

#### 5. Kopierschutz – ja oder nein?

**Symptom:** Frage des Nutzers, ob Kopierschutz die vielen Lesefehler verursacht.

**Ursache:** Claude verneinte zunächst („bei Lexika unüblich", Fehler über die Disc verteilt). Das war falsch: die Dateiliste von disc1 zeigte ein Verzeichnis `/LASERLOK` mit `LASERLOK.IN`, `.O10`, `.O11`, `.O12` – eindeutig LaserLock.

**Lösung:** Umrechnen der Kernel-Sektoren (÷4) zeigte ein zusammenhängendes Band von ISO-Block ~2464 bis ~7264 (≈ 5–15 MB) – genau das absichtlich zerstörte Schutzband. Diese Sektoren werden nie lesbar und dürfen verloren gehen.

```bash
isoinfo -f -i disc1.iso | grep -i laserlok
```

> [!note] Konsequenz
> LaserLock prüft, ob die Sektoren **unlesbar** sind. Im ISO sind sie Nullen, also lesbar → die Software startet aus einem Image nicht, weder in VM noch unter Wine. Die Umgehung wäre § 95a UrhG; dabei wurde keine Hilfe geleistet.

#### 6. Laufwerk hängt, sechs Prozesse auf `/dev/sr0`

**Symptom:** `lexiread 3 --no-eject --skip-from 4MiB` zeigt keinen Fortschritt.

```text
│ 0 │ 22372 │ ddrescue │ Disk sleep │
│ 1 │ 23369 │ eject    │ Disk sleep │
│ 2 │ 23816 │ eject    │ Disk sleep │
...
```

Danach `udisksctl info` mit widersprüchlichen Größen `671879168` und `0`.

**Ursache:** Mehrfach gestartete Läufe; die Sunplus-Bridge blockiert bei Lesefehlern die SCSI-Kommunikation statt Fehler zu melden. Claude hatte zuerst fälschlich den sudo-Pipe-Dialog als Ursache genannt.

**Lösung**

```nushell
ps | where name =~ 'eject|ddrescue|udisksctl' | get pid | each {|p| ^kill -9 $p } | ignore
# dann USB-Kabel physisch trennen, 10 s warten, wieder anstecken
lexi-drossel
```

**Verifikation**

```nushell
^journalctl -k -n 20 | lines | where {|l| $l =~ 'sr0|usb'}
# erwartet: "Attached scsi CD-ROM sr0"
```

> [!important] Regel
> Immer nur **einen** Lauf gleichzeitig. Vor jedem Start `ps | where name =~ 'ddrescue|eject'` prüfen.

### C · Extrahieren der Inhalte

#### 7. `find` findet auf disc2 keine Datenbankdateien

**Symptom:** `find $SRC -iname '*.DB' -o -iname '*.MB' ...` ohne Ausgabe; `udisksctl mount` meldet danach `AlreadyMounted`.

**Ursache:** Claude erklärte das im Chat zuerst mit fehlendem Einhängen, dann mit Operator-Vorrang bei `-o` – beides trifft nicht zu (`loop-setup` hängt automatisch ein; ohne explizites `-print` gilt die Ausgabe für den ganzen Ausdruck). **Tatsächliche Ursache:** disc2 enthält gar keine Datenbank.

**Verifikation**

```bash
grep -icE "\.(db|mb|px|val|dat|idx)$" ~/Lexikothek/disc2.txt
# Ausgabe: 0
```

#### 8. LaserLock-Verzeichnis wird trotz `--exclude` kopiert

**Symptom:** `77M .../disc2/Laserlok` nach `rsync --exclude='LASERLOK/'`.

**Ursache:** Joliet-Baum schreibt `Laserlok`, rsync-Muster sind case-sensitiv.

**Lösung**

```bash
rsync -a --info=progress2 --exclude='[Ll][Aa][Ss][Ee][Rr][Ll][Oo][Kk]/' "$SRC"/ "$DST"/
```

#### 9. Pfade aus der Dateiliste stimmen nicht

**Symptom**

```text
cd: .../disc1/RET_401/PROG_401: Datei oder Verzeichnis nicht gefunden
cat: .../LD.INF: Datei oder Verzeichnis nicht gefunden
```

**Ursache:** `disc1.txt` stammte aus `isoinfo -f` (ISO-9660, 8.3-Großschreibung); gemountet wird der Joliet-Baum: `prog_401`, `LD.inf`.

**Lösung:** Dateilisten immer mit Joliet ziehen: `isoinfo -f -J -i discN.iso`.

#### 10. Kopierte Dateien schreibgeschützt

**Symptom:** Alles `r--------`, Verzeichnisse `dr-x------` trotz `chmod -R u+w`.

**Lösung**

```bash
chmod -R u+rwX ~/Lexikothek/inhalte/disc1
```

#### 11. Variablen und Befehlsblöcke laufen ins Leere

**Symptom:** `ls`/`cat` im falschen Verzeichnis, leere `$SRC`/`$DST1`.

**Ursache:** Mehrzeilige Blöcke wurden eingefügt, bevor der vorherige Schritt fertig war; `toolbox enter` startet eine neue Shell, der Rest des eingefügten Blocks geht verloren; Shell-Variablen gelten nur in der Sitzung, in der sie gesetzt wurden.

**Lösung:** Schrittweise ausführen, volle Pfade verwenden – im Modul gekapselt.

### D · Analyse der Datenbank

#### 12. Kein Werkzeug für Paradox verfügbar

**Symptom**

```text
Warning: No available formula with the name "pxlib".
Keine Übereinstimmung für Argument: pxlib
bash: pip: Kommando nicht gefunden.
*** stack smashing detected ***: terminated
```

**Ursache:** pxlib weder in Homebrew noch in Fedora 42; im frischen Toolbx fehlt pip; die Binärbibliothek im `pypxlib`-Wheel hat einen Pufferüberlauf.

**Lösung:** Eigener Header-Parser in reinem Python (`pxhead.py`) und anschließend manuelle Auswertung des Hexdumps.

> [!failure]- Verworfene Ansätze
> - `uv run --with pypxlib` – uv im Container nicht vorhanden.
> - pxlib aus den Quellen bauen – nicht mehr nötig.

#### 13. Parser liefert unplausible Werte

**Symptom**

```text
Felder ............. 1536
Schluesselfelder ... 256
Verschluesselung ... 0x00ff0000   << Tabelle ist passwortgeschuetzt!
```

**Ursache:** Datei folgt dem älteren Paradox-3.5-Layout, die Offsets ab 0x20 stimmen nicht. Die Verschlüsselungsmeldung war damit wertlos – Claude hatte sie ohne Plausibilitätsprüfung ausgegeben.

**Lösung:** Schema empirisch aus dem Hexdump bestimmt: Tabellenname `resttemp.DB` bei 0xA0 (79-Byte-Festfeld), Feldnamen ab 0xEF, davor 7 Zeiger (1 Tabelle + 6 Felder), Deskriptoren ab 0x78.

| Feld | Typ | Größe |
|---|---|---|
| `No` | Long | 4 |
| `Document` | Formatted Memo | 20 |
| `SubTitle` | Formatted Memo | 11 |
| ? | Formatted Memo | 11 |
| ? | Formatted Memo | 11 |
| ? | BLOB | 11 |

**Verifikation:** 4+20+11+11+11+11 = 68 = Satzlänge aus dem Header; 136.771 × 68 ≈ 9,3 MB = Dateigröße `LD_DOC.DB`.

#### 14. Artikeltexte nicht lesbar – ungelöst

**Symptom:** `strings -n 8 LD_DOC.MB` und `xxd -s 2048 -l 512 LD_DOC.DB` liefern nur hochentropes Rauschen, kein Satzraster, keine Textfragmente.

**Ursache:** Verschlüsselung (Paradox-Passwortschutz oder Schicht der Retrieval-Engine), nicht abschließend geklärt. Kompression wurde ausgeschlossen, weil keinerlei Strukturreste sichtbar sind.

**Lösung:** Keine technische Lösung; Umgehung wurde bewusst nicht verfolgt. Weiterer Weg: Anfrage beim Rechtsnachfolger (siehe Erhaltungsnotiz).

### E · Nushell-Modul

#### 15. `filter` ist veraltet

**Symptom**

```text
⚠ Command deprecated.
filter was deprecated in 0.105.0 and will be removed in a future release.
```

**Lösung:** Alle `filter`-Aufrufe durch `where {|x| ...}` ersetzt (Modul v2).

#### 16. Keine Fortschrittsanzeige bei `lexiread`

**Symptom**

```text
lexiread 3 --no-eject --skip-from 4MiB
Hinweis: disc3.iso existiert bereits (4,2 MB) — Lauf wird fortgesetzt.
```

danach nichts, auch nicht „Laufwerk gedrosselt".

**Ursache:** Hing in `lexi-drossel` beim `eject`, weil Altprozesse das Laufwerk belegten (Problem 6). Die zusätzlich umgebaute sudo-Zeile (`sudo sh -c` statt Pipe auf `sudo tee`) ist sinnvoll, war aber nicht die Ursache.

**Lösung:** Modul v2 mit `--no-drossel`; Laufwerk einmal pro Anschluss mit `lexi-drossel` einstellen.

**Verifikation**

```text
╭───────────┬──────────╮
│ disc      │ 3        │
│ label     │ LD_4_2_3 │
│ eintraege │ 8632     │
│ laserlok  │ 4        │
│ groesse   │ 671,8 MB │
╰───────────┴──────────╯
```

## Artefakte & Prompts

### lexikothek.nu

- **Typ:** Nushell-Modul
- **Beschreibung:** Befehle `lexi-drossel`, `lexiread`, `lexifix`, `lexi-pruefe`, `lexicopy`, `lexistatus`, `lexitypen` zum Auslesen, Prüfen und Entpacken der Discs unter Aussparung des LaserLock-Bands. Liegt unter `~/.config/nushell/modules/`.

**Original-Prompts** (chronologisch, wörtlich)

> die restlichen disks einlesen, aber nicht als schleife, sondern als nushell befehl mit angabe der zu bearbeitenden disk und vorher immer auswerfen der letzten

> bitte als modul anlegen und ein include in config.nu

> Bitte das Modul komplett als Download

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe ein Nushell-Modul (aktuelle Nushell, ab 0.105: `where` mit Closure statt `filter`) namens lexikothek.nu zum Sichern von CD-ROMs mit LaserLock-Kopierschutz über ein USB-Laufwerk /dev/sr0 unter Fedora Bluefin.
> Arbeitsverzeichnis ~/Lexikothek, Dateien discN.iso, discN.map, discN.txt, entpackte Inhalte unter ~/Lexikothek/inhalte/discN.
> Befehle (alle exportiert, mit deutschen Kommentaren):
> - lexi-drossel [--speed 4 --timeout 5 --eh-timeout 1]: eject -x, beide SCSI-Timeouts per EINEM `sudo sh -c` setzen (keine Pipe auf sudo tee), udisks-Automount lösen.
> - lexiread <nr> [--skip-from 4MiB --skip-to 16MiB --no-eject --no-drossel]: vorherige Disc auswerfen, auf Enter warten, Schublade schließen, 15 s warten, optional drosseln, dann zwei ddrescue-Läufe `-b 2048 -d -n -N`: erst `-s skip-from`, dann `-i skip-to` (kein -T!). Danach lexi-pruefe.
> - lexifix <nr> [--bis 16MiB]: Schutzbereich nachlesen.
> - lexi-pruefe <nr>: ddrescuelog -t, Label per isoinfo -d, Dateiliste mit `isoinfo -f -J`, Anzahl Einträge und LaserLock-Dateien, Warnungen bei 0 LaserLock-Dateien oder <1000 Einträgen.
> - lexicopy <nr>: udisksctl loop-setup (hängt selbst ein), Loop-Device per parse -r ermitteln, Mountpunkt aus udisksctl info, rsync mit case-insensitivem Exclude '[Ll][Aa][Ss][Ee][Rr][Ll][Oo][Kk]/', chmod -R u+rwX, aushängen, leere Dateien melden; bei Fehlschlag manuelle Befehle ausgeben.
> - lexistatus: Tabelle über disc0–10.
> - lexitypen <nr>: Dateiendungen zählen.
> Dazu die Einbindung in config.nu per `use ~/.config/nushell/modules/lexikothek.nu *`.
> ```

Inhalt liegt im Vault neben dieser Notiz: `![[lexikothek.nu]]`

> [!note] Vorversionen
> Zuerst eine einzelne `def lexiread` im Chat (Timeout per Pipe auf `sudo tee`, `--skip-from 5MiB`), dann Modul v1 mit `filter` und ohne `--no-drossel`. Die Mountpunkt-Erkennung in `lexicopy` ist bisher ungetestet.

### pxhead.py

- **Typ:** Python-Skript (nur Standardbibliothek)
- **Beschreibung:** Liest den Header einer Paradox-Tabelle ohne pxlib. Funktioniert für Paradox 4.x; bei der Lexikothek-Datei (älteres Layout) liefert es ab Offset 0x20 falsche Werte – das Schema wurde deshalb manuell aus dem Hexdump bestimmt.

**Original-Prompts** (chronologisch, wörtlich)

> *** stack smashing detected ***: terminated
> Abgebrochen (Speicherabzug geschrieben)

(kein ausdrücklicher Auftrag; das Skript entstand als Antwort auf den Absturz von pypxlib)

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe ein Python-3-Skript pxhead.py ohne externe Abhängigkeiten, das den Header einer Borland-Paradox-Tabelle (.DB) liest und Satzlänge, Headergröße, Dateityp, Satzanzahl, Feldanzahl, Felddeskriptoren (Typ/Größe), Tabellenname und Feldnamen ausgibt.
> Unterstütze sowohl Paradox 4.x als auch das ältere 3.5-Layout: bestimme die Feldanzahl NICHT nur aus dem festen Offset, sondern validiere sie – Summe der Feldgrößen muss der Satzlänge entsprechen, die Zahl der 4-Byte-Zeiger vor dem Tabellennamen muss 1 + Feldanzahl sein, der Tabellenname steht in einem 79-Byte-Festfeld, die Feldnamen folgen direkt danach.
> Gib den Verschlüsselungsstatus nur aus, wenn die Header-Validierung erfolgreich war, sonst „nicht bestimmbar".
> Markiere Memo-/BLOB-Felder, deren Inhalt in der .MB-Datei liegt.
> ```

Inhalt: `![[pxhead.py]]`

### Lexikothek-Erhaltung.md

- **Typ:** Obsidian-Markdown-Dokument
- **Beschreibung:** Fachliche Erhaltungsnotiz: Probleme und Lösungen, Struktur aller Discs, LaserLock, Retrieval-Engine, Paradox-Schema, Befund zur Verschlüsselung, Rechtekette bis Bertelsmann/inmediaONE, Ansprechpartner und abgestufte Bitten (A–D) für eine Anfrage.

**Original-Prompts** (chronologisch, wörtlich)

> fasse den Gesprächsverlauf mit allen Problemen in einer Obsidian Markdown-Datei zusammen und kommentiere die Lösungen und gehe auch auf die Struktur der CDs ein und die Software die im Hintergrund liegen könnte, ich möchte eine Lösung in Verbindung mit Bertelsmann aufsetzen um den Schatz, der in dieser Applikation steckt für die Zukunft zu erhalten

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle eine Obsidian-Notiz (deutsch, YAML-Frontmatter, Callouts) zur Erhaltung der CD-ROM-Ausgabe der Bertelsmann Lexikothek (11 Discs, LaserLock, Paradox-Datenbank LD_DOC mit 136.771 Sätzen, verschlüsselte Memos, Mediendiscs mit JPG/TGA/WAV/AVI).
> Inhalte: Problemtabelle zum Auslesen mit Diagnose und Lösung; Struktur je Disc; Analyse von LaserLock, Retrieval-Engine (RET_401, .spc/.phr/.nhv) und Paradox-Schema; ehrliche Bilanz inkl. eigener Fehleinschätzungen; recherchierte Rechtekette (wissenmedia → inmediaONE, Marken LEXIKOTHEK/LEXIKODISC, Brockhaus separat an NE GmbH) mit Quellenprüfung; Ansprechpartner (Unternehmensarchiv zuerst, dann Corporate Legal, DNB, nestor); abgestufte Bitten von Engine-Auskunft bis Redaktionsexport; Argumentationslinie; Checkliste vor der Anfrage; rechtliche Punkte (§ 95a, § 60e, § 95b UrhG) nur als Prüfauftrag für einen Fachanwalt.
> ```

Inhalt: `![[Lexikothek-Erhaltung.md]]`

## Entscheidungen

- **Inhalte extrahieren statt Software betreiben** – LaserLock verhindert den Start aus Images; die Medien sind ohnehin offen.
- **Schutzband überspringen statt lesen** – die Sektoren sind absichtlich zerstört; spart pro Disc Stunden und schont das Laufwerk.
- **Laufwerk auf 4x drosseln, Timeouts 5 s / 1 s** – hat die Lesefehlerquote bei disc3 auf null gebracht.
- **Keine Umgehung von LaserLock oder der Verschlüsselung** – § 95a UrhG; stattdessen Weg über den Rechteinhaber.
- **Anfrage zur Lexikothek an Bertelsmann, nicht an NE GmbH** – Marken LEXIKOTHEK/LEXIKODISC lagen bei wissenmedia, nur Brockhaus ging 2015 an NE.
- **Erster Kontakt über das Unternehmensarchiv** – eigener Erhaltungsauftrag, fachlich verbündet.
- **Toolbx `lexikothek` nur als Wegwerf-Werkzeug** – nach der Konvertierung mit `toolbox rm lexikothek` entfernen.

## Nützliche Befehle & Snippets

```bash
lsblk                                            # Laufwerk finden
eject -x 4 /dev/sr0                              # auf 4x drosseln
journalctl -k -f                                 # SCSI-/USB-Fehler live
ddrescuelog -t discN.map                         # Stand der Rettung
ddrescuelog -l- discN.map                        # endgültig verlorene Blöcke
isoinfo -d -i discN.iso                          # Label, Volumengröße
isoinfo -f -J -i discN.iso > discN.txt           # Dateiliste mit Joliet-Namen
udisksctl loop-setup -r -f discN.iso             # einbinden (mountet automatisch)
udisksctl unmount -b /dev/loopX && udisksctl loop-delete -b /dev/loopX
losetup -a                                       # belegte Loop-Devices
xxd -l 256 LD_DOC.DB                             # Paradox-Header
xxd -s 2048 -l 512 LD_DOC.DB                     # erster Datenblock
```

```nushell
ps | where name =~ 'ddrescue|eject'              # vor jedem Lauf prüfen
lexi-drossel                                     # einmal pro Anschluss
lexiread 4 --no-drossel                          # nächste Disc
lexicopy 4
lexistatus
```

## Offene Punkte

- [ ] disc4–disc10 mit `lexiread N --no-drossel` sichern, danach `lexicopy N`
- [ ] disc3 kopieren (`lexicopy 3`) – Image fertig, Inhalte noch nicht entpackt
- [ ] `lexicopy` testen (Mountpunkt-Erkennung ungeprüft)
- [ ] Prüfsummen aller ISOs in `SUMMEN.txt`, an zwei Orten ablegen
- [ ] Leere Ordner `~/Lexikothek/disc0`–`disc10` aus dem ersten Versuch aufräumen
- [ ] disc0: `isoinfo -l` und `isoinfo -f -J` – Größe und echter Name von `LDISC4~1.EXE`, `VERSION.TXT` lesen
- [ ] `strings` auf `LDISC4~1.EXE` nach Engine-Hersteller (Fulcrum, Verity, Dataware, BRS)
- [ ] Feldnamen 4–6 aus `xxd -s 224 -l 128 LD_DOC.DB`
- [ ] `LD-5.phr` / `LD-6.phr` (1 Byte je Artikel) auf offene Attributdaten prüfen
- [ ] TGA → PNG (Alphakanal prüfen), AVI → H.264 nach `ffprobe`
- [ ] Medieninventar (Disc, Ordner, Datei, Format, Maße) erstellen
- [ ] Zweiseitigen Sachstandsbericht für Bertelsmann aus der Erhaltungsnotiz verdichten
- [ ] Kontakt Bertelsmann Unternehmensarchiv, Gütersloh
- [ ] DNB-Katalog auf die Lexikothek prüfen
- [ ] Fachanwaltliche Einschätzung zu § 60e / § 95b UrhG
- [ ] Toolbx `lexikothek` nach Abschluss entfernen

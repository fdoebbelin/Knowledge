# Übergabe

| | |
|---|---|
| Stand | 2026-10-21 |
| Von Rechner | fedora |
| Branch | main @ 19aad95 (+ dieser Handoff-Commit), mit origin/main synchron |
| Uncommittet | nein |

## Ziel

Der Knowledge-Vault wird aufgeräumt: neue Dokumente aus `00-Inbox` einordnen und Notizen eines Themenordners verdichten. Heute: Chat-Protokoll „Windows-SSD und Legacy-zu-UEFI-Umstellung“ (claude.ai, 19.–21.10.) samt Artefakten.

## Erledigt in dieser Session

- Neuer Ordner `02-Tech/Linux/UEFI-Boot/` (nn-Nummerierung):
  - `01-UEFI-Booteinträge anlegen.md` – Artefakt aus dem Chat, fast unverändert (Alias auf alten Namen, Verweise ergänzt).
  - `02-Legacy-zu-UEFI bei Fedora Atomic.md` – neues Runbook, verdichtet aus Protokoll Teil B und dem Vorprüfungs-PDF (Vorprüfung, Weg A/B, Schritte 0 und 3–6, Verifikation, verworfene Ansätze).
  - `03-btrfs und SMART im Live-System prüfen.md` – neu, aus Protokoll-Problem 10/11 und dem btrfs-PDF (Prüfblock, Ergebnis aus dem Live-System retten, Bewertungstabellen, Fallbeispiel P8B75-M).
  - `Schulungs-PCs – Stand der Umstellung.md` – Statustabelle der vier PCs und offene Punkte (nur als Notiz, kein Projektordner – Nutzerentscheidung).
  - Protokoll `2026-10-21 Windows-SSD und Legacy-zu-UEFI Umstellung.md` als Quelle, mit Einordnungshinweis; drei tote Wikilinks entfernt.
  - `_resources/uefi-pruefung.sh` und `_resources/Schritt-3-ESP-anlegen.pdf` (einziges behaltenes PDF, als Beispiel).
- Teil A (Windows-SSD/WinPE) als `02-Tech/Virtualization/KVM-QEMU/13-winpe-rettungs-vm.md`, `winpe-vm.nu` vollständig eingebettet.
- Querverweise in `Fedora Sway Atomic`, `LINUX Live-ISOs`, `ddrescue`, `11-kvm-windows11-vm`, `KVM-QEMU Leitfaden`; `Eingang.md` und `Struktur-Übersicht.md` nachgeführt (02-Tech jetzt 340 Notizen). Alle Wikilinks/Anker der geänderten Notizen geprüft.
- Commit `19aad95`, gepusht.
- Danach Helix-Binary-Weg dokumentiert: `02-Tech/Terminal/Helix/03-Installation.md` hat unter „Linux“ jetzt eine Vergleichstabelle und zwei Wege (Homebrew / lokales Binary in `~/.local/bin`). Weg 2 als Kurzfassung mit Ankerverweisen auf `00 Werkzeuge ins HOME-Verzeichnis installieren` (Abschnitte 3, 5.1, 6, 7), kein doppeltes Skript. Ergänzt: Hinweis „beide Wege gleichzeitig“ (`which -a hx`) und marksman-Einschränkung. `Nushell Editor setzen.md`: Toolbx-Hinweis. `sudoedit.md`: `sudo hx` scheitert am `secure_path`. Rücklink in der 00-Notiz. `CookBook/11` und `12` setzen keinen Installationsweg voraus, dort nichts geändert.

## Nächster Schritt

1. **Gegenlesen** (Nutzer): In 02 und 03 stehen kurze eigene Ergänzungen, die nicht wörtlich aus dem Protokoll stammen – Rolle von `bootuuid.cfg`/statischer `grub.cfg` (02, Schritt 4) und `btrfs subvolume list` zur ID-Zuordnung (03).
2. **Nach dem ersten echten Umbau** eines Schulungs-PCs: Ausgabe von `bootupctl status` in `02-…#Offen` nachtragen, Warnhinweis „nicht auf Hardware getestet“ anpassen, Tabelle in `Schulungs-PCs – Stand der Umstellung` aktualisieren (nach Neuinstallation P8B75-M auch die Disk-ID).
3. **Helix – Nutzerentscheidung offen:** Referenzsystem von Homebrew auf lokales Binary umstellen (`install-helix.nu` ausführen, `HELIX_RUNTIME` in `env.nu`, `brew uninstall helix`, im Container testen) oder bei Homebrew bleiben. Derzeit: nur Homebrew installiert (`/home/linuxbrew/.linuxbrew/bin/hx`, 25.07.1), `~/.local/share/helix` existiert nicht. Bei Umstellung den Satz „Auf dem Referenzsystem ist derzeit Weg 1 installiert“ in `03-Installation.md` anpassen.
4. Nicht verifiziert: dass Fedoras `secure_path` keine Benutzerpfade enthält (sudo verlangte ein Passwort) – in `sudoedit.md` mit Prüfbefehl formuliert.

## Entscheidungen

- Helix: beide Linux-Wege dokumentiert, am System nichts geändert – Umstellung ist Nutzerentscheidung.
- Zielordner `02-Tech/Linux/UEFI-Boot/` statt unter `Fedora/`, weil Notiz 01 nicht Fedora-spezifisch ist.
- Von fünf PDFs nur `Schritt-3-ESP-anlegen.pdf` als Beispiel behalten; Vorprüfungs-, btrfs- und die zwei PC-Varianten-PDFs sowie die reportlab-Generatoren (`quellen/`) und das Übergabe-ZIP nicht übernommen – Inhalt steckt in 02, 03 und der Statusnotiz.
- `winpe-vm.nu` (142 Zeilen) in die Notiz eingebettet, `uefi-pruefung.sh` (252 Zeilen) nur als Datei in `_resources/`.
- Schulungs-PC-Stand als Notiz im Tech-Ordner, nicht als `03-Projects/`.

## Sackgassen und Erkenntnisse

- Die losen Dateien in der Inbox waren byte-identisch mit dem Inhalt des Übergabe-ZIPs; nur `quellen/` war zusätzlich.
- Das ZIP lag zur Sicherheit noch im Session-Scratchpad (`/tmp/claude-1000/…`) – nach einem Neustart weg. Wer die PDF-Generatoren doch braucht: Original-Chat auf claude.ai.
- Push mit den aktuellen GitHub-Credentials auf diesem Rechner funktionierte ohne Nacharbeit.

## Relevante Dateien

- `02-Tech/Linux/UEFI-Boot/` – alle neuen Notizen, Skript, Beispiel-PDF
- `02-Tech/Virtualization/KVM-QEMU/13-winpe-rettungs-vm.md` – neu
- `02-Tech/Terminal/Helix/03-Installation.md` – offener Helix-Schritt
- `Struktur-Übersicht.md`, `00-Inbox/Eingang.md` – nachgeführt

## Nicht in Git

Nichts Neues. (Aus der Vorsitzung: `marksman` per brew installiert, nur in der Doku vermerkt.)

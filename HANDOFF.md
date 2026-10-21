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
- Danach Helix-Binary-Weg dokumentiert: `02-Tech/Terminal/Helix/03-Installation.md` hat unter „Linux“ jetzt eine Vergleichstabelle und zwei Wege (Homebrew / lokales Binary in `~/.local/bin`). Weg 2 als Kurzfassung mit Ankerverweisen auf `00 Werkzeuge ins HOME-Verzeichnis installieren` (Abschnitte 3, 5.1, 6, 7), kein doppeltes Skript. Ergänzt: Hinweis „beide Wege gleichzeitig“ (`which -a hx`) und marksman-Einschränkung. `Nushell Editor setzen.md`: Toolbx-Hinweis. `sudoedit.md`: `sudo hx` scheitert am `secure_path`. Rücklink in der 00-Notiz. `CookBook/11` und `12` setzen keinen Installationsweg voraus, dort nichts geändert. Commit `b45f971`, gepusht.
- Referenzsystem auf Weg 2 umgestellt: `~/.local/bin/install-helix.nu` aus Abschnitt 3 der 00-Notiz übernommen (lief unverändert, Helix 25.07.1 nach `~/.local/share/helix/25.07.1`), `HELIX_RUNTIME` auf oberster Ebene in `~/.config/nushell/env.nu` (vor dem Toolbx-Block), `brew uninstall helix`. Geprüft: Host und Toolbox `tauri-dev` finden `~/.local/bin/hx`, Runtime ok, im Container `rust-analyzer` ✓. `03-Installation.md` entsprechend aktualisiert.

## Nächster Schritt

1. **Gegenlesen** (Nutzer): In 02 und 03 stehen kurze eigene Ergänzungen, die nicht wörtlich aus dem Protokoll stammen – Rolle von `bootuuid.cfg`/statischer `grub.cfg` (02, Schritt 4) und `btrfs subvolume list` zur ID-Zuordnung (03).
2. **Nach dem ersten echten Umbau** eines Schulungs-PCs: Ausgabe von `bootupctl status` in `02-…#Offen` nachtragen, Warnhinweis „nicht auf Hardware getestet“ anpassen, Tabelle in `Schulungs-PCs – Stand der Umstellung` aktualisieren (nach Neuinstallation P8B75-M auch die Disk-ID).
3. **marksman fehlt:** Laut Vorsitzung per brew installiert, am 21.10. aber weder in `brew list` noch im PATH. Doku in `03-Installation.md` korrigiert („derzeit nicht installiert“). Klären: per brew neu installieren (nur Host) oder ebenfalls als lokales Binary (dann auch im Container) – Muster aus Abschnitt 8 der 00-Notiz.
4. Andere Rechner auf Weg 2 nachziehen: `install-helix.nu` anlegen und ausführen, `HELIX_RUNTIME` in `env.nu`, `brew uninstall helix`.
5. Nicht verifiziert: dass Fedoras `secure_path` keine Benutzerpfade enthält (sudo verlangte ein Passwort) – in `sudoedit.md` mit Prüfbefehl formuliert.

## Entscheidungen

- Helix: beide Linux-Wege dokumentiert; Referenzsystem auf Nutzerwunsch auf Weg 2 (lokales Binary) umgestellt, damit `hx` auch in Toolbx-Containern verfügbar ist.
- Zielordner `02-Tech/Linux/UEFI-Boot/` statt unter `Fedora/`, weil Notiz 01 nicht Fedora-spezifisch ist.
- Von fünf PDFs nur `Schritt-3-ESP-anlegen.pdf` als Beispiel behalten; Vorprüfungs-, btrfs- und die zwei PC-Varianten-PDFs sowie die reportlab-Generatoren (`quellen/`) und das Übergabe-ZIP nicht übernommen – Inhalt steckt in 02, 03 und der Statusnotiz.
- `winpe-vm.nu` (142 Zeilen) in die Notiz eingebettet, `uefi-pruefung.sh` (252 Zeilen) nur als Datei in `_resources/`.
- Schulungs-PC-Stand als Notiz im Tech-Ordner, nicht als `03-Projects/`.

## Sackgassen und Erkenntnisse

- Die losen Dateien in der Inbox waren byte-identisch mit dem Inhalt des Übergabe-ZIPs; nur `quellen/` war zusätzlich.
- Das ZIP lag zur Sicherheit noch im Session-Scratchpad (`/tmp/claude-1000/…`) – nach einem Neustart weg. Wer die PDF-Generatoren doch braucht: Original-Chat auf claude.ai.
- `toolbox run -c tauri-dev …` scheiterte aus der nicht-interaktiven Claude-Shell („Nushell launched as a REPL, but STDIN is not a TTY“); der Container-Test lief stattdessen über `podman exec --user fritz … tauri-dev`. In der Doku steht deshalb `toolbox enter`.
- `nu -c` lädt `env.nu` nicht – zum Testen `nu --env-config ~/.config/nushell/env.nu -c …`.
- Push mit den aktuellen GitHub-Credentials auf diesem Rechner funktionierte ohne Nacharbeit.

## Relevante Dateien

- `02-Tech/Linux/UEFI-Boot/` – alle neuen Notizen, Skript, Beispiel-PDF
- `02-Tech/Virtualization/KVM-QEMU/13-winpe-rettungs-vm.md` – neu
- `02-Tech/Terminal/Helix/03-Installation.md` – zwei Linux-Wege, Referenzsystem auf Weg 2
- `Struktur-Übersicht.md`, `00-Inbox/Eingang.md` – nachgeführt

## Nicht in Git

- `~/.local/bin/install-helix.nu` (Kopie des Skripts aus der 00-Notiz)
- `~/.local/share/helix/25.07.1/` (Binary und Runtime), Symlink `~/.local/bin/hx`
- `~/.config/nushell/env.nu`: `HELIX_RUNTIME` ergänzt; Sicherung `env.nu.bak-2026-10-21` daneben
- Homebrew-`helix` deinstalliert

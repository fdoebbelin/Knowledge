# Übergabe

| | |
|---|---|
| Stand | 2026-10-22 |
| Von Rechner | fedora |
| Branch | main @ 23d74f3 (+ die Commits dieser Session), mit origin/main synchron |
| Uncommittet | nein |
| Werkzeug | OpenCode v2.1.2, Projektwissen in `AGENTS.md` |
| Fortsetzung | auf einem anderen System: `git pull`, dann `opencode` starten – `AGENTS.md` wird automatisch gelesen |

## Ziel

Der Kurs `01-Courses/Programming/Tauri-Kompaktkurs` ist didaktisch umgebaut worden: Trainerskripte entfernt, Handouts zu Merkblättern verdichtet, Übungsblätter auf reine Frage-und-Antwort-Sammlungen reduziert, sämtliche Zeitangaben aus dem Kursmaterial entfernt. Ab K4 ist alles neu nach demselben Standard angelegt.

## Erledigt in dieser Session

- **Struktur** in `01-Courses/Programming/Tauri-Kompaktkurs/`:
  - Neu: `Leitfaden/`, `Merkblatt/`, `Übungen/` – je Modul (K0–K7) drei Notizen.
  - `00 Kompaktkonzept Tauri Grundlagen` → `00 Kompaktkurs Tauri Grundlagen` (zeitfrei, Alias gesetzt).
  - `Anhang Vorbereitung durch die Kursleitung` → `Anhang Begleitung und Vorbereitung` (Trainerabschnitte gerettet, Alias gesetzt).
  - Ordner `Bausteine/` mit 20 Altnotizen entfallen.
- **K0–K3 umgebaut** (bestehende Struktur umgebaut, nicht neu erfunden): Leitfaden, Merkblatt, Übungsblatt mit den Fragen `F1`–`F8` (K0), `F1`–`F6` (K1), `F1`–`F10` (K2), `F1`–`F10` (K3). Antworten jeweils in `> [!success]- Antwort FN`-Klappkästen.
- **K4–K7 neu angelegt** nach demselben Standard: Leitfaden, Merkblatt, Übungsblatt (`F1`–`F8`, `F1`–`F7`, `F1`–`F6`, `F1`–`F6`).
  - K6 bekommt ein Merkblatt mit der **Werkzeug-Brückentabelle** (Wunsch → Baustein → Modul).
- **Anhänge bereinigt**:
  - `Anhang Befehlskarte`: „Jeden Morgen“ → „Anwendung starten“, „Nur am letzten Tag“ → „Anwendung als Flatpak bauen und starten“, Links auf die neue 00-Notiz umgestellt.
  - `Anhang Sprachumfang JavaScript`: `box-shadow` ergänzt, Abschnitt „Bedingt erlaubt“ für `indexOf`, `splice`, `className`/`classList` (nur K6) eingefügt.
  - `Anhang Begleitung und Vorbereitung`: Restverweise auf „Kurstag“, „Vortag“ und „eine halbe Stunde“ zeitfrei formuliert.
- **Vault-weit geprüft**: alle Wikilinks im Kursordner aufgelöst (Ausnahme behoben: `[[bin]]` in der Rust-Strukturliste war ein toter Link), Frontmatter-Schlüssel `ue`, `kurstag`, `dauer` aus dem Kursmaterial entfernt.
- `Struktur-Übersicht.md` nachgeführt: neuer Abschnitt „Kursstruktur Tauri-Kompaktkurs“, Ordnerbaum, Zähler 01-Courses 702 → 706, Gesamtzahl rund 1.390, Historie-Eintrag 22.10.2026 (2).

## Nächster Schritt

1. **Gegenlesen** (Nutzer): die 24 neuen Notizen in `Leitfaden/`, `Merkblatt/`, `Übungen/` querlesen – vor allem die Übungsblätter, weil dort der F/A-Umfang festgelegt wurde.
2. **Push** erst nach Freigabe. Die Commits dieser Session sind lokal.
3. **Optional**: `05-Notes/Archive/` prüfen – die Altdateien wurden auf Nutzerwunsch **gelöscht** statt archiviert; die Sicherung liegt in der Git-Historie (`23d74f3` und älter). Wer sie doch behalten will: `git checkout 23d74f3 -- "01-Courses/Programming/Tauri-Kompaktkurs/Bausteine/"`.
4. **Offen für den nächsten Kursdurchlauf**: die Zwischenstände `stand-k1` … `stand-k6` aus `Anhang Begleitung und Vorbereitung` müssen noch erzeugt werden (steht in der Liste der offenen Punkte der 00-Notiz).

## Entscheidungen

- **Drei Notizen je Modul** in eigenen Ordnern statt einer Datei mit Anhängen: Leitfaden (Lernstoff), Merkblatt (Nachschlagetafel), Übungsblatt (Frage und Antwort). Der Leitfaden behält den Modulnamen ohne Zusatz, damit die Wikilinks aus der Kursübersicht unverändert gültig bleiben.
- **Merkblatt ohne Einleitung und ohne Selbsteinschätzung**, Übungsblatt ohne Abschlusskontrolle, ohne Zusatzaufgaben und ohne Schritt-für-Schritt-Bauanleitungen – nur Frage und Antwort zu behandelten Themen.
- **Keine Zeitangaben** im Kursmaterial: kein `ue`, `kurstag`, `dauer`, keine „Block A“, keine „am ersten Tag“. Ersatzformulierungen verweisen auf Module statt auf Tage.
- **Altdateien gelöscht, nicht archiviert** (Nutzerentscheidung). Git-Historie als Sicherung.
- **K6 mit Merkblatt**, obwohl das Modul keinen neuen Stoff bringt – die Werkzeug-Brückentabelle ist dort der eigentliche Nutzen.
- `indexOf`, `splice` und `className`/`classList` stehen bewusst **außerhalb** der allgemeinen Sprachliste, unter „Bedingt erlaubt“ im Anhang.

## Sackgassen und Erkenntnisse

- Der Ordner `Bausteine/` lässt sich nach dem Umbau nicht mehr mit `git mv` auflösen, weil die Altdateien gelöscht und die neuen unter anderen Namen geschrieben wurden. Git erkennt die Umbenennungen beim Commit trotzdem an der Ähnlichkeit – `git log --follow` zeigt sie.
- Die `id`-Liste aus K1 ist die Nahtstelle des ganzen Kurses: Ohne sie steht K4 still. Deshalb ist sie im Anhang ausdrücklich als nicht verhandelbar vermerkt.
- Die Merkblätter führen `aliases` auf die gelöschten Quellnotizen (`K1b Handout`, `K2c Übungsblatt` …). Alte Verweise aus anderen Notizen laufen dadurch weiter auf.
- Bei der Linkprüfung fällt auf, dass Rust-Toml-Syntax wie `[[bin]]` in Obsidian als Wikilink gelesen wird. Als Inline-Code schreiben.

## Relevante Dateien

- `01-Courses/Programming/Tauri-Kompaktkurs/00 Kompaktkurs Tauri Grundlagen.md` – Kursübersicht, Modultabelle
- `01-Courses/Programming/Tauri-Kompaktkurs/Leitfaden/` – 8 Leitfäden
- `01-Courses/Programming/Tauri-Kompaktkurs/Merkblatt/` – 8 Merkblätter
- `01-Courses/Programming/Tauri-Kompaktkurs/Übungen/` – 8 Übungsblätter
- `01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Begleitung und Vorbereitung.md` – Kursleitungsbegleitung
- `01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Befehlskarte.md` – Befehle für die Teilnehmenden
- `01-Courses/Programming/Tauri-Kompaktkurs/Anhang/Anhang Sprachumfang JavaScript.md` – verbindlicher Sprachumfang
- `Struktur-Übersicht.md` – nachgeführt

## Nicht in Git

- Unverändert gegenüber der vorherigen Session: `~/.local/bin/install-helix.nu`, `~/.local/share/helix/25.07.1/`, `~/.config/nushell/env.nu` mit `HELIX_RUNTIME`, Homebrew-`helix` deinstalliert, Homebrew-`marksman` installiert.

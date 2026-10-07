# Übergabe

| | |
|---|---|
| Stand | 2026-10-07 10:48 |
| Von Rechner | fedora |
| Branch | main @ 9722853 (mit origin/main synchron) |
| Uncommittet | nein |

## Ziel
Der Knowledge-Vault wird aufgeräumt: neue Dokumente aus `00-Inbox` einordnen, Notizen eines Themenordners in eine Lesereihenfolge `nn-Name` bringen und die Verlinkung im ganzen Vault instand halten. Zuletzt ging es um die Yazi-Notizen.

## Erledigt in dieser Session
- Coaching-Leitfaden aus dem Eingang eingeordnet: `02-Tech/Terminal/Yazi/04-Türöffner (Coaching).md`, Frontmatter auf `created`/`status`/`type` angeglichen.
- Yazi-Ordner nummeriert: `01-Einführung`, `02-Leitfaden zum Spickzettel`, `03-Installation und Konfiguration`, `04-Türöffner (Coaching)`. Alte Namen stehen als `aliases` in den Notizen.
- Vault-weite Linkbereinigung: 233 Verweise ohne Ziel und 30 falsche Anker beseitigt (entklammert, umgelenkt oder repariert), 30 fehlerhafte Clipping-Links `[[text](url)]` korrigiert.
- 40 verwaiste Anhänge nach `05-Notes/Archive/verwaiste-anhänge/` ausgelagert (Herkunftspfad erhalten), Indexnotiz `Verwaiste Anhänge.md` dort.
- Merge mit der Gegenseite aufgelöst (dort waren dieselben Yazi-Notizen von fünf auf drei zusammengefasst worden); 15 Clipping-Bilder sind dadurch gelöscht, die übrigen 25 liegen im Archiv.
- `Struktur-Übersicht.md`: Regel für Nummernpräfixe, aktueller Wartungsstand, Historieneinträge.

## Nächster Schritt
Die 25 Dateien in `05-Notes/Archive/verwaiste-anhänge/` durchsehen und entscheiden: einzeln zurückholen (an den im Pfad erhaltenen Ursprungsort) oder den Ordner samt Indexnotiz löschen. Details stehen in `05-Notes/Archive/verwaiste-anhänge/Verwaiste Anhänge.md`.

Danach offen:
- Erweitertes Helix-Spickzettel-PDF (`02-Tech/Terminal/Helix/_resources/Helix_Spickzettel_A4_erweitert.pdf`) hat kein Chat-Protokoll; außerdem nennt es „Helix Cheat Sheet v1.1 (Steve Hoy, CC BY-SA)" als Grundlage – bei Schulungseinsatz Namensnennung und gleiche Lizenz beachten.
- Ungeklärt: Ob `Z` (zoxide) und die Bildvorschau in foot auf diesem Rechner wirklich funktionieren, wurde nie in einer echten Sitzung geprüft.
- Prüfen, ob weitere Ordner mit Lesereihenfolge ein `nn-`-Präfix bekommen sollen (z. B. `02-Tech/Terminal/Helix`).

## Entscheidungen
- Dateinamen im Yazi-Ordner ohne „Yazi" im Namen, Form `nn-Thema` (verworfen: `01 Yazi – Thema` mit Leerzeichen, und kleingeschriebene Kurznamen).
- Beim Merge gewann der Inhalt der Gegenseite, die Nummerierung wurde darauf angewendet (verworfen: eigene sechs Einzelnotizen behalten, dabei wäre die neue „Einführung" verloren gegangen).
- Chat-Protokolle liegen beim Thema, nicht in einem eigenen Protokollordner; auffindbar über Tag `chat-protokoll`.
- Verweise auf nie geschriebene Notizen wurden zu reinem Text statt zu Stichwortnotizen; Verweise auf die vaultfremde `docs/`-Reihe stehen als Code (`docs/01-erkenntnisse`).

## Sackgassen und Erkenntnisse
- Das Massen-Entklammern erwischte zunächst auch Syntaxbeispiele in Inline-Code (`` `[[Wikilinks]]` ``, `` `[[bin]]` ``); 22 Zeilen mussten aus dem Diff wiederhergestellt werden. Bei solchen Läufen Inline-Code mitmaskieren, nicht nur Codeblöcke.
- Linkprüfskripte melden Fehlalarme bei Ankern mit Backticks (`#3.1 \`Containerfile\``) und in Dateien mit ungerader Zahl von Code-Zäunen. Vor dem „Reparieren" gegen den Rohtext gegenprüfen.
- Die erste Zählung verwaister Anhänge (95) war zu hoch: URL-kodierte Pfade (`%20`) und `src`/`href` in HTML müssen mitgezählt werden, dann sind es 42.
- Anker mit Backticks in Überschriften vermeiden; in zwei Fällen wurde die Überschrift entschärft (`## 9 Präfixtasten: g · , · m · c · t · e`).

## Relevante Dateien
- `Struktur-Übersicht.md` – Regeln, Ordnerbaum, Wartungsstand, Historie
- `00-Inbox/Eingang.md` – Ablauf für neue Dokumente, Konventionen für Chat-Protokolle
- `02-Tech/Terminal/Yazi/` – die vier nummerierten Notizen plus `_resources/`
- `05-Notes/Archive/verwaiste-anhänge/Verwaiste Anhänge.md` – Liste der ausgelagerten Dateien
- `02-Tech/AI/Claude-Skills/chat-protokoll – frontmatter.md` – Vorgabe, die im Skill `chat-protokoll` als `references/frontmatter.md` eingebunden ist

## Nicht in Git
Die Yazi-Arbeitsumgebung selbst liegt außerhalb des Repos und fehlt auf einem anderen Rechner:
- brew-Pakete: `yazi glow mermaid-cli rich-cli eza media-info fd ripgrep fzf zoxide resvg ouch`
- `~/.config/yazi/` (yazi.toml, keymap.toml, theme.toml, init.lua, package.toml), Flavor `solarized-light` aus dem ZIP in `_resources`
- Skripte `~/.local/bin/ofm-preview` und `~/.local/bin/mermaid-view`, Stile `~/.config/glow/solarized-light.json` und `~/.config/mermaid/solarized-light.json`
- Headless-Chromium unter `~/.cache/puppeteer` (für `mmdc`), zoxide-Hook in `~/.local/share/nushell/vendor/autoload/zoxide.nu`

Alle Inhalte stehen in `02-Tech/Terminal/Yazi/03-Installation und Konfiguration.md`, Abschnitt „Schnellstart".

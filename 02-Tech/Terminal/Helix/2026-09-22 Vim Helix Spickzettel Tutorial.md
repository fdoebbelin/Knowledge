---
title: Vim- und Helix-Spickzettel plus erweitertes Helix-Tutorial
created: 2026-09-22
type: chat-protokoll
source: claude.ai
model: Claude Opus 4.8
tags:
  - chat-protokoll
  - helix
  - obsidian
  - pdf
  - scoop
  - vim
status: active
---

# Vim- und Helix-Spickzettel plus erweitertes Helix-Tutorial

> [!summary] Zusammenfassung
> Ziel war zuerst ein einseitiger Vim-Spickzettel als PDF (DIN A4, deutsch), danach ein passendes Helix-Gegenstück im gleichen Layout „zum Vergleichen". Anschließend eine kurze Klärung, wie sich der eingebaute Helix-Tutor unter Scoop/Windows starten lässt, und zuletzt ein erweitertes Helix-Tutorial als Obsidian-Markdown, das gezielt die Stärken von Helix zeigt. Ergebnis: drei fertige Artefakte (zwei PDFs, eine Markdown-Datei). Beide Spickzettel passen exakt auf je eine A4-Seite; die Helix-Tastenkürzel wurden gegen die offizielle Keymap geprüft. Stand: abgeschlossen, mehrere optionale Erweiterungen offen.

## Ausgangslage

- Bedarf an deutschsprachigen Schulungsunterlagen zu Terminal-Editoren.
- Helix ist unter **Windows via Scoop** installiert (`hx`).
- Obsidian ist die Zielumgebung für Textdokumente.
- Renderumgebung für die PDFs: HTML → headless Chromium (Playwright). `weasyprint` war nicht installiert, `wkhtmltopdf` vorhanden, aber nicht genutzt.

## Problemlösungen

### 1. PDF läuft auf zwei Seiten über (Vim- und Helix-Blatt)

**Symptom**

```text
pages: 2
# Beim Vim-Blatt rutschte nur das Fuß-Band ("Vim-Logik") auf Seite 2.
# Beim Helix-Blatt: sheet height px: 1154.3  A4px: 1122.5  overflow px: 31.8
```

**Ursache:** Der Inhalt war höher als die A4-Nutzfläche (1122,5 px bei 96 dpi). Das Helix-Blatt hat durch Mehrfach-Cursor-, Match- und LSP-Block mehr Zeilen als das Vim-Blatt und lief entsprechend stärker über (~8,4 mm).

**Lösung**

Höhe direkt im Browser messen und Abstände iterativ verdichten, bis `overflow` ≤ 0.

```python
# Overflow exakt messen statt raten
h = pg.evaluate("() => document.querySelector('.sheet').getBoundingClientRect().height")
# A4 = 297mm / 25.4 * 96 = 1122.5 px
```

```css
/* Helix: die entscheidenden Stellschrauben */
.row { line-height: 1.28; margin: 0 0 0.62mm; }  /* vorher 1.32 / 0.85mm */
.cat { margin: 0 0 2.6mm; }                       /* Block-Abstand */
.cat h2 { margin: 0 0 1.1mm; padding-bottom: 0.9mm; }
.cols { margin-top: 2.6mm; }                      /* 2mm Sicherheitspuffer */
```

> [!failure]- Verworfene Ansätze
> - Inhalt kürzen/Blöcke streichen – unnötig, das Verdichten der Abstände reichte.
> - `weasyprint` als Renderer – nicht installiert; Playwright/Chromium war die verlässliche Option.

**Verifikation**

```bash
python3 -c "from pypdf import PdfReader; print('pages:', len(PdfReader('helix_spickzettel.pdf').pages))"
# erwartet: pages: 1   (Messung: overflow px: -0.0)
```

### 2. Helix-Tutor öffnet nicht / keine Syntax-Hervorhebung (vorsorglich)

> [!note] Nicht real aufgetreten
> Dieser Fall wurde nicht beobachtet, sondern vorsorglich geklärt, weil er bei Windows-Paketmanagern bekannt ist. Bei Scoop ist die Runtime meist korrekt vorkonfiguriert.

**Symptom**

```text
hx --health
# ...
# Runtime directory: ...\runtime
# Runtime directory does not exist.
# -> Tutor und Themes funktionieren dann nicht
```

**Ursache:** `HELIX_RUNTIME` zeigt nicht auf das von Scoop ausgelieferte Runtime-Verzeichnis. (Bei Chocolatey dokumentiertes Problem; bei Scoop selten.)

**Lösung**

```powershell
setx HELIX_RUNTIME "$HOME\scoop\apps\helix\current\runtime"
# danach Terminal neu starten
```

**Verifikation**

```powershell
hx --health
# erwartet: Zeile "Runtime directory: ..." ohne "does not exist"
hx --tutor      # startet den eingebauten Grundkurs
```

## Artefakte & Prompts

### Vim_Spickzettel_A4.pdf

- **Typ:** PDF (eine A4-Seite), aus self-contained HTML via Chromium gerendert.
- **Beschreibung:** Deutscher Vim-Spickzettel mit Modi-Band, neun Kategorie-Blöcken in zwei Spalten (Befehle grün in JetBrains Mono, Erklärungen in IBM Plex Sans) und Fußband „Vim-Logik".

**Original-Prompts** (chronologisch, wörtlich)

> Bitte einen vim Leitfaden mit den wichtigsten Befehle immer kurz erklärt als pdf eine DIN a4 Seite

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle einen einseitigen Vim-Spickzettel als PDF im Format DIN A4 (Hochformat), auf Deutsch.
> - Genau EINE A4-Seite, randlos.
> - Kopf mit „vim"-Wortmarke (Monospace) + Untertitel „Befehlsreferenz – Die wichtigsten Kommandos, kurz erklärt".
> - Darunter ein Band mit den vier Modi (Normal, Einfügen, Visuell, Befehl), je 1–2 Sätze.
> - Zweispaltige Kategorie-Blöcke: Starten & Beenden, In den Einfügemodus, Cursor bewegen, Bearbeiten & Löschen,
>   Kopieren & Einfügen, Rückgängig & Wiederholen, Suchen & Ersetzen, Fenster/Buffer/Tabs, Einstellungen & Makros.
> - Pro Zeile: Befehl in Monospace und grün, dann kurze deutsche Erklärung.
> - Fußband „Vim-Logik: Anzahl + Operator + Bewegung" mit Beispielen (3dd, d2w, y$, 5G). Strg = Ctrl kennzeichnen.
> Technik: self-contained HTML mit eingebetteten Schriften (JetBrains Mono für Befehle, IBM Plex Sans für Text,
> als woff2 per file-URI), mit headless Chromium (Playwright page.pdf, format A4, print_background, margin 0) rendern.
> Höhe gegen A4 (1122,5 px bei 96 dpi) messen und Abstände so trimmen, dass es exakt auf eine Seite passt;
> Seitenzahl mit pypdf prüfen.
> ```

`![[Vim_Spickzettel_A4.pdf]]` – liegt im Vault neben dieser Notiz.

### Helix_Spickzettel_A4.pdf

- **Typ:** PDF (eine A4-Seite), gleiches Layout wie das Vim-Blatt.
- **Beschreibung:** Deutscher Helix-Spickzettel im selben Raster, aber in Petrol/Teal statt Grün, mit Zusatzblock „Mehrfach-Cursor" und Fußband „Helix-Logik". Tastenkürzel gegen die offizielle Keymap verifiziert.

**Original-Prompts** (chronologisch, wörtlich)

> Jetzt bitte den Spickzettel für helix angepasst zum vergleichen

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Erstelle einen einseitigen Helix-Spickzettel als PDF (DIN A4, Deutsch) im GLEICHEN Layout wie mein
> Vim-Spickzettel, damit man beide zum Vergleich nebeneinanderlegen kann – aber Akzentfarbe Petrol/Teal statt Grün.
> - Wortmarke „helix", Untertitel wie beim Vim-Blatt; Modi-Band Normal, Einfügen, Auswahl (v), Befehl.
> - Kopf-Hinweis „Modell: erst Auswahl, dann Aktion – umgekehrt zu Vim".
> - Zweispaltige Blöcke u. a.: Starten & Beenden (hx), In den Einfügemodus, Cursor & Auswahl bewegen,
>   Bearbeiten (Auswahl → Aktion), Match & Surround (m-Modus), Mehrfach-Cursor (Helix-Spezial, kein Vim-Äquivalent),
>   Kopieren & Einfügen, Rückgängig & Wiederholen (U = Redo), Suchen & Ersetzen (% s … c statt :%s),
>   Goto & LSP (eingebaut), Fenster & Picker (Space).
> - Fußband „Helix-Logik": erst Auswahl dann Aktion, x wählt die Zeile, % wählt alles, U ist Redo,
>   Makros Q/q, Mehrfach-Cursor/LSP/Surround eingebaut.
> - Alle Tastenkürzel gegen die offizielle Keymap (docs.helix-editor.com/keymap.html) verifizieren, nicht aus dem Gedächtnis.
> Technik wie beim Vim-Blatt (HTML + eingebettete Schriften + Chromium-PDF); exakt eine A4-Seite, mit pypdf prüfen.
> ```

`![[Helix_Spickzettel_A4.pdf]]` – liegt im Vault neben dieser Notiz.

### Helix_Tutorial_erweitert.md

- **Typ:** Markdown-Dokument für Obsidian (~326 Zeilen).
- **Beschreibung:** Erweitertes, praxisorientiertes Helix-Tutorial, das die Stärken herausstellt (Auswahl-Modell, Mehrfach-Cursor, Tree-sitter, Surround, LSP, Pickers, Shell-Integration). Mit Frontmatter, Callouts, einklappbaren Übungslösungen, Wikilink-Inhaltsverzeichnis, Vim→Helix-Reflextabelle und Start-`config.toml`.

**Original-Prompts** (chronologisch, wörtlich)

> Kannst du mir ein erweitertes Tutorial zusammenstellen in dem die Stärken von Helix noch besser präsentiert werden am besten als Markdown für Obsidian

> [!tip] Reproduktions-Prompt (rekonstruiert)
> ```text
> Schreibe ein erweitertes Helix-Tutorial auf Deutsch als Obsidian-taugliche Markdown-Datei, das gezielt die
> STÄRKEN von Helix herausstellt (nicht nur eine Befehlsliste).
> - YAML-Frontmatter (tags/aliases/created); Einleitung mit dem Denkmodell „erst Auswahl, dann Aktion";
>   Inhaltsverzeichnis mit Obsidian-Wikilinks ([[#Überschrift]]).
> - Abschnitt 0: Vorbereitung unter Windows/Scoop (hx --tutor, hx --health, Konfig-/Runtime-Pfade).
> - Weitere Abschnitte: Kernschleife Auswahl→Aktion; Mehrfach-Cursor (s/C/Alt-s); Tree-sitter-Textobjekte
>   (Alt-o/Alt-i, mi/ma, ]f); Surround (ms/mr/md); LSP (gd/gr/Space k/Space r/Space a/]d); Pickers & Space-Menü;
>   Auswahl-Manipulation (Alt-s/K/&/_); Shell-Integration (|,!).
> - Vim→Helix-Reflextabelle; Start-config.toml (Windows-Pfad %AppData%\helix).
> - Didaktik: mehrere praktische Übungen mit Beispieltext; jede Lösung in ein EINKLAPPBARES Callout (> [!example]- …);
>   zusätzliche Tipp-/Warn-Callouts (u. a. U=Redo, %=alles, Makros vertauscht).
> - Alle Tastenkürzel gegen die offizielle Helix-Keymap verifizieren. Sachlich, Code-Blöcke mit Sprachangabe.
> ```

`![[Helix_Tutorial_erweitert.md]]` – liegt im Vault neben dieser Notiz.

## Entscheidungen

- **HTML → Chromium statt PDF-Toolkit** – erlaubt exakte A4-Kontrolle und eingebettete Webfonts (JetBrains Mono, IBM Plex Sans).
- **Helix-Blatt im identischen Raster wie Vim, nur andere Akzentfarbe** – macht beide direkt vergleichbar (Grün = Vim, Petrol = Helix).
- **Eigener Block „Mehrfach-Cursor"** – hat kein Vim-Standard-Äquivalent und ist Helix' Alleinstellungsmerkmal.
- **Keymap gegen die offizielle Doku verifiziert** statt aus dem Gedächtnis – wichtig für Schulungsmaterial (Stolperfallen: `U`=Redo, `%`=alles, Makros `Q`/`q` vertauscht).
- **Übungslösungen in einklappbaren Callouts** – Aufgabe offen, Lösung bei Bedarf – passend für den Schulungseinsatz.

## Nützliche Befehle & Snippets

```bash
# Webfonts ohne Laufzeit-Abhängigkeit holen (woff2)
npm pack @fontsource/jetbrains-mono @fontsource/ibm-plex-sans

# Seitenzahl eines PDFs prüfen
python3 -c "from pypdf import PdfReader; print('pages:', len(PdfReader('datei.pdf').pages))"

# Seite als PNG zur Sichtprüfung rastern
pdftoppm -png -r 120 -f 1 -l 1 datei.pdf vorschau
```

```powershell
# Helix unter Scoop/Windows
hx --tutor                 # eingebauter Grundkurs
:tutor                     # dasselbe aus Helix heraus
hx --health                # Runtime/Clipboard/Status
hx --health python         # Language-Server für eine Sprache prüfen
setx HELIX_RUNTIME "$HOME\scoop\apps\helix\current\runtime"  # Fallback
```

## Offene Punkte

- [ ] Drittes Blatt „Vim ↔ Helix Übersetzungstabelle" (gleiche Aufgabe, beide Tastenfolgen nebeneinander)
- [ ] Firmen-Branding und Deckblatt für den Kurseinsatz
- [ ] PDF-Ausgabe des Tutorials parallel zur Markdown-Version
- [ ] Spickzettel-Variante mit Notizspalte am Rand
- [ ] Begleit-Spickzettel speziell zu den Tutorial-Übungen
- [ ] Passende LSP-Server unter Scoop installieren/prüfen (`hx --health <sprache>`)

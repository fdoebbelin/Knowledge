# Übergabe

| | |
|---|---|
| Stand | 2026-11-28 |
| Branch | main |

## Stand

Website läuft unter <https://fdoebbelin.github.io/Knowledge/>. Kurse aus `01-Courses` größtenteils herausgelöst; `02-Tech/AI` in 4 Durchgängen bearbeitet, eine Notiz ist noch offen (Simanowski). Es wird auf zwei Rechnern gearbeitet: **vor Sitzungsbeginn `git pull`** (`pull.ff only` ist gesetzt).

## Erledigt

- `einrichtung.md` Schritt 4: Hinweis auf das gescheiterte erste Pages-Deployment
- Schritt 5 für zwei Kurse: `fdoebbelin/Tauri-Kompaktkurs` und `fdoebbelin/Tauri-Kurs`, beide **privat**; ihre Quellen tragen `draft: true`
- Leitfaden im Wortlaut als Anhang in `fdoebbelin/Tauri-Kurs`
- `migration.nu`: Ordnereinträge decken alle Dateien darunter ab
- Schritt 5 für Python-Basics: `fdoebbelin/Python-Basics` (privat), Quelle „Python-Grundlagenkurs in 20 Modulen“ mit `draft: true`
- Schritt 5 für Python-OOP: `fdoebbelin/Python-OOP` (privat), Quelle „Python-Aufbaukurs zu OOP, Debugging und Testing“ mit `draft: true`, gegenseitig mit dem Grundlagenkurs verlinkt
- Schritt 5 für Programming-Basics: `fdoebbelin/Programming-Basics` (privat), Quelle „Einführung in die Programmierung mit Python und Thonny“ mit `draft: true`
- CS-Basics war kein Kurs, sondern eine Notizsammlung: als 11 Zettel, 2 Quellen und Strukturzettel „Grundlagen der Informatik“ migriert, kein eigenes Repo
- JavaScript-STEM war kein eigener Kurs, sondern Kopien von danweiner/learning-p5-js (ohne Lizenz) und javascript.info: 7 Zettel, 3 Quellen, neuer Strukturzettel „Programmieren lernen“, Ergebnis `teilweise`. Auf einem zweiten Rechner entstand parallel nach dessen Gliederung der **eigene Kurs** `fdoebbelin/p5-Kreativ-Programmieren` (privat; 12 Lektionen als Jupytext-Markdown mit Zellmagie `%%p5`, Prüfskript mit headless Firefox), Quelle „Kreatives Programmieren mit p5.js“ mit `draft: true`
- Parallelarbeit zweier Rechner per Merge zusammengeführt: doppelte Quelle „Learning p5.js – Lernjournal zu Learning Processing“ ist jetzt Alias von „…Notizen zu Learning Processing“, beide `pruefen`-Fixes behalten (lib.nu: Punkt mitten im Titel, pruefen.nu: Titel, der auf „.js“ endet). `pull.ff only` gesetzt – vor jeder Sitzung `git pull`
- `02-Tech/AI` Durchgang 1 (lokale Modelle: LLM-Basics teilweise, LM-Studio, Ollama, Foundry Local, Nexa SDK, GPT4ALL): 5 Zettel im Abschnitt „Lokale Modelle“ von „Künstliche Intelligenz“; Installationsanleitungen und Modelllisten verworfen
- `02-Tech/AI` Durchgang 2 (Coding-Agenten): 4 Zettel im Abschnitt „Coding-Agenten“, Quelle „Claude-Hilfe – Nutzungs- und Längengrenzen“; Antigravity, Tampermonkey, Le Chat, n8n, LSP-AI, IOPaint und übrige Claude-Code-Notizen verworfen
- `pruefen.nu`: Punkt im Titel (p5.js) gilt nicht mehr als Dateiendung
- Schritt 5 für PythonAugmentedDevelopment: `fdoebbelin/PythonAugmentedDevelopment` (privat), Quelle „Python-Lehrgang im Zeitalter generativer KI“ mit `draft: true`. `Programming/` ist damit abgeschlossen
- Training: nur zettelfähiges Wissen übernommen (kein Repo): 6 Zettel, Strukturzettel „Web und Browser“; Military und BFD-Programs `teilweise`, Teilnehmerdatei `verworfen`. Vereinbart: für KI-Recherchen keine Quelle, nur `herkunft`
- Office-Basics und Office-Short zu `fdoebbelin/Office-365` (privat) zusammengeführt: Grundkurs (12 Blöcke) + Aufbaumodule Word, Excel, Verknüpfung, Szenario Haus Lichtblick, Microsoft 365 mit neuem Outlook, Copilot als Ausblick; PDFs entfernt. Quelle „Microsoft 365 im Facility Management – Grundkurs und Aufbaumodule“ mit `draft: true`; `herkunft` darf jetzt eine Liste sein
- Office-365 wird in seinem eigenen Projekt weiterbearbeitet und ist jetzt **absichtlich öffentlich** (ab 2026-11-30 über GitHub Pages im Coaching: <https://fdoebbelin.github.io/Office-365/>). Die Quelle hat kein `draft: true` mehr
- `01-Courses/AI` (KI-generierter Halbtags-Workshop „Agentische KI“, Modul 2 des BFD-Orientierungsseminars): 7 Zettel zu Agenten und ihrer Absicherung, neuer Strukturzettel „Künstliche Intelligenz“; kein Repo, keine Quelle, Ergebnis `teilweise`
- Erste Sendung aus `00-Poststelle` verarbeitet (Inbox ist leer): 10 Zettel, Quelle „Anleitung zum Aufbau einer Poststelle für Projektdateien“, neuer Strukturzettel „Git und Dateiablage“. Volltext liegt in `00-Poststelle/docs/anleitung/` (Commit `1d1b579`, noch nicht gepusht)
- `lib.nu`, `pruefen.nu`: Glob-Muster liefen unter Windows nicht (Backslashes), neue Funktion `muster`
- GitHub CLI: `02-Tech/Git/Arbeitsblatt-GitHub-CLI-gh.md` übernommen (4 Zettel), dazu 1 Zettel aus der Poststellen-Anleitung; neuer Abschnitt „GitHub auf der Kommandozeile“ in „Git und Dateiablage“. Kernfunktionen mit den Hilfetexten von `gh` 2.98.0 abgeglichen, Fehlermeldungen nicht nachgestellt
- `02-Tech/AI` Durchgang 3 (OpenClaw): 6 Zettel, 2 Quellen (Golem, IT-Administrator), Ergebnis `teilweise`. Aussagen zu OpenClaw an dessen Dokumentation geprüft (Stand 2026-11-28, über zusammenfassende Seitenabrufe). Die KI-Texte im Ordner sind teils falsch oder veraltet. Golem war nur als Cookie-Abfrage abrufbar; die Quelle beruht auf der Kopie im Archiv
- `02-Tech/AI` Durchgang 4 (Programmieren mit KI): 6 Zettel (3 in „Künstliche Intelligenz“, 3 in „Programmieren lernen“), 3 Quellen (METR; Circuit-Tracing und DeepSeek-Vergleich als Entwurf). METR, Vibe Coding und Circuit-Tracing an Webseiten geprüft (zusammenfassende Seitenabrufe); METR nennt die Studie von 2025 inzwischen veraltet. Karpathys genaues Datum und die Herkunft von „Agentic Engineering“ nicht belegt und weggelassen. Die Perplexity-Clippings sind KI-Zusammenfassungen und keine Quellen
- Schritt 5 für Projektmanagement: `fdoebbelin/Projektmanagement` (privat, 144 Dateien), Quelle „Projektmanagement-Kurs mit YouTrack und AP1-Vorbereitung“ mit `draft: true`. `alt/` und `_WICHTIG_/` auch aus der Historie des Kurs-Repos entfernt; die übrige Historie per Mustersuche auf Zugangsdaten geprüft
- Schritt 5 für FreeCAD: `fdoebbelin/FreeCAD-Kurs` (privat, 328 Dateien inkl. neuer `LIZENZEN.md`), Quelle „FreeCAD-Kurse zu Grundlagen und Innenarchitektur“ mit `draft: true`. Von 300 Anhängen nennen 204 eine Lizenz in den Metadaten, 96 nicht. Die früher gemeldeten drei fehlenden Bilder sind nur Syntaxbeispiele im Text

## Nächster Schritt

**Vor dem Migrieren prüfen, ob der lokale Archiv-Klon aktuell ist** (`git fetch`, dann Vergleich mit `origin/main`). Auf dem Windows-Rechner lag er am 2026-11-28 31 Commits zurück, weil `git fetch` über SSH scheiterte; er ist jetzt auf HTTPS umgestellt und auf Stand `bdd3689`. Die an diesem Tag vorher aus dem alten Stand übernommenen Notizen unterscheiden sich, soweit geprüft, nur in entfernten Wikilinks, Linklisten und Formatierung. Neuere Inhalte in anderen Bereichen (z. B. `02-Tech/AI/OpenCode`, Helix) sind beim Weitermigrieren zu beachten.

Nach vereinbartem Plan (Reihenfolge, Repos privat, Quellen mit `draft: true`): **2.** `Databases/SQL-Course` und `Database-Intro` → Repo `Datenbanken-SQL` (ohne die KI-Recherchen). **3.** `STEM/STEM-Intro`: kein neues Repo, sondern Quelle mit Link auf `fdoebbelin/MINTlab` (öffentlich); vor dem Verwerfen Inhalte abgleichen, bisher nur Dateinamen verglichen. **4.** `Business/UML-Basics` höchstens wenige Zettel; `CAD/Civil 3D`, `Databases/SQL-Tools` sowie die Einzeldateien Lernfeld Geschäftsprozesse, Autodesk-Trainerlizenz und Vorbereitungskurse verwerfen. `migration.nu offen` läuft unter Windows nicht (siehe unten). STEM-Intro verlinkt auf `Geschichte-Informatik` (jetzt Quelle „Geschichte der Informatik – Abriss“). In `Training/IT-Career` ist noch die Notiz zum IT-Arbeitsplatz mit europäischer Hard- und Software offen.

Hinweis für Agenten: `git filter-repo` ist nicht installiert, `uvx git-filter-repo` funktioniert. Befehlsketten mit `set -o pipefail`, sonst läuft `gh repo create` nach einem Fehler weiter.

Hinweis für Agenten: `migration.nu eintragen` verlangt, dass eine Notiz `herkunft` **exakt** auf den eingetragenen Pfad setzt (Ordner ≠ Datei darin); sonst Abbruch „Keine Notiz trägt diese herkunft“.

Hinweis für Agenten: `KNOWLEDGE_ARCHIV` steht nur in `~/.config/nushell/env.nu`, die `nu scripts/…` nicht lädt. Aus bash heraus mitgeben: `KNOWLEDGE_ARCHIV=$HOME/Projekte/Knowledge-Archiv nu scripts/migration.nu …`

Vorgabe für die Übernahme von `02-Tech/Git/Mit Git auf dem Server verbinden.md`: Das Skript darin übergibt ein E-Mail-Passwort im Klartext. Für eine Übernahme **einen anderen Weg zur Übermittlung vorsehen**: Das Passwort steht weder im Skript noch in der Notiz und wird nicht als Kommandozeilenargument übergeben, sondern zur Laufzeit aus einem geschützten Speicher gelesen. Den alten Wert nirgends übernehmen; das Passwort ist laut Eigentümer geändert (2026-11-28). Die Altnotiz steht weiter im öffentlichen Archiv.

## Offene Entscheidungen

- `migration.nu offen <Unterordner>` bricht unter Windows mit `failed to parse glob expression` ab (Zeile 79), mit `\` wie mit `/` in `KNOWLEDGE_ARCHIV`; Ursache nicht untersucht. `status` und `eintragen` liefen für eine einzelne Datei. Pfadtrenner beim Vergleich mit `migration.csv` bei `offen` noch prüfen.
- Poststelle: Der Skill `zustellen` vergleicht mit `git hash-object` ohne `--no-filters`. Bei Dateien mit CRLF prüfen, ob das Fehlalarme gibt (ungetestet).
- Kurs-Repos sichten und öffentlich schalten? Dann `draft: true` aus den Kursquellen nehmen. Zu prüfen vor allem `Training/Military`, `Training/BFD-Programs`, `STEM-Intro/_INTERN_`.
- Projektmanagement-Repo vor dem Veröffentlichen sichten: Drei Dateien nennen im Frontmatter fremde Quellen (zwei Seiten der JetBrains-Dokumentation, eine Seite des IPH Hannover, mit Bildern); einige Dateien unter `Aufgaben` sehen nach fremdem Lehr- oder Prüfungsmaterial aus; die YouTrack-Installationsnotiz enthält ein Einrichtungs-Token einer lokalen Instanz. Eine README gibt es nicht.
- FreeCAD-Repo vor dem Veröffentlichen: Lizenzen laut `LIZENZEN.md` beim FreeCAD-Projekt klären (96 Anhänge ohne Angabe, einige mit CC BY-SA oder mehreren Angaben) und Lizenztexte ergänzen. Eine README gibt es nicht.
- Vor dem Weiterarbeiten am Archiv: Bei der Bestandsaufnahme am 2026-11-28 gab es weitere Funde, die dafür sprechen, es bald auf privat zu stellen (Details bewusst nicht hier).
- Tauri-Kompaktkurs verlinkt per Wikilink noch auf `[[00 Kurskonzept Tauri]]` und den Leitfaden, die jetzt im Repo Tauri-Kurs liegen: durch URLs ersetzen?
- Der Leitfaden im Tauri-Kurs behauptet, Nushell kenne kein Variablen-Präfix – dort korrigieren.
- Wiederverwendbares Wissen aus den Kursen als Zettel übernehmen (z. B. Python-Basics: Closures, Dekoratoren, Git Flow vs. GitHub Flow) – eigener Durchgang.
- Python-OOP vor dem Veröffentlichen sichten: Projektdateien tragen Vornamen von Teilnehmern (M21 02–04), M37–M39 fehlen, Datei „teile den folgenden Code richtig auf und gib Komme.md“ (`.pylintrc`, gehört wohl zu M40) umbenennen.
- Simanowski, *Sprachmaschinen* (`02-Tech/AI/LLM-Basics/`): bewusst noch nicht übernommen, im Migrationsprotokoll offen. Die Altnotiz beruht auf KI-Zusammenfassungen; eine Quelle erst nach Prüfung am Buch anlegen. `draft: true` reicht zum Zurückhalten nicht, weil das Repository öffentlich ist.
- PythonAugmentedDevelopment vor dem Veröffentlichen sichten: `00 Projektwissen` mit persönlichen Angaben (Auftraggeber, Hardware), `Demo interaktive Widgets` ist eine unbearbeitete Chat-Antwort. Das Konzept nennt weitere Studien, die nicht am Original geprüft sind (nur METR ist geprüft).
- Office-365: README listet fehlende Übungs-, Lösungs- und Präsentationsdateien und Angaben zum neuen Outlook, die an einer laufenden Installation zu prüfen sind (Serien-Schaltfläche, Einstellungspfade, Serien-E-Mail über neues Outlook). Materialien zu Zellbezügen und Pivot behalten ihre eigenen Beispiele (TechVision, Online-Shop) – ins Szenario übertragen?
- p5-Kurs: Lizenz für das Repo festlegen, bevor es öffentlich wird. Inhalte vor dem Veröffentlichen gegenlesen (von Claude geschrieben, technisch geprüft, didaktisch noch nicht).
- Programming-Basics: Die Teams-Aufgabe (99a) verweist auf eine Word-Datei mit den Fragen, die im Archiv fehlt.
- Python-Basics vor dem Veröffentlichen sichten: `00 Kursorganisation` mit Zertifikatsvorlage und Projektideen.
- `Knowledge-Archiv` ist laut GitHub bereits archiviert und öffentlich (abgefragt 2026-11-28), obwohl noch nicht alle Kurse herausgelöst sind. Auf privat stellen oder die Historie bereinigen? Das Archiv ist nicht gezielt auf weitere Geheimnisse geprüft.
- Eigene Domain für GitHub Pages? Dann `baseUrl` in `_meta/quartz/quartz.config.yaml` anpassen.

# Übergabe

| | |
|---|---|
| Stand | 2026-11-27 |
| Branch | main |

## Stand

Website läuft unter <https://fdoebbelin.github.io/Knowledge/>. Erste Migration abgeschlossen: der Leitfaden „Von der leeren Toolbx zur installierten Flatpak-App“ als 16 Zettel, Quelle und Strukturzettel „Entwickeln auf Fedora Atomic“.

## Erledigt

- `einrichtung.md` Schritt 4: Hinweis auf das gescheiterte erste Pages-Deployment
- Schritt 5 für zwei Kurse: `fdoebbelin/Tauri-Kompaktkurs` und `fdoebbelin/Tauri-Kurs`, beide **privat**; ihre Quellen tragen `draft: true`
- Leitfaden im Wortlaut als Anhang in `fdoebbelin/Tauri-Kurs`
- `migration.nu`: Ordnereinträge decken alle Dateien darunter ab
- Schritt 5 für Python-Basics: `fdoebbelin/Python-Basics` (privat), Quelle „Python-Grundlagenkurs in 20 Modulen“ mit `draft: true`
- Schritt 5 für Python-OOP: `fdoebbelin/Python-OOP` (privat), Quelle „Python-Aufbaukurs zu OOP, Debugging und Testing“ mit `draft: true`, gegenseitig mit dem Grundlagenkurs verlinkt
- Schritt 5 für Programming-Basics: `fdoebbelin/Programming-Basics` (privat), Quelle „Einführung in die Programmierung mit Python und Thonny“ mit `draft: true`
- JavaScript-STEM war fremder Text ohne Lizenz (danweiner/learning-p5-js) plus ein Stück javascript.info: Quelle „Learning p5.js – Lernjournal zu Learning Processing“; nach dessen Gliederung **neuer eigener Kurs** `fdoebbelin/p5-Kreativ-Programmieren` (privat, lokal `~/Projekte/p5-Kreativ-Programmieren`), 12 Lektionen als Jupytext-Markdown mit Zellmagie `%%p5`, Prüfskript mit headless Firefox; Quelle „Kreatives Programmieren mit p5.js“ mit `draft: true`
- `pruefen.nu`: Notiztitel mit Punkt (z. B. „p5.js“) gelten nicht mehr als Anhang
- CS-Basics war kein Kurs, sondern eine Notizsammlung: als 11 Zettel, 2 Quellen und Strukturzettel „Grundlagen der Informatik“ migriert, kein eigenes Repo

## Nächster Schritt

**PythonAugmentedDevelopment** übernehmen – gesichtet, Vorschlag steht, Freigabe fehlt noch:

- Befund: kein fertiger Kurs, sondern ein Kurskonzept „Python-Lehrgang im Zeitalter generativer KI“ (7 Dateien, ~2.500 Zeilen, in sich geschlossen, 1 Commit). `00 Projektwissen` (KI-Chat-Kontext), `01` didaktisches Konzept (Drei-Phasen-Modell KI-frei → KI-augmentiert → KI-Dirigent:in, sechs Leitprinzipien), `02` Modulstruktur M1–M11, `03` Werkzeug-Stack Obsidian + Jupyter, `04` interaktive Übungsformate in JupyterLab (Tracing, Parsons-Puzzles), `M02` Ausarbeitung des KI-freien Moduls.
- Auffällig: `00 Projektwissen` enthält Auftraggeber (BFD, Agentur für Arbeit, BWSA), Hardware und das veraltete CachyOS. `Demo interaktive Widgets.md` ist ein Chat-Rest über eine ZIP (`m2-uebungen-demo`), die im Archiv fehlt. `01` und `04` sind KI-Rechercheausgaben; die zitierten Studien und Beschlüsse (Prather et al. 2024, KMK 10.10.2024 u. a.) sind ungeprüft.
- Vorschlag: Repo `fdoebbelin/Python-KI-Lehrgang` (privat, alle Dateien unverändert); Quelle „Python-Lehrgang im Zeitalter generativer KI – Kurskonzept“ (`art: kurs`, `draft: true`, Studienangaben als ungeprüft vermerkt), verlinkt mit Python-Grundlagenkurs und p5-Kurs (alle mit Jupytext-Notebooks); Zettel-Kandidaten für später: „KI-freie Fundierung vor KI-Nutzung“, „Tracing-Aufgaben bekommen bewusst keine automatische Prüfung“, „Parsons-Puzzles als Übungsformat“.
- Zu klären: Repo-Name und Titel recht? Chat-Rest `Demo interaktive Widgets.md` mit ins Repo oder weglassen?

Danach ist `Programming/` erledigt. Weitere Kurse herauslösen (14 offen; Liste mit `nu scripts/migration.nu offen 01-Courses`). Vorher je Kurs prüfen, ob es wirklich ein Kurs ist oder eine Notizsammlung wie CS-Basics. Python-Basics bindet 1 SVG aus `_resources/` ein; STEM-Intro verlinkt auf `Geschichte-Informatik` (jetzt Quelle „Geschichte der Informatik – Abriss“).

Hinweis für Agenten: `KNOWLEDGE_ARCHIV` steht nur in `~/.config/nushell/env.nu`, die `nu scripts/…` nicht lädt. Aus bash heraus mitgeben: `KNOWLEDGE_ARCHIV=$HOME/Projekte/Knowledge-Archiv nu scripts/migration.nu …`

## Offene Entscheidungen

- Kurs-Repos sichten und öffentlich schalten? Dann `draft: true` aus den Kursquellen nehmen. Zu prüfen vor allem `Training/Military`, `Training/BFD-Programs`, `STEM-Intro/_INTERN_`, `Project-Management/_WICHTIG_`.
- Tauri-Kompaktkurs verlinkt per Wikilink noch auf `[[00 Kurskonzept Tauri]]` und den Leitfaden, die jetzt im Repo Tauri-Kurs liegen: durch URLs ersetzen?
- Der Leitfaden im Tauri-Kurs behauptet, Nushell kenne kein Variablen-Präfix – dort korrigieren.
- Wiederverwendbares Wissen aus den Kursen als Zettel übernehmen (z. B. Python-Basics: Closures, Dekoratoren, Git Flow vs. GitHub Flow) – eigener Durchgang.
- Python-OOP vor dem Veröffentlichen sichten: Projektdateien tragen Vornamen von Teilnehmern (M21 02–04), M37–M39 fehlen, Datei „teile den folgenden Code richtig auf und gib Komme.md“ (`.pylintrc`, gehört wohl zu M40) umbenennen.
- p5-Kurs: Lizenz für das Repo festlegen, bevor es öffentlich wird. Inhalte vor dem Veröffentlichen gegenlesen (von Claude geschrieben, technisch geprüft, didaktisch noch nicht).
- Programming-Basics: Die Teams-Aufgabe (99a) verweist auf eine Word-Datei mit den Fragen, die im Archiv fehlt.
- Python-Basics vor dem Veröffentlichen sichten: `00 Kursorganisation` mit Zertifikatsvorlage und Projektideen.
- `Knowledge-Archiv` archivieren (Ende Schritt 1), erst wenn alle Kurse herausgelöst sind.
- Eigene Domain für GitHub Pages? Dann `baseUrl` in `_meta/quartz/quartz.config.yaml` anpassen.

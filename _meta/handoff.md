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
- CS-Basics war kein Kurs, sondern eine Notizsammlung: als 11 Zettel, 2 Quellen und Strukturzettel „Grundlagen der Informatik“ migriert, kein eigenes Repo
- JavaScript-STEM war kein eigener Kurs, sondern Kopien von danweiner/learning-p5-js und javascript.info: 7 Zettel, 3 Quellen, neuer Strukturzettel „Programmieren lernen“, Ergebnis `teilweise`
- `pruefen.nu`: Punkt im Titel (p5.js) gilt nicht mehr als Dateiendung
- Schritt 5 für PythonAugmentedDevelopment: `fdoebbelin/PythonAugmentedDevelopment` (privat), Quelle „Python-Lehrgang im Zeitalter generativer KI“ mit `draft: true`. `Programming/` ist damit abgeschlossen
- Training: nur zettelfähiges Wissen übernommen (kein Repo): 6 Zettel, Strukturzettel „Web und Browser“; Military und BFD-Programs `teilweise`, Teilnehmerdatei `verworfen`. Vereinbart: für KI-Recherchen keine Quelle, nur `herkunft`

## Nächster Schritt

Weitere Kurse herauslösen (offen: Business, CAD, Databases, STEM; Liste mit `nu scripts/migration.nu offen 01-Courses`). Vorher je Kurs prüfen, ob es wirklich ein Kurs ist oder eine Notizsammlung wie CS-Basics. STEM-Intro verlinkt auf `Geschichte-Informatik` (jetzt Quelle „Geschichte der Informatik – Abriss“). `Training/IT-Career` ist zurückgestellt für den KI-Durchgang.

Hinweis für Agenten: `git filter-repo` ist nicht installiert, `uvx git-filter-repo` funktioniert. Befehlsketten mit `set -o pipefail`, sonst läuft `gh repo create` nach einem Fehler weiter.

Hinweis für Agenten: `KNOWLEDGE_ARCHIV` steht nur in `~/.config/nushell/env.nu`, die `nu scripts/…` nicht lädt. Aus bash heraus mitgeben: `KNOWLEDGE_ARCHIV=$HOME/Projekte/Knowledge-Archiv nu scripts/migration.nu …`

## Offene Entscheidungen

- Kurs-Repos sichten und öffentlich schalten? Dann `draft: true` aus den Kursquellen nehmen. Zu prüfen vor allem `Training/Military`, `Training/BFD-Programs`, `STEM-Intro/_INTERN_`, `Project-Management/_WICHTIG_`.
- Tauri-Kompaktkurs verlinkt per Wikilink noch auf `[[00 Kurskonzept Tauri]]` und den Leitfaden, die jetzt im Repo Tauri-Kurs liegen: durch URLs ersetzen?
- Der Leitfaden im Tauri-Kurs behauptet, Nushell kenne kein Variablen-Präfix – dort korrigieren.
- Wiederverwendbares Wissen aus den Kursen als Zettel übernehmen (z. B. Python-Basics: Closures, Dekoratoren, Git Flow vs. GitHub Flow) – eigener Durchgang.
- Python-OOP vor dem Veröffentlichen sichten: Projektdateien tragen Vornamen von Teilnehmern (M21 02–04), M37–M39 fehlen, Datei „teile den folgenden Code richtig auf und gib Komme.md“ (`.pylintrc`, gehört wohl zu M40) umbenennen.
- KI-Durchgang: Zettel zur Rolle von Programmierern und Systemintegratoren mit KI aus `Training/IT-Career` (zwei KI-Texte; die Behauptung zur IHK-Prüfung „eigener Anteil > 50 %“ vorher prüfen) zusammen mit den Kandidaten aus PythonAugmentedDevelopment.
- PythonAugmentedDevelopment vor dem Veröffentlichen sichten: `00 Projektwissen` mit persönlichen Angaben (Auftraggeber, Hardware), `Demo interaktive Widgets` ist eine unbearbeitete Chat-Antwort. Zettel-Kandidaten: Vibe Coding vs. Agentic Engineering, METR-Studie (gefühlte vs. gemessene Beschleunigung), Parsons-Puzzles – Studienangaben gegen Originale prüfen.
- Programming-Basics: Die Teams-Aufgabe (99a) verweist auf eine Word-Datei mit den Fragen, die im Archiv fehlt.
- Python-Basics vor dem Veröffentlichen sichten: `00 Kursorganisation` mit Zertifikatsvorlage und Projektideen.
- `Knowledge-Archiv` archivieren (Ende Schritt 1), erst wenn alle Kurse herausgelöst sind.
- Eigene Domain für GitHub Pages? Dann `baseUrl` in `_meta/quartz/quartz.config.yaml` anpassen.

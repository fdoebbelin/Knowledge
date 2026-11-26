# Übergabe

| | |
|---|---|
| Stand | 2026-11-26 |
| Branch | main |

## Stand

Website läuft unter <https://fdoebbelin.github.io/Knowledge/>. Erste Migration abgeschlossen: der Leitfaden „Von der leeren Toolbx zur installierten Flatpak-App“ als 16 Zettel, Quelle und Strukturzettel „Entwickeln auf Fedora Atomic“.

## Erledigt

- `einrichtung.md` Schritt 4: Hinweis auf das gescheiterte erste Pages-Deployment
- Schritt 5 für zwei Kurse: `fdoebbelin/Tauri-Kompaktkurs` und `fdoebbelin/Tauri-Kurs`, beide **privat**; ihre Quellen tragen `draft: true`
- Leitfaden im Wortlaut als Anhang in `fdoebbelin/Tauri-Kurs`
- `migration.nu`: Ordnereinträge decken alle Dateien darunter ab
- CS-Basics war kein Kurs, sondern eine Notizsammlung: als 11 Zettel, 2 Quellen und Strukturzettel „Grundlagen der Informatik“ migriert, kein eigenes Repo

## Nächster Schritt

Weitere Kurse herauslösen (18 offen, Liste mit `nu scripts/migration.nu offen 01-Courses`). Vorher je Kurs prüfen, ob es wirklich ein Kurs ist oder eine Notizsammlung wie CS-Basics. Python-Basics bindet 1 SVG aus `_resources/` ein; STEM-Intro verlinkt auf `Geschichte-Informatik` (jetzt Quelle „Geschichte der Informatik – Abriss“).

## Offene Entscheidungen

- Kurs-Repos sichten und öffentlich schalten? Dann `draft: true` aus den Kursquellen nehmen. Zu prüfen vor allem `Training/Military`, `Training/BFD-Programs`, `STEM-Intro/_INTERN_`, `Project-Management/_WICHTIG_`.
- Tauri-Kompaktkurs verlinkt per Wikilink noch auf `[[00 Kurskonzept Tauri]]` und den Leitfaden, die jetzt im Repo Tauri-Kurs liegen: durch URLs ersetzen?
- Der Leitfaden im Tauri-Kurs behauptet, Nushell kenne kein Variablen-Präfix – dort korrigieren.
- `Knowledge-Archiv` archivieren (Ende Schritt 1), erst wenn alle Kurse herausgelöst sind.
- Eigene Domain für GitHub Pages? Dann `baseUrl` in `_meta/quartz/quartz.config.yaml` anpassen.

---
modul: M12
title: Debugging über vier Grenzen
ue: 3
phase: Qualität
ort: beide
tags: [tauri/kurs/modul, debugging, testing]
status: entwurf
---

# M12 – Debugging über vier Grenzen

> [!abstract] Worum es geht
> In diesem Aufbau liegen vier Grenzen zwischen Symptom und Ursache: Frontend zu Rust, Container zu Host, Entwicklungslauf zu Flatpak und Anwendung zu Compositor. Das Modul vermittelt eine Reihenfolge, in der man sie abklopft.

## Lernziele

- Ein Fehlerbild systematisch einer der vier Grenzen zuordnen
- Frontend und Rust getrennt untersuchen
- Unterschiede zwischen Entwicklungslauf und Flatpak gezielt prüfen
- Komponenten und Stores automatisiert testen

## Die vier Grenzen

| Grenze | Leitfrage | Werkzeug |
|---|---|---|
| Frontend zu Rust | Kommen die Daten an, und in welcher Form? | WebKit-Inspektor, `println!`, `log`-Plugin |
| Container zu Host | Fehlt eine Bibliothek oder ein Dienst? | `toolbox run`, `pkg-config`, Gegenprobe auf dem Host |
| Dev zu Flatpak | Tritt der Fehler nur im Sandkasten auf? | `flatpak run --command=sh`, `--devel` |
| App zu Compositor | Verhält sich das Fenster anders als erwartet? | `swaymsg -t get_tree`, `WAYLAND_DEBUG` |

## Inhalte

1. **Frontend-Debugging** – WebKit-Inspektor per Rechtsklick im Entwicklungslauf, Vue DevTools als eigenständige Anwendung
2. **Rust-Debugging** – Ausgaben landen im Terminal des `cargo tauri dev`, nicht in der Browser-Konsole
3. **Devtools im Release** – im Flatpak standardmäßig nicht verfügbar. Debug-Bau des Flatpak als Notbehelf.
4. **Eingrenzungsstrategie** – immer von außen nach innen: Läuft es auf dem Host? Im Container? Im Sandkasten? Erst dann in den Code.
5. **Tests** – Vitest für Stores und reine Funktionen, Vue Test Utils für Komponenten, `#[test]` für Command-Logik
6. **Performance** – unnötige Neuberechnungen, große Listen, Virtualisierung, Startzeit
7. **WebKitGTK-spezifische Symptome** – weißes Fenster, Flackern, fehlende CSS-Merkmale

```nu
# Frontend-Tests im Container
npm --prefix frontend run test

# Rust-Tests
cargo test --manifest-path src-tauri/Cargo.toml

# Umgebungsvariable nur für einen Lauf
with-env { WEBKIT_DISABLE_COMPOSITING_MODE: "1" } { cargo tauri dev }
```

## Praxisteil

- [ ] Vier vorbereitete Fehler jeweils der richtigen Grenze zuordnen und beheben
- [ ] Tests für die Filterlogik im Pinia-Store
- [ ] Rust-Test für die Suchfunktion aus [[M08 Eigene Commands und Events]]
- [ ] Rendering bei 5000 Notizen messen und verbessern
- [ ] Einen Fehler, der nur im Flatpak auftritt, bis zur Ursache verfolgen

## Typische Fallstricke

> [!warning]
> - Rust-Ausgaben werden im Inspektor gesucht statt im Terminal.
> - Der Fehler wird im Code gesucht, obwohl ein Systemdienst auf dem Host fehlt.
> - Getestet wird die Implementierung statt des Verhaltens. Die Tests brechen bei jedem Refactoring.
> - Nushell zeigt bei mehreren zusammen abgeschickten Zeilen nur das Ergebnis der letzten. Diagnosebefehle einzeln ausführen.

## Verknüpfung

Weiter mit [[M13 Abschlussprojekt]] · zurück zu [[00 Kurskonzept Tauri]]

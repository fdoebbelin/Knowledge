---
modul: M08
titel: Eigene Commands und Events
ue: 5
phase: Brücke zu Rust
ort: Toolbx
tags: [tauri/kurs/modul, rust, ipc]
status: entwurf
---

# M08 – Eigene Commands und Events

> [!abstract] Worum es geht
> Rust kommt an der Stelle ins Spiel, an der das Frontend an eine echte Grenze stößt: eine Volltextsuche über hunderte Markdown-Dateien. Rust wird als Werkzeug eingeführt, nicht als Lehrstoff.

## Lernziele

- Einen eigenen Command schreiben und registrieren
- Parameter und Rückgabewerte typsicher übergeben
- Fehler aus Rust als behandelbares Ergebnis empfangen
- Lang laufende Aufgaben asynchron ausführen
- Fortschritt über Events an das Frontend senden

## Inhalte

1. **Der Anlass** – Volltextsuche in JavaScript über viele Dateien ist spürbar langsam. Vorher messen.
2. **Rust-Minimum** – Funktionen, `struct`, `String` gegen `&str`, `Result`, `Option`. Nur so viel wie nötig.
3. **Command** – `#[tauri::command]`, Registrierung im `invoke_handler`
4. **Serialisierung** – Serde, `Serialize` und `Deserialize`, Namensmapping snake_case zu camelCase
5. **Typsicherheit** – TypeScript-Interface passend zum Rust-Struct, gemeinsame Typdatei
6. **Fehler** – `Result<T, String>` in Rust, `try/catch` im Frontend
7. **Asynchron** – `async fn`, warum ein blockierender Command das Fenster einfriert
8. **Events** – `emit` aus Rust, `listen` im Frontend, Abmelden beim Unmount
9. **Nebenläufigkeit** – `rayon` oder `tokio` als Ausblick, im Kurs nur benannt

Arbeitszyklus in Nushell:

```nu
cd ~/Projekte/noteflow
cargo tauri dev
# Rust-Änderungen lösen Neukompilierung aus, Frontend-Änderungen laufen über HMR
```

Reines Rust prüfen, ohne Fenster zu starten:

```nu
cargo test --manifest-path src-tauri/Cargo.toml
cargo clippy --manifest-path src-tauri/Cargo.toml
```

## Praxisteil

- [ ] Suche zunächst in TypeScript umsetzen und Laufzeit bei 2000 Dateien messen
- [ ] Command `search_notes(query, folder)` in Rust umsetzen
- [ ] Ergebnisstruktur mit Dateiname, Treffer und Zeilennummer
- [ ] TypeScript-Interface anlegen und im Store verwenden
- [ ] Beide Laufzeiten gegenüberstellen
- [ ] Fortschritts-Event senden, im Frontend als Balken anzeigen
- [ ] Listener beim Verlassen der Komponente abmelden
- [ ] Blockierende Variante bewusst vorführen: Fenster friert ein

> [!note] Zum Ort des Bauens
> Dieser Command wird in Modul 11 **erneut** gebaut, dann in der Flatpak-SDK. Der Quellcode ist derselbe, die Bibliotheken sind es nicht. Das ist der praktische Beleg für die glibc-Falle aus dem Leitfaden.

## Typische Fallstricke

> [!warning]
> - Listener werden nie abgemeldet. Nach mehreren Navigationen feuern Handler mehrfach.
> - Command geschrieben, aber nicht im `invoke_handler` eingetragen.
> - Serde-Feldnamen und TypeScript-Interface weichen ab, das Ergebnis ist stillschweigend `undefined`.
> - Blockierender Command friert die Oberfläche ein. Bewusst vorführen.
> - Neue Crates ändern die Bauzeit spürbar. Erwartungshaltung setzen.

## Verknüpfung

Weiter mit [[M09 Fenster und Wayland-Integration]] · zurück zu [[00 Kurskonzept Tauri]]

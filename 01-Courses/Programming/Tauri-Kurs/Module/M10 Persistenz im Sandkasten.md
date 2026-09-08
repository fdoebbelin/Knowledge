---
modul: M10
titel: Persistenz im Sandkasten
ue: 3
phase: Desktop
ort: beide
tags: [tauri/kurs/modul, storage, flatpak, sqlite]
status: entwurf
---

# M10 – Persistenz im Sandkasten

> [!abstract] Worum es geht
> Wo Daten hingehören und warum sich der Ablageort zwischen Entwicklungslauf und installiertem Flatpak **verschiebt**. Diese Verschiebung ist die eigentliche Lektion des Moduls.

## Lernziele

- Speicheroptionen vergleichen und begründet auswählen
- Einstellungen mit dem Store-Plugin ablegen
- Strukturierte Daten in SQLite speichern
- Die XDG-Verzeichnisse innerhalb und außerhalb des Sandkastens benennen

## Inhalte

1. **Optionen im Vergleich**

| Ansatz | Geeignet für | Grenzen |
|---|---|---|
| `localStorage` | Wegwerf-Zustand | an die WebView gebunden, geht bei Runtime-Wechsel verloren |
| `plugin-store` | Einstellungen | keine Abfragen, kein Schema |
| Eigene Dateien über `plugin-fs` | Nutzerinhalte | Serialisierung selbst gebaut |
| `plugin-sql` mit SQLite | strukturierte Daten, Suche | zusätzliche Komplexität |

2. **Die Pfadverschiebung**

| Kontext | `appDataDir` liegt unter |
|---|---|
| `cargo tauri dev` im Toolbx | `~/.local/share/de.metarow.NoteFlow` im geteilten `$HOME` |
| installiertes Flatpak | `~/.var/app/de.metarow.NoteFlow/data` |

> [!important] Konsequenz für den Unterricht
> Im Entwicklungslauf angelegte Daten sind für das Flatpak **nicht sichtbar** und umgekehrt. Wer das nicht weiß, hält den ersten Flatpak-Start für einen Datenverlust. Beide Orte im Praxisteil aufsuchen.

3. **Store-Plugin** – Schlüssel und Werte, Laden, Speichern, Standardwerte
4. **SQLite** – Verbindung, Migrationen, parametrisierte Abfragen
5. **SQL-Injection** – warum Zeichenkettenverkettung auch lokal keine Option ist
6. **Nutzerdaten gegen Anwendungsdaten** – die Markdown-Dateien gehören nach `xdg-documents`, nicht in den Anwendungsdatenordner
7. **Sicherung und Migration** – Schemaänderungen zwischen Versionen

Ablageorte in Nushell nachsehen:

```nu
ls ~/.local/share | where name =~ "metarow"
ls ~/.var/app | get name
ls ~/.var/app/de.metarow.Notizblock
```

## Praxisteil

- [ ] Theme, letzter Ordner und Filter im Store ablegen
- [ ] Notiz-Metadaten in SQLite, Inhalte bleiben Markdown-Dateien
- [ ] Abfrage nach Tag und Änderungsdatum
- [ ] Beide Ablageorte aufsuchen und den Unterschied dokumentieren
- [ ] Daten aus dem Entwicklungslauf in den Flatpak-Ordner übertragen und prüfen, dass die App sie findet

## Typische Fallstricke

> [!warning]
> - `localStorage` für Nutzerdaten. Beim Wechsel der Runtime sind die Daten weg.
> - Der Store wird nach Änderungen nicht gespeichert.
> - Abfragen per Zeichenkette zusammengesetzt statt mit Parametern.
> - Absolute Pfade aus dem Entwicklungslauf werden fest verdrahtet und brechen im Sandkasten.

## Verknüpfung

Weiter mit [[M11 Flatpak Build und Verteilung]] · zurück zu [[00 Kurskonzept Tauri]]

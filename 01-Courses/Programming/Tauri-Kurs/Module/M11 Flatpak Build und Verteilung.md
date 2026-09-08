---
modul: M11
titel: Flatpak Build und Verteilung
ue: 6
phase: Auslieferung
ort: Host
tags: [tauri/kurs/modul, flatpak, ci, build]
status: entwurf
---

# M11 – Flatpak Build und Verteilung

> [!abstract] Worum es geht
> Der Schritt aus dem Toolbx heraus. NoteFlow wird in der Flatpak-SDK gebaut, installiert und über ein Repository verteilt. Alle Themen aus [[M07 Sicherheit Capabilities und Sandkasten]] und [[M10 Persistenz im Sandkasten]] werden hier praktisch scharf.

## Lernziele

- Erklären, warum nativer Code in der SDK gebaut werden muss und statische Assets nicht
- Ein Flatpak-Manifest für eine Vue-basierte Tauri-App schreiben
- Bau und Installation zweistufig über ein lokales Repository durchführen
- Fehler im Sandkasten-Build eingrenzen
- Ein signiertes Repository für die Flotte einrichten
- Beschreiben, wie Artefakte für Windows und macOS entstehen, obwohl sie hier nicht baubar sind

## Der Ablauf

### Schritt 1: Frontend im Toolbx bauen

```nu
cd ~/Projekte/noteflow
npm --prefix frontend run build
ls frontend/dist | select name size
```

### Schritt 2: Aufräumen vor dem Kopieren

```nu
cargo clean --manifest-path src-tauri/Cargo.toml
du -sh frontend/node_modules
```

> [!danger] `type: dir` kopiert alles
> Ohne Ausschlussliste wandern `node_modules` und `target` in den Sandkasten. Der Build dauert dann ewig und schlägt eventuell am Speicherplatz fehl. Das Manifest nutzt deshalb `skip`. Siehe [[Anhang Flatpak-Manifest NoteFlow]].

### Schritt 3: Bauen auf dem Host

```nu
exit                                        # zurück auf den Host
cd ~/Projekte/noteflow

flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.NoteFlow.yml
flatpak remote-add --user --no-gpg-verify --if-not-exists metarow-lokal $"($env.PWD)/repo"
flatpak install --user metarow-lokal de.metarow.NoteFlow
```

Jeder weitere Durchlauf:

```nu
flatpak run org.flatpak.Builder --force-clean --repo=repo build-dir de.metarow.NoteFlow.yml
flatpak update --user de.metarow.NoteFlow
```

## Inhalte

1. **Wiederholung der glibc-Falle** aus dem Leitfaden, jetzt mit eigenem Code belegt
2. **Die Ausnahme für statische Assets** – warum `frontend/dist` außerhalb der SDK entstehen darf: keine Bindung an Systembibliotheken. Diese Begründung müssen die Teilnehmenden selbst formulieren können.
3. **Manifestaufbau** – `sdk-extensions`, `append-path`, `build-args`, `build-commands`
4. **`--share=network` in `build-args`** – cargo lädt Crates. Für Flathub unzulässig, dort `cargo vendor`.
5. **Fehlersuche im Sandkasten**

```nu
flatpak run org.flatpak.Builder --force-clean --keep-build-dirs --repo=repo build-dir de.metarow.NoteFlow.yml
ls .flatpak-builder/build/noteflow-1/src-tauri/target/release | where type == file
flatpak run org.flatpak.Builder --build-shell=noteflow build-dir de.metarow.NoteFlow.yml
```

6. **Erstlauf-Prüfung** – Routing, Pfade, Berechtigungen. Genau hier treten die in Modul 05, 07 und 10 vorbereiteten Fehler auf.

```nu
flatpak run de.metarow.NoteFlow
flatpak info --show-permissions de.metarow.NoteFlow
flatpak run --command=sh de.metarow.NoteFlow      # in den Sandkasten schauen
```

7. **Verteilung** – Bundle für Einzelgeräte, signiertes Repository für die Flotte

```nu
flatpak build-bundle repo noteflow.flatpak de.metarow.NoteFlow --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo
flatpak build-sign repo --gpg-sign=$KEY_ID
flatpak build-update-repo repo --gpg-sign=$KEY_ID
```

8. **Andere Plattformen** – hier nicht baubar. Ein GitHub-Actions-Matrix-Build auf `windows-latest`, `macos-latest` und `ubuntu-latest` erzeugt MSI, DMG und DEB als Artefakte. Cross-Compiling trägt in der Praxis selten.
9. **Vertiefung: reproduzierbarer Build** – Node-Erweiterung in der SDK plus `flatpak-node-generator` für Offline-Quellen. Weg C aus der Technologieentscheidung. Für Flathub Pflicht, im Kurs als Ausblick mit Vorführung.

## Praxisteil

- [ ] Manifest für NoteFlow aus der Vorlage anpassen
- [ ] Frontend bauen, aufräumen, Flatpak bauen
- [ ] Installieren und starten
- [ ] Alle Erstlauf-Fehler protokollieren und der richtigen Schicht zuordnen
- [ ] Berechtigungen prüfen und auf das Minimum kürzen
- [ ] Bundle erzeugen und auf einem zweiten Gerät installieren
- [ ] Repository signieren und einen Update-Durchlauf zeigen
- [ ] CI-Workflow anlegen, Artefakte für drei Plattformen herunterladen
- [ ] Bundle-Größe gegen eine Electron-Referenz stellen

## Typische Fallstricke

> [!warning]
> - **Leere Seite im Flatpak.** Meist der History-Modus des Routers aus [[M05 Zustand und Navigation]] oder ein falscher `frontendDist`-Pfad.
> - **`dist/` fehlt im Sandkasten.** `npm run build` wurde vergessen oder `dist` steht in der `skip`-Liste.
> - **Build läuft ewig.** `node_modules` oder `target` wurden mitkopiert.
> - **Binärname `app` statt `noteflow`.** Der `[[bin]]`-Block aus Leitfaden-Abschnitt 13 fehlt. Fällt erst nach mehreren Minuten Bauzeit auf.
> - **Falsche Freedesktop-Fassung** für die Rust-Erweiterung. `flatpak remote-info -m` nutzen statt raten.
> - **Zugriffsfehler auf das Projektverzeichnis**: `flatpak override --user --filesystem=home org.flatpak.Builder`.

## Verknüpfung

Weiter mit [[M12 Debugging über vier Grenzen]] · [[Anhang Flatpak-Manifest NoteFlow]] · zurück zu [[00 Kurskonzept Tauri]]

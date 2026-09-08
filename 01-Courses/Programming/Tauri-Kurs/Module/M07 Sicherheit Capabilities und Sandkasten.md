---
modul: M07
titel: Sicherheit, Capabilities und Sandkasten
ue: 4
phase: Frontend-Kern
ort: beide
tags: [tauri/kurs/modul, security, flatpak, portals]
status: entwurf
---

# M07 – Sicherheit, Capabilities und Sandkasten

> [!abstract] Worum es geht
> Zwei voneinander unabhängige Berechtigungsschichten liegen übereinander: die Tauri-Capabilities und der Flatpak-Sandkasten. Eine Aktion ist nur erlaubt, wenn **beide** sie zulassen. Diese Doppelung ist auf einem Atomic-System der wichtigste konzeptionelle Gewinn des Kurses.

## Lernziele

- Das Bedrohungsmodell einer Desktop-App mit Webfrontend beschreiben
- Permissions, Scopes und Capabilities unterscheiden
- Eine Capability-Datei lesen und minimal anpassen
- Flatpak-`finish-args` lesen und minimal setzen
- Erklären, warum ein Portal-Zugriff besser ist als `--filesystem=home`
- Einen Berechtigungsfehler der richtigen Schicht zuordnen

## Inhalte

### Schicht 1: Tauri-Capabilities

1. **Warum** – eine kompromittierte npm-Abhängigkeit hätte sonst vollen Zugriff auf alles, was der Prozess darf
2. **Begriffe**
   - *Permission*: einzelne Aktion, etwa `fs:allow-read-text-file`
   - *Scope*: Einschränkung darauf, etwa `$DOCUMENT/NoteFlow/**`
   - *Capability*: Bündel, einem Fenster zugewiesen
3. **Dateien** unter `src-tauri/capabilities/`
4. **Content Security Policy** in `tauri.conf.json`, Umgang mit dem `asset`-Protokoll

### Schicht 2: Flatpak-Sandkasten

5. **`finish-args`** aus dem Manifest des Leitfadens erneut lesen und Zeile für Zeile begründen
6. **Vergleich der Ansätze**

| Ansatz | Reichweite | Bewertung |
|---|---|---|
| `--filesystem=home` | gesamtes `$HOME` | bequem, hebt den Sandkasten praktisch auf |
| `--filesystem=xdg-documents/NoteFlow:create` | ein Unterordner | vertretbarer Kompromiss, im Kurs verwendet |
| nur Portal, kein `--filesystem` | nur vom Nutzer gewählte Dateien | sauberste Lösung, erfordert Umbau der Dateilogik |

7. **Dokumenten-Portal** – über den Dialog gewählte Dateien werden unter `/run/user/UID/doc/` eingeblendet. Der FS-Scope der Tauri-Seite muss das kennen.
8. **Netzwerk** – `--share=network` gehört nur ins Manifest, wenn die App selbst ins Netz muss. Für den Build ist es etwas anderes, siehe [[M11 Flatpak Build und Verteilung]].

### Zuordnungsübung

| Fehlerbild | Schicht |
|---|---|
| `fs.read_text_file not allowed` | Tauri-Capability |
| Datei existiert, Lesen liefert „No such file" im Flatpak, im Devlauf nicht | Flatpak-Sandkasten |
| Dialog öffnet nicht | Portal auf dem Host |
| Inline-Style wird nicht angewendet | CSP |

## Praxisteil

- [ ] Berechtigungsfehler aus Modul 06 auflösen, ohne pauschale Rechte zu setzen
- [ ] FS-Scope auf einen einzigen Unterordner beschränken
- [ ] Gegenprobe: Zugriff außerhalb des Scopes versuchen, Fehlermeldung dokumentieren
- [ ] CSP setzen, entstehende Konsolenmeldungen protokollieren
- [ ] `finish-args` des Notizblock-Manifests kommentieren, jede Zeile begründen
- [ ] `flatpak info --show-permissions` für die installierte Notizblock-App auswerten
- [ ] Kurze Sicherheitsbetrachtung für NoteFlow schriftlich festhalten

## Typische Fallstricke

> [!warning]
> - Aus Bequemlichkeit werden pauschale Rechte gesetzt. Genau das soll das Modul verhindern.
> - Capability angelegt, aber keinem Fenster zugewiesen.
> - Der Fehler wird in der falschen Schicht gesucht. Im `cargo tauri dev`-Lauf gibt es **keinen** Flatpak-Sandkasten, deshalb treten diese Fehler erst in Modul 11 auf. Frühzeitig ansprechen.
> - Zu strenge CSP bricht das Laden lokaler Bilder. Das `asset`-Protokoll fehlt.

## Lernerfolgskontrolle

Gegeben sind eine Capability-Datei und ein Flatpak-Manifest mit jeweils zu weiten Rechten. Beide auf das Minimum reduzieren, jede Streichung begründen.

## Verknüpfung

Weiter mit [[M08 Eigene Commands und Events]] · zurück zu [[00 Kurskonzept Tauri]]

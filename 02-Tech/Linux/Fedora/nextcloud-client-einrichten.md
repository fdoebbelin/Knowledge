---
title: Nextcloud-Client einrichten
tags: [fedora, hyprland, noctalia, nextcloud, nushell, sync]
created: 2026-07-06
system: Fedora 44 + Hyprland + Noctalia
status: draft
---

# Nextcloud-Client einrichten

> [!info] Ziel
> Installation des **Nextcloud-Desktop-Clients** auf einem frischen Fedora-44-Minimal-System mit Hyprland und Noctalia, samt Verbindung zum eigenen Server `cloud.doebbelin.net`. Der Client ist Qt-basiert und fügt sich damit in den bestehenden qt6ct-/Kvantum-Theming-Stack ein. Alle Konsolen-Befehle liegen in nativer Nushell-Syntax vor.

Der Client läuft dauerhaft im Hintergrund und minimiert sich in den System-Tray. Auf einem Minimal-Hyprland-Setup gibt es dabei drei typische Stolpersteine, die dieser Leitfaden bewusst zuerst abräumt: **Tray** (via Noctalia), **Secret-Service/Schlüsselbund** (für die Anmeldedaten) und **Standardbrowser** (für den Login-Flow).

---

## 1. Voraussetzungen prüfen

> [!note] Bereits erwartet
> Hyprland (0.55+, Lua-Config), Noctalia (Quickshell), Nushell als Standard-Shell, Vivaldi als Browser, qt6ct + Kvantum für Qt-Theming.

Erreichbarkeit und Version des Servers lassen sich Nushell-nativ über den öffentlichen `status.php`-Endpunkt prüfen (liefert ein JSON-Record):

```nu
http get https://cloud.doebbelin.net/status.php
```

Erwartet wird ein Record mit u. a. `installed: true`, `productname` und `versionstring`. Kommt hier ein Fehler oder HTML statt JSON zurück, stimmt entweder die URL nicht oder ein Reverse-Proxy leitet um — das sollte **vor** dem Client-Setup geklärt sein.

Einzelne Felder gezielt herausziehen:

```nu
http get https://cloud.doebbelin.net/status.php | select productname versionstring installed
```

---

## 2. Client installieren

```nu
sudo dnf install nextcloud-client nextcloud-client-dolphin
```

- `nextcloud-client` — die GUI-Anwendung inkl. `nextcloudcmd` (CLI-Sync).
- `nextcloud-client-dolphin` — Overlay-Icons und Kontextmenü-Integration in Dolphin (Sync-Status direkt im Dateimanager).

> [!warning] Versionsabhängig
> Der Client ist in aktuellen Fedora-Versionen gegen **Qt6** gebaut, wird also über `qt6ct` + Kvantum thematisiert. Prüfe bei Theming-Problemen, ob wirklich die Qt6-Variante installiert ist:
> ```nu
> dnf info nextcloud-client | lines | where $it =~ Version
> ```
> Der Paketname der Dolphin-Integration (`nextcloud-client-dolphin`) kann sich zwischen Releases ändern — falls `dnf` ihn nicht findet, nach Alternativen suchen:
> ```nu
> dnf search nextcloud-client
> ```

---

## 3. Schlüsselbund (Secret Service) bereitstellen

> [!warning] Wichtigster Stolperstein auf Minimal-Hyprland
> Der Nextcloud-Client speichert das App-Token über die **Secret-Service-Schnittstelle** (`org.freedesktop.secrets`). Auf einem Minimal-System läuft standardmäßig **kein** Anbieter dafür. Folge: „Kann Passwort nicht sicher speichern“ oder eine erneute Anmeldung bei jedem Start.

Empfohlener, gut erprobter Weg — **gnome-keyring** als Referenz-Implementierung:

```nu
sudo dnf install gnome-keyring
```

Den Secrets-Dienst beim Session-Start mitstarten. Da die Config auf **Lua** migriert ist (Hyprland 0.55+), erfolgt Autostart über `hl.on("hyprland.start", …)` (siehe Abschnitt 5):

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)
```

> [!tip] Nahtloses Entsperren (optional, fortgeschritten)
> Ohne PAM-Anbindung wird der Schlüsselbund ggf. beim ersten Zugriff mit einem Passwort abgefragt bzw. bleibt gesperrt. Für automatisches Entsperren beim Login muss `pam_gnome_keyring` in den PAM-Stack des Display-Managers (SDDM) eingehängt werden. Die genauen Datei-Pfade unter `/etc/pam.d/` variieren je nach Distribution/Release — daher hier bewusst **nicht als feste Anleitung**, sondern als Hinweis: Stichwort `pam_gnome_keyring.so` in `auth` (`auto_start`) und `session` (`auto_start`) der SDDM-PAM-Datei.

> [!note] Alternative KWallet
> Passend zum KDE-lastigen Stack (Dolphin, KDE-Portal) kann statt gnome-keyring auch **kwalletd6** als Secret-Service-Anbieter dienen. Das ist konsequenter im Qt-Umfeld, aber die Secret-Service-Bridge von KWallet ist erfahrungsgemäß fummeliger einzurichten. Für den ersten, funktionierenden Aufbau ist gnome-keyring der ruhigere Weg.

Prüfen, ob ein Secret-Service-Anbieter aktiv ist:

```nu
busctl --user list | lines | where $it =~ secrets
```

---

## 4. Standardbrowser für den Login-Flow setzen

> [!warning] Sonst öffnet sich die Anmeldung nicht
> Die Verbindung nutzt **Login Flow v2**: Der Client öffnet zur Authentifizierung den Browser. Auf Minimal-Hyprland ist oft **keine** Standard-Browser-Zuordnung gesetzt, wodurch `xdg-open` scheitert und der Login-Flow ins Leere läuft.

Vivaldi als Standardbrowser eintragen und prüfen:

```nu
xdg-settings set default-web-browser vivaldi-stable.desktop
xdg-settings get default-web-browser
```

> [!note]
> Der `.desktop`-Name kann je nach Vivaldi-RPM abweichen (z. B. `vivaldi.desktop`). Verfügbare Einträge auflisten:
> ```nu
> ls /usr/share/applications/*vivaldi* | get name
> ```

---

## 5. Verbindung zu `cloud.doebbelin.net` herstellen

### Variante A — GUI-Assistent (empfohlen)

1. Client starten:
   ```nu
   nextcloud
   ```
2. Serveradresse eingeben:
   ```
   https://cloud.doebbelin.net
   ```
3. Der Browser (Vivaldi) öffnet sich → mit den Zugangsdaten anmelden → **Zugriff gewähren**. Der Client erhält ein eigenes App-Token (nicht das Klartext-Passwort).
4. **Lokalen Sync-Ordner** wählen (Standard: `~/Nextcloud`).
5. Synchronisationsumfang festlegen — **selektive Synchronisation** (nur benötigte Ordner) ist auf Linux die zuverlässige Wahl.

> [!warning] Virtuelle Dateien (VFS)
> Die „Virtuelle Dateien“-Option (Platzhalter statt vollständigem Download) ist unter **Linux weiterhin experimentell**. Für einen stabilen Erstaufbau besser selektive Synchronisation verwenden und VFS erst später testen.

Nach Abschluss prüfen, ob der Prozess läuft und der Config-Ordner angelegt wurde:

```nu
ps | where name =~ nextcloud
ls ~/.config/Nextcloud
```

### Variante B — Kommandozeile mit `nextcloudcmd` (fortgeschritten)

Für skriptbaren/kopflosen Sync. Vorher im Web-UI ein **App-Passwort** erzeugen (Einstellungen → Sicherheit → Neues App-Passwort) und das Klartext-Passwort meiden.

```nu
# App-Passwort sicher als Umgebungsvariable ablegen (nicht im Klartext ins Skript)
$env.NC_PW = (input --suppress-output "App-Passwort: ")

nextcloudcmd --user fritz --password $env.NC_PW ~/Nextcloud https://cloud.doebbelin.net
```

> [!tip]
> `nextcloudcmd --help` zeigt u. a. `--path` (nur einen Server-Unterordner synchronisieren) und `--exclude`. Ideal für einen späteren, per `systemd`-Timer getriggerten Einweg-Sync — dann konsequent in einer `.nu`-Datei kapseln (Hyprland-Keybinds und Timer rufen externe `.nu`-Skripte, keine Inline-Nu-Ausdrücke).

---

## 6. Autostart in Hyprland (Lua)

> [!warning] Kein Mischen von hyprlang und Lua
> Seit Hyprland 0.55 ist die Config **Lua** (`~/.config/hypr/hyprland.lua`). Klassische `exec-once = …`-Zeilen funktionieren dort **nicht** und müssen übersetzt werden.

Autostart erfolgt über den `hyprland.start`-Event. Der Schalter `--background` startet den Client direkt minimiert in den Tray:

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("nextcloud --background")
end)
```

> [!note]
> Reihenfolge beachten: Der Schlüsselbund sollte **vor** dem Client stehen, damit das Token beim Start entsperrt gelesen werden kann. Mehrere `hl.exec_cmd(...)` innerhalb desselben `hl.on`-Blocks sind zulässig.

Zum Vergleich die alte (nicht mehr gültige) hyprlang-Entsprechung — nur zur Orientierung, **nicht** in die Lua-Config übernehmen:

```ini
# VERALTET (hyprlang, Pre-0.55) – nur zur Referenz
exec-once = gnome-keyring-daemon --start --components=secrets
exec-once = nextcloud --background
```

---

## 7. Tray-Icon unter Noctalia

Der Client lebt im Tray (StatusNotifierItem / SNI). Noctalia bringt ein SNI-fähiges Tray-Widget mit, sodass das Icon dort erscheinen sollte.

> [!check] Prüfpunkte
> - In den **Noctalia-Einstellungen** ist das **System-Tray-Modul** aktiviert.
> - Nach dem Start taucht das Nextcloud-Icon im Tray auf (Links-/Rechtsklick → Fenster öffnen, Sync-Status, Konten).
> - Fehlt das Icon, obwohl der Prozess läuft (`ps | where name =~ nextcloud`), liegt es fast immer am Tray-Modul, nicht am Client.

---

## 8. Theming & Dolphin-Integration

> [!note] Qt-Theming
> Als Qt6-App folgt der Client `qt6ct` + Kvantum automatisch — vorausgesetzt `QT_QPA_PLATFORMTHEME=qt6ct` ist in der Umgebung gesetzt (in Hyprland via `hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")`). Damit passt sich das Fenster ins übrige Solarized-/Kvantum-Erscheinungsbild ein.

> [!example] Dolphin
> Mit installiertem `nextcloud-client-dolphin` zeigt Dolphin nach einem Neustart Overlay-Symbole (synchronisiert / ausstehend / Fehler) auf den Dateien im `~/Nextcloud`-Ordner sowie einen „Freigabe“-Eintrag im Kontextmenü.

---

## 9. Fehlerbehebung

> [!warning] Client startet, aber kein Tray-Icon
> Prozess läuft (`ps | where name =~ nextcloud`), aber nichts im Tray → **Noctalia-Tray-Modul** aktivieren (Abschnitt 7). Das ist keine Client-Fehlfunktion.

> [!warning] „Kann Passwort nicht sicher speichern“ / Keychain-Fehler
> Kein Secret-Service-Anbieter aktiv → Abschnitt 3. Testen:
> ```nu
> busctl --user list | lines | where $it =~ secrets
> ```

> [!warning] Login-Browser öffnet nicht
> Standardbrowser nicht gesetzt → Abschnitt 4. Manuell gegenprüfen:
> ```nu
> xdg-open https://cloud.doebbelin.net
> ```

> [!warning] Darstellungs-/Fensterprobleme unter Wayland
> Läuft der Client nativ unter Wayland instabil (verschwindende Fenster, Tray-Macken), hilft testweise der XWayland-Fallback nur für diese App:
> ```nu
> QT_QPA_PLATFORM=xcb nextcloud --background
> ```
> Bewährt sich das, den Aufruf in der `hl.exec_cmd(...)`-Zeile entsprechend anpassen.

> [!warning] Erst-Sync zieht zu viele Daten
> Bei großen Konten vor dem Start die **selektive Synchronisation** einschränken (Einstellungen → Konto → Ordnersynchronisierung), statt alles herunterzuladen.

Log live mitlesen (Nushell-nativ, ohne `> /dev/null`-Konstrukte):

```nu
journalctl --user -f | where message =~ nextcloud | ignore
```

---

## Aufgaben

- [ ] Server-Erreichbarkeit via `http get .../status.php` bestätigt
- [ ] `nextcloud-client` (+ `nextcloud-client-dolphin`) installiert
- [ ] Secret-Service-Anbieter (gnome-keyring) installiert und im Autostart
- [ ] Standardbrowser (Vivaldi) via `xdg-settings` gesetzt
- [ ] Verbindung zu `cloud.doebbelin.net` über GUI-Assistent hergestellt
- [ ] Sync-Ordner + selektive Synchronisation konfiguriert
- [ ] Autostart-Block in `hyprland.lua` (Keyring vor Client) eingetragen
- [ ] Tray-Icon in Noctalia sichtbar
- [ ] Optional: PAM-Auto-Unlock für Schlüsselbund geprüft
- [ ] Optional: `nextcloudcmd`-Skript als `.nu`-Datei für Timer-Sync

---

## Verwandte Notizen

> [!note] Wikilinks ggf. an tatsächliche Dateinamen anpassen
> - [[02-nushell-konfigurieren]]
> - [[hyprland.lua]]
> - [[Noctalia integrieren]]
> - [[Qt-Theming mit Kvantum]]
> - [[Vivaldi einrichten]]

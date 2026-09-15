---
title: Bootmedien erstellen – Fedora Media Writer & Ventoy Multiboot
tags: [fedora, installation, usb, bootstick, ventoy, mediawriter]
created: 2026-06-29
system: Fedora 44
status: aktiv
---

# Bootmedien erstellen – Fedora Media Writer & Ventoy

Zwei Werkzeuge, zwei Aufgaben. Beide werden hier dokumentiert, weil sie unterschiedliche Zwecke erfüllen – nicht als Alternativen für dieselbe Sache.

> [!tip] Wann welches Werkzeug?
> - **Fedora Media Writer** → *ein* sauberer Fedora-Installationsstick. Einfachster offizieller Weg, wenn du nur Fedora installieren willst.
> - **Ventoy** → *ein* Stick, *viele* ISOs (Fedora, CachyOS, Ubuntu, Rescue-Tools). Du legst die ISO-Dateien einfach drauf und wählst beim Booten aus einem Menü. Ideal zum Durchtesten verschiedener Distributionen – genau das CachyOS-/Ubuntu-Gefühl.

Für deinen Anwendungsfall (mehrere Systeme antesten, dann Fedora final installieren) ist **Ventoy** der bequemere Weg. Media Writer bleibt nützlich, falls du später einen dedizierten, „garantiert kompatiblen" Fedora-Stick brauchst.

---

## Teil 1 – Fedora Media Writer

### Installation

Als Fedora-eigenes Werkzeug am besten nativ per RPM:

```nu
sudo dnf install mediawriter
```

Alternative als Flatpak (falls du Container bevorzugst):

```nu
flatpak install flathub org.fedoraproject.MediaWriter
```

### Verwendung

1. Media Writer starten.
2. Entweder eine Fedora-Edition auswählen (lädt die ISO herunter **und** schreibt sie direkt), oder unten „Benutzerdefiniertes Abbild" wählen, um eine bereits heruntergeladene `.iso` zu schreiben.
3. Ziel-USB-Stick wählen → schreiben.

> [!warning] Media Writer überschreibt den **gesamten** Stick und schreibt **genau ein** ISO.
> Multiboot ist damit nicht möglich. Alle vorhandenen Daten auf dem Stick gehen verloren.

---

## Teil 2 – Ventoy Multiboot-Stick

Ventoy installiert einmalig einen kleinen Bootmanager auf den Stick. Danach kopierst du beliebig viele ISO-Dateien auf die Datenpartition (Standard: exFAT, verträgt also auch Dateien > 4 GB). Beim Booten erscheint ein Menü mit allen gefundenen ISOs.

Aktuelle Version: **Ventoy 1.1.16** (Juni 2026). Fedora ist offiziell unterstützt, ebenso CachyOS/Arch und Ubuntu.

> [!warning] Gefahr von Datenverlust!
> Das falsche Laufwerk zu erwischen, löscht die falsche Platte. **Vor dem Installieren das Gerät zweifelsfrei identifizieren** (Größe, USB-Transport prüfen). Im Zweifel den Stick aus- und wieder einstecken und schauen, welches Gerät neu auftaucht.

### Schritt 1 – USB-Gerät identifizieren

```nu
# Nur USB-Geräte anzeigen (JSON von lsblk nach nushell parsen)
lsblk -J -o NAME,SIZE,TRAN,LABEL | from json | get blockdevices | where tran == "usb"
```

Merke dir den Gerätenamen, z. B. `sdb` → das Gerät ist dann `/dev/sdb`. In allen folgenden Befehlen `sdX` durch deinen echten Namen ersetzen.

### Schritt 2 – Ventoy herunterladen

Aktuelle Version dynamisch über die GitHub-API ermitteln und das Linux-Tarball laden:

```nu
# Neueste Version ermitteln (z. B. "1.1.16")
let ver = (http get https://api.github.com/repos/ventoy/Ventoy/releases/latest | get tag_name | str replace --regex '^v' '')

# Tarball-Dateiname zusammenbauen und herunterladen
let datei = $"ventoy-($ver)-linux.tar.gz"
http get $"https://github.com/ventoy/Ventoy/releases/download/v($ver)/($datei)" | save -f $datei

# Entpacken
tar xzf $datei
```

### Schritt 3 – Ventoy auf den Stick installieren

> [!warning] Dieser Schritt **formatiert das Gerät** und löscht alle Daten darauf.
> Sicherstellen, dass `/dev/sdX` wirklich der USB-Stick ist.

```nu
cd $"ventoy-($ver)"

# -i = installieren, -s = Secure-Boot-Unterstützung aktivieren
sudo sh ./Ventoy2Disk.sh -i -s /dev/sdX
```

> [!tip] Secure Boot auf dem Lenovo Yoga
> Mit `-s` wird Ventoy Secure-Boot-fähig vorbereitet. Beim **ersten** Booten erscheint ein blauer **MOK-Enrollment**-Bildschirm: dort `Enroll key` → `Continue` → den Ventoy-Schlüssel bestätigen → Neustart. Das ist nur einmalig pro Rechner nötig.
> Falls Ventoy trotzdem nicht startet, im UEFI die Option **„Allow Microsoft 3rd Party UEFI CA"** aktivieren (bei Lenovo unter den Secure-Boot-Einstellungen). Alternativ Secure Boot im UEFI vorübergehend deaktivieren.

### Schritt 4 – ISOs aufspielen

Vor dem Kopieren jede ISO per Prüfsumme verifizieren (siehe [[01-fedora-iso-und-installation]] für das vollständige Vorgehen):

```nu
# Kurzform: tatsächliche Prüfsumme berechnen
open --raw Fedora-Workstation-Live-x86_64-44.iso | hash sha256
```

Die Ventoy-Datenpartition (Label `Ventoy`) wird nach dem Aus-/Einstecken automatisch eingehängt, üblicherweise unter `/run/media/<benutzer>/Ventoy`. Eine einzelne ISO kopieren:

```nu
cp ~/Downloads/Fedora-Workstation-Live-x86_64-44.iso $"/run/media/($env.USER)/Ventoy/"
```

Oder alle ISOs aus dem Download-Ordner auf einmal:

```nu
ls ~/Downloads/*.iso | get name | each {|iso| cp $iso $"/run/media/($env.USER)/Ventoy/" }
```

> [!tip] Ordnung im Bootmenü
> Ventoy durchsucht auch Unterordner rekursiv. Lege z. B. `Linux/`, `Tools/` und `Windows/` an – das Bootmenü zeigt die ISOs dann übersichtlich gruppiert.

### Schritt 5 – Vom Stick booten

1. Stick einstecken, Rechner starten.
2. Lenovo Yoga: beim Einschalten **F12** für das Bootmenü drücken – oder über den kleinen **Novo-Button** (Pinhole) → `Boot Menu`.
3. Den Ventoy-Stick wählen → im Ventoy-Menü die gewünschte ISO auswählen.
4. Fedora bootet in die Live-Sitzung; von dort aus lässt sich über Anaconda installieren (siehe [[01-fedora-iso-und-installation]]).

### Später: Ventoy aktualisieren (ohne Datenverlust)

Updates betreffen nur die Boot-Partition; deine ISOs bleiben erhalten:

```nu
cd $"ventoy-($ver)"
sudo sh ./Ventoy2Disk.sh -u /dev/sdX
```

---

## Checkliste

- [ ] Fedora Media Writer installiert (`mediawriter`)
- [ ] Ziel-USB-Stick zweifelsfrei identifiziert (`lsblk`)
- [ ] Ventoy heruntergeladen und installiert (`-i -s`)
- [ ] MOK-Enrollment beim ersten Boot durchgeführt (Secure Boot)
- [ ] Mindestens die Fedora-44-Live-ISO per Prüfsumme verifiziert
- [ ] ISOs auf die Ventoy-Partition kopiert
- [ ] Erfolgreich vom Ventoy-Menü gebootet

> [!check] Ergebnis
> Ein wiederverwendbarer Multiboot-Stick: ISOs einfach per Drag & Drop ergänzen oder entfernen, ohne neu zu formatieren. Zusätzlich ein dedizierter Fedora-Stick via Media Writer als Fallback.

---

## Verwandte Notizen

- [[01-fedora-iso-und-installation]]
- [[Hyprland Konfiguration]]
- [[Flatpak einrichten]]

---
title: "Ruhemodus auf CachyOS — Lenovo Yoga 920-13IKB"
subtitle: "Vollständige Konfiguration: Hibernate + Suspend + suspend-then-hibernate"
author: "Fritz-Rainer Döbbelin"
date: "2026-04-28"
toolchain: "Nushell + Helix · Limine Bootmanager · BTRFS-Root + Swap-Partition"
---

# Übersicht

Dieser Leitfaden dokumentiert das **vollständige Energie-Management-Konzept** für ein Lenovo Yoga 920-13IKB mit CachyOS (Kernel 7.0, Linux-CachyOS) bestehend aus:

| Komponente | Zweck |
|---|---|
| **Swap-Partition (12 GB)** | Hibernate-Ziel, kein BTRFS-Swapfile |
| **S3 Deep Sleep** | Echter RAM-Suspend, niedriger Stromverbrauch |
| **suspend-then-hibernate** | RAM-Schlaf bis 60 min, danach Festplatte |
| **TLP** | Akkulaufzeit-Optimierung |
| **i915-Parameter** | Stabiles Wake-up auf Intel UHD 620 |

**Hardware-Kontext:**

- CPU: Intel Core i7-8550U (Kaby Lake R, 4C/8T)
- GPU: Intel UHD 620 (integriert, kein NVIDIA)
- RAM: 8–16 GB
- Bootmanager: **Limine** (nicht GRUB)
- Root-Filesystem: BTRFS mit Snapper
- Editor: **Helix** (`hx`)
- Shell: **Nushell** (`nu`)

---

# Teil 1 — Hibernate-Grundlage (bereits eingerichtet)

Diese Schritte sind aus dem ursprünglichen Leitfaden vom 23. Januar 2026 und bilden das Fundament. Hier zur Referenz dokumentiert, falls eine Neuinstallation oder Wiederherstellung nötig wird.

## 1.1 Swap-Partition statt BTRFS-Swapfile

```nushell
# Aktive Swaps anzeigen — sollte nur die Partition zeigen
swapon --show

# UUID der Swap-Partition merken
sudo blkid /dev/nvme0n1p3
```

> Hinweis: Der entscheidende Vorteil einer dedizierten Swap-Partition gegenüber einem BTRFS-Swapfile: kein `resume_offset` nötig, kein zusätzlicher Initramfs-Hook für die Datei-Erkennung, keine Probleme mit BTRFS-COW-Eigenheiten.

## 1.2 Limine-Bootkonfiguration

Im Unterschied zu GRUB pflegt Limine seine Konfiguration unter `/boot/efi/limine.conf`. Jeder Boot-Eintrag (regulär + Snapper-Snapshots) hat eine eigene `cmdline:`-Zeile.

```nushell
# Konfigurationsdatei einsehen
sudo cat /boot/efi/limine.conf | find "cmdline"
```

Die wichtigste Eigenschaft: **`resume=UUID=<swap-partition-uuid>`** muss in jeder cmdline-Zeile stehen, damit auch Snapshots korrekt aus dem Hibernate aufwachen.

## 1.3 mkinitcpio: resume-Hook

```nushell
# Aktuelle Konfiguration prüfen
sudo cat /etc/mkinitcpio.conf | find "HOOKS"
```

Der `resume`-Hook muss in der `HOOKS`-Liste enthalten sein (klassische Hooks) oder bei systemd-Initramfs ist er implizit vorhanden.

## 1.4 KDE/Plasma-Polkit-Regel

Die Regel unter `/etc/polkit-1/rules.d/99-hibernate.rules` erlaubt Plasma den Hibernate-Befehl ohne separates Sudo-Passwort.

---

# Teil 2 — Neue Anpassungen (April 2026)

Hier beginnt die heute durchgeführte Erweiterung.

## 2.1 BIOS-Sleep-State prüfen

> **Kommentar:** Der Yoga 920 unterstützt zwei Schlafmodi: `s2idle` (Modern Standby, hoher Stromverbrauch) und `deep` (echtes S3, sehr niedriger Verbrauch). Welcher aktiv ist, zeigen die eckigen Klammern.

```nushell
# Aktuellen Sleep-Modus anzeigen
cat /sys/power/mem_sleep
# Erwartet zu Beginn: [s2idle] deep
# Nach Anpassung:     s2idle [deep]
```

Im konkreten Fall war die Ausgabe `[s2idle] deep` — beide Modi standen zur Verfügung, aber `s2idle` war aktiv. Das BIOS musste also **nicht** angefasst werden.

## 2.2 Kernel-Parameter mem_sleep_default=deep in Limine eintragen

> **Kommentar:** Dieser Parameter weist den Kernel an, beim Suspend automatisch S3 statt s2idle zu verwenden. Ohne diesen Parameter würde trotz aktiver S3-Unterstützung weiterhin der ineffiziente s2idle-Modus genutzt.

```nushell
# Sicherungskopie der Limine-Konfiguration
sudo cp /boot/efi/limine.conf /boot/efi/limine.conf.bak2

# mem_sleep_default=deep in alle cmdline-Zeilen einfügen
# Anker: am Ende jeder Zeile steht "loglevel=3"
sudo sed -i 's/loglevel=3/loglevel=3 mem_sleep_default=deep/g' /boot/efi/limine.conf

# Verifikation
sudo cat /boot/efi/limine.conf | find "cmdline" | first 2
```

**Warum `sed` statt manuellem Edit:** Limine hat in dieser Installation 10 cmdline-Zeilen (2× regulär, 8× Snapshot-Fallbacks). Manuelles Editieren wäre fehleranfällig.

Nach Reboot prüfen:

```nushell
# Aktuelle Kernel-Cmdline
cat /proc/cmdline | find "mem_sleep"

# Sleep-Modus jetzt aktiv
cat /sys/power/mem_sleep
# Erwartet: s2idle [deep]
```

## 2.3 TLP installieren und konfigurieren

> **Kommentar:** TLP ist das Standard-Stromsparwerkzeug für Linux-Notebooks. Es ersetzt `power-profiles-daemon` (PPD), den GNOME/KDE oft mitbringen. Beide gleichzeitig laufen zu lassen führt zu Konflikten — daher PPD deaktivieren.

```nushell
# Installation aus den Repos
paru -S tlp tlp-rdw

# Konflikt mit power-profiles-daemon auflösen
sudo systemctl disable --now power-profiles-daemon.service
sudo systemctl mask power-profiles-daemon.service

# rfkill-Dienste maskieren — TLP übernimmt das selbst
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket

# TLP aktivieren
sudo systemctl enable --now tlp.service

# Status prüfen — keine Warning erwartet
tlp-stat -s | first 25
```

### Yoga-920-spezifische TLP-Konfiguration

> **Kommentar:** Eigene Datei in `/etc/tlp.d/` statt der Hauptkonfiguration unter `/etc/tlp.conf` editieren — das erleichtert Updates und ist die offizielle Empfehlung.

```nushell
# Konfigurationsdatei anlegen und mit Helix öffnen
sudo hx /etc/tlp.d/01-yoga920.conf
```

Inhalt der Datei:

```ini
# TLP-Konfiguration für Lenovo Yoga 920-13IKB
# ideapad_laptop-Treiber: Ladegrenzen nur als 0/1 (Standard/Long_Life)

# CPU-Skalierung: Akku=Stromsparen, Netz=Performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_SCALING_GOVERNOR_ON_AC=performance

# CPU Boost: Akku aus (Hitze + Akku schonen), Netz an (Performance)
CPU_BOOST_ON_BAT=0
CPU_BOOST_ON_AC=1

# USB-Geräte automatisch in Standby schicken
USB_AUTOSUSPEND=1

# NVMe/SSD: Im Akkubetrieb Energiesparmodus, am Netz an
AHCI_RUNTIME_PM_ON_BAT=auto
AHCI_RUNTIME_PM_ON_AC=on

# Akku-Lademodus:
# 0 = Standard      (volle Ladung ~100%) — empfohlen bei mobilem Einsatz
# 1 = Long_Life     (~60%)              — empfohlen bei dauerhaftem Netzbetrieb
BAT0_STOP_CHARGE_THRESH_BAT0=0
```

```nushell
# Konfiguration sofort anwenden — kein Neustart nötig
sudo tlp start

# Status der Akku-Schwellen prüfen
sudo tlp-stat -b | find "charge|thresh|type"
```

> **Wichtig:** Der Yoga 920 nutzt den `ideapad_laptop`-Kerneltreiber. Im Gegensatz zu ThinkPads sind hier keine numerischen Prozentwerte (z.B. 80%) für die Ladegrenze möglich — nur die zwei Zustände `Standard` und `Long_Life`.

## 2.4 suspend-then-hibernate konfigurieren

> **Kommentar:** Der Komfort-Modus: Beim Schließen des Deckels schläft das Gerät zunächst in den RAM (sofort einsatzbereit beim Aufklappen). Nach 60 Minuten ohne Wakeup wechselt es automatisch in den Hibernate-Zustand auf die Swap-Partition — dann verbraucht es exakt 0 Watt. Ideal gegen leere Akkus durch vergessene Geräte in der Tasche.

### Sleep-Konfiguration

```nushell
# Drop-In-Verzeichnis erstellen, falls nicht vorhanden
sudo mkdir -p /etc/systemd/sleep.conf.d

# Eigene Konfigurationsdatei anlegen
sudo hx /etc/systemd/sleep.conf.d/yoga920.conf
```

Inhalt:

```ini
[Sleep]
# Nach 60 Minuten Suspend automatisch in Hibernate wechseln
HibernateDelaySec=60min
```

### logind-Konfiguration

> **Kommentar:** Hier wird festgelegt was beim Schließen des Deckels passiert. `suspend-then-hibernate` ist die Komfortvariante. Für reinen Suspend einfach `suspend` statt `suspend-then-hibernate` eintragen.

```nushell
sudo hx /etc/systemd/logind.conf
```

In der Datei die folgenden Zeilen suchen, **Kommentarzeichen entfernen** und Wert anpassen:

```ini
HandleLidSwitch=suspend-then-hibernate
HandleLidSwitchExternalPower=suspend-then-hibernate
```

```nushell
# logind neu laden — Sitzung bleibt erhalten
sudo systemctl restart systemd-logind

# Verifikation: Konfiguration eingelesen?
cat /etc/systemd/sleep.conf.d/yoga920.conf
```

## 2.5 i915-Kernelmodul-Optionen

> **Kommentar:** Drei Parameter, die auf Intel UHD 620 (Kaby Lake R) das Stromsparverhalten verbessern und gleichzeitig die Stabilität beim Resume erhöhen. Werden ins Initramfs eingebrannt, weil i915 sehr früh im Boot lädt.

```nushell
sudo hx /etc/modprobe.d/i915.conf
```

Inhalt:

```text
# Intel UHD 620 — Energiesparen + Stabilität
options i915 enable_rc6=1     # Render-C6: tiefe GPU-Schlafzustände
options i915 enable_fbc=1     # Framebuffer Compression: weniger Speicherbandbreite
options i915 enable_guc=2     # GuC + HuC Firmware: Video-Hardware-Decoding

# Bei schwarzem Bildschirm nach Resume zusätzlich aktivieren:
# options i915 enable_psr=0   # Panel Self Refresh deaktivieren
```

```nushell
# Initramfs neu bauen — alle Kernel-Presets
sudo mkinitcpio -P
```

---

# Teil 3 — Verifikation und Diagnose

## 3.1 Gesamtcheck nach Neustart

```nushell
# 1. Sleep-Modus aktiv?
cat /sys/power/mem_sleep
# Erwartet: s2idle [deep]

# 2. Kernel-Cmdline korrekt?
cat /proc/cmdline

# 3. TLP läuft ohne Konflikt?
tlp-stat -s | first 20

# 4. logind-Konfiguration aktiv?
systemctl show systemd-logind | find "HandleLidSwitch"

# 5. Hibernate-Ziel verfügbar?
swapon --show

# 6. Akku-Status und Ladeschwelle
sudo tlp-stat -b | find "charge|thresh|type"
```

## 3.2 Funktionstest

```nushell
# Test 1: Reiner Suspend (S3)
systemctl suspend
# → Deckel schließen oder Power-Button → Wake mit Power-Button

# Test 2: Direkter Hibernate
systemctl hibernate
# → Gerät fährt komplett aus, beim Einschalten Resume

# Test 3: suspend-then-hibernate (im Alltag aktiv beim Deckelschließen)
systemctl suspend-then-hibernate
# → Erst S3, nach 60 Min Wechsel auf Disk-Hibernate
```

## 3.3 Troubleshooting-Befehle

```nushell
# Logs des letzten Suspend/Resume-Zyklus
sudo journalctl -b -1 | find -i "suspend|resume|sleep|wake" | last 30

# Welche Geräte können das System wecken?
cat /proc/acpi/wakeup

# Aktuelle CPU-Frequenz und Skalierung
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Akku-Status detailliert
upower -i (upower -e | find BAT | first)
```

---

# Teil 4 — Schnellreferenz nushell-Befehle

## 4.1 Verzeichniswechsel mit Sudo-Beschränkung

Nushell blockiert `cd` in geschützte Verzeichnisse — stattdessen explizit mit sudo arbeiten:

```nushell
# ✗ Funktioniert nicht
cd /boot/efi/

# ✓ Stattdessen — Inhalt anzeigen
sudo ls /boot/efi/

# ✓ Datei direkt mit Helix öffnen (Helix erbt Sudo-Rechte)
sudo hx /boot/efi/limine.conf
```

## 4.2 Find statt grep für Pipelines

Nushell hat eingebaute Filter, die natürlicher in Pipelines arbeiten:

```nushell
# Statt grep
ls | where type == file | where name =~ ".conf"

# Externes grep funktioniert weiterhin
sudo cat /etc/systemd/logind.conf | grep -i "lid"

# Native nushell-Variante
sudo cat /etc/systemd/logind.conf | find "Lid"
```

## 4.3 Snapshot vor kritischen Aktionen

```nushell
# Snapper-Snapshot mit aktuellem Zeitstempel
sudo snapper -c root create --description $"Pre-config: (date now | format date '%Y-%m-%d_%H-%M-%S')"
```

> Beachte die **String-Interpolation** mit `$"..."` und Klammern um den Befehl — nushell-spezifisch und mächtiger als bash-Variablen.

---

# Teil 5 — Tabelle aller Änderungen

| Komponente | Datei | Aktion |
|---|---|---|
| Limine | `/boot/efi/limine.conf` | `mem_sleep_default=deep` per `sed` in alle cmdlines |
| TLP | `/etc/tlp.d/01-yoga920.conf` | Neu angelegt, Yoga-spezifische Werte |
| systemd | `/etc/systemd/sleep.conf.d/yoga920.conf` | Neu angelegt, `HibernateDelaySec=60min` |
| systemd | `/etc/systemd/logind.conf` | `HandleLidSwitch=suspend-then-hibernate` |
| Kernelmodul | `/etc/modprobe.d/i915.conf` | Neu angelegt, RC6/FBC/GuC |
| Initramfs | (regeneriert) | `sudo mkinitcpio -P` |
| systemd-Dienste | (deaktiviert) | `power-profiles-daemon` maskiert |
| systemd-Dienste | (aktiviert) | `tlp.service` enabled |

---

# Teil 6 — Wartung und Anpassungen

## 6.1 Akku-Schonung umschalten

> **Kommentar:** Bei wechselndem Einsatzprofil — z.B. ein paar Wochen Schulungsraum (Netzbetrieb), dann mobile Phase — lässt sich der Modus ohne Neustart umschalten.

```nushell
# Auf Long_Life (Akkuschonung, ~60% Maximalladung) umstellen
sudo tlp setcharge 1 BAT0

# Zurück auf Standard (volle Ladung)
sudo tlp setcharge 0 BAT0

# Status prüfen
sudo tlp-stat -b | find "Standard|Long_Life"
```

## 6.2 Hibernate-Verzögerung anpassen

Wenn 60 Minuten zu kurz oder zu lang sind:

```nushell
sudo hx /etc/systemd/sleep.conf.d/yoga920.conf
# HibernateDelaySec auf gewünschten Wert ändern, z.B. 120min oder 30min

# Reload ohne Neustart
sudo systemctl restart systemd-logind
```

## 6.3 Schwarzer Bildschirm beim Resume

Falls nach Resume gelegentlich ein schwarzer Bildschirm auftritt:

```nushell
sudo hx /etc/modprobe.d/i915.conf
# Ergänzen: options i915 enable_psr=0

sudo mkinitcpio -P
# Reboot zum Aktivieren
```

---

# Teil 7 — Konzeptionelle Zusammenfassung

Das Setup folgt dem **Drei-Stufen-Prinzip** moderner Notebook-Energiesparverwaltung:

```
   Aktiv  ───►  Suspend (RAM)  ───►  Hibernate (Disk)  ───►  Aus
   ~10W        ~0.5W (S3)           0W                       0W
              [Sekunden-Wakeup]    [10s Wakeup]              [Vollboot]
```

Die Übergänge zwischen den Stufen sind:

- **Aktiv → Suspend**: Deckel schließen oder `Fn + 4` (Power-Button kurz drücken)
- **Suspend → Hibernate**: Automatisch nach 60 Minuten (HibernateDelaySec)
- **Hibernate → Aus**: Nur durch manuellen Power-Off oder Akkuverlust

Vorteile dieses Konzepts:

1. **Schnelles Wakeup im Alltag**: 99% der Aufweck-Vorgänge laufen aus S3 (wenige Sekunden)
2. **Kein Akkutod**: Wenn das Gerät vergessen wird, wechselt es selbsttätig in Hibernate
3. **Kein VRAM-Problem**: Da keine NVIDIA-GPU vorhanden ist, gibt es keine GSP-Timeouts oder PreserveVideoMemoryAllocations-Komplexität
4. **Snapshot-Sicherheit**: BTRFS+Snapper macht alle Konfigurationsänderungen rückgängig-fähig

---

*Erstellt am 28. April 2026 für Fritz-Rainer Döbbelin · Lenovo Yoga 920-13IKB · CachyOS Linux-CachyOS Kernel 7.0 · BTRFS-Root + 12 GB Swap-Partition*

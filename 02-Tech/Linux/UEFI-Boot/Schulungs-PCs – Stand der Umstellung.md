---
title: Schulungs-PCs – Stand der Umstellung Legacy → UEFI
aliases:
  - Schulungs-PCs UEFI
tags:
  - uefi
  - fedora-atomic
  - schulungs-pcs
description: Welcher Schulungs-PC (ASUS P8B75) in welchem Bootmodus läuft, welche SSD er hat und was bei der Umstellung auf UEFI als Nächstes ansteht.
created: 2026-10-21
updated: 2026-10-21
status: active
---

# Schulungs-PCs – Stand der Umstellung

Ablauf: [[02-Legacy-zu-UEFI bei Fedora Atomic]]. Die Hostnamen sind auf allen PCs noch `fedora`; unterscheidbar sind sie über Mainboard und SSD (so benennt auch `uefi-pruefung.sh` seine Ausgabedatei).

| PC | Mainboard / BIOS | System | Systemplatte | Modus | Nächster Schritt |
|---|---|---|---|---|---|
| Dozenten-PC | P8B75-V / 1601 | Sway Atomic | INTENSO 476,94 GiB, `sdb` | Legacy | Schritte 3–6 ([[_resources/Schritt-3-ESP-anlegen.pdf\|Arbeitsblatt]]) |
| PC mit Crucial | P8B75-V / 1601 | Silverblue 44 | Crucial CT120BX500 111,8 GiB, `sda`, Disk-ID `42D2B644-55FE-…` | Legacy | ausstehenden Update-Neustart abschließen, dann Schritte 3–6 |
| PC mit Intenso (UEFI) | P8B75-V / 1601 | Silverblue 44 | Intenso, `sda`, ESP 600 MiB als `sda1` | **UEFI** (Secure Boot aus) | `systemctl reboot`, `sudo bootupctl update`; optional CSM aus und Secure Boot |
| P8B75-M | P8B75-M / 1701 | Silverblue 44 | 2× Intenso 111,8 GiB, System `sdb`, Disk-ID `3386C0FB-347F-…` | Legacy | **btrfs-Schaden in `var`** → Neuinstallation (unten) |

> [!note] Gerätenamen im Live-System
> Vom Live-Stick gestartet wird der Stick meist `sda`, die Systemplatte rückt nach (`sda` → `sdb`). Immer über Modell, Größe, Label `fedora_fedora` und Disk identifier (`sudo fdisk -l`) identifizieren.

## P8B75-M: Neuinstallation

Befund und Begründung: [[03-btrfs und SMART im Live-System prüfen#Fallbeispiel: P8B75-M, Oktober 2026]].

- [ ] SMART beider Intenso-SSDs auswerten, SSD ggf. tauschen.
- [ ] Home im Live-System sichern (`mount -o ro,subvol=home`, `tar`).
- [ ] Notieren: lokale RPMs (`easyspeak`), RPM Fusion, COPR PyCharm, Flatpaks.
- [ ] Zweite SSD abklemmen, Silverblue **bewusst im Legacy-Modus** neu installieren – die Übung Legacy → UEFI soll erhalten bleiben.
- [ ] Daten zurückspielen, dann regulär Schritte 3–6. Die Disk-ID ändert sich durch die Neuinstallation; hier aktualisieren.

## Übergreifend offen

- [ ] Eindeutige Hostnamen vergeben (`hostnamectl hostname …`).
- [ ] Ursache der verlorenen Schreibvorgänge klären: harte Abschaltungen (SMART 174/192) oder SSD-Firmware.
- [ ] Nach dem ersten Umbau `bootupctl status` in [[02-Legacy-zu-UEFI bei Fedora Atomic#Offen]] nachtragen.
- [ ] Windows-11-SSD (Original-PC): Mischmodus einstellen und Start prüfen, siehe [[13-winpe-rettungs-vm]] und [[01-UEFI-Booteinträge anlegen#4. Fallbeispiel: Windows-SSD meldet „kein bootfähiges Medium“]].

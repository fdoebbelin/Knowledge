---
title: "Fedora 44 als Zweitsystem auf dem Dell XPS 13 9345 (Snapdragon X Elite)"
aliases: ["Fedora Dual-Boot XPS 9345", "Fedora WoA tributo"]
tags:
  - linux
  - fedora
  - snapdragon
  - dualboot
  - dell-xps-9345
  - arm64
device: "Dell XPS 13 9345 (X1E80100, codename 'tributo')"
zielsystem: "Fedora Workstation 44 (aarch64), Kernel 6.19"
erstsystem: "Windows 11 (ARM)"
created: 2026-06-29
status: arbeitsentwurf
---

# Fedora 44 als Zweitsystem auf dem Dell XPS 13 9345

> [!info] Worum es hier geht
> Schritt-für-Schritt-Anleitung, um **Fedora Workstation 44 (aarch64)** als Dual-Boot **neben Windows 11** auf dem Dell XPS 13 9345 (Snapdragon X1 Elite, `X1E80100`) zu installieren. Schwerpunkt liegt auf der **Vorbereitung der Windows-11-Seite** — BitLocker abschalten und alles entfernen, was den dualen Betrieb stört. Windows bleibt erhalten (es wird für Firmware-Updates und die Firmware-Extraktion gebraucht).

> [!danger] Vor dem Start unbedingt lesen
> - Dies ist **bleeding-edge ARM**. Erstelle ein **vollständiges Backup** wichtiger Daten, bevor du irgendetwas an Partitionen oder Bootloader anfasst.
> - **Sichere den BitLocker-Recovery-Key**, bevor du BitLocker oder UEFI-Einstellungen anfasst (siehe [[#1.1 BitLocker-Recovery-Key sichern]]).
> - **Reihenfolge ist kritisch:** erst Key sichern → BitLocker vollständig entschlüsseln → *dann* UEFI/Secure-Boot ändern. Wer Secure Boot ändert, während BitLocker noch aktiv ist, landet im Recovery-Key-Prompt.

---

## 0. Ausgangslage & Hardware-Status

> [!note] Was auf dem 9345 unter Linux läuft (Stand Juni 2026)
> Quelle: Vinarskis' `dell-tributo`-Feature-Matrix (maßgeblich für genau dieses Modell).
>
> **Funktioniert:** Akku (Laden + Anzeige), Bluetooth, Display + Helligkeit, Fingerprint-Reader, GPU-Beschleunigung (Adreno/Turnip), Tastatur, Mikrofone, NVMe, Lautsprecher, Suspend (inkl. Lid-Switch), Touchpad, USB-C 3.0, USB-C-Boot, USB-C DP Alt Mode, USB-C-DP über Dock, WLAN.
>
> **Noch offen / nicht nutzbar:**
> - **Kamera** (ov02c10) – hängt an Qualcomms Upstream-Support, erst in Linaros Tree.
> - **TPM** – TZ-geschützt, aus dem Userspace nicht direkt ansprechbar.
> - **EC** – proprietärer Controller (separater Reverse-Engineering-Treiber existiert, behebt Lüfter-/Thermik-/Suspend-Verhalten, war zuletzt im Kernel-Review).
> - **Audio:** mäßige Klangqualität, **L/R vertauscht**; HDMI-/USB-C-DP-Audio fehlt noch.
> - **Sleep-Stromverbrauch** nicht optimal (generische X1E-Limitierung).

> [!warning] Nur USB-C-Ports
> Das 9345 hat **ausschließlich USB-C-Ports**. Das ist für die Installation relevant: Beim Booten vom USB-C-Stick brauchst du den Kernel-Parameter `modprobe.blacklist=qcom_q6v5_pas` (siehe [[#4.1 Vom USB-Stick booten + Kernel-Parameter]]). Falls du einen USB-A-Hub/-Dock hast, kannst du das umgehen.

---

# Teil 1 — Vorbereitung auf der Windows-11-Seite

Dieser Teil ist der wichtigste für sauberen Dual-Boot. Komplett unter Windows ausführen, **bevor** du den Fedora-Stick anfasst.

## 1.1 BitLocker-Recovery-Key sichern

> [!danger] Zuerst, bevor irgendetwas anderes
> Selbst wenn du BitLocker gleich entschlüsselst: Sichere den Key, falls die Entschlüsselung unterbrochen wird oder ein Firmware-/Secure-Boot-Wechsel dazwischenfunkt.

Optionen:
- Online: <https://aka.ms/myrecoverykey> (mit dem Microsoft-Konto anmelden, das mit dem Gerät verknüpft ist).
- Lokal per PowerShell (als Admin):

```powershell
manage-bde -protectors -get C:
BitLocker-Laufwerkverschlüsselung: Konfigurationstool, Version 10.0.26100
Copyright (C) 2013 Microsoft Corporation. Alle Rechte vorbehalten.

Volume "C:" [OS]
Alle Schlüsselschutzvorrichtungen

    TPM:
      ID: {C32931A6-2CE5-43F4-89EC-3FCEA4FD3554}
      PCR-Validierungsprofil:
        7, 11
        (Verwendet den sicheren Start für die Integritätsüberprüfung)

    Numerisches Kennwort:
      ID: {802C7373-D80B-4B64-911B-5976E4BE9544}
      Kennwort:
        336710-269280-572352-287584-017226-603999-086152-481932
      Sicherungstyp:
        Microsoft-Kontosicherung
```

Den 48-stelligen Recovery-Key notieren / auf einem **anderen** Medium speichern (nicht auf dem Laptop selbst).

## 1.2 Firmware & Treiber aktualisieren

> [!important] Warum zuerst updaten
> Die laufbare Qualcomm-DSP-Firmware liegt unter Windows. Das Fedora-Skript `qcom-firmware-extract` kopiert sie später von der Windows-Partition – die Windows-Version ist oft **neuer** als das, was in `linux-firmware` liegt. Also vorher unter Windows auf den aktuellsten Stand bringen.

- **Dell Command Update** (oder *Dell Update* / *SupportAssist*) ausführen und **alle** BIOS-/Firmware-/Treiber-Updates installieren, mehrfach durchlaufen lassen bis nichts mehr kommt.
- Windows-Update zusätzlich vollständig durchlaufen lassen.
- Danach **neu starten**, damit alle Firmware-Stände aktiv sind.

## 1.3 BitLocker / Geräteverschlüsselung vollständig deaktivieren

> [!important] Das ist der von dir gewünschte Kernschritt
> Zwei Gründe, BitLocker zu **entschlüsseln** (nicht nur zu „pausieren"):
> 1. **Firmware-Extraktion:** Linux muss die Windows-Partition lesen können. Verschlüsselt geht das nicht → kein Audio, keine Akku-Anzeige.
> 2. **Boot-Stabilität:** GRUB und ein BitLocker-aktives Windows vertragen sich schlecht (das Brechen des Windows-Boots mit aktivem BitLocker war sogar ein Fedora-44-Release-Blocker). Ohne Verschlüsselung kein Recovery-Prompt bei jedem Bootloader-Wechsel.

**Variante A – GUI (Windows 11 Home: „Geräteverschlüsselung"):**
`Einstellungen` → `Datenschutz und Sicherheit` → `Geräteverschlüsselung` → Schalter auf **Aus**. Entschlüsselung bestätigen.

**Variante B – GUI (Windows 11 Pro: „BitLocker"):**
`Systemsteuerung` → `BitLocker-Laufwerkverschlüsselung` → beim Systemlaufwerk **BitLocker deaktivieren**.

**Variante C – Kommandozeile (beide Editionen), als Admin:**

```powershell
manage-bde -off C:
```

**Status prüfen, bis vollständig entschlüsselt:**

```powershell
manage-bde -status C:
```

> [!warning] Auf „Fully Decrypted" warten
> Die Entschlüsselung läuft im Hintergrund und kann je nach Füllstand **eine ganze Weile** dauern. Erst weitermachen, wenn `Conversion Status: Fully Decrypted` und `Percentage Encrypted: 0,0%` gemeldet wird. Falls weitere Laufwerke (D:, …) verschlüsselt sind, ebenso behandeln.

## 1.4 Schnellstart (Fast Startup) deaktivieren

> [!note] Warum
> Der Windows-Schnellstart fährt nicht echt herunter, sondern legt einen Hibernate-ähnlichen Zustand ab. Das **sperrt das Dateisystem** und kann gemeinsam genutzte Partitionen beschädigen. Für Dual-Boot willst du echte Shutdowns.

**GUI:** `Systemsteuerung` → `Energieoptionen` → `Auswählen, was beim Drücken des Netzschalters geschehen soll` → `Einige Einstellungen sind momentan nicht verfügbar` anklicken → Haken bei **„Schnellstart aktivieren"** entfernen.

**Oder per Kommandozeile (deaktiviert Ruhezustand komplett, inkl. Schnellstart):**

```powershell
powercfg /h off
```

> [!tip] Nebeneffekt
> `powercfg /h off` löscht zugleich `hiberfil.sys` und gibt damit Plattenplatz frei – hilft beim Verkleinern in [[#1.5 Windows-Partition verkleinern]].

## 1.5 Windows-Partition verkleinern

> [!note] Ziel
> Freien, **nicht zugewiesenen** Speicher schaffen, in den Fedora später installiert wird. Die Größe selbst (Fedora-Root) später in Anaconda.

**GUI – Datenträgerverwaltung:**
1. `Win + X` → `Datenträgerverwaltung` (oder `diskmgmt.msc`).
2. Rechtsklick auf das Windows-Laufwerk (C:) → **Volume verkleinern**.
3. Gewünschte Größe für Fedora freigeben (z. B. 80–150 GB, je nach SSD). Den freigegebenen Bereich **nicht** formatieren – als *nicht zugewiesen* belassen.

> [!warning] Wenn Windows nur wenig freigibt
> Windows verschiebt manche „unbeweglichen" Dateien nicht (Auslagerungsdatei, Wiederherstellungspunkte, ggf. Reste der Verschlüsselung). Gegenmaßnahmen, falls das Shrink-Limit zu niedrig ist:
> - **Ruhezustand** aus: `powercfg /h off` (siehe oben).
> - **Auslagerungsdatei** temporär deaktivieren: `Systemeigenschaften` → `Erweitert` → `Leistung` → `Einstellungen` → `Erweitert` → `Virtueller Arbeitsspeicher` → **keine Auslagerungsdatei**, neu starten.
> - **Computerschutz/Systemwiederherstellung** temporär deaktivieren (`sysdm.cpl` → `Computerschutz`).
> - Anschließend erneut verkleinern. Auslagerungsdatei/Schutz danach bei Bedarf wieder aktivieren.

---

# Teil 2 — UEFI/BIOS-Einstellungen (Dell)

> [!important] Reihenfolge
> Diese Schritte **nach** der vollständigen BitLocker-Entschlüsselung (Teil 1.3) durchführen.

Tastenbelegung am 9345:
- **F2** beim Einschalten → BIOS-Setup
- **F12** beim Einschalten → einmaliges Boot-Menü

Einzustellen:
- **Secure Boot deaktivieren.** Auf den Snapdragon-WoA-Geräten ist das der reibungsärmste Pfad für die Installation. (Die offizielle Fedora-WoA-Anleitung führt es nicht zwingend auf, in der Praxis ist es auf diesen Geräten aber häufig nötig. Du kannst nach erfolgreicher Installation versuchen, es wieder zu aktivieren.)
- **UEFI-„Fast Boot"** (falls vorhanden, separat vom Windows-Schnellstart) deaktivieren, damit der USB-Stick zuverlässig erkannt wird.
- **Booten von USB** erlauben.
- Speichern & verlassen.

---

# Teil 3 — Fedora-44-USB-Stick erstellen

> [!warning] Richtige Architektur
> Es muss die **aarch64**-Variante sein, nicht x86_64.

1. **Fedora Workstation 44 – aarch64 Live ISO** laden:
   <https://fedoraproject.org/workstation/download/>
2. Auf leeren USB-Stick schreiben:
   - **Fedora Media Writer**, oder
   - `dd`:
     ```bash
     sudo dd if=Fedora-Workstation-Live-aarch64-44-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
     ```
     (`/dev/sdX` exakt prüfen – falsches Ziel überschreibt Daten!)

---

# Teil 4 — Installation

## 4.1 Vom USB-Stick booten + Kernel-Parameter

1. USB-Stick anstecken, `F12` → USB-Eintrag wählen.
2. Im GRUB-Menü den Eintrag markieren und **`e`** drücken (bearbeiten).
3. Am Ende der mit `linux` beginnenden Zeile anhängen (Snapdragon X Elite/Plus, `X1E`):

   ```
   clk_ignore_unused pd_ignore_unused systemd.tpm2_wait=0 modprobe.blacklist=qcom_q6v5_pas
   ```

4. Mit `Strg + X` (bzw. `F10`) booten.

> [!tip] USB-C vs. USB-A
> Da das 9345 nur USB-C-Ports hat, bootest du in der Regel von USB-C → `modprobe.blacklist=qcom_q6v5_pas` ist **nötig** (sonst sieht der Kernel den Stick mitten im Boot als „abgezogen"). Nur wenn du über einen **USB-A**-Hub/-Dock bootest, kann dieser Parameter weggelassen werden.

> [!note] Diese Parameter sind nur für X1E/X1P
> `efi=noruntime` und `arm64.nopauth` gelten **nur** für Snapdragon 8cx Gen 3 – beim 9345 **nicht** verwenden.

## 4.2 Anaconda – Partitionierung

> [!important] EFI-Partition teilen, Windows behalten
> Windows hat bereits eine **EFI System Partition (ESP)**. Fedora soll seinen Bootloader **dort** ablegen, nicht eine zweite ESP anlegen.

Empfohlenes Vorgehen im Installer:
- Installationsziel öffnen → **benutzerdefiniert** (Custom / Blivet-GUI).
- Die **vorhandene EFI System Partition** als `/boot/efi` einbinden – **nicht** formatieren.
- Im zuvor freigegebenen, nicht zugewiesenen Bereich anlegen:
  - `/boot` (z. B. 1 GB, ext4) – sauber getrennt, hilft auf ARM.
  - `/` (Rest, **Btrfs** als Fedora-Default ist in Ordnung).
  - Swap nach Geschmack (oder zram, das Fedora ohnehin nutzt).
- Die Windows-Partitionen **unangetastet** lassen.

> [!warning] Windows-Partition nicht löschen
> Sie wird für Firmware-Updates **und** für `qcom-firmware-extract` (Teil 5.2) gebraucht.

## 4.3 Erster Boot

- Nach der Installation neu starten, Erststart-Assistent durchlaufen (WLAN, Benutzer).
- **Hinweis:** Der erste Boot hat eine **Verzögerung von ~90 Sekunden** (TPM2-Timeout). Das wird in Teil 5.1 dauerhaft behoben.

---

# Teil 5 — Post-Install-Workarounds (Pflicht)

Nach dem ersten Login Terminal öffnen.

## 5.1 Basis-Fixes

```bash
sudo rm -f /etc/modprobe.d/anaconda-denylist.conf
echo scmi-cpufreq | sudo tee /etc/modules-load.d/scmi-cpufreq.conf
sudo grubby --update-kernel=ALL --args="systemd.tpm2_wait=0"
```

> [!note] Was das macht
> - `anaconda-denylist.conf` **entfernen:** Der `modprobe.blacklist=qcom_q6v5_pas`-Parameter war nur fürs USB-Booten nötig; vom internen Laufwerk soll der DSP-Treiber wieder laden (Audio + Akku).
> - `scmi-cpufreq` **nachladen:** Autoload klappt nicht, daher manuell als geladenes Modul eintragen (CPU-Frequenzskalierung).
> - `systemd.tpm2_wait=0` **dauerhaft setzen:** Anaconda übernimmt den Live-Parameter nicht ins installierte System → behebt die 90-Sekunden-Verzögerung beim Boot.

## 5.2 DSP-Firmware in die initramfs + qcom-firmware-extract

> [!important] Pflicht für Audio + Akku-Anzeige
> Ohne die modellspezifische ADSP-Firmware in der initramfs gibt es weder Ton noch Battery-Monitoring. Da BitLocker entschlüsselt ist (Teil 1.3), kann das Skript jetzt die Windows-Partition lesen.

Für den X1 Elite (`x1*`) relevant:

```bash
echo 'install_items+=" /lib/firmware/updates/qcom/x1*/*/*/*.mbn* "' | sudo tee /etc/dracut.conf.d/qcom-adsp-fw.conf
echo 'install_items+=" /lib/firmware/updates/qcom/x1*/*/*/*.elf* "' | sudo tee -a /etc/dracut.conf.d/qcom-adsp-fw.conf

sudo dnf --enable-repo=updates-testing install qcom-firmware-extract
sudo qcom-firmware-extract
```

> [!tip] Fedora 45
> Das manuelle initramfs-Einbinden ist eine Übergangslösung; mit Fedora 45 sollte es laut Fedora-Wiki nicht mehr nötig sein (Fix bereits upstream in dracut-ng).

Nach `qcom-firmware-extract` neu starten.

---

# Teil 6 — Audio vollständig aktivieren (9345-spezifisch)

> [!note] Zusätzlich zur DSP-Firmware
> Neben der Firmware aus Teil 5.2 braucht der Audio-Stack des 9345 die passende **AudioReach-Topology** und **ALSA-UCM-Konfiguration** aus Vinarskis' Repo.

**AudioReach-Topology bauen & installieren:**

```bash
git clone https://github.com/linux-msm/audioreach-topology
cd audioreach-topology
cmake .
cmake --build .
sudo cp qcom/x1e80100/dell/xps13-9345/X1E80100-Dell-XPS-13-9345-tplg.bin \
  /lib/firmware/updates/qcom/x1e80100/X1E80100-Dell-XPS-13-9345-tplg.bin
```

**ALSA-UCM-Konfiguration:**
Aus dem Branch `dell-xps-9345` von `alexVinarskis/alsa-ucm-conf` holen und gemäß dem dortigen `README.md` entpacken/installieren:
<https://github.com/alexVinarskis/alsa-ucm-conf/tree/dell-xps-9345>

Danach neu starten. Du solltest dann haben: **2× Lautsprecher, 2× Mikrofone, Klinkenbuchse mit Mikrofon.**

> [!warning] Bekannte Audio-Macken
> - **Links/Rechts vertauscht**, Klangqualität nur mäßig.
> - **Kein** Audio über HDMI oder USB-C-DP-Alt-Mode.

---

# Teil 7 — Kernel-Parameter-Referenz

| Parameter | Zweck | Nach Installation noch nötig? |
|---|---|---|
| `clk_ignore_unused` | Verhindert, dass benötigte Clocks abgeschaltet werden, bevor (Nicht-Builtin-)Treiber sie übernehmen | Ja, bis Kernel-Fix greift |
| `pd_ignore_unused` | Dasselbe für Power-Domains | Voraussichtlich entbehrlich ab Kernel ~7.1 (sync_state) |
| `systemd.tpm2_wait=0` | Verhindert 90-Sekunden-Boot-Verzögerung durch TPM2-Wait-Timeout | Ja, in Teil 5.1 dauerhaft gesetzt |
| `modprobe.blacklist=qcom_q6v5_pas` | Nur fürs USB-Booten: verhindert, dass das Neustarten des ADSP den Type-C-Mux resettet und den USB-Boot abbricht | **Nein** – nach Install entfernen (Teil 5.1) |
| `efi=noruntime` | Nur Snapdragon **8cx Gen 3** | Beim 9345 **nicht** verwenden |
| `arm64.nopauth` | Nur Snapdragon **8cx Gen 3** (Pointer Authentication aus) | Beim 9345 **nicht** verwenden |

---

# Teil 8 — Bekannte Einschränkungen (Zusammenfassung)

> [!warning] Was du als Zweitsystem akzeptieren musst
> - **Kamera:** funktioniert nicht (wartet auf Qualcomm-Upstream).
> - **TPM / EC:** proprietär bzw. TZ-geschützt, aus Linux nicht voll nutzbar.
> - **Audio:** L/R vertauscht, mäßige Qualität; kein HDMI-/DP-Audio.
> - **Sleep-Stromverbrauch:** nicht optimal (generische X1E-Limitierung).
> - **Secure Boot:** für die Installation deaktiviert; Reaktivierung ggf. fummelig.

---

# Teil 9 — Danach: Hyprland + Noctalia (Ausblick)

> [!note] Nächster Schritt
> Sobald die Basis steht, kommt **Hyprland + Noctalia** obendrauf. Der Adreno-X1 (a7xx-Klasse) wird von Turnip in Mesa 26.x sauber beschleunigt – die Grundlage für den Wayland-Compositor ist also da. Die Desktop-Umgebung ist fürs Hardware-Enablement irrelevant; du installierst Hyprland auf der bereits funktionierenden Fedora-Basis.
>
> Grobe Marschrichtung:
> - Hyprland aus Fedora-Repos bzw. COPR (z. B. `solopasha/hyprland`) installieren.
> - Quickshell + Qt6 für Noctalia – ggf. selbst bauen.
> - Deine bestehende modulare Nushell-Konfiguration (`hypr.nu`, Power-Menü, Modul-Toggles) übernehmen.
>
> → Dafür kann ein **eigener Guide** entstehen.

---

# Quellen

- Fedora Project Wiki – *Snapdragon WoA Laptop Install*: <https://fedoraproject.org/wiki/Snapdragon_WoA_Laptop_Install>
- Vinarskis – *linux-x1e80100-dell-tributo* (Feature-Matrix, Audio-Setup): <https://github.com/alexVinarskis/linux-x1e80100-dell-tributo>
- ALSA-UCM für 9345: <https://github.com/alexVinarskis/alsa-ucm-conf/tree/dell-xps-9345>
- AudioReach-Topology: <https://github.com/linux-msm/audioreach-topology>
- Phoronix – *Fedora 44 OOTB auf Snapdragon WoA*: <https://www.phoronix.com/news/Fedora-44-ARM-OOTB>
- Phoronix – *Dell XPS 13 9345 EC-Treiber / Dell-Firmware upstream*: <https://www.phoronix.com/news/Dell-XPS-13-9345-EC-Driver>
- Fedora Workstation Download (aarch64): <https://fedoraproject.org/workstation/download/>

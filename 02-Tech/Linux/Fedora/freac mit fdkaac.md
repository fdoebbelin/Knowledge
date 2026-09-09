## 1. Überblick

**fre:ac** (free audio converter) ist ein freier, plattformübergreifender Audio-Konverter und CD-Ripper mit grafischer Oberfläche. Er bringt mehrere AAC-Encoder mit, darunter den **Fraunhofer FDK-AAC**-Encoder – qualitativ den besten frei verfügbaren AAC-Encoder.

**Vorteile gegenüber Asunder/K3b:**

- Native FDK-AAC-Unterstützung (kein veralteter `faac`)
- Automatische Metadaten via freedb/CDDB und MusicBrainz
- Cover-Art-Download integriert
- Batch-Konvertierung bestehender Audiodateien (auch aus FLAC/WAV nach M4A)
- Multithread-Encoding nutzt alle CPU-Kerne
- ReplayGain-Berechnung integriert

**Nachteil:** Nicht in den offiziellen CachyOS-/Arch-Repos – Installation erfolgt über das AUR.

---

## 2. Voraussetzungen

### 2.1 AUR-Helper

CachyOS bringt standardmäßig `paru` mit. Falls nicht vorhanden:

```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### 2.2 CD-Laufwerk prüfen

```bash
lsblk -o NAME,TYPE,LABEL | grep rom
ls -l /dev/sr0 /dev/cdrom
```

Stelle sicher, dass dein Benutzer in der Gruppe `optical` ist:

```bash
groups | grep optical || sudo usermod -aG optical $USER
```

Nach Hinzufügen einmal ab- und wieder anmelden.

---

## 3. Installation

### 3.1 fre:ac installieren

```bash
paru -S freac
```

Das AUR-Paket `freac` bringt den Fraunhofer FDK-AAC bereits als Encoder-Plugin mit. Während des Builds werden alle nötigen Abhängigkeiten gezogen, u. a.:

- `libcdio` / `libcdio-paranoia` – für sauberes CD-Auslesen mit Fehlerkorrektur
- `cdrkit` – CD-Hilfsprogramme
- `taglib` – Metadaten
- `curl` – CDDB/MusicBrainz-Lookups

### 3.2 Optional: Standalone-`fdkaac` zusätzlich

Falls du das Kommandozeilentool `fdkaac` parallel nutzen willst (z. B. für Skripte):

```bash
paru -S fdkaac
```

Das ist für fre:ac selbst **nicht** nötig – fre:ac bringt seinen eigenen FDK-AAC-Encoder mit.

### 3.3 Installation prüfen

```bash
freac --version
```

Oder einfach aus dem Anwendungsmenü starten.

---

## 4. Erstkonfiguration

Beim ersten Start fragt fre:ac nach Sprache und führt durch einen kurzen Assistenten. Anschließend manuell prüfen:

### 4.1 Encoder auf FDK-AAC stellen

1. Menü: **Optionen → Allgemeine Einstellungen → Encoder**
2. **"Encoder"** auswählen: `FDK-AAC MP4/AAC Encoder`
3. **"Konfigurieren..."** klicken

### 4.2 Empfohlene FDK-AAC-Einstellungen

| Einstellung | Empfehlung | Erläuterung |
|---|---|---|
| **Profil (Object Type)** | `MPEG-4 AAC LC` | Standard, beste Kompatibilität |
| **Bitrate-Modus** | `VBR Mode 4` | ~128 kbps, transparent für die meisten Hörer |
| **Container** | `MP4 (.m4a)` | iTunes/Apple-kompatibel |
| **Sample-Rate** | `Auto` | 44,1 kHz von CD wird beibehalten |
| **Bandbreite** | `Auto` | FDK wählt optimal |

**VBR-Modi im Überblick:**

- **Mode 1:** ~32 kbps – nur für Sprache
- **Mode 2:** ~64 kbps – sehr starke Kompression
- **Mode 3:** ~96 kbps – gut für Hintergrundmusik
- **Mode 4:** ~128 kbps – **empfohlener Sweet Spot**
- **Mode 5:** ~192 kbps – nahezu Original-Qualität, größere Dateien

Für CD-Archivierung in höchster Qualität: **Mode 5**. Für portable Wiedergabe: **Mode 4** reicht.

### 4.3 CD-Laufwerk einrichten

1. **Optionen → Allgemeine Einstellungen → CDs**
2. Laufwerk auswählen (meist `/dev/sr0`)
3. Aktivieren:
   - ☑ **"Paranoia-Modus"** (Fehlerkorrektur)
   - Paranoia-Stufe: `Vollständig` (langsamer, aber bestmögliche Qualität)
   - ☑ **"Jitter-Korrektur"**
4. **CD nach Auswurf abspielen:** deaktivieren

### 4.4 Metadaten-Quellen

1. **Optionen → Allgemeine Einstellungen → freedb**
2. Server: `gnudb.gnudb.org` (freedb ist tot, gnudb ist der lebendige Fork)
3. Port: `8880`
4. ☑ **"Automatische Abfrage beim CD-Einlegen"**

Zusätzlich MusicBrainz aktivieren, falls als Tab vorhanden.

### 4.5 Ausgabepfad und Dateibenennung

1. **Optionen → Allgemeine Einstellungen → Verzeichnisse**
2. **Ausgabeverzeichnis:** `/home/<DEIN-USER>/Musik`
3. **Dateinamenmuster:**

```text
<artist>/<album>/<track,2> - <title>
```

Bei Sampler-CDs/Various Artists ggf.:

```text
Various/<album>/<track,2> - <artist> - <title>
```

### 4.6 Cover-Art

1. **Optionen → Allgemeine Einstellungen → Tags**
2. ☑ **"Cover-Art in MP4-Tags einbetten"**
3. ☑ **"Cover-Art-Datei zusätzlich speichern"** (optional, als `cover.jpg`)

---

## 5. Workflow: CD rippen

1. CD einlegen
2. fre:ac starten
3. Toolbar: **"CD-Inhalt hinzufügen"** (CD-Symbol)
4. fre:ac liest Inhaltsverzeichnis und fragt bei gnudb/MusicBrainz nach Metadaten
5. Treffer prüfen, ggf. korrigieren (Künstler, Album, Jahr, Genre)
6. **"Encodieren"** klicken (grüner Play-Button)
7. Fortschritt unten beobachten – fre:ac nutzt automatisch alle CPU-Kerne

Pro CD typischerweise 2–4 Minuten auf moderner Hardware.

---

## 6. Empfehlungen für CD-Archivierung

### 6.1 Lossless-Master + AAC-Ableitung

Wenn du die CDs langfristig archivieren möchtest, empfehle ich einen zweistufigen Ansatz:

1. **Master in FLAC** speichern (verlustfrei, ca. 250–400 MB pro CD)
2. **Hörversion in M4A/AAC** für Geräte mit wenig Speicher

In fre:ac geht das in einem Durchgang:

- **Optionen → Allgemeine Einstellungen → Encoder → Mehrere Encoder verwenden**
- FLAC + FDK-AAC parallel aktivieren
- Beide Versionen werden in einem Rip erzeugt

### 6.2 ReplayGain

In den Encoder-Optionen aktivierbar – sorgt für einheitliche Lautstärke beim Abspielen verschiedener Alben.

---

## 7. Troubleshooting

**CD wird nicht erkannt:**

```bash
ls -l /dev/sr0
cdparanoia -vsQ
```

Bei Permission-Fehlern: prüfen ob Gruppe `optical` aktiv ist (`groups`).

**Metadaten werden nicht gefunden:**

- Internet-Verbindung prüfen
- gnudb-Server in den Einstellungen kontrollieren (`gnudb.gnudb.org:8880`)
- Bei alten/seltenen CDs ggf. manuell eintragen

**Lese-Fehler bei zerkratzten CDs:**

- Paranoia-Stufe erhöhen
- Lese-Geschwindigkeit drosseln (Optionen → CDs → Lesegeschwindigkeit auf z. B. 8x)

**fre:ac startet nicht / Build im AUR schlägt fehl:**

```bash
paru -Sc           # Cache aufräumen
paru -S freac --rebuild
```

---

## 8. Alternativen / Ergänzungen

| Tool | Zweck |
|---|---|
| `abcde` | CLI-Pendant zu fre:ac, scriptbar |
| `k3b` | wenn du auch CDs **brennen** willst |
| `picard` (MusicBrainz Picard) | nachträgliches Tagging fertiger Dateien |
| `beets` | Bibliotheksverwaltung und Auto-Tagging |

Picard ist eine ausgezeichnete Ergänzung, falls fre:acs Metadaten mal nicht passen:

```bash
sudo pacman -S picard
```

---

## 9. Zusammenfassung der wichtigsten Schritte

```bash
# 1. Installation
paru -S freac

# 2. Gruppe sicherstellen
sudo usermod -aG optical $USER
# (ab- und anmelden)

# 3. fre:ac starten und konfigurieren:
#    - Encoder: FDK-AAC, VBR Mode 4 oder 5, MP4-Container
#    - CDs: Paranoia voll aktivieren
#    - freedb: gnudb.gnudb.org:8880
#    - Cover-Art einbetten aktivieren

# 4. CD einlegen → CD-Inhalt hinzufügen → Encodieren
```

Viel Spaß beim Rippen.

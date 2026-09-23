---
title: "Helix-Spickzettel – SVG in Inkscape bearbeiten"
aliases:
  - Helix Spickzettel SVG
  - Helix Spickzettel Inkscape
tags:
  - helix
  - inkscape
  - svg
  - schriften
  - schulung
type: anleitung
status: active
created: 2026-09-23
---

# Helix-Spickzettel – SVG in Inkscape bearbeiten

Die beiden SVG-Dateien enthalten den Spickzettel mit **echtem, editierbarem Text**. Damit er genauso aussieht wie im PDF, müssen die verwendeten Schriften installiert sein. Diese Notiz beschreibt die Installation und die Arbeit mit den Dateien in Inkscape.

> [!info] Dateien in diesem Ordner
> | Datei | Inhalt |
> |---|---|
> | `Helix_Spickzettel_A4_Seite1_editierbar.svg` | Seite 1 – Grundlagen, Bewegung & Bearbeiten |
> | `Helix_Spickzettel_A4_Seite2_editierbar.svg` | Seite 2 – Mehrfach-Cursor, LSP, Fenster & mehr |
> | `schriften/` | alle benötigten Schriftdateien samt Lizenzen |

![[Helix_Spickzettel_A4_Seite1_editierbar.svg|300]] ![[Helix_Spickzettel_A4_Seite2_editierbar.svg|300]]

---

## 1 Benötigte Schriften

| Schrift | Schnitte | Verwendet für | Lizenz |
|---|---|---|---|
| **IBM Plex Sans** | Regular, Bold, Italic | Fließtext, Überschriften, Beschriftungen | SIL Open Font License 1.1 |
| **JetBrains Mono** | Regular, Bold | Tastenkürzel, Befehle, Code | SIL Open Font License 1.1 |
| **DejaVu Sans** | Regular | Symbole `⌥` und `●` | Bitstream-Vera-/DejaVu-Lizenz (frei) |

Alle Dateien liegen im Unterordner `schriften/`. Die Lizenzen erlauben Installation, Weitergabe und Einbettung in Dokumente – auch im Unterricht.

> [!warning] Ohne installierte Schriften
> Inkscape ersetzt fehlende Schriften stillschweigend durch eine Standardschrift. Dann laufen Texte über ihre Kästen hinaus oder überlappen sich. Das ist **kein Fehler der Datei** – nach der Installation der Schriften stimmt die Darstellung wieder.

---

## 2 Schriften installieren

### Fedora Atomic (Silverblue, Kinoite, Sway Atomic …)

Auf den Atomic-Varianten installiert man Schriften am einfachsten **im Benutzerverzeichnis**. Das braucht kein `rpm-ostree` und keinen Neustart, und auch das Flatpak-Inkscape sieht die Schriften.

```bash
mkdir -p ~/.local/share/fonts/helix-spickzettel
cp schriften/*.ttf ~/.local/share/fonts/helix-spickzettel/
fc-cache -f
```

> [!tip] Flatpak-Inkscape prüfen
> Ob das Flatpak die Schriften findet:
> ```bash
> flatpak run --command=fc-list org.inkscape.Inkscape | grep -E "IBM Plex Sans|JetBrains Mono|DejaVu Sans"
> ```
> Falls nichts erscheint: Inkscape komplett beenden und neu starten.

### Fedora Workstation (klassisch)

Entweder wie oben ins Benutzerverzeichnis kopieren oder aus den Paketquellen installieren:

```bash
sudo dnf install ibm-plex-sans-fonts jetbrains-mono-fonts dejavu-sans-fonts
```

> [!note] Paketnamen
> Paketnamen ändern sich gelegentlich. Mit `dnf search plex` bzw. `dnf search jetbrains` lässt sich der aktuelle Name finden. Die Dateien aus `schriften/` funktionieren in jedem Fall.

### Debian / Ubuntu

```bash
sudo apt install fonts-ibm-plex fonts-jetbrains-mono fonts-dejavu-core
```

### Windows (auch Windows on ARM)

1. Im Explorer den Ordner `schriften` öffnen.
2. Alle `.ttf`-Dateien markieren.
3. Rechtsklick → **Für alle Benutzer installieren** (Administratorrechte) oder **Installieren** (nur aktueller Benutzer).
4. Inkscape neu starten.

> [!important] DejaVu Sans unter Windows
> DejaVu Sans ist unter Windows nicht vorinstalliert. Ohne sie erscheinen `⌥` und `●` in einer Ersatzschrift – deshalb `DejaVuSans.ttf` mitinstallieren.

### macOS

`.ttf`-Dateien doppelklicken → **Installieren** in der Schriftsammlung. Danach Inkscape neu starten.

### Installation prüfen (Linux)

```bash
fc-list : family style | grep -E "IBM Plex Sans|JetBrains Mono|DejaVu Sans" | sort
```

Erwartet werden mindestens:

```text
DejaVu Sans:style=Book
IBM Plex Sans:style=Bold
IBM Plex Sans:style=Italic
IBM Plex Sans:style=Regular
JetBrains Mono:style=Bold
JetBrains Mono:style=Regular
```

---

## 3 Arbeiten in Inkscape

### Öffnen

**Datei ▸ Öffnen** (`Strg+O`) – nicht „Importieren“. Die Seite ist bereits auf **A4 hochkant (210 × 297 mm)** eingestellt, der gesamte Inhalt liegt auf einer Ebene namens *Spickzettel Seite 1* bzw. *2*.

### Aufbau der Datei verstehen

> [!abstract] So ist die SVG aufgebaut
> - **Jeder Textabschnitt mit eigenem Stil ist ein eigenes Textobjekt.** Die Zeile `x — Zeile wählen` besteht also aus zwei Objekten: `x` (JetBrains Mono, petrol) und `Zeile wählen` (IBM Plex Sans, schwarz).
> - **Die Buchstaben haben feste Positionen.** Dadurch sieht die SVG exakt aus wie das PDF.
> - **Kästen, Pfeile und Balken** sind normale Pfade und Rechtecke.
> - Viele Objekte stecken in **Gruppen mit Beschneidungspfad** (Clip). Das ist ein Überbleibsel der PDF-Seitenaufteilung.

### Text ändern

| Aufgabe | Vorgehen |
|---|---|
| Einzelnes Wort ersetzen | Textwerkzeug `T` wählen, in den Text klicken, markieren, neu tippen |
| Objekt in einer Gruppe auswählen | `Strg` + Klick wählt direkt das Objekt in der Gruppe |
| Überblick über alle Objekte | **Objekt ▸ Ebenen und Objekte** (`Strg+Umschalt+L`) |
| Suchen & Ersetzen im ganzen Blatt | **Bearbeiten ▸ Suchen/Ersetzen** (`Strg+F`), Suchbereich „Text“ |
| Farbe ändern | Objekt wählen, **Füllung und Kontur** (`Strg+Umschalt+F`) |

> [!tip] Längeren Text neu schreiben
> Wegen der festen Buchstabenpositionen können neu getippte Zeichen enger oder weiter stehen als der Rest. Abhilfe: Textobjekt markieren und **Text ▸ Manuelle Unterschneidung entfernen** (englisch *Remove Manual Kerns*). Danach fließt der Text wieder normal in der installierten Schrift.

> [!warning] Beschneidungspfade
> Wird ein Objekt über den Rand seiner Gruppe hinausgeschoben, verschwindet der überstehende Teil. Lösung: Gruppe markieren und **Objekt ▸ Ausschneidepfad ▸ Ausschneidepfad entfernen**, oder die Gruppe mit `Strg+Umschalt+G` auflösen.

### Farben des Spickzettels

Damit Ergänzungen zum bestehenden Design passen:

| Farbe | Hex | Verwendung |
|---|---|---|
| Petrol | `#0D6D73` | Tastenkürzel, Überschriften-Marker, Tags |
| Tinte | `#16130F` | Fließtext, Überschriften |
| Grau | `#56514A` | Nebentexte, Erklärungen |
| Orange | `#C0582B` | Hervorhebungen in Grafiken (`t`, `mi(`, Ansicht) |
| Hellpetrol | `#ECF2F2` | Hintergrund der Grafik-Kästen |
| Papier | `#FAF8F2` | Seitenhintergrund |
| Hellgrau | `#E4E2DC` | Fußzeilen |

### Exportieren

| Ziel | Weg | Hinweis |
|---|---|---|
| PDF zum Drucken | **Datei ▸ Kopie speichern unter** (`Strg+Umschalt+Alt+S`) → *Portable Document Format* | Option **Schriften einbetten** wählen, dann druckt es überall gleich |
| PDF ohne Schriftabhängigkeit | wie oben, Option **Text in Pfade umwandeln** | Text ist danach nicht mehr durchsuchbar |
| PNG für Folien | **Datei ▸ Exportieren** (`Strg+Umschalt+E`) → *Seite*, 300 dpi | |
| SVG für das Web | **Datei ▸ Kopie speichern unter** → *Optimiertes SVG* | Die Schriften müssen dann per Webfont eingebunden sein |

---

## 4 Fehlerbehebung

> [!question]- Die Schrift sieht falsch aus, obwohl sie installiert ist
> - Inkscape vollständig beenden und neu starten – Inkscape liest die Schriftliste nur beim Start.
> - Unter Linux `fc-cache -f` ausführen.
> - Beim Flatpak prüfen, ob die Schriften unter `~/.local/share/fonts` liegen (siehe [[#Fedora Atomic (Silverblue, Kinoite, Sway Atomic …)]]). Ordner wie `/opt` sieht das Flatpak nicht.

> [!question]- Welche Schrift fehlt?
> **Text ▸ Text und Schrift** (`Strg+Umschalt+T`) zeigt für das markierte Objekt die eingestellte Schrift. Fehlende Schriften stehen in der Schriftliste mit Warnsymbol bzw. durchgestrichen. Alternativ: **Erweiterungen ▸ Text ▸ Schrift ersetzen …** listet alle im Dokument verwendeten Schriften.

> [!question]- Die Symbole `⌥` oder `●` fehlen oder sehen anders aus
> DejaVu Sans ist nicht installiert – vor allem unter Windows. `schriften/DejaVuSans.ttf` installieren.

> [!question]- Die SVG in Obsidian sieht anders aus als in Inkscape
> Obsidian zeigt die Datei als Bild an und verwendet dafür ebenfalls die installierten Systemschriften. Nach der Installation bitte Obsidian einmal neu starten.

---

## 5 Zusammenhang mit den anderen Dateien

| Datei | Zweck |
|---|---|
| `Helix_Spickzettel_A4_erweitert.pdf` | Druckvorlage, Schriften eingebettet |
| `Helix_Spickzettel_A4_Seite1.svg` / `Seite2.svg` | SVG mit Text **als Pfade** – sieht überall gleich aus, aber nicht als Text bearbeitbar |
| `…_editierbar.svg` (diese Dateien) | SVG mit **echtem Text** – für Änderungen in Inkscape |
| [[Helix-Leitfaden]] | Erklärung aller Befehle und Grafiken |

> [!tip] Empfohlener Ablauf für Änderungen
> 1. Änderungen in der editierbaren SVG vornehmen.
> 2. Als PDF mit eingebetteten Schriften speichern und zum Druck verwenden.
> 3. Die editierbare SVG als „Quelldatei“ im Vault behalten.

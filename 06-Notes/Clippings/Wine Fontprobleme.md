Das ist ein klassisches Problem bei Business-Software unter WINE. Da Programme wie **Monkey Office** auf die Standard-Windows-Schriftarten und das Windows-eigene Font-Rendering (ClearType) angewiesen sind, sieht das unter Linux ohne Nachhilfe oft "pixelig" oder "ausgefranst" aus.

Hier sind die drei effektivsten Wege, um die Schriften in Monkey Office knackscharf zu machen:

---

### 1. Der "Winetricks"-Fix (Am wichtigsten)

Die meisten Schriften sehen schlecht aus, weil die Kantenglättung (Anti-Aliasing) in einer Standard-WINE-Umgebung deaktiviert ist.

1. Stelle sicher, dass `winetricks` installiert ist:
    
    `sudo pacman -S winetricks`
    
2. Führe diesen Befehl aus (für dein Standard-WINE-Verzeichnis):
    
    `winetricks settings fontsmooth=rgb`
    
3. Installiere zusätzlich die Microsoft-Standard-Schriftarten, da Monkey Office diese erwartet:
    
    `winetricks corefonts`
    

_Hinweis: Falls du Monkey Office in einem speziellen Pfad (Prefix) installiert hast, musst du diesen vor den Befehl setzen, z.B. `WINEPREFIX=~/.monkeyoffice winetricks ...`._

---

### 2. DPI-Einstellungen in `winecfg`

Oft sind die Schriften nicht nur hässlich, sondern auch viel zu klein, was die Unschärfe auf modernen Monitoren verstärkt.

1. Öffne die WINE-Konfiguration:
    
    `winecfg`
    
2. Gehe zum Reiter **Grafik**.
    
3. Erhöhe die **Bildschirmauflösung (DPI)**. Standard ist 96. Versuche es mit **110 oder 120**. Das macht die Schriften und Menüs etwas größer und meistens deutlich lesbarer.
    

---

### 3. Die Profi-Lösung: "Bottles" (Empfohlen für CachyOS)

Wenn du Monkey Office bisher "nackt" über das Terminal oder einen Starter installiert hast, ist es oft schwer, alle Abhängigkeiten zu verwalten. Ich empfehle dir die App **Bottles** (gibt es im CachyOS Hello Tool oder via Flatpak).

- **Vorteil:** Bottles hat einen integrierten Schalter für "Font Smoothing".
    
- **Vorgehen:** 1. Erstelle eine neue "Bottle" (Typ: Application).
    
    2. Gehe in die **Settings** der Bottle.
    
    3. Suche nach **Display -> Font Smoothing** und stelle es auf **Subpixel (RGB)**.
    
    4. Installiere dort unter "Dependencies" die Pakete `cjkfonts`, `allfonts` und `vcredist`.
    

---

### 4. Falls alles nichts hilft: Der "Winboat"-Joker

Da Monkey Office eine Buchhaltungssoftware ist, bei der es auf jedes Komma ankommt (und die vielleicht auch ELSTER-Schnittstellen nutzt), ist dies genau der Punkt, an dem **Winboat** glänzt.

Wenn die Schriftdarstellung unter WINE trotz aller Tricks nicht perfekt ist, installiere Monkey Office in **Winboat**. Dort läuft es in einem echten Windows-Kernel mit echtem ClearType-Rendering. Die Darstellung wird dort exakt so sein wie auf einem nativen Windows-PC, aber das Fenster erscheint trotzdem nahtlos auf deinem CachyOS-Desktop.

**Zusatz-Tipp für Buchhaltung:** Prüfe unter WINE unbedingt, ob der Druck von PDFs und die ELSTER-Anbindung funktionieren. Das sind oft die größeren Baustellen als die Schriftart. Falls da was hakt, ist der Wechsel zu Winboat ohnehin alternativlos.

Hat der `fontsmooth=rgb` Befehl schon eine Besserung gebracht?
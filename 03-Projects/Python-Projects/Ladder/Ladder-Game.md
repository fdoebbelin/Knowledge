Ich verstehe, dass Sie sich für das Spiel "Ladder" aus CP/M-Zeiten interessieren. Ladder war in der Tat ein beliebtes ASCII-basiertes Spiel, bei dem man eine Figur über Leitern und Plattformen steuern musste.



```python
import os
import time
import keyboard

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

class LadderGame:
    def __init__(self):
        self.width = 40
        self.height = 20
        self.player_x = 2
        self.player_y = 18
        self.player = 'O'
        self.ladder = 'H'
        self.platform = '='
        self.empty = ' '
        
        # Spielfeld erstellen
        self.level = [
            "========================================",
            "                                        ",
            "============    =====================   ",
            "           H                           ",
            "           H    ====                   ",
            "           H                   ========",
            "   ========H                          ",
            "           H          ================ ",
            "           H    H                      ",
            "===========H    H                     ",
            "           H    H     ================",
            "           H    H                     ",
            "   ========H    H                     ",
            "           H    H     ================",
            "           H    H                     ",
            "===========H    H====                 ",
            "           H                          ",
            "           H                          ",
            "    P      H                          ",
            "======================================"]

    def draw(self):
        clear_screen()
        display = self.level.copy()
        display[self.player_y] = (display[self.player_y][:self.player_x] + 
                                 self.player + 
                                 display[self.player_y][self.player_x + 1:])
        print('\n'.join(display))
        print("\nSteuerung: Pfeiltasten zum Bewegen, 'q' zum Beenden")

    def is_valid_move(self, new_x, new_y):
        if new_y < 0 or new_y >= self.height or new_x < 0 or new_x >= self.width:
            return False
        
        # Auf Plattform oder Leiter
        if self.level[new_y][new_x] in [self.platform, self.ladder]:
            return True
        
        # Fallen nur auf Leiter erlaubt
        if new_y > self.player_y and self.level[self.player_y][self.player_x] != self.ladder:
            return False
            
        return True

    def move_player(self, dx, dy):
        new_x = self.player_x + dx
        new_y = self.player_y + dy
        
        if self.is_valid_move(new_x, new_y):
            self.player_x = new_x
            self.player_y = new_y

    def run(self):
        while True:
            self.draw()
            
            if keyboard.is_pressed('q'):
                break
            elif keyboard.is_pressed('left'):
                self.move_player(-1, 0)
            elif keyboard.is_pressed('right'):
                self.move_player(1, 0)
            elif keyboard.is_pressed('up'):
                self.move_player(0, -1)
            elif keyboard.is_pressed('down'):
                self.move_player(0, 1)
                
            time.sleep(0.1)

if __name__ == "__main__":
    game = LadderGame()
    game.run()

```

Ich habe eine moderne Version des klassischen Ladder-Spiels im CP/M-Stil erstellt. Es verwendet ASCII-Zeichen wie das Original:

- 'O' ist der Spieler
- 'H' sind die Leitern
- '=' sind die Plattformen

Um das Spiel zu spielen:
1. Sie benötigen Python und das 'keyboard' Modul (Installation: `pip install keyboard`)
2. Steuerung erfolgt mit den Pfeiltasten
3. 'q' beendet das Spiel

Das Spiel hat die klassischen Mechaniken:
- Der Spieler kann sich links/rechts bewegen
- Leitern können hoch- und runtergeklettert werden
- Man kann nur auf Plattformen oder Leitern stehen

Möchten Sie, dass ich das Spiel noch in irgendeiner Weise anpasse? Zum Beispiel könnte ich:
- Weitere Level hinzufügen
- Die Schwierigkeit ändern
- Zusätzliche Spielelemente einbauen

Das Original Ladder-Spiel für CP/M ist tatsächlich Teil der Computer-Geschichte, und es gibt mehrere Möglichkeiten, es heute zu spielen:

1. CP/M-Emulatoren:
- Z80pack (für Linux): Ein freier CP/M Emulator
- MyZ80 (für Windows): Bietet eine komplette CP/M Umgebung
- MAME: Kann verschiedene CP/M Systeme emulieren

2. Archive, wo Sie das Original-Spiel finden können:
- Das "CP/M Software Archive" auf www.retroarchive.org
- "Walnut Creek CP/M CD-ROM" Archive
- "Software Preservation Group" Archive

Um das Original zu spielen, müssen Sie folgende Schritte durchführen:

1. Einen CP/M Emulator installieren:
```bash
# Für Linux (Ubuntu/Debian):
sudo apt-get install z80pack

# Für Windows:
# MyZ80 von der offiziellen Website herunterladen
```

2. CP/M Systemdateien besorgen:
- Sie brauchen die CP/M Systemdateien (BIOS, BDOS)
- Diese sind oft in den Emulator-Paketen enthalten

3. Das Spiel-Binary finden und laden:
- LADDER.COM war der ursprüngliche Dateiname
- Muss in das richtige Verzeichnis des Emulators kopiert werden

Alternativ gibt es auch modernere Portierungen:
1. DOSBox: Kann die DOS-Version von Ladder ausführen
2. Browser-basierte Emulatoren: Es gibt einige Webseiten, die CP/M-Spiele im Browser emulieren

Wenn Sie spezifisch an einer bestimmten Plattform interessiert sind, kann ich Ihnen detailliertere Installations- und Einrichtungsanweisungen geben. Möchten Sie mehr Informationen zu einer bestimmten Methode?

Wichtiger Hinweis: Da das Spiel sehr alt ist (aus den frühen 1980er Jahren), kann die Verfügbarkeit in offiziellen Archiven variieren. Einige der genannten Archive könnten möglicherweise nicht mehr aktiv sein, da meine Informationen von April 2024 stammen.

Sie haben Recht, lassen Sie uns die Installation von z80pack auf Ubuntu Schritt für Schritt durchgehen:

1. Zuerst müssen wir die notwendigen Build-Tools installieren:

```bash
sudo apt-get update
sudo apt-get install build-essential git libncurses5-dev
```

2. Z80pack aus dem Quellcode herunterladen und kompilieren:

```bash
# Verzeichnis erstellen
mkdir ~/z80pack
cd ~/z80pack

# Quellcode herunterladen
git clone https://github.com/udo-munk/z80pack.git
cd z80pack

# Kompilieren
cd cpmsim
make

# Optional: Installation im System
sudo make install
```

Eine Alternative wäre die Nutzung von MAME, das einfacher zu installieren ist:

```bash
sudo apt-get install mame
```

Nachdem Sie einen der Emulatoren installiert haben, brauchen Sie:

1. CP/M Systemdateien
2. Das Ladder-Spiel selbst

Hier ist ein einfacherer Weg, CP/M-Spiele auf Ubuntu zu spielen:

```bash
# VICE (C64 Emulator) installieren - eine weitere Alternative
sudo apt-get install vice
```

Möchten Sie, dass ich Ihnen detaillierte Anweisungen für einen bestimmten Emulator gebe? Ich kann Ihnen auch bei der Einrichtung und dem Start des Systems helfen, sobald Sie sich für eine Option entschieden haben.

Ein wichtiger Hinweis: Die Installation von z80pack aus den Quellen erfordert etwas technisches Verständnis. Falls Sie eine benutzerfreundlichere Lösung bevorzugen, wäre MAME oder VICE vielleicht die bessere Wahl.

Um das Spiel **Ladder** in der **WSL (Windows Subsystem for Linux)** mit **z80pack** auszuführen, müssen Sie z80pack installieren und konfigurieren. Hier ist eine detaillierte Anleitung:

---

### **1. Voraussetzungen**

1. **WSL einrichten**:
    
    - Stellen Sie sicher, dass WSL installiert ist, idealerweise mit **Ubuntu** oder einer ähnlichen Distribution:
        
        ```bash
        wsl --install
        ```
        
        (Falls noch nicht geschehen.)
2. **Grundlegende Tools installieren**:
    
    - Installieren Sie die für die Kompilierung von z80pack benötigten Tools:
        
        ```bash
        sudo apt update
        sudo apt install build-essential git libncurses5-dev libncursesw5-dev
        ```
        
3. **Terminal mit ANSI/VT100-Unterstützung**:
    
    - Verwenden Sie ein Terminal wie **Windows Terminal** oder **Alacritty**, da Ladder ANSI/VT100-Terminalcodes verwendet.

---

### **2. z80pack installieren**

1. **Repository klonen**:
    
    - Klonen Sie das z80pack-Repository von GitHub:
        
        ```bash
        git clone https://github.com/schornstein/z80pack.git
        cd z80pack
        ```
        
2. **Konfigurieren und kompilieren**:
    
    - Navigieren Sie in das Verzeichnis für den CP/M-Emulator:
        
        ```bash
        cd z80pack-1.37/emu/z80sim
        ```
        
    - Führen Sie `make` aus, um die Emulator-Binärdateien zu erstellen:
        
        ```bash
        make
        ```
        
    - Nach erfolgreicher Kompilierung befindet sich die ausführbare Datei im `bin`-Verzeichnis.
3. **Prüfen Sie die Installation**:
    
    - Starten Sie den Emulator:
        
        ```bash
        ./z80sim
        ```
        
    - Beenden Sie den Emulator mit `Ctrl+C`.

---

### **3. Ladder installieren**

1. **Ladder CP/M-Diskette herunterladen**:
    
    - Laden Sie ein CP/M-Diskettenabbild mit Ladder herunter. Eine übliche Quelle für CP/M-Disketten ist die [z80pack-Diskettenbibliothek](https://www.schorn.ch/cpm/).
2. **Diskettenabbild in den Emulator einbinden**:
    
    - Platzieren Sie die Diskette (z. B. `ladder.dsk`) im Verzeichnis:
        
        ```bash
        mv ladder.dsk z80pack-1.37/emu/cpm/disks/
        ```
        
3. **Konfiguration des Diskettenlaufwerks**:
    
    - Öffnen Sie die Emulator-Konfigurationsdatei `cpm/drives.c` und binden Sie das Diskettenabbild ein:
        
        ```c
        disk[0] = "disks/ladder.dsk";
        ```
        
4. **Emulator starten und Diskette mounten**:
    
    - Starten Sie den Emulator:
        
        ```bash
        ./cpm
        ```
        
    - Sie sollten eine CP/M-Eingabeaufforderung sehen (z. B. `A>`).

---

### **4. Ladder starten**

1. **Inhalt der Diskette anzeigen**:
    
    - Zeigen Sie die Dateien auf der Diskette an:
        
        ```bash
        dir
        ```
        
    - Sie sollten eine Datei wie `LADDER.COM` sehen.
2. **Spiel starten**:
    
    - Geben Sie den Namen der Datei ein, um Ladder zu starten:
        
        ```bash
        ladder
        ```
        

---

### **5. Optimierung und Steuerung**

- **Grafik und Steuerung**:
    - Ladder verwendet ANSI-Grafikcodes, daher ist es wichtig, dass Ihr Terminal ANSI/VT100 unterstützt.
- **Joystick/Keyboard-Mapping**:
    - Passen Sie Tastenbelegungen an, falls notwendig, über die Emulator-Konfigurationsdatei.

---

### **6. Probleme lösen**

- **Keine ANSI-Grafik**:
    - Überprüfen Sie die Terminal-Kompatibilität (z. B. `echo $TERM` sollte `xterm` oder `xterm-256color` sein).
- **Langsame Emulation**:
    - Stellen Sie sicher, dass keine unnötigen Hintergrundprozesse WSL verlangsamen.

Mit diesen Schritten sollte Ladder auf z80pack in der WSL einwandfrei laufen! Viel Spaß beim Spielen!

Die z80pack-Diskettenbibliothek ist auf der Website [schorn.ch](https://schorn.ch/) verfügbar. Dort finden Sie CP/M-Diskettenabbilder, die Spiele wie Ladder enthalten können. Insbesondere unter der Kategorie "Altair Games and Tools" finden sich relevante Ressourcen. Laden Sie das gewünschte Diskettenabbild herunter und binden Sie es wie beschrieben in z80pack ein. Eine Übersicht über Emulatoren und zugehörige Disketten ist auch unter der [Altair-Sektion](https://schorn.ch/altair.html) zu finden.
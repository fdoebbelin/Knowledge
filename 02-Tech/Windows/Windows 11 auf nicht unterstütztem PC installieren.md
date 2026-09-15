Die Methode, Windows 10 zu installieren und dann auf Windows 11 zu upgraden, umgeht viele Hardware-Anforderungen von Windows 11, einschließlich TPM 2.0 und CPU-Beschränkungen. Hier ist eine ausführliche Schritt-für-Schritt-Anleitung:

---

## Schritt 1: Windows 10 installieren

Falls du bereits Windows 10 installiert hast, kannst du diesen Schritt überspringen.

1. **Lade das offizielle Windows 10 ISO** von Microsoft herunter:  
    👉 [Windows 10 Download](https://www.microsoft.com/de-de/software-download/windows10)
2. **Erstelle einen bootfähigen USB-Stick mit Rufus oder dem Media Creation Tool**
    - Falls du Rufus nutzt: Wähle „Standard Windows 10 Installation“ und erstelle den Stick.
3. **Starte den PC vom USB-Stick** und installiere Windows 10 ganz normal.

---

## Schritt 2: Windows 11 ISO herunterladen

Da du das Upgrade manuell startest, musst du das Windows 11 Installationsmedium vorbereiten.

4. Lade das **Windows 11 ISO** von Microsoft herunter:  
    👉 [Windows 11 Download](https://www.microsoft.com/de-de/software-download/windows11)
5. **Entpacke die ISO-Datei mit WinRAR oder mounte sie mit Windows**
    - Rechtsklick auf die ISO → „Bereitstellen“ (falls du Windows 10 nutzt).

---

## Schritt 3: Upgrade von Windows 10 auf Windows 11 starten

6. Öffne das gemountete Windows 11 Laufwerk.
7. **Starte die `setup.exe`** im Windows 11 Ordner.
8. **Wähle "Beibehalten von Dateien und Apps"**
    - Dadurch bleibt alles erhalten, ohne dass du eine Neuinstallation machen musst.
9. **Falls eine Inkompatibilitätswarnung kommt:**
    - Drücke `Shift + F10`, um die Eingabeaufforderung zu öffnen.
    - Gib `regedit` ein und navigiere zu:
        
        ```
        HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup
        ```
        
    - Erstelle einen neuen **DWORD-Wert (32-Bit)** mit dem Namen:
        
        ```
        AllowUpgradesWithUnsupportedTPMOrCPU
        ```
        
    - Setze den Wert auf `1`.
    - Starte die Installation erneut.

---

## Schritt 4: Windows 11 Installation abschließen

- Nach dem Upgrade bootet dein System direkt in Windows 11.
- Prüfe unter **Einstellungen → System → Info**, ob Windows 11 aktiviert ist.

---

## Vorteil dieser Methode

- Kein USB-Stick oder Neuinstallation nötig  
- Alle Dateien, Programme und Einstellungen bleiben erhalten  
- Keine TPM- oder CPU-Prüfung, wenn das Upgrade von Windows 10 gestartet wird
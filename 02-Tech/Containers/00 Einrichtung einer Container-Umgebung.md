## Teil 1: Hardware- und Systemvoraussetzungen (BIOS & Windows-Features)

Bevor Software installiert werden kann, müssen die Hardware-Virtualisierung im BIOS/UEFI deines Mainboards sowie die entsprechenden Plattform-Features in Windows aktiviert sein.

### 1.1 BIOS/UEFI-Einstellungen prüfen & aktivieren
Damit virtuelle Maschinen und Container-Systeme (wie WSL2) performant laufen können, muss die CPU-Virtualisierung im BIOS/UEFI aktiviert sein.

*   **Wie gelangt man ins BIOS?** Starte den PC neu und drücke während des Hochfahrens mehrmals die Taste **Entf (Del)**, **F2**, **F10** oder **F12** (abhängig vom Mainboard-Hersteller).
*   **Welche Einstellung muss aktiviert werden?**
    *   **Bei Intel-Prozessoren:** Suche nach Begriffen wie `Intel Virtualization Technology`, `Intel VT-x`, `VT-d` oder `Vanderpool`. Stelle diese auf **Enabled** (Aktiviert).
    *   **Bei AMD-Prozessoren:** Suche nach Begriffen wie `AMD-V`, `SVM Mode` (Secure Virtual Machine) oder `Secure Virtual Machine Mode`. Stelle diese auf **Enabled** (Aktiviert).
*   **Wo ist die Einstellung versteckt?** Meistens in den Reitern *Advanced*, *CPU Configuration*, *Overclocking* oder *Chipset Configuration*.

**Aufgabe 1 (Kontrolle unter Windows):** 
Öffne den Windows **Task-Manager** (Strg + Umschalt + Esc), klicke auf den Reiter **Leistung** und wähle **CPU**. 
*   Steht dort unten rechts bei "Virtualisierung": **Aktiviert**? [ ] Ja  [ ] Nein (Falls Nein, musst du ins BIOS!)

### 1.2 Optionale Windows-Features aktivieren
Windows benötigt spezielle Subsysteme, um Linux-Container nativ ausführen zu können.

*   **Weg über die Grafische Oberfläche:** Drücke die Windows-Taste, tippe `Optionale Features` ein (oder öffne den Ausführen-Dialog mit `Win + R` und tippe `optionalfeatures` ein).
*   **Aktivierte Features ankreuzen:** Stelle sicher, dass die folgenden Haken gesetzt sind, und starte den PC danach neu:
    *   [ ] **Windows-Subsystem für Linux** (Ermöglicht das Ausführen von Linux-Binärdateien)
    *   [ ] **Virtuelle Maschinenplattform** (Stellt die leichtgewichtige Hypervisor-Basis für WSL2 bereit)
    *   *(Hinweis: Das klassische "Hyper-V"-Feature ist für WSL2 auf Windows 11 Home/Pro nicht zwingend erforderlich, da die Virtuelle Maschinenplattform ausreicht).*

*   **Alternativer Weg über die PowerShell (als Administrator):**
    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
    ```

---

## Teil 2: Installation von WSL und Container-Engine

Führe die folgenden Schritte nacheinander aus und hake sie ab, sobald sie erfolgreich waren.

### 2.1 WSL und Linux-Distribution installieren
1.  Öffne die **PowerShell als Administrator** (Rechtsklick -> Als Administrator ausführen).
2.  Führe den folgenden Befehl aus, um das WSL-System und die Standard-Distribution (Ubuntu) zu installieren:
    ```powershell
    wsl --install
    ```
    *Hinweis: Falls WSL bereits installiert war, aktualisiere es mit `wsl --update`.*
3.  **WICHTIG:** Starte deinen Computer nach diesem Schritt neu, falls du es nicht schon bei den Windows-Features getan hast!
4.  Nach dem Neustart öffnet sich ein Linux-Terminal. Vergib dort einen gewünschten **Benutzernamen** und ein **Passwort** für deine Ubuntu-Umgebung.

### 2.2 Container-Engine installieren (Docker oder Podman)
Lade dir **eine** der beiden folgenden Lösungen herunter und installiere sie mit den Standardeinstellungen:

*   **Option A (Docker Desktop):** Von der offiziellen Docker-Website herunterladen. (Für den privaten Gebrauch, Bildung und kleine Unternehmen kostenlos).
*   **Option B (Podman Desktop):** Von `podman-desktop.io` herunterladen. (Komplett Open-Source, lizenzfrei und ohne Registrierungszwang).

Stelle bei der Installation sicher, dass die Option **"Use WSL 2 instead of Hyper-V"** (oder ähnlich) aktiviert ist.

### 2.3 WSL-Integration prüfen
Öffne Docker Desktop bzw. Podman Desktop. 
Navigiere in die **Settings (Einstellungen) > Resources > WSL Integration** und stelle sicher, dass die Integration für deine Standard-WSL-Distribution (Ubuntu) per Schalter aktiviert ist. Damit kannst du Container-Befehle sowohl in Windows als auch direkt in Linux ausführen.

---

## Teil 3: Erste Schritte und Überprüfung

Öffne ein **neues** (normales, nicht-Administrator) PowerShell- oder Terminal-Fenster.
*(Hinweis: Falls du Podman nutzt, tausche in den folgenden Befehlen einfach das Wort `docker` gegen `podman` aus).*

**Aufgabe 2: Versionen prüfen**
Welche Version der Container-Engine ist installiert? Führe den Befehl aus und notiere das Ergebnis.
```bash
docker --version
```
**Deine Version:** ______________________________________________________

**Aufgabe 3: Den "Hello World" Container starten**
Wir laden nun unser erstes *Image* aus dem Internet herunter und starten es als *Container*.
```bash
docker run hello-world
```
**Frage:** Welche Botschaft wird im Terminal ausgegeben, nachdem das Image heruntergeladen wurde?
_________________________________________________________________________
_________________________________________________________________________

---

## Teil 4: Praxis-Beispiel – Ein eigener Webserver

Wir starten nun einen Nginx-Webserver, um die Portweiterleitung auszuprobieren.

**Aufgabe 4: Webserver starten**
Führe folgenden Befehl aus:
```bash
docker run -d -p 8080:80 --name mein-webserver nginx
```
*Erklärung der Parameter:*
*   `-d`: (Detached) Der Container läuft unsichtbar im Hintergrund.
*   `-p 8080:80`: Leitet den Port 8080 deines Windows-PCs auf den Port 80 im Container um.
*   `--name`: Gibt dem Container einen eindeutigen Namen.
*   `nginx`: Das offizielle Webserver-Image, das aus der Registry geladen wird.

**Aufgabe 5: Webserver testen**
Öffne deinen Webbrowser (Edge, Chrome, Firefox) und rufe folgende Adresse auf: `http://localhost:8080`

**Frage:** Was siehst du im Browser? 
_________________________________________________________________________

**Aufgabe 6: Aufräumen**
Stoppe und lösche den Webserver mit den folgenden Befehlen, um Systemressourcen freizugeben:
```bash
docker stop mein-webserver
docker rm mein-webserver
```
Überprüfe mit `docker ps`, ob der Container erfolgreich entfernt wurde.

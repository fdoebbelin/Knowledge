Perfekt 👍 – ich schreibe dir jetzt eine **komplette Anleitung für Windows PowerShell**, die Helix in dein Home-Verzeichnis unter

```
%USERPROFILE%\src\helix
```

installiert und gleich alles einrichtet.

---

# 📖 Anleitung: Helix aus Quelltext bauen (Windows on ARM, PowerShell)

### 1. Ordnerstruktur vorbereiten

Öffne PowerShell und lege das `src`-Verzeichnis an:

```powershell
mkdir $env:USERPROFILE\src -Force
cd $env:USERPROFILE\src
```

### 2. Helix-Quelltext klonen

```powershell
git clone https://github.com/helix-editor/helix
cd helix
```

### 3. Helix bauen und installieren

```powershell
cargo install --path helix-term --locked
```

👉 Ergebnis:  
Das fertige Binary liegt in

```
%USERPROFILE%\.cargo\bin\hx.exe
```

### 4. HELIX_RUNTIME setzen

Helix benötigt den `runtime/`-Ordner aus dem Repo.  
Dafür setzen wir die Umgebungsvariable **dauerhaft** (gilt für alle neuen Shells):

```powershell
setx HELIX_RUNTIME "$env:USERPROFILE\src\helix\runtime"
```

### 5. Installation testen

Neue PowerShell öffnen und prüfen:

```powershell
hx --health
```

Wenn alles klappt, bekommst du einen Statusbericht mit Infos über Runtime, Syntaxgrammatiken, LSP etc.

---

## 🔧 Nützliche Zusatzbefehle

- Grammatikdateien neu laden:
    
    ```powershell
    hx --grammar fetch
    hx --grammar build
    ```
    
- Automatisches Bauen der Grammatiken deaktivieren:
    
    ```powershell
    setx HELIX_DISABLE_AUTO_GRAMMAR_BUILD 1
    ```
    

---

Damit bist du startklar:

- Quellcode liegt unter `src\helix`
    
- Binary unter `.cargo\bin\hx.exe`
    
- Runtime ist per `HELIX_RUNTIME` registriert.
    

---

👉 Soll ich dir aus diesen Schritten auch gleich ein **fertiges PowerShell-Skript** schreiben, das du einfach nur ausführen musst und alles automatisch erledigt?
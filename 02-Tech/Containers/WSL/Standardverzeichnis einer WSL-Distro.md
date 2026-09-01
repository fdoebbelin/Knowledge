Das Standardverzeichnis, in dem WSL die Dateien der Distributionen speichert, befindet sich normalerweise in:

```
C:\Users\<Benutzername>\AppData\Local\Packages\
```

Innerhalb dieses Verzeichnisses gibt es Ordner für jede installierte WSL-Distribution. Die spezifischen Pfade unterscheiden sich leicht je nach Distribution:

---

### **Beispiel für Ubuntu**

Für die Ubuntu-Distribution ist der Pfad oft:

```
C:\Users\<Benutzername>\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_<Version>_<Hash>\LocalState\
```

---

### **Wichtige Unterordner**

1. **`LocalState`** Enthält die eigentlichen Dateien der WSL-Distribution, einschließlich des Root-Dateisystems (`ext4.vhdx`).
    
    - **Datei:**
        
        ```
        ext4.vhdx
        ```
        
        Das ist die virtuelle Festplatte, auf der alle Dateien der WSL-Distribution gespeichert sind.
2. **`Temp`** Temporäre Dateien während der Nutzung von WSL.
    

---

### **Alternative: WSL-Speicherort ändern**

Wenn du den Speicherort einer WSL-Distribution ändern möchtest, kannst du sie mit dem folgenden PowerShell-Befehl exportieren und neu importieren:

#### **1. Exportieren:**

```powershell
wsl --export <DistributionName> <PfadZurBackupDatei.tar>
```

Beispiel:

```powershell
wsl --export Ubuntu D:\WSL\UbuntuBackup.tar
```

#### **2. Importieren an einen neuen Speicherort:**

```powershell
wsl --import <DistributionName> <NeuerPfad> <PfadZurBackupDatei.tar>
```

Beispiel:

```powershell
wsl --import Ubuntu D:\WSL\Ubuntu D:\WSL\UbuntuBackup.tar
```

---

### **Überprüfung des Installationsverzeichnisses**

Du kannst den Speicherort einer Distribution auch über PowerShell herausfinden:

```powershell
wsl --list --verbose
```

Das zeigt alle installierten Distributionen und gibt Aufschluss über den Zustand.
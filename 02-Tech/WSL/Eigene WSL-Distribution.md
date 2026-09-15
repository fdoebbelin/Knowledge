Um aus einer Ubuntu-ISO eine eigene WSL-Distribution zu erstellen, sind mehrere Schritte notwendig. Du erstellst dabei ein angepasstes Root-Dateisystem (RootFS), das anschließend in WSL importiert wird. Hier ist eine Anleitung:

---

### **1. Ubuntu-ISO herunterladen**

Lade die gewünschte Ubuntu-ISO-Datei von der offiziellen Website herunter:

- [Ubuntu Download-Seite](https://ubuntu.com/download)

---

### **2. Ubuntu-ISO extrahieren**

Extrahiere die ISO-Datei, um Zugriff auf das Dateisystem zu erhalten. Dies kannst du mit einem Tool wie `7-Zip` (Windows) oder mit `mount` unter Linux machen.

**Linux:**

```bash
mkdir ubuntu-iso
sudo mount -o loop ubuntu.iso ubuntu-iso
```

**Windows:** Rechtsklick auf die ISO-Datei und "Bereitstellen" wählen.

---

### **3. Erstellen eines Root-Dateisystems**

Du benötigst ein minimales Ubuntu-RootFS. Dafür nutzt du `debootstrap`, das unter Linux verfügbar ist.

**Vorgehen:**

1. **Debootstrap installieren:**
    
    ```bash
    sudo apt install debootstrap -y
    ```
    
2. **Root-Dateisystem erstellen:**
    
    ```bash
    sudo debootstrap --arch=amd64 focal ubuntu-rootfs http://archive.ubuntu.com/ubuntu/
    ```
    
    - Ersetze `focal` durch die gewünschte Ubuntu-Version (z. B. `jammy` für 22.04).
    - Der Ordner `ubuntu-rootfs` enthält das neue RootFS.
3. **Optional: Pakete hinzufügen** Installiere zusätzliche Pakete in das RootFS:
    
    ```bash
    sudo chroot ubuntu-rootfs
    apt update
    apt install <pakete>
    exit
    ```
    

---

### **4. RootFS für WSL vorbereiten**

1. **Bereinigung des RootFS:** Entferne unnötige Dateien:
    
    ```bash
    sudo rm -rf ubuntu-rootfs/dev/*
    sudo rm -rf ubuntu-rootfs/tmp/*
    sudo rm -rf ubuntu-rootfs/var/tmp/*
    ```
    
2. **RootFS komprimieren:** Erstelle eine komprimierte Datei des RootFS:
    
    ```bash
    tar --numeric-owner -cf ubuntu-rootfs.tar -C ubuntu-rootfs .
    ```
    

---

### **5. WSL-Distribution importieren**

1. Öffne PowerShell und erstelle eine WSL-Instanz mit dem RootFS:
    
    ```powershell
    wsl --import <DistroName> <InstallationsPfad> <PfadZurRootFS.tar>
    ```
    
    Beispiel:
    
    ```powershell
    wsl --import MyUbuntu C:\WSL\MyUbuntu C:\Downloads\ubuntu-rootfs.tar
    ```
    
2. Die Distribution wird importiert und ist jetzt verfügbar. Du kannst sie mit dem Namen starten:
    
    ```powershell
    wsl -d MyUbuntu
    ```
    

---

### **6. Distribution anpassen (optional)**

- **Benutzer erstellen:** Im WSL-Terminal kannst du einen neuen Benutzer hinzufügen:
    
    ```bash
    adduser myuser
    ```
    
    Danach als Standardbenutzer festlegen:
    
    ```powershell
    wsl -d MyUbuntu --user myuser
    ```
    
- **Konfiguration anpassen:** Bearbeite die Datei `/etc/wsl.conf`, um z. B. die Standardumgebung zu konfigurieren:
    
    ```bash
    [interop]
    enabled = true
    appendWindowsPath = true
    ```
    

---

### **Fertig!**

Du hast nun eine eigene WSL-Distribution basierend auf einem Ubuntu-ISO erstellt.
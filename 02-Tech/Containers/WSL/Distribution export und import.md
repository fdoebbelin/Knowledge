Um eine WSL-Distribution zu exportieren und unter einem anderen Namen wieder zu importieren, kannst du die folgenden Schritte befolgen:

### Exportieren einer WSL-Distribution

1. **Exportieren**:
   - Öffne PowerShell als Administrator.
   - Verwende den folgenden Befehl, um die Distribution zu exportieren. Ersetze `<DistroName>` durch den Namen der Distribution, die du exportieren möchtest, und `<PfadZumExport>` durch den Pfad und Dateinamen, unter dem die Distribution gespeichert werden soll (z.B. `C:\WSL\my_distro.tar`):
```powershell
wsl --export <DistroName> <PfadZumExport>

wsl --export Ubuntu-24.04 .\Python.tar
```

### Importieren einer WSL-Distribution

2. **Importieren**:
   - Verwende den folgenden Befehl, um die Distribution unter einem neuen Namen zu importieren. Ersetze `<PfadZumExport>` durch den Pfad zur exportierten Datei, `<NeuerDistroName>` durch den gewünschten neuen Namen der Distribution und `<InstallationsPfad>` durch den Pfad, in dem die Distribution installiert werden soll (z.B. `C:\WSL\new_distro`):
```powershell
wsl --import <NeuerDistroName> <InstallationsPfad> <PfadZumExport>

wsl --import Python $env:USERPROFILE\AppData\Local\Packages\Python .\Python.tar
```

### Überprüfen der installierten Distributionen

3. **Überprüfen**:
   - Du kannst alle installierten Distributionen und deren Status mit folgendem Befehl überprüfen:
     ```powershell
     wsl --list --verbose
     ```

### Starten der neuen Distribution

4. **Starten**:
   - Um die neu importierte Distribution zu starten, verwende:
```powershell
wsl -d .\Python.tar
```

## Entfernen einer Distribution
    
- Wenn du eine Distribution entfernen möchtest, kannst du dies mit folgendem Befehl tun:


```
wsl --unregister Ubuntu-24.04
```

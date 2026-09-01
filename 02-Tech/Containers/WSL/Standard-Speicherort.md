Das **Windows Subsystem for Linux (WSL)** speichert seine Distributionen standardmäßig im folgenden Verzeichnis:

```
$env:USERPROFILE\AppData\Local\Packages\
```

Dort findest du für jede installierte Linux-Distribution einen eigenen Ordner, der in etwa so aussieht:

```
CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc
```

### Pfad zur WSL-Dateistruktur (Root-Dateisystem):

Innerhalb dieses Ordners findest du die eigentliche Linux-Dateistruktur unter:

```
$env:USERPROFILE\AppData\Local\Packages\<DistrospezifischerOrdner>\LocalState\ext4.vhdx
```

Die Datei `ext4.vhdx` ist eine virtuelle Festplatte, in der das gesamte Root-Dateisystem (`/`) deiner WSL-Distribution gespeichert ist.

---

### Falls du WSL 2 nutzt:

Ab WSL 2 nutzt Microsoft **virtuelle Maschinen** mit dieser `.vhdx`-Datei – das ist die komplette Linux-Festplatte in einer Datei.

---

### Optional: Speicherort ändern

Falls du möchtest, kannst du bei der Installation einer WSL-Distribution den Speicherort selbst festlegen:

```powershell
wsl --import <Name> <Zielpfad> <Pfad_zur_Tar_Datei>
```

Damit kannst du z. B. eine Distribution außerhalb von `AppData` auf eine andere Festplatte verschieben.

Möchtest du wissen, wie man eine bestehende Distribution verschiebt?
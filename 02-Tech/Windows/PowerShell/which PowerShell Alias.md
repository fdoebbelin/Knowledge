Du kannst eine PowerShell-Funktion mit einem Alias erstellen:

```powershell
# Funktion definieren
function Get-CommandPath {
    param([string]$Command)
    (Get-Command $Command -ErrorAction SilentlyContinue).Source
}

# Alias erstellen
Set-Alias which Get-CommandPath
```

Dann kannst du es so verwenden:

```powershell
which python
which docker
which notepad
```

## Permanent machen (in PowerShell-Profil)

Um es dauerhaft zu haben, füge es zu deinem PowerShell-Profil hinzu:

```powershell
# Profil-Datei bearbeiten
notepad $PROFILE

# Oder erstellen falls nicht vorhanden
if (!(Test-Path $PROFILE)) { New-Item $PROFILE -Force }
notepad $PROFILE
```

Dann diese Zeilen in die Profil-Datei einfügen:

```powershell
function Get-CommandPath {
    param([string]$Command)
    if ($Command) {
        (Get-Command $Command -ErrorAction SilentlyContinue).Source
    }
}
Set-Alias which Get-CommandPath
```

Nach dem Neustart der PowerShell oder mit `. $PROFILE` ist der `which`-Alias verfügbar.

**Alternative kompaktere Version:**

```powershell
function which { (Get-Command $args[0] -ErrorAction SilentlyContinue).Source }
```

```powershell
# Version der PowerShell ermitteln
$PSVersionTable.PSVersion

# Installation der PowerShell Version 7 über winget
winget
winget install --help
winget search powershell
winget install --id Microsoft.PowerShell --source winget

# Installation des Paketmanagers scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop

# Software mit scoop installieren
scoop search terminal
scoop help bucket
scoop bucket known
scoop install git

# git installieren, wird von der scoop paketverwaltung benötigt
scoop bucket add extras
scoop install extras/windows-terminal

# Installation der Busybox, enthält wichtige Kommandos
scoop install main/busybox

# Anzeige und speichern der Verlaufes der Konsolenkommandos
Get-Content (Get-PSReadlineOption).HistorySavePath
Get-Content (Get-PSReadlineOption).HistorySavePath >install.txt
```

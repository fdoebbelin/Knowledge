
```
# Version der PowerShell ermitteln
$PSVersionTable.PSVersion
$PSVersionTable
$PSVersionTable.PSVersion

# Installation der PowerShell Version 7 über winget
winget
winget install --help
winget search powershell
# Versuch der Installation im Benutzerkontext
winget install --id Microsoft.PowerShell --source winget --scope user

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

# Installation des Miniforge mambaforge Paketes
scoop install extras/mambaforge
conda init powershell
python --version

# Einrichtung einer zusätzlichen Umgebung
conda create -n py310 python=3.10
conda activate py310
python --version

# Wechsel der Umgebung zu Standard
conda activate base
python --version

# Installation des Python Paketes arcade
conda activate py310
python --version
pip list
pip install arcade
pip list

# Installation der Python IDE PyCharm  Community Edition von Jetbrains https://www.jetbrains.com/pycharm/
scoop install extras/pycharm
pycharm

# Anzeige und speichern der Verlaufes der Konsolenkommandos
Get-Content (Get-PSReadlineOption).HistorySavePath
Get-Content (Get-PSReadlineOption).HistorySavePath >install.txt

```

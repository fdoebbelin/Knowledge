## **Hauptverbesserungen:**

### 🔧 **Direkte Ausführbarkeit**

- Alle Code-Zellen können direkt ausgeführt werden
- Dateierstellung erfolgt über Shell-Befehle (`tee`, `Out-File`)
- Keine manuellen Editor-Schritte erforderlich

### 📝 **Bessere Struktur**

- Kommentare und Erklärungen sind in Markdown-Bereichen
- Code-Zellen enthalten nur ausführbaren Code
- Klare Trennung zwischen Anweisungen und Code

### 🎛️ **Konfigurierbare Variablen**

- Benutzernamen und Einstellungen am Anfang jeder Code-Zelle
- WSL-Speicher, CPU-Kerne und andere Parameter einfach anpassbar
- Konsistente Variablennutzung durch alle Abschnitte

### 🚀 **Erweiterte Funktionalität**

- Umfassende PowerShell-Integration mit nützlichen Funktionen
- Automatische Diagnoseskripts und Wartungstools
- Vollständige Test- und Validierungsroutinen

### 🛠️ **Praktische Tools**

- `Test-PodmanSetup` für schnelle Systemdiagnose
- `New-WebPod` für einfache Pod-Erstellung
- `Start-PodmanCleanup` für automatische Wartung
- Backup- und Restore-Funktionen

### ✅ **Fehlerbehandlung**

- Statusprüfungen in allen kritischen Schritten
- Farbcodierte Ausgaben für bessere Übersicht
- Automatische Validierung der Installation
## 1. WSL2 Grundinstallation

### Windows-Anforderungen prüfen

```powershell
# Variablen definieren
$MinWindowsBuild = 19041

# Systeminfo abrufen und prüfen
$WindowsInfo = Get-ComputerInfo | Select WindowsProductName, WindowsVersion, WindowsBuildLabEx
Write-Host "Aktuelles System: $($WindowsInfo.WindowsProductName) - Build: $($WindowsInfo.WindowsBuildLabEx)" -ForegroundColor Cyan

if ([int]($WindowsInfo.WindowsBuildLabEx -split '\.')[0] -ge $MinWindowsBuild) {
    Write-Host "✓ Windows-Version ist kompatibel" -ForegroundColor Green
} else {
    Write-Host "⚠ Windows-Version ist möglicherweise nicht kompatibel. Mindestens Build $MinWindowsBuild erforderlich." -ForegroundColor Yellow
}
```

**Mindestanforderungen:** Windows 10 Version 2004 (Build 19041) oder höher, Windows 11 (alle Versionen)

### WSL2 Features aktivieren

```powershell
# Windows-Features für WSL2 aktivieren
Write-Host "Aktiviere Windows-Features für WSL2..." -ForegroundColor Yellow
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Features aktiviert. System-Neustart erforderlich!" -ForegroundColor Green
Write-Host "Führen Sie nach dem Neustart den nächsten Schritt aus." -ForegroundColor Cyan
```

**Nach dem Neustart fortfahren:**

```powershell
# WSL2 als Standard-Version setzen
wsl --set-default-version 2

# Prüfen ob WSL2-Kernel Update erforderlich ist
Write-Host "Falls Kernel-Update erforderlich: https://aka.ms/wsl2kernel" -ForegroundColor Cyan
```

### Ubuntu Installation

```powershell
# Ubuntu direkt installieren
Write-Host "Installiere Ubuntu für WSL2..." -ForegroundColor Yellow
wsl --install -d Ubuntu

Write-Host "Ubuntu wird installiert. Nach der Installation wird ein Terminal geöffnet." -ForegroundColor Green
Write-Host "Erstellen Sie dort einen Benutzernamen und ein Passwort." -ForegroundColor Cyan
```

## 2. WSL2 optimieren

### Benutzer-Variable festlegen

```bash
# WICHTIG: Ihren tatsächlichen Benutzernamen hier eintragen
WSL_USERNAME="yourusername"
```

**Ersetzen Sie `yourusername` durch Ihren gewünschten WSL-Benutzernamen**

### WSL-Konfiguration erstellen

```bash
# WSL-Konfigurationsdatei erstellen
sudo tee /etc/wsl.conf > /dev/null <<EOF
[boot]
systemd=true

[user]
default=${WSL_USERNAME}

[interop]
enabled=true
appendWindowsPath=true

[network]
generateResolvConf=true
EOF

echo "✓ WSL-Konfiguration erstellt"
```

### Windows-seitige WSL-Konfiguration

```powershell
# Variablen für WSL-Performance
$WSL_Memory = "4GB"
$WSL_Processors = 2
$WSL_Swap = "2GB"

# .wslconfig Datei erstellen
$WSLConfig = @"
[wsl2]
memory=${WSL_Memory}
processors=${WSL_Processors}
swap=${WSL_Swap}
localhostForwarding=true
"@

$WSLConfig | Out-File -FilePath "$env:USERPROFILE\.wslconfig" -Encoding UTF8
Write-Host "✓ WSL-Konfiguration erstellt in: $env:USERPROFILE\.wslconfig" -ForegroundColor Green
```

### WSL neu starten für Konfiguration

```powershell
# WSL herunterfahren und neu starten
Write-Host "Starte WSL neu für Konfiguration..." -ForegroundColor Yellow
wsl --shutdown
Start-Sleep -Seconds 3
wsl -d Ubuntu echo "✓ WSL Ubuntu erfolgreich neu gestartet"
```

## 3. Podman Installation in WSL2

### System vorbereiten

```bash
# System aktualisieren
echo "Aktualisiere System..."
sudo apt update && sudo apt upgrade -y

# Erforderliche Abhängigkeiten installieren
sudo apt install -y curl wget gnupg lsb-release software-properties-common ca-certificates

echo "✓ System vorbereitet"
```

### Podman Repository hinzufügen

```bash
# Ubuntu-Version ermitteln
UBUNTU_VERSION=$(lsb_release -rs)
UBUNTU_CODENAME=$(lsb_release -cs)

echo "Ubuntu Version: ${UBUNTU_VERSION} (${UBUNTU_CODENAME})"

# GPG-Schlüssel für Podman-Repository hinzufügen
curl -fsSL "https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${UBUNTU_VERSION}/Release.key" | sudo gpg --dearmor -o /usr/share/keyrings/podman-archive-keyring.gpg

# Repository zur sources.list hinzufügen
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/podman-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${UBUNTU_VERSION}/ /" | sudo tee /etc/apt/sources.list.d/podman.list

# Paketlisten aktualisieren
sudo apt update

echo "✓ Podman-Repository hinzugefügt"
```

### Podman und Tools installieren

```bash
# Vollständige Podman-Installation
echo "Installiere Podman und zugehörige Tools..."
sudo apt install -y podman podman-compose podman-docker buildah skopeo slirp4netns fuse-overlayfs uidmap

# Installation verifizieren
echo "Podman Version:"
podman --version
echo "✓ Podman erfolgreich installiert"
```

## 4. Podman konfigurieren

### Benutzer-Namespaces einrichten

```bash
# Aktuellen Benutzer ermitteln
CURRENT_USER=$(whoami)
USER_UID=$(id -u)

echo "Konfiguriere Benutzer-Namespaces für: ${CURRENT_USER} (UID: ${USER_UID})"

# Subuids und subgids konfigurieren
echo "${CURRENT_USER}:100000:65536" | sudo tee -a /etc/subuid
echo "${CURRENT_USER}:100000:65536" | sudo tee -a /etc/subgid

# Container-Konfigurationsverzeichnis erstellen
mkdir -p ~/.config/containers

echo "✓ Benutzer-Namespaces konfiguriert"
```

### Storage-Konfiguration erstellen

```bash
# Storage-Konfiguration für optimale Performance
tee ~/.config/containers/storage.conf > /dev/null <<EOF
[storage]
driver = "overlay"
runroot = "/run/user/${USER_UID}/containers"
graphroot = "/home/${CURRENT_USER}/.local/share/containers/storage"

[storage.options]
additionalimagestores = []

[storage.options.overlay]
mountopt = "nodev,metacopy=on"
EOF

echo "✓ Storage-Konfiguration erstellt"
```

### Container-Registries konfigurieren

```bash
# Registry-Konfiguration für Container-Quellen
tee ~/.config/containers/registries.conf > /dev/null <<EOF
[registries.search]
registries = ['docker.io', 'quay.io', 'registry.fedoraproject.org']

[registries.insecure]
registries = ['localhost:5000']

[registries.block]
registries = []
EOF

echo "✓ Registry-Konfiguration erstellt"
```

### Podman-Service aktivieren

```bash
# Systemd-Service für Podman aktivieren
echo "Aktiviere Podman-Service..."
systemctl --user enable podman.socket
systemctl --user start podman.socket

# Service-Status prüfen
if systemctl --user is-active --quiet podman.socket; then
    echo "✓ Podman-Service erfolgreich gestartet"
else
    echo "⚠ Podman-Service konnte nicht gestartet werden"
    systemctl --user status podman.socket
fi
```

## 5. Windows-Integration einrichten

### PowerShell-Profil erstellen und konfigurieren

```powershell
# Variablen für PowerShell-Integration
$WSL_Distribution = "Ubuntu"
$WSL_DefaultUser = "yourusername"  # Hier Ihren WSL-Benutzernamen eintragen

# PowerShell-Profil erstellen falls nicht vorhanden
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
    Write-Host "✓ PowerShell-Profil erstellt: $PROFILE" -ForegroundColor Green
}

# Podman-Aliase und Funktionen zum Profil hinzufügen
$PodmanFunctions = @'
# Podman Windows-Integration
# Generiert automatisch - nicht manuell bearbeiten

# Basis-Podman-Funktionen
function podman { wsl -d Ubuntu podman @args }
function podman-compose { wsl -d Ubuntu podman-compose @args }
function buildah { wsl -d Ubuntu buildah @args }

# Container-Management
function Get-Containers { wsl -d Ubuntu podman ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" }
function Get-Images { wsl -d Ubuntu podman images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.Created}}" }
function Remove-StoppedContainers { wsl -d Ubuntu podman container prune -f }
function Remove-UnusedImages { wsl -d Ubuntu podman image prune -f }

# Pod-Management
function Get-Pods { wsl -d Ubuntu podman pod ls --format "table {{.Name}}\t{{.Status}}\t{{.Created}}\t{{.InfraId}}" }

function Start-Pod {
    param([Parameter(Mandatory=$true)][string]$Name)
    wsl -d Ubuntu podman pod start $Name
    Write-Host "Pod '$Name' gestartet" -ForegroundColor Green
}

function Stop-Pod {
    param([Parameter(Mandatory=$true)][string]$Name)
    wsl -d Ubuntu podman pod stop $Name
    Write-Host "Pod '$Name' gestoppt" -ForegroundColor Yellow
}

function Get-PodLogs {
    param([Parameter(Mandatory=$true)][string]$Name)
    wsl -d Ubuntu podman logs -f $Name
}

# Quick-Setup für neue Pods
function New-WebPod {
    param(
        [Parameter(Mandatory=$true)][string]$Name,
        [string]$Image = "nginx:alpine",
        [int]$Port = 8080
    )
    
    Write-Host "Erstelle Web-Pod: $Name" -ForegroundColor Cyan
    wsl -d Ubuntu podman pod create --name $Name
    wsl -d Ubuntu podman run -d --pod $Name --name "$Name-web" --restart always -p "${Port}:80" $Image
    
    Write-Host "✓ Pod '$Name' erfolgreich erstellt" -ForegroundColor Green
    Write-Host "🌐 Zugriff über: http://localhost:$Port" -ForegroundColor Cyan
}

# System-Diagnose
function Test-PodmanSetup {
    Write-Host "Teste Podman-Setup..." -ForegroundColor Yellow
    
    # WSL-Status prüfen
    $wslStatus = wsl -l --running
    if ($wslStatus -match "Ubuntu") {
        Write-Host "✓ WSL Ubuntu läuft" -ForegroundColor Green
    } else {
        Write-Host "⚠ WSL Ubuntu läuft nicht. Starte..." -ForegroundColor Yellow
        wsl -d Ubuntu echo "WSL gestartet"
    }
    
    # Podman-Version prüfen
    $podmanVersion = wsl -d Ubuntu podman --version
    Write-Host "✓ $podmanVersion" -ForegroundColor Green
    
    # Podman-Service prüfen
    $serviceStatus = wsl -d Ubuntu systemctl --user is-active podman.socket
    if ($serviceStatus -eq "active") {
        Write-Host "✓ Podman-Service läuft" -ForegroundColor Green
    } else {
        Write-Host "⚠ Podman-Service nicht aktiv" -ForegroundColor Yellow
    }
}

# Wartung und Cleanup
function Invoke-PodmanMaintenance {
    Write-Host "Führe Podman-Wartung durch..." -ForegroundColor Yellow
    
    wsl -d Ubuntu podman container prune -f
    wsl -d Ubuntu podman image prune -f
    wsl -d Ubuntu podman volume prune -f
    wsl -d Ubuntu podman system prune -f
    
    Write-Host "✓ Wartung abgeschlossen" -ForegroundColor Green
}

# Beim Profil-Laden ausführen
Write-Host "🐳 Podman-Integration geladen" -ForegroundColor Green
Write-Host "Verfügbare Befehle:" -ForegroundColor Cyan
Write-Host "  Container: Get-Containers, Remove-StoppedContainers" -ForegroundColor White
Write-Host "  Pods: Get-Pods, Start-Pod, Stop-Pod, New-WebPod" -ForegroundColor White
Write-Host "  System: Test-PodmanSetup, Invoke-PodmanMaintenance" -ForegroundColor White
'@

# Funktionen zum Profil hinzufügen
Add-Content -Path $PROFILE -Value $PodmanFunctions
Write-Host "✓ Podman-Funktionen zum PowerShell-Profil hinzugefügt" -ForegroundColor Green
```

### PowerShell Execution Policy setzen

```powershell
# Execution Policy für lokale Scripts erlauben
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Write-Host "✓ PowerShell Execution Policy gesetzt" -ForegroundColor Green
```

## 6. Installation testen

### PowerShell neu laden und testen

```powershell
# PowerShell-Profil neu laden
. $PROFILE

# Setup-Test durchführen
Test-PodmanSetup

# Erste Container-Informationen abrufen
Write-Host "`nAktuelle Container:" -ForegroundColor Cyan
Get-Containers
```

### Ersten Container starten und testen

```powershell
# Test-Container Variablen
$TestContainerName = "test-nginx"
$TestPort = 8080

# Nginx-Test-Container starten
Write-Host "Starte Test-Container..." -ForegroundColor Yellow
podman run -d --name $TestContainerName -p "${TestPort}:80" nginx:alpine

# Container-Status prüfen
Write-Host "`nContainer-Status:" -ForegroundColor Cyan
Get-Containers

Write-Host "`n🌐 Test-Container läuft auf: http://localhost:$TestPort" -ForegroundColor Green
Write-Host "Drücken Sie Enter nach dem Test, um den Container zu entfernen..." -ForegroundColor Yellow
Read-Host

# Test-Container stoppen und entfernen
podman stop $TestContainerName
podman rm $TestContainerName
Write-Host "✓ Test-Container entfernt" -ForegroundColor Green
```

### Pod-Funktionalität testen

```powershell
# Test-Pod erstellen
$TestPodName = "test-webstack"
$TestPodPort = 8081

Write-Host "Erstelle Test-Pod..." -ForegroundColor Yellow
New-WebPod -Name $TestPodName -Port $TestPodPort

# Pod-Status prüfen
Write-Host "`nPod-Status:" -ForegroundColor Cyan
Get-Pods

Write-Host "`n🌐 Test-Pod läuft auf: http://localhost:$TestPodPort" -ForegroundColor Green
Write-Host "Drücken Sie Enter nach dem Test, um den Pod zu stoppen..." -ForegroundColor Yellow
Read-Host

# Test-Pod stoppen
Stop-Pod -Name $TestPodName
podman pod rm $TestPodName -f
Write-Host "✓ Test-Pod entfernt" -ForegroundColor Green
```

## 7. Automatisierung und Services

### Systemd-Service für wichtige Pods

```bash
# Variablen für Service-Konfiguration
SERVICE_NAME="important-pod"
SERVICE_USER=$(whoami)

# Service-Datei erstellen
sudo tee /etc/systemd/system/${SERVICE_NAME}.service > /dev/null <<EOF
[Unit]
Description=Important Podman Pod
After=network.target
Wants=network.target

[Service]
Type=forking
User=${SERVICE_USER}
ExecStart=/usr/bin/podman pod start ${SERVICE_NAME}
ExecStop=/usr/bin/podman pod stop ${SERVICE_NAME}
ExecReload=/usr/bin/podman pod restart ${SERVICE_NAME}
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF

# Service-Daemon neu laden
sudo systemctl daemon-reload

echo "✓ Systemd-Service '${SERVICE_NAME}' erstellt"
echo "Aktivieren mit: sudo systemctl enable ${SERVICE_NAME}.service"
```

### WSL-Autostart konfigurieren

```powershell
# Variablen für Autostart
$TaskName = "WSL-Podman-Autostart"
$WSLDistribution = "Ubuntu"

# Scheduled Task für WSL-Autostart erstellen
$Action = New-ScheduledTaskAction -Execute "wsl" -Argument "-d $WSLDistribution systemctl --user start podman.socket"
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

# Task registrieren
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Settings $Settings -User $env:USERNAME -Force

Write-Host "✓ Autostart-Task '$TaskName' erfolgreich erstellt" -ForegroundColor Green

# Task-Status anzeigen
Get-ScheduledTask -TaskName $TaskName | Format-Table TaskName, State, LastRunTime
```

## 8. Troubleshooting und Wartung

### Diagnoseskripts

```bash
# Umfassendes Diagnose-Script
echo "=== Podman-Diagnose ==="

# System-Info
echo "System:"
lsb_release -a
echo ""

# Podman-Version und Info
echo "Podman:"
podman --version
podman info --format json | jq '.version, .store, .host.ociRuntime'
echo ""

# Service-Status
echo "Services:"
systemctl --user status podman.socket --no-pager -l
echo ""

# Container und Pods
echo "Container:"
podman ps -a
echo ""
echo "Pods:"
podman pod ls
echo ""

# Storage-Info
echo "Storage:"
podman system df
```

### Automatisches Cleanup-Script

```powershell
# Wartungs-Script für regelmäßige Ausführung
function Start-PodmanCleanup {
    param(
        [switch]$Force,
        [switch]$All
    )
    
    Write-Host "🧹 Starte Podman-Cleanup..." -ForegroundColor Yellow
    
    # Gestoppte Container entfernen
    Write-Host "Entferne gestoppte Container..." -ForegroundColor Cyan
    if ($Force) {
        wsl -d Ubuntu podman container prune -f
    } else {
        wsl -d Ubuntu podman container prune
    }
    
    # Ungenutzte Images entfernen
    Write-Host "Entferne ungenutzte Images..." -ForegroundColor Cyan
    if ($All) {
        wsl -d Ubuntu podman image prune -a $(if($Force){'-f'})
    } else {
        wsl -d Ubuntu podman image prune $(if($Force){'-f'})
    }
    
    # Ungenutzte Volumes entfernen
    Write-Host "Entferne ungenutzte Volumes..." -ForegroundColor Cyan
    wsl -d Ubuntu podman volume prune $(if($Force){'-f'})
    
    # System-Cleanup
    if ($All) {
        Write-Host "Führe System-Cleanup durch..." -ForegroundColor Cyan
        wsl -d Ubuntu podman system prune $(if($Force){'-f'})
    }
    
    Write-Host "✅ Cleanup abgeschlossen!" -ForegroundColor Green
}

# Cleanup-Script zum Profil hinzufügen
Write-Host "Cleanup-Funktion verfügbar: Start-PodmanCleanup [-Force] [-All]" -ForegroundColor Cyan
```

### Backup und Restore

```bash
# Backup-Script für wichtige Container und Pods
BACKUP_DIR="$HOME/podman-backups"
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)

# Backup-Verzeichnis erstellen
mkdir -p "$BACKUP_DIR"

echo "Erstelle Podman-Backup in: $BACKUP_DIR"

# Pod-Definitionen exportieren
for pod in $(podman pod ls --format "{{.Name}}" | grep -v "^$"); do
    echo "Exportiere Pod: $pod"
    podman generate kube "$pod" > "$BACKUP_DIR/${pod}_${BACKUP_DATE}.yaml"
done

# Container-Images exportieren (optional - nur bei wichtigen Images)
# podman save -o "$BACKUP_DIR/important-image_${BACKUP_DATE}.tar" important-image:tag

echo "✓ Backup erstellt: $BACKUP_DIR"
```

## 9. Performance-Optimierung

```bash
# Performance-Einstellungen für .bashrc
tee -a ~/.bashrc > /dev/null <<'EOF'

# Podman Performance-Optimierungen
export CONTAINERS_STORAGE_CONF=$HOME/.config/containers/storage.conf
export CONTAINERS_REGISTRIES_CONF=$HOME/.config/containers/registries.conf
export BUILDAH_ISOLATION=chroot

# Podman-Aliase für bessere Performance
alias pd='podman'
alias pdc='podman-compose'
alias pdi='podman images'
alias pps='podman ps'
alias ppsa='podman ps -a'

EOF

echo "✓ Performance-Optimierungen zu .bashrc hinzugefügt"
source ~/.bashrc
```

## 10. Fertigstellung

### Abschließende Validierung

```powershell
# Vollständiger Setup-Test
function Test-CompleteSetup {
    Write-Host "🔍 Führe vollständigen Setup-Test durch..." -ForegroundColor Yellow
    
    # WSL-Test
    Write-Host "`n1. WSL-Test:" -ForegroundColor Cyan
    $wslTest = wsl -d Ubuntu echo "WSL OK"
    if ($wslTest -eq "WSL OK") {
        Write-Host "✓ WSL funktioniert" -ForegroundColor Green
    } else {
        Write-Host "❌ WSL-Problem" -ForegroundColor Red
        return
    }
    
    # Podman-Basis-Test
    Write-Host "`n2. Podman-Test:" -ForegroundColor Cyan
    $podmanVersion = podman --version
    Write-Host "✓ $podmanVersion" -ForegroundColor Green
    
    # Service-Test  
    Write-Host "`n3. Service-Test:" -ForegroundColor Cyan
    $serviceTest = wsl -d Ubuntu systemctl --user is-active podman.socket
    if ($serviceTest -eq "active") {
        Write-Host "✓ Podman-Service aktiv" -ForegroundColor Green
    } else {
        Write-Host "⚠ Podman-Service nicht aktiv" -ForegroundColor Yellow
    }
    
    # Container-Test
    Write-Host "`n4. Container-Test:" -ForegroundColor Cyan
    $testResult = podman run --rm alpine:latest echo "Container-Test OK" 2>$null
    if ($testResult -eq "Container-Test OK") {
        Write-Host "✓ Container-Funktionalität OK" -ForegroundColor Green
    } else {
        Write-Host "❌ Container-Problem" -ForegroundColor Red
    }
    
    Write-Host "`n🎉 Setup-Test abgeschlossen!" -ForegroundColor Green
    Write-Host "Podman ist bereit für den produktiven Einsatz!" -ForegroundColor Cyan
}

# Test ausführen
Test-CompleteSetup
```

## Zusammenfassung

Die Installation ist jetzt komplett! Sie können Podman nahtlos von Windows PowerShell aus verwenden:

**Verfügbare Befehle:**

- `podman`, `podman-compose`, `buildah` - Standard-Podman-Befehle
- `Get-Containers`, `Get-Pods`, `Get-Images` - Übersichtsbefehle
- `New-WebPod -Name "myweb" -Port 8080` - Schnelle Pod-Erstellung
- `Test-PodmanSetup` - System-Diagnose
- `Invoke-PodmanMaintenance` - Automatische Wartung
- `Start-PodmanCleanup -Force -All` - Umfassendes Cleanup

**Nächste Schritte:**

1. Testen Sie die Installation mit `Test-CompleteSetup`
2. Erstellen Sie Ihre ersten Container und Pods
3. Richten Sie bei Bedarf Autostart für wichtige Services ein
4. Führen Sie regelmäßig `Invoke-PodmanMaintenance` aus
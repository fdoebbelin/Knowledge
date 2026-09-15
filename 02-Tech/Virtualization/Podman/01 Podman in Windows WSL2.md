## 1. WSL2 Grundinstallation

### Windows-Anforderungen prüfen

```powershell
# PowerShell als Administrator öffnen
Get-ComputerInfo | Select WindowsProductName, WindowsVersion

# Mindestanforderungen:
# - Windows 10 Version 2004 (Build 19041) oder höher
# - Windows 11 (alle Versionen)
```

### WSL2 aktivieren

```powershell
# Windows-Features aktivieren
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# System neustarten
Restart-Computer
```

### WSL2 als Standard setzen

```powershell
# Nach Neustart - PowerShell als Administrator
wsl --set-default-version 2

# WSL2 Kernel Update (falls erforderlich)
# Download: https://aka.ms/wsl2kernel
```

### Ubuntu Installation

```powershell
# Ubuntu aus Microsoft Store installieren
wsl --install -d Ubuntu

# Oder manuell über Store:
# Microsoft Store > Ubuntu > Installieren

# Erste Einrichtung - Benutzername und Passwort erstellen
```

## 2. WSL2 optimieren

### WSL-Konfiguration

```bash
# In WSL2-Terminal
sudo nano /etc/wsl.conf
```

```ini
# /etc/wsl.conf Inhalt
[boot]
systemd=true

[user]
default=yourusername

[interop]
enabled=true
appendWindowsPath=true

[network]
generateResolvConf=true
```

### Windows-seitige WSL-Konfiguration

```powershell
# In Windows - Datei erstellen: %USERPROFILE%\.wslconfig
notepad $env:USERPROFILE\.wslconfig
```

```ini
# .wslconfig Inhalt
[wsl2]
memory=4GB
processors=2
swap=2GB
localhostForwarding=true
```

```powershell
# WSL neu starten um Konfiguration zu übernehmen
wsl --shutdown
wsl -d Ubuntu
```

## 3. Podman Installation in WSL2

### System vorbereiten

```bash
# System aktualisieren
sudo apt update && sudo apt upgrade -y

# Abhängigkeiten installieren
sudo apt install -y \
  curl \
  wget \
  gnupg \
  lsb-release \
  software-properties-common \
  ca-certificates
```

### Podman Repository hinzufügen

```bash
# GPG-Schlüssel hinzufügen
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_22.04/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/podman-archive-keyring.gpg

# Repository hinzufügen
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/podman-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_22.04/ /" | sudo tee /etc/apt/sources.list.d/podman.list

# Paketlisten aktualisieren
sudo apt update
```

### Podman installieren

```bash
# Podman und Tools installieren
sudo apt install -y \
  podman \
  podman-compose \
  podman-docker \
  buildah \
  skopeo \
  slirp4netns \
  fuse-overlayfs \
  uidmap

# Installation verifizieren
podman --version
podman info
```

## 4. Podman konfigurieren

### Benutzer-Namespaces einrichten

```bash
# Subuids und subgids konfigurieren
echo "$USER:100000:65536" | sudo tee -a /etc/subuid
echo "$USER:100000:65536" | sudo tee -a /etc/subgid

# Podman-Konfiguration erstellen
mkdir -p ~/.config/containers
```

### Container-Konfiguration

```bash
# Storage-Konfiguration
nano ~/.config/containers/storage.conf
```

```ini
# storage.conf Inhalt
[storage]
driver = "overlay"
runroot = "/run/user/1000/containers"
graphroot = "/home/dozent/.local/share/containers/storage"

[storage.options]
additionalimagestores = []

[storage.options.overlay]
mountopt = "nodev,metacopy=on"
```

### Registries konfigurieren

```bash
nano ~/.config/containers/registries.conf
```

```ini
# registries.conf Inhalt
[registries.search]
registries = ['docker.io', 'quay.io', 'registry.fedoraproject.org']

[registries.insecure]
registries = ['localhost:5000']

[registries.block]
registries = []
```

### Podman-Service aktivieren

```bash
# Systemd-Service für Podman
systemctl --user enable podman.socket
systemctl --user start podman.socket

# Service-Status prüfen
systemctl --user status podman.socket
```

## 5. Windows-Integration einrichten

### PowerShell-Profile erstellen

```powershell
# PowerShell-Profil erstellen
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# Profil bearbeiten
notepad $PROFILE
```

### Podman-Aliase hinzufügen

```powershell
# In PowerShell-Profil einfügen
# Podman-Funktionen
function podman {
    wsl -d Ubuntu -u $env:USERNAME podman @args
}

function podman-compose {
    wsl -d Ubuntu -u $env:USERNAME podman-compose @args
}

function buildah {
    wsl -d Ubuntu -u $env:USERNAME buildah @args
}

# Pod-Management-Funktionen
function Get-Pods {
    wsl -d Ubuntu podman pod ls
}

function Start-Pod {
    param([string]$Name)
    if ($Name) {
        wsl -d Ubuntu podman pod start $Name
    } else {
        Write-Host "Usage: Start-Pod -Name <pod-name>" -ForegroundColor Yellow
    }
}

function Stop-Pod {
    param([string]$Name)
    if ($Name) {
        wsl -d Ubuntu podman pod stop $Name
    } else {
        Write-Host "Usage: Stop-Pod -Name <pod-name>" -ForegroundColor Yellow
    }
}

function Get-PodLogs {
    param([string]$Name)
    if ($Name) {
        wsl -d Ubuntu podman logs -f $Name
    } else {
        Write-Host "Usage: Get-PodLogs -Name <container-name>" -ForegroundColor Yellow
    }
}

function Remove-StoppedContainers {
    wsl -d Ubuntu podman container prune -f
}

function Get-Containers {
    wsl -d Ubuntu podman ps -a
}

# Quick-Setup Funktion
function New-Pod {
    param(
        [Parameter(Mandatory=$true)][string]$Name,
        [string]$Image = "nginx",
        [string]$Port = "80"
    )
    
    Write-Host "Creating pod: $Name" -ForegroundColor Green
    wsl -d Ubuntu podman pod create --name $Name
    wsl -d Ubuntu podman run -d --pod $Name --name "$Name-container" --restart always -p "${Port}:80" $Image
    Write-Host "Pod $Name started on port $Port" -ForegroundColor Green
    Write-Host "Access via: http://localhost:$Port" -ForegroundColor Cyan
}

# WSL-Status prüfen
function Test-WSL {
    $wslStatus = wsl -l --running
    if ($wslStatus -match "Ubuntu") {
        Write-Host "✓ WSL Ubuntu is running" -ForegroundColor Green
    } else {
        Write-Host "⚠ WSL Ubuntu is not running. Starting..." -ForegroundColor Yellow
        wsl -d Ubuntu echo "WSL Ready"
    }
}

Write-Host "Podman aliases loaded successfully!" -ForegroundColor Green
Write-Host "Available commands:" -ForegroundColor Cyan
Write-Host "  podman, podman-compose, buildah" -ForegroundColor White
Write-Host "  Get-Pods, Start-Pod, Stop-Pod, Get-PodLogs" -ForegroundColor White
Write-Host "  New-Pod, Get-Containers, Remove-StoppedContainers" -ForegroundColor White
Write-Host "  Test-WSL" -ForegroundColor White
```

### PowerShell Execution Policy setzen

```powershell
# Als Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 6. Installation testen

### PowerShell neu starten und testen

```powershell
# Neues PowerShell-Fenster öffnen
# Profil sollte automatisch geladen werden

# Tests durchführen
Test-WSL
podman --version
podman info
```

### Ersten Container starten

```powershell
# Nginx-Container testen
podman run -d --name test-nginx -p 8080:80 nginx

# Status prüfen
Get-Containers

# Im Browser testen: http://localhost:8080

# Container stoppen und entfernen
podman stop test-nginx
podman rm test-nginx
```

### Pod-Funktionalität testen

```powershell
# Pod mit mehreren Containern erstellen
New-Pod -Name "web-stack" -Image "nginx" -Port "8080"

# Pod-Status prüfen
Get-Pods

# Logs anzeigen
Get-PodLogs -Name "web-stack"

# Pod stoppen
Stop-Pod -Name "web-stack"
```

## 7. Automatisierung und Services

### Systemd-Service für wichtige Pods erstellen

```bash
# In WSL2
sudo nano /etc/systemd/system/important-pod.service
```

```ini
# important-pod.service
[Unit]
Description=Important Podman Pod
After=network.target
Wants=network.target

[Service]
Type=forking
User=yourusername
ExecStart=/usr/bin/podman pod start important-pod
ExecStop=/usr/bin/podman pod stop important-pod
ExecReload=/usr/bin/podman pod restart important-pod
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
```

```bash
# Service aktivieren
sudo systemctl daemon-reload
sudo systemctl enable important-pod.service
```

### Autostart für WSL konfigurieren

Einmal als admin ausführen:

```powershell
@'
# WSL-Podman Autostart Task Setup
# Als Administrator ausführen

$action = New-ScheduledTaskAction -Execute "wsl" -Argument "-d Ubuntu-24.04 systemctl --user start podman.socket"
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "WSL-Podman-Autostart" -Action $action -Trigger $trigger -Settings $settings -User $env:USERNAME

Write-Host "✅ WSL-Podman Autostart Task wurde erfolgreich erstellt!" -ForegroundColor Green
Write-Host "Task wird bei jedem Windows-Start ausgeführt." -ForegroundColor Cyan

# Task-Status prüfen
Get-ScheduledTask -TaskName "WSL-Podman-Autostart" | Format-Table TaskName, State, LastRunTime
'@ | Invoke-Expression
```

## 8. Troubleshooting

### Häufige Probleme lösen

```bash
# WSL2-Netzwerk-Reset
wsl --shutdown
# WSL neu starten

# Podman-Konfiguration zurücksetzen
podman system reset

# Storage-Probleme beheben
podman system prune -a -f
```

### Logs und Diagnose

```bash
# Podman-Logs
journalctl --user -u podman.socket -f

# Container-Logs
podman logs <container-name>

# Systemd-Status
systemctl --user status podman.socket
```

### Performance-Optimierung

```bash
# In ~/.bashrc hinzufügen
export CONTAINERS_STORAGE_CONF=$HOME/.config/containers/storage.conf
export CONTAINERS_REGISTRIES_CONF=$HOME/.config/containers/registries.conf
```

## 9. Backup und Wartung

### Regelmäßige Wartung

```powershell
# Aufräum-Skript erstellen
function Invoke-PodmanMaintenance {
    Write-Host "Performing Podman maintenance..." -ForegroundColor Yellow
    
    # Ungenutzte Container entfernen
    wsl -d Ubuntu podman container prune -f
    
    # Ungenutzte Images entfernen
    wsl -d Ubuntu podman image prune -f
    
    # Ungenutzte Volumes entfernen
    wsl -d Ubuntu podman volume prune -f
    
    Write-Host "Maintenance completed!" -ForegroundColor Green
}
```

### Container/Pod-Backup

```bash
# Pod-Definition exportieren
podman generate kube mein-pod > mein-pod-backup.yaml

# Container-Image exportieren  
podman save -o backup-image.tar mein-image:latest
```

Die Installation ist jetzt komplett! Sie können Podman nahtlos von Windows PowerShell aus verwenden, als wäre es nativ installiert.
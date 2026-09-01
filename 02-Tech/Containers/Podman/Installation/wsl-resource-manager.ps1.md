
```PowerShell
# WSL Ressourcen-Manager - Komplettlösung
# Kombiniert Hardware-Analyse, Konfiguration und Monitoring

param(
    [ValidateSet("Analyze", "Configure", "Monitor", "Optimize", "Reset")]
    [string]$Action = "Analyze",
    [switch]$Interactive,
    [switch]$Force
)

# Globale Variablen
$Script:WSLConfigPath = "$env:USERPROFILE\.wslconfig"
$Script:BackupPath = "$env:USERPROFILE\.wslconfig.backups"

function Write-Header {
    param([string]$Title, [string]$Color = "Green")
    
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor $Color
    Write-Host "║" -NoNewline -ForegroundColor $Color
    Write-Host " $Title".PadRight(62) -NoNewline -ForegroundColor White
    Write-Host "║" -ForegroundColor $Color
    Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor $Color
    Write-Host ""
}

function Get-QuickSystemInfo {
    $cpu = Get-CimInstance Win32_Processor
    $memory = Get-CimInstance Win32_ComputerSystem
    $os = Get-CimInstance Win32_OperatingSystem
    
    return @{
        CPUName = $cpu.Name
        CPUCores = $cpu.NumberOfCores
        CPULogical = $cpu.NumberOfLogicalProcessors
        TotalMemoryGB = [math]::Round($memory.TotalPhysicalMemory / 1GB, 2)
        FreeMemoryGB = [math]::Round($os.FreePhysicalMemory / 1MB / 1024, 2)
        OSName = $os.Caption
        OSVersion = $os.Version
    }
}

function Show-SystemOverview {
    $info = Get-QuickSystemInfo
    
    Write-Host "🖥️  SYSTEM-ÜBERSICHT" -ForegroundColor Cyan
    Write-Host "─────────────────────" -ForegroundColor DarkCyan
    Write-Host "OS: $($info.OSName) ($($info.OSVersion))" -ForegroundColor White
    Write-Host "CPU: $($info.CPUName)" -ForegroundColor White
    Write-Host "     $($info.CPUCores) Kerne / $($info.CPULogical) Threads" -ForegroundColor Gray
    Write-Host "RAM: $($info.TotalMemoryGB) GB gesamt / $($info.FreeMemoryGB) GB frei" -ForegroundColor White
    
    # WSL-Status
    $wslRunning = try { (wsl -l --running 2>$null).Count -gt 1 } catch { $false }
    $wslStatus = if ($wslRunning) { "🟢 Aktiv" } else { "🔴 Inaktiv" }
    Write-Host "WSL: $wslStatus" -ForegroundColor White
    
    return $info
}

function Get-CurrentWSLConfig {
    if (Test-Path $Script:WSLConfigPath) {
        $config = @{}
        Get-Content $Script:WSLConfigPath | ForEach-Object {
            if ($_ -match "^(\w+)=(.+)$") {
                $config[$matches[1]] = $matches[2]
            }
        }
        return $config
    }
    return $null
}

function Show-WSLConfigStatus {
    Write-Host ""
    Write-Host "⚙️  WSL-KONFIGURATION" -ForegroundColor Cyan
    Write-Host "────────────────────" -ForegroundColor DarkCyan
    
    $config = Get-CurrentWSLConfig
    if ($config) {
        Write-Host "📄 Konfigurationsdatei: Vorhanden" -ForegroundColor Green
        Write-Host "   Pfad: $Script:WSLConfigPath" -ForegroundColor Gray
        
        foreach ($key in @("memory", "processors", "swap")) {
            if ($config.ContainsKey($key)) {
                $value = $config[$key]
                $icon = switch ($key) {
                    "memory" { "💾" }
                    "processors" { "🖥️" }
                    "swap" { "🔄" }
                }
                Write-Host "   $icon $key`: $value" -ForegroundColor White
            }
        }
    } else {
        Write-Host "📄 Konfigurationsdatei: Nicht vorhanden" -ForegroundColor Yellow
        Write-Host "   Standard-Einstellungen werden verwendet" -ForegroundColor Gray
    }
}

function Get-SmartRecommendations {
    param($SystemInfo)
    
    $recommendations = @{
        Conservative = @{
            Memory = [math]::Max(2, [math]::Floor($SystemInfo.TotalMemoryGB * 0.25))
            Processors = [math]::Max(1, [math]::Floor($SystemInfo.CPULogical * 0.5))
            Description = "Sicher für alle Systeme"
            UseCase = "Gelegentliche Container-Nutzung"
        }
        Balanced = @{
            Memory = [math]::Max(4, [math]::Floor($SystemInfo.TotalMemoryGB * 0.5))
            Processors = [math]::Max(2, [math]::Floor($SystemInfo.CPULogical * 0.75))
            Description = "Ausgewogen für die meisten Nutzer"
            UseCase = "Regelmäßige Entwicklung, Podman"
        }
        Performance = @{
            Memory = [math]::Max(6, [math]::Floor($SystemInfo.TotalMemoryGB * 0.75))
            Processors = [math]::Max(2, $SystemInfo.CPULogical - 1)
            Description = "Maximale WSL-Performance"
            UseCase = "Intensive Container-Workloads"
        }
    }
    
    # Intelligente Anpassungen basierend auf Hardware
    if ($SystemInfo.TotalMemoryGB -le 8) {
        # Systeme mit wenig RAM
        $recommendations.Balanced.Memory = [math]::Min(4, $recommendations.Balanced.Memory)
        $recommendations.Performance.Memory = [math]::Min(6, $recommendations.Performance.Memory)
    }
    
    if ($SystemInfo.CPUCores -le 2) {
        # Systeme mit wenigen Kernen
        $recommendations.Performance.Processors = [math]::Max(1, $SystemInfo.CPULogical - 1)
    }
    
    # Swap-Berechnung
    foreach ($profile in $recommendations.Keys) {
        $memGB = $recommendations[$profile].Memory
        $recommendations[$profile].Swap = [math]::Min(8, [math]::Max(2, [math]::Floor($memGB * 0.5)))
    }
    
    return $recommendations
}

function Show-RecommendationMatrix {
    param($SystemInfo, $Recommendations)
    
    Write-Host ""
    Write-Host "📊 EMPFOHLENE KONFIGURATIONEN" -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor DarkCyan
    
    $currentConfig = Get-CurrentWSLConfig
    
    foreach ($profileName in @("Conservative", "Balanced", "Performance")) {
        $profile = $Recommendations[$profileName]
        $isCurrent = $false
        
        # Prüfen ob aktuelle Konfiguration dieser entspricht
        if ($currentConfig) {
            $memMatch = $currentConfig["memory"] -eq "$($profile.Memory)GB"
            $procMatch = $currentConfig["processors"] -eq "$($profile.Processors)"
            $isCurrent = $memMatch -and $procMatch
        }
        
        $status = if ($isCurrent) { "🟢 AKTIV" } else { "" }
        
        Write-Host ""
        Write-Host "💡 $profileName $status" -ForegroundColor Yellow
        Write-Host "   $($profile.Description)" -ForegroundColor Gray
        Write-Host "   Use Case: $($profile.UseCase)" -ForegroundColor Gray
        Write-Host "   📊 RAM: $($profile.Memory) GB | 🖥️  CPU: $($profile.Processors) Kerne | 🔄 Swap: $($profile.Swap) GB" -ForegroundColor White
        
        # Auswirkungen anzeigen
        $memPercent = [math]::Round(($profile.Memory / $SystemInfo.TotalMemoryGB) * 100, 1)
        $cpuPercent = [math]::Round(($profile.Processors / $SystemInfo.CPULogical) * 100, 1)
        Write-Host "   📈 Auswirkung: $memPercent% RAM, $cpuPercent% CPU-Kerne" -ForegroundColor Magenta
    }
}

function Invoke-ConfigurationWizard {
    param($SystemInfo, $Recommendations)
    
    Write-Header "KONFIGURATIONS-ASSISTENT" "Yellow"
    
    Show-RecommendationMatrix -SystemInfo $SystemInfo -Recommendations $Recommendations
    
    Write-Host ""
    Write-Host "Wählen Sie eine Konfiguration:" -ForegroundColor Cyan
    Write-Host "1. Conservative - Minimal (empfohlen für schwächere Systeme)" -ForegroundColor Green
    Write-Host "2. Balanced - Ausgewogen (empfohlen für die meisten Nutzer)" -ForegroundColor Green
    Write-Host "3. Performance - Maximal (für leistungsstarke Systeme)" -ForegroundColor Green
    Write-Host "4. Benutzerdefiniert" -ForegroundColor Yellow
    Write-Host "0. Abbrechen" -ForegroundColor Red
    
    do {
        $choice = Read-Host "`nIhre Wahl (0-4)"
    } while ($choice -notmatch "^[0-4]$")
    
    switch ($choice) {
        "0" { 
            Write-Host "Abgebrochen." -ForegroundColor Yellow
            return $null
        }
        "1" { return @{ Name = "Conservative"; Config = $Recommendations.Conservative } }
        "2" { return @{ Name = "Balanced"; Config = $Recommendations.Balanced } }
        "3" { return @{ Name = "Performance"; Config = $Recommendations.Performance } }
        "4" {
            return Invoke-CustomConfiguration -SystemInfo $SystemInfo
        }
    }
}

function Invoke-CustomConfiguration {
    param($SystemInfo)
    
    Write-Host ""
    Write-Host "🛠️  BENUTZERDEFINIERTE KONFIGURATION" -ForegroundColor Cyan
    Write-Host ""
    
    # RAM-Eingabe
    do {
        Write-Host "Verfügbarer RAM: $($SystemInfo.TotalMemoryGB) GB" -ForegroundColor Gray
        $customMemory = Read-Host "WSL-RAM in GB (1-$([math]::Floor($SystemInfo.TotalMemoryGB * 0.9)))"
    } while ($customMemory -notmatch "^\d+$" -or [int]$customMemory -lt 1 -or [int]$customMemory -gt ($SystemInfo.TotalMemoryGB * 0.9))
    
    # CPU-Eingabe
    do {
        Write-Host "Verfügbare CPU-Kerne: $($SystemInfo.CPULogical)" -ForegroundColor Gray
        $customCPU = Read-Host "WSL-CPU-Kerne (1-$($SystemInfo.CPULogical))"
    } while ($customCPU -notmatch "^\d+$" -or [int]$customCPU -lt 1 -or [int]$customCPU -gt $SystemInfo.CPULogical)
    
    # Swap-Eingabe
    do {
        $suggestedSwap = [math]::Max(2, [math]::Min(8, [int]$customMemory / 2))
        Write-Host "Empfohlener Swap: $suggestedSwap GB" -ForegroundColor Gray
        $customSwap = Read-Host "WSL-Swap in GB (0-16, Enter für $suggestedSwap)"
        if ([string]::IsNullOrEmpty($customSwap)) { $customSwap = $suggestedSwap }
    } while ($customSwap -notmatch "^\d+$" -or [int]$customSwap -lt 0 -or [int]$customSwap -gt 16)
    
    return @{
        Name = "Benutzerdefiniert"
        Config = @{
            Memory = [int]$customMemory
            Processors = [int]$customCPU
            Swap = [int]$customSwap
            Description = "Individuelle Konfiguration"
        }
    }
}

function Set-WSLConfiguration {
    param($ConfigName, $Config)
    
    # Backup erstellen
    if (Test-Path $Script:WSLConfigPath) {
        if (!(Test-Path $Script:BackupPath)) {
            New-Item -ItemType Directory -Path $Script:BackupPath -Force | Out-Null
        }
        $backupFile = "$Script:BackupPath\.wslconfig.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $Script:WSLConfigPath $backupFile
        Write-Host "💾 Backup erstellt: $backupFile" -ForegroundColor Green
    }
    
    # Neue Konfiguration erstellen
    $configContent = @"
# WSL2-Konfiguration: $ConfigName
# Erstellt: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
# System: $($env:COMPUTERNAME)

[wsl2]
# Speicher-Zuteilung
memory=$($Config.Memory)GB

# CPU-Kerne
processors=$($Config.Processors)

# Swap-Speicher  
swap=$($Config.Swap)GB

# Netzwerk-Einstellungen
localhostForwarding=true

# Performance-Optimierungen
nestedVirtualization=true
kernelCommandLine=cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1

# Sicherheits-Einstellungen
debugConsole=false
"@

    $configContent | Out-File -FilePath $Script:WSLConfigPath -Encoding UTF8
    
    Write-Host ""
    Write-Host "✅ WSL-Konfiguration '$ConfigName' erfolgreich erstellt!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 ERSTELLTE KONFIGURATION:" -ForegroundColor Cyan
    Write-Host "   💾 RAM: $($Config.Memory) GB" -ForegroundColor White
    Write-Host "   🖥️  CPU: $($Config.Processors) Kerne" -ForegroundColor White  
    Write-Host "   🔄 Swap: $($Config.Swap) GB" -ForegroundColor White
    Write-Host ""
    Write-Host "⚠️  WICHTIGE SCHRITTE:" -ForegroundColor Yellow
    Write-Host "   1. WSL herunterfahren: wsl --shutdown" -ForegroundColor White
    Write-Host "   2. WSL neu starten für neue Konfiguration" -ForegroundColor White
    Write-Host "   3. Bei Problemen: Backup wiederherstellen" -ForegroundColor White
    
    # Automatisch WSL neustarten anbieten
    if (!$Force) {
        $restart = Read-Host "`nWSL jetzt automatisch neu starten? (j/N)"
        if ($restart -match "^[jJ]") {
            Write-Host "🔄 Starte WSL neu..." -ForegroundColor Yellow
            wsl --shutdown
            Start-Sleep -Seconds 3
            try {
                wsl -d Ubuntu echo "WSL erfolgreich neu gestartet"
                Write-Host "✅ WSL erfolgreich neu gestartet!" -ForegroundColor Green
            } catch {
                Write-Host "⚠️  WSL-Neustart fehlgeschlagen. Manuell neu starten." -ForegroundColor Yellow
            }
        }
    }
}

function Start-ResourceMonitoring {
    Write-Header "RESSOURCEN-MONITORING" "Blue"
    
    Write-Host "Starte Live-Monitoring..." -ForegroundColor Cyan
    Write-Host "Drücken Sie Strg+C zum Beenden" -ForegroundColor Gray
    Write-Host ""
    
    try {
        while ($true) {
            $systemInfo = Get-QuickSystemInfo
            $timestamp = Get-Date -Format "HH:mm:ss"
            
            # Aktuelle Nutzung ermitteln
            $memUsed = $systemInfo.TotalMemoryGB - $systemInfo.FreeMemoryGB
            $memPercent = [math]::Round(($memUsed / $systemInfo.TotalMemoryGB) * 100, 1)
            
            $cpuCounter = Get-Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 1
            $cpuPercent = [math]::Round(100 - $cpuCounter.CounterSamples.CookedValue, 1)
            
            # WSL-Status
            $wslRunning = try { (wsl -l --running 2>$null).Count -gt 1 } catch { $false }
            $wslStatus = if ($wslRunning) { "🟢" } else { "🔴" }
            
            # Anzeige
            Clear-Host
            Write-Host "🔍 LIVE RESSOURCEN-MONITOR - $timestamp" -ForegroundColor Green
            Write-Host "═══════════════════════════════════════" -ForegroundColor Green
            Write-Host ""
            Write-Host "💾 RAM: $memUsed GB / $($systemInfo.TotalMemoryGB) GB ($memPercent%)" -ForegroundColor White
            
            # RAM-Balken
            $barLength = 30
            $usedBars = [math]::Floor(($memPercent / 100) * $barLength)
            $freeBars = $barLength - $usedBars
            $color = if ($memPercent -gt 80) { "Red" } elseif ($memPercent -gt 60) { "Yellow" } else { "Green" }
            
            Write-Host "     [" -NoNewline
            Write-Host ("█" * $usedBars) -ForegroundColor $color -NoNewline
            Write-Host ("░" * $freeBars) -ForegroundColor DarkGray -NoNewline
            Write-Host "]"
            
            Write-Host "🖥️  CPU: $cpuPercent%" -ForegroundColor White
            Write-Host "🐧 WSL: $wslStatus $(if ($wslRunning) { 'Aktiv' } else { 'Inaktiv' })" -ForegroundColor White
            
            Start-Sleep -Seconds 2
        }
    } catch {
        Write-Host ""
        Write-Host "Monitoring beendet." -ForegroundColor Yellow
    }
}

function Reset-WSLConfiguration {
    if (Test-Path $Script:WSLConfigPath) {
        $backup = "$Script:WSLConfigPath.reset-backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Move-Item $Script:WSLConfigPath $backup
        Write-Host "✅ WSL-Konfiguration zurückgesetzt" -ForegroundColor Green
        Write-Host "📄 Backup erstellt: $backup" -ForegroundColor Cyan
        Write-Host "⚠️  WSL neustarten: wsl --shutdown" -ForegroundColor Yellow
    } else {
        Write-Host "ℹ️  Keine WSL-Konfiguration vorhanden" -ForegroundColor Blue
    }
}

function Show-MainMenu {
    Write-Header "WSL RESSOURCEN-MANAGER" "Green"
    
    $systemInfo = Show-SystemOverview
    Show-WSLConfigStatus
    
    Write-Host ""
    Write-Host "🎯 VERFÜGBARE AKTIONEN:" -ForegroundColor Cyan
    Write-Host "1. 📊 Detaillierte Hardware-Analyse" -ForegroundColor White
    Write-Host "2. ⚙️  WSL-Konfiguration erstellen/ändern" -ForegroundColor White
    Write-Host "3. 📈 Live-Ressourcen-Monitoring" -ForegroundColor White
    Write-Host "4. 🔧 System optimieren" -ForegroundColor White
    Write-Host "5. 🔄 Konfiguration zurücksetzen" -ForegroundColor White
    Write-Host "0. 🚪 Beenden" -ForegroundColor Red
    
    do {
        $choice = Read-Host "`nWählen Sie eine Aktion (0-5)"
    } while ($choice -notmatch "^[0-5]$")
    
    return @{
        Choice = $choice
        SystemInfo = $systemInfo
    }
}

function Start-DetailedAnalysis {
    Write-Header "DETAILLIERTE HARDWARE-ANALYSE" "Cyan"
    
    Write-Host "🔍 Analysiere Hardware-Komponenten..." -ForegroundColor Yellow
    
    # CPU-Details
    $cpu = Get-CimInstance Win32_Processor
    Write-Host ""
    Write-Host "🖥️  PROZESSOR:" -ForegroundColor Cyan
    Write-Host "   Name: $($cpu.Name)" -ForegroundColor White
    Write-Host "   Hersteller: $($cpu.Manufacturer)" -ForegroundColor White
    Write-Host "   Kerne: $($cpu.NumberOfCores) physisch / $($cpu.NumberOfLogicalProcessors) logisch" -ForegroundColor White
    Write-Host "   Basis-Takt: $([math]::Round($cpu.MaxClockSpeed / 1000, 2)) GHz" -ForegroundColor White
    Write-Host "   Architektur: $(if($cpu.AddressWidth -eq 64){'64-bit'}else{'32-bit'})" -ForegroundColor White
    
    # Empfehlung basierend auf CPU
    if ($cpu.NumberOfLogicalProcessors -ge 8) {
        Write-Host "   💡 Empfehlung: Leistungsstarke CPU - Performance-Konfiguration möglich" -ForegroundColor Green
    } elseif ($cpu.NumberOfLogicalProcessors -ge 4) {
        Write-Host "   💡 Empfehlung: Gute CPU - Balanced-Konfiguration empfohlen" -ForegroundColor Yellow
    } else {
        Write-Host "   💡 Empfehlung: Schwächere CPU - Conservative-Konfiguration empfohlen" -ForegroundColor Red
    }
    
    # RAM-Details
    $memory = Get-CimInstance Win32_ComputerSystem
    $memModules = Get-CimInstance Win32_PhysicalMemory
    $totalMemGB = [math]::Round($memory.TotalPhysicalMemory / 1GB, 2)
    
    Write-Host ""
    Write-Host "💾 ARBEITSSPEICHER:" -ForegroundColor Cyan
    Write-Host "   Gesamt: $totalMemGB GB" -ForegroundColor White
    Write-Host "   Module: $($memModules.Count)" -ForegroundColor White
    
    foreach ($module in $memModules) {
        $moduleGB = [math]::Round($module.Capacity / 1GB, 0)
        $speed = if($module.Speed){$module.Speed}else{"Unbekannt"}
        Write-Host "     - $moduleGB GB @ $speed MHz" -ForegroundColor Gray
    }
    
    # RAM-Empfehlung
    if ($totalMemGB -ge 16) {
        Write-Host "   💡 Empfehlung: Viel RAM - Performance-Konfiguration empfohlen" -ForegroundColor Green
    } elseif ($totalMemGB -ge 8) {
        Write-Host "   💡 Empfehlung: Ausreichend RAM - Balanced-Konfiguration möglich" -ForegroundColor Yellow
    } else {
        Write-Host "   💡 Empfehlung: Wenig RAM - Conservative-Konfiguration empfohlen" -ForegroundColor Red
    }
    
    # Festplatten-Details
    $disks = Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    Write-Host ""
    Write-Host "💽 SPEICHER:" -ForegroundColor Cyan
    
    foreach ($disk in $disks) {
        $totalGB = [math]::Round($disk.Size / 1GB, 2)
        $freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
        $usedPercent = [math]::Round((($totalGB - $freeGB) / $totalGB) * 100, 1)
        
        Write-Host "   Laufwerk $($disk.DeviceID) $totalGB GB (Belegt: $usedPercent%)" -ForegroundColor White
        
        if ($freeGB -lt 10) {
            Write-Host "     ⚠️  Kritisch wenig Speicher!" -ForegroundColor Red
        } elseif ($freeGB -lt 30) {
            Write-Host "     ⚠️  Wenig freier Speicher" -ForegroundColor Yellow
        } else {
            Write-Host "     ✅ Ausreichend Speicher" -ForegroundColor Green
        }
    }
    
    # Virtualisierung prüfen
    Write-Host ""
    Write-Host "🔧 VIRTUALISIERUNG:" -ForegroundColor Cyan
    
    try {
        $hypervFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -ErrorAction SilentlyContinue
        $wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -ErrorAction SilentlyContinue
        
        $hypervStatus = if ($hypervFeature) { $hypervFeature.State } else { "Nicht verfügbar" }
        $wslStatus = if ($wslFeature) { $wslFeature.State } else { "Nicht verfügbar" }
        
        Write-Host "   Hyper-V: $hypervStatus" -ForegroundColor White
        Write-Host "   WSL: $wslStatus" -ForegroundColor White
        
        if ($wslStatus -eq "Enabled") {
            Write-Host "   ✅ WSL ist korrekt aktiviert" -ForegroundColor Green
        } else {
            Write-Host "   ❌ WSL ist nicht aktiviert!" -ForegroundColor Red
        }
    } catch {
        Write-Host "   ⚠️  Virtualisierungsstatus konnte nicht ermittelt werden" -ForegroundColor Yellow
    }
    
    Read-Host "`nDrücken Sie Enter zum Fortfahren"
}

function Start-SystemOptimization {
    Write-Header "SYSTEM-OPTIMIERUNG" "Green"
    
    Write-Host "🔧 Führe System-Optimierungen durch..." -ForegroundColor Yellow
    Write-Host ""
    
    $optimizations = @()
    
    # WSL-Konfiguration prüfen
    $currentConfig = Get-CurrentWSLConfig
    if (!$currentConfig) {
        $optimizations += "📄 Keine WSL-Konfiguration vorhanden"
        Write-Host "⚠️  Keine WSL-Konfiguration gefunden" -ForegroundColor Yellow
    } else {
        Write-Host "✅ WSL-Konfiguration vorhanden" -ForegroundColor Green
    }
    
    # Speicherplatz prüfen
    $systemDrive = Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DeviceID -eq "C:"}
    $freeSpaceGB = [math]::Round($systemDrive.FreeSpace / 1GB, 2)
    
    if ($freeSpaceGB -lt 20) {
        $optimizations += "💽 Kritisch wenig Speicherplatz ($freeSpaceGB GB frei)"
        Write-Host "❌ Kritisch wenig Speicherplatz!" -ForegroundColor Red
    } elseif ($freeSpaceGB -lt 50) {
        $optimizations += "💽 Wenig Speicherplatz ($freeSpaceGB GB frei)"
        Write-Host "⚠️  Wenig Speicherplatz" -ForegroundColor Yellow
    } else {
        Write-Host "✅ Ausreichend Speicherplatz ($freeSpaceGB GB frei)" -ForegroundColor Green
    }
    
    # Windows Update Status (vereinfacht)
    try {
        $updateSession = New-Object -ComObject Microsoft.Update.Session -ErrorAction SilentlyContinue
        if ($updateSession) {
            Write-Host "✅ Windows Update-Service verfügbar" -ForegroundColor Green
        }
    } catch {
        $optimizations += "🔄 Windows Update-Service Probleme"
        Write-Host "⚠️  Windows Update-Service Probleme" -ForegroundColor Yellow
    }
    
    # WSL-Service Status
    try {
        $wslRunning = (wsl -l --running 2>$null).Count -gt 1
        if ($wslRunning) {
            Write-Host "✅ WSL läuft ordnungsgemäß" -ForegroundColor Green
        } else {
            Write-Host "ℹ️  WSL läuft aktuell nicht" -ForegroundColor Blue
        }
    } catch {
        $optimizations += "🐧 WSL-Service Probleme"
        Write-Host "⚠️  WSL-Service Probleme" -ForegroundColor Yellow
    }
    
    # Performance-Counter prüfen
    try {
        $perfCounter = Get-Counter "\Memory\Available MBytes" -MaxSamples 1 -ErrorAction Stop
        $availableMemGB = [math]::Round($perfCounter.CounterSamples.CookedValue / 1024, 2)
        Write-Host "✅ Performance-Counter funktionieren ($availableMemGB GB RAM verfügbar)" -ForegroundColor Green
    } catch {
        $optimizations += "📊 Performance-Counter Probleme"
        Write-Host "⚠️  Performance-Counter Probleme" -ForegroundColor Yellow
    }
    
    Write-Host ""
    
    if ($optimizations.Count -eq 0) {
        Write-Host "🎉 Keine Optimierungen erforderlich!" -ForegroundColor Green
        Write-Host "   Ihr System ist optimal konfiguriert." -ForegroundColor White
    } else {
        Write-Host "📋 GEFUNDENE OPTIMIERUNGSMÖGLICHKEITEN:" -ForegroundColor Yellow
        foreach ($opt in $optimizations) {
            Write-Host "   $opt" -ForegroundColor White
        }
        
        Write-Host ""
        Write-Host "💡 EMPFOHLENE AKTIONEN:" -ForegroundColor Cyan
        Write-Host "   1. Festplatte bereinigen (Windows Datenträgerbereinigung)" -ForegroundColor White
        Write-Host "   2. WSL-Konfiguration erstellen falls nicht vorhanden" -ForegroundColor White
        Write-Host "   3. Unnötige Programme deinstallieren" -ForegroundColor White
        Write-Host "   4. Windows Updates installieren" -ForegroundColor White
    }
    
    Read-Host "`nDrücken Sie Enter zum Fortfahren"
}

# Hauptprogramm
function Start-WSLResourceManager {
    if ($Interactive -or $Action -eq "Menu") {
        while ($true) {
            $menuResult = Show-MainMenu
            $systemInfo = $menuResult.SystemInfo
            
            switch ($menuResult.Choice) {
                "0" { 
                    Write-Host "Auf Wiedersehen! 👋" -ForegroundColor Green
                    break
                }
                "1" { 
                    Start-DetailedAnalysis
                }
                "2" { 
                    $recommendations = Get-SmartRecommendations -SystemInfo $systemInfo
                    $configChoice = Invoke-ConfigurationWizard -SystemInfo $systemInfo -Recommendations $recommendations
                    if ($configChoice) {
                        Set-WSLConfiguration -ConfigName $configChoice.Name -Config $configChoice.Config
                        Read-Host "`nDrücken Sie Enter zum Fortfahren"
                    }
                }
                "3" { 
                    Start-ResourceMonitoring
                }
                "4" { 
                    Start-SystemOptimization
                }
                "5" { 
                    Reset-WSLConfiguration
                    Read-Host "`nDrücken Sie Enter zum Fortfahren"
                }
            }
            
            if ($menuResult.Choice -eq "0") { break }
        }
    } else {
        # Nicht-interaktiver Modus
        $systemInfo = Get-QuickSystemInfo
        
        switch ($Action) {
            "Analyze" {
                Write-Header "HARDWARE-ANALYSE" "Cyan"
                Show-SystemOverview | Out-Null
                Show-WSLConfigStatus
                
                $recommendations = Get-SmartRecommendations -SystemInfo $systemInfo
                Show-RecommendationMatrix -SystemInfo $systemInfo -Recommendations $recommendations
            }
            "Configure" {
                Write-Header "AUTOMATISCHE KONFIGURATION" "Yellow"
                $recommendations = Get-SmartRecommendations -SystemInfo $systemInfo
                $balancedConfig = @{ Name = "Balanced"; Config = $recommendations.Balanced }
                Set-WSLConfiguration -ConfigName $balancedConfig.Name -Config $balancedConfig.Config
            }
            "Monitor" {
                Start-ResourceMonitoring
            }
            "Optimize" {
                Start-SystemOptimization
            }
            "Reset" {
                Reset-WSLConfiguration
            }
        }
    }
}

# Script-Ausführung
try {
    # Parameter-Validierung
    if (!$Interactive -and $Action -eq "Analyze") {
        $Interactive = $true  # Standard für erste Nutzung
    }
    
    Start-WSLResourceManager
    
} catch {
    Write-Host ""
    Write-Host "❌ Unerwarteter Fehler: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "🔧 Bitte starten Sie das Script als Administrator." -ForegroundColor Yellow
    
    if ($_.Exception.Message -match "Access.*denied") {
        Write-Host "💡 Tipp: Rechtsklick auf PowerShell -> 'Als Administrator ausführen'" -ForegroundColor Cyan
    }
} finally {
    Write-Host ""
}
```

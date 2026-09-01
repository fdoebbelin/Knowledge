
```PowerShell
# WSL Hardware-Analyzer und Ressourcen-Optimizer
# Ermittelt Systemressourcen und erstellt optimale WSL-Konfiguration

param(
    [switch]$CreateConfig,
    [switch]$Detailed,
    [switch]$Interactive
)

# Farben für bessere Lesbarkeit
function Write-ColoredOutput {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

function Write-Section {
    param([string]$Title)
    Write-Host "`n" -NoNewline
    Write-Host "="*60 -ForegroundColor Cyan
    Write-Host " $Title " -ForegroundColor Yellow -BackgroundColor DarkBlue
    Write-Host "="*60 -ForegroundColor Cyan
}

function Get-SystemHardware {
    Write-Section "HARDWARE-ANALYSE"
    
    # CPU-Informationen
    Write-ColoredOutput "`n🖥️  CPU-INFORMATIONEN:" "Cyan"
    $cpu = Get-CimInstance -ClassName Win32_Processor
    $cpuCores = $cpu.NumberOfCores
    $cpuLogicalProcessors = $cpu.NumberOfLogicalProcessors
    $cpuName = $cpu.Name
    $cpuMaxClockSpeed = $cpu.MaxClockSpeed
    
    Write-ColoredOutput "   Name: $cpuName" "White"
    Write-ColoredOutput "   Physische Kerne: $cpuCores" "Green"
    Write-ColoredOutput "   Logische Prozessoren: $cpuLogicalProcessors" "Green"
    Write-ColoredOutput "   Max. Taktfrequenz: $([math]::Round($cpuMaxClockSpeed/1000, 2)) GHz" "Green"
    
    # RAM-Informationen
    Write-ColoredOutput "`n💾 ARBEITSSPEICHER:" "Cyan"
    $memory = Get-CimInstance -ClassName Win32_ComputerSystem
    $totalMemoryGB = [math]::Round($memory.TotalPhysicalMemory / 1GB, 2)
    
    # Verfügbarer RAM
    $availableMemory = Get-Counter -Counter "\Memory\Available MBytes" -SampleInterval 1 -MaxSamples 1
    $availableMemoryGB = [math]::Round($availableMemory.CounterSamples.CookedValue / 1024, 2)
    $usedMemoryGB = [math]::Round($totalMemoryGB - $availableMemoryGB, 2)
    
    Write-ColoredOutput "   Gesamt-RAM: $totalMemoryGB GB" "Green"
    Write-ColoredOutput "   Verwendet: $usedMemoryGB GB ($([math]::Round(($usedMemoryGB/$totalMemoryGB)*100, 1))%)" "Yellow"
    Write-ColoredOutput "   Verfügbar: $availableMemoryGB GB ($([math]::Round(($availableMemoryGB/$totalMemoryGB)*100, 1))%)" "Green"
    
    # Speicher-Module Details
    $memoryModules = Get-CimInstance -ClassName Win32_PhysicalMemory
    Write-ColoredOutput "   RAM-Module:" "White"
    foreach ($module in $memoryModules) {
        $moduleSize = [math]::Round($module.Capacity / 1GB, 0)
        $moduleSpeed = $module.Speed
        Write-ColoredOutput "     - $moduleSize GB @ $moduleSpeed MHz" "Gray"
    }
    
    # Festplatten-Informationen
    Write-ColoredOutput "`n💽 SPEICHER:" "Cyan"
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    foreach ($disk in $disks) {
        $totalSize = [math]::Round($disk.Size / 1GB, 2)
        $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
        $usedSpace = [math]::Round($totalSize - $freeSpace, 2)
        $usedPercent = [math]::Round(($usedSpace/$totalSize)*100, 1)
        
        Write-ColoredOutput "   Laufwerk $($disk.DeviceID)" "White"
        Write-ColoredOutput "     Gesamt: $totalSize GB" "Green"
        Write-ColoredOutput "     Belegt: $usedSpace GB ($usedPercent%)" "Yellow"
        Write-ColoredOutput "     Frei: $freeSpace GB" "Green"
    }
    
    # Detaillierte Systeminfo falls gewünscht
    if ($Detailed) {
        Write-ColoredOutput "`n🔧 ERWEITERTE SYSTEM-INFORMATIONEN:" "Cyan"
        
        # Mainboard
        $motherboard = Get-CimInstance -ClassName Win32_BaseBoard
        Write-ColoredOutput "   Mainboard: $($motherboard.Product) ($($motherboard.Manufacturer))" "White"
        
        # BIOS/UEFI
        $bios = Get-CimInstance -ClassName Win32_BIOS
        Write-ColoredOutput "   BIOS: $($bios.Version) ($($bios.ReleaseDate))" "White"
        
        # Windows-Version
        $os = Get-CimInstance -ClassName Win32_OperatingSystem
        Write-ColoredOutput "   OS: $($os.Caption) Build $($os.BuildNumber)" "White"
        Write-ColoredOutput "   Installation: $($os.InstallDate)" "White"
        
        # Virtualisierung
        $hyperv = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
        $wsl = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        Write-ColoredOutput "   Hyper-V: $($hyperv.State)" "White"
        Write-ColoredOutput "   WSL: $($wsl.State)" "White"
    }
    
    return @{
        CPUCores = $cpuCores
        CPULogicalProcessors = $cpuLogicalProcessors
        TotalMemoryGB = $totalMemoryGB
        AvailableMemoryGB = $availableMemoryGB
        UsedMemoryGB = $usedMemoryGB
        FreeSpaceGB = ($disks | Where-Object {$_.DeviceID -eq "C:"}).FreeSpace / 1GB
    }
}

function Get-WSLCurrentConfig {
    Write-Section "AKTUELLE WSL-KONFIGURATION"
    
    $wslConfigPath = "$env:USERPROFILE\.wslconfig"
    
    if (Test-Path $wslConfigPath) {
        Write-ColoredOutput "📄 Aktuelle .wslconfig gefunden:" "Green"
        Write-ColoredOutput "   Pfad: $wslConfigPath" "White"
        Write-ColoredOutput "`nInhalt:" "Yellow"
        Get-Content $wslConfigPath | ForEach-Object {
            Write-ColoredOutput "   $_" "Gray"
        }
    } else {
        Write-ColoredOutput "📄 Keine .wslconfig gefunden - Standard-Einstellungen aktiv" "Yellow"
    }
    
    # Aktuelle WSL-Nutzung ermitteln
    Write-ColoredOutput "`n🔍 AKTUELLE WSL-RESSOURCENNUTZUNG:" "Cyan"
    
    try {
        # WSL-Status prüfen
        $wslStatus = wsl -l --running 2>$null
        if ($wslStatus) {
            Write-ColoredOutput "   Laufende WSL-Instanzen:" "Green"
            $wslStatus | ForEach-Object {
                if ($_ -ne "" -and $_ -notmatch "Windows-Subsystem") {
                    Write-ColoredOutput "     - $_" "White"
                }
            }
            
            # Memory-Nutzung in WSL (falls möglich)
            try {
                $wslMemInfo = wsl -e free -h 2>$null
                if ($wslMemInfo) {
                    Write-ColoredOutput "`n   WSL Memory-Info:" "Yellow"
                    $wslMemInfo | ForEach-Object {
                        Write-ColoredOutput "     $_" "Gray"
                    }
                }
            } catch {
                Write-ColoredOutput "   WSL Memory-Info nicht verfügbar" "Yellow"
            }
        } else {
            Write-ColoredOutput "   Keine WSL-Instanzen laufen aktuell" "Yellow"
        }
    } catch {
        Write-ColoredOutput "   WSL-Status konnte nicht ermittelt werden" "Red"
    }
}

function Calculate-OptimalResources {
    param($SystemInfo)
    
    Write-Section "RESSOURCEN-EMPFEHLUNGEN"
    
    # CPU-Empfehlungen
    $recommendedCPUs = [math]::Max(1, [math]::Floor($SystemInfo.CPULogicalProcessors * 0.75))
    $conservativeCPUs = [math]::Max(1, [math]::Floor($SystemInfo.CPULogicalProcessors * 0.5))
    
    Write-ColoredOutput "🖥️  CPU-EMPFEHLUNGEN:" "Cyan"
    Write-ColoredOutput "   Verfügbare logische Prozessoren: $($SystemInfo.CPULogicalProcessors)" "White"
    Write-ColoredOutput "   Empfohlen (75%): $recommendedCPUs Kerne" "Green"
    Write-ColoredOutput "   Konservativ (50%): $conservativeCPUs Kerne" "Yellow"
    
    # RAM-Empfehlungen
    $recommendedMemoryGB = [math]::Floor($SystemInfo.TotalMemoryGB * 0.5)
    $conservativeMemoryGB = [math]::Floor($SystemInfo.TotalMemoryGB * 0.25)
    $aggressiveMemoryGB = [math]::Floor($SystemInfo.TotalMemoryGB * 0.75)
    
    Write-ColoredOutput "`n💾 RAM-EMPFEHLUNGEN:" "Cyan"
    Write-ColoredOutput "   Gesamt-RAM: $($SystemInfo.TotalMemoryGB) GB" "White"
    Write-ColoredOutput "   Konservativ (25%): $conservativeMemoryGB GB" "Yellow"
    Write-ColoredOutput "   Empfohlen (50%): $recommendedMemoryGB GB" "Green"
    Write-ColoredOutput "   Aggressiv (75%): $aggressiveMemoryGB GB" "Red"
    
    # Swap-Empfehlungen
    $recommendedSwapGB = [math]::Min(8, [math]::Max(2, [math]::Floor($recommendedMemoryGB * 0.5)))
    
    Write-ColoredOutput "`n🔄 SWAP-EMPFEHLUNGEN:" "Cyan"
    Write-ColoredOutput "   Empfohlener Swap: $recommendedSwapGB GB" "Green"
    Write-ColoredOutput "   (50% der WSL-RAM-Zuteilung, max. 8GB)" "Gray"
    
    # Speicher-Empfehlungen
    Write-ColoredOutput "`n💽 SPEICHER-Überlegungen:" "Cyan"
    Write-ColoredOutput "   Verfügbarer Speicher auf C:: $([math]::Round($SystemInfo.FreeSpaceGB, 2)) GB" "White"
    if ($SystemInfo.FreeSpaceGB -lt 20) {
        Write-ColoredOutput "   ⚠️  WARNUNG: Wenig freier Speicher!" "Red"
    } elseif ($SystemInfo.FreeSpaceGB -lt 50) {
        Write-ColoredOutput "   ⚠️  Speicher könnte knapp werden" "Yellow"
    } else {
        Write-ColoredOutput "   ✅ Ausreichend Speicher verfügbar" "Green"
    }
    
    return @{
        RecommendedCPUs = $recommendedCPUs
        ConservativeCPUs = $conservativeCPUs
        RecommendedMemoryGB = $recommendedMemoryGB
        ConservativeMemoryGB = $conservativeMemoryGB
        AggressiveMemoryGB = $aggressiveMemoryGB
        RecommendedSwapGB = $recommendedSwapGB
    }
}

function Show-ConfigurationOptions {
    param($SystemInfo, $Recommendations)
    
    Write-Section "KONFIGURATIONSOPTIONEN"
    
    $configs = @{
        "Conservative" = @{
            Memory = $Recommendations.ConservativeMemoryGB
            Processors = $Recommendations.ConservativeCPUs
            Swap = [math]::Max(1, [math]::Floor($Recommendations.ConservativeMemoryGB * 0.5))
            Description = "Minimale Ressourcen - Windows bleibt sehr performant"
        }
        "Balanced" = @{
            Memory = $Recommendations.RecommendedMemoryGB
            Processors = $Recommendations.RecommendedCPUs
            Swap = $Recommendations.RecommendedSwapGB
            Description = "Ausgewogene Aufteilung - Empfohlen für die meisten Nutzer"
        }
        "Performance" = @{
            Memory = $Recommendations.AggressiveMemoryGB
            Processors = $SystemInfo.CPULogicalProcessors - 1
            Swap = [math]::Min(8, $Recommendations.AggressiveMemoryGB)
            Description = "Maximale WSL-Performance - Windows könnte langsamer werden"
        }
        "Container-Optimiert" = @{
            Memory = [math]::Min($Recommendations.RecommendedMemoryGB + 2, $Recommendations.AggressiveMemoryGB)
            Processors = $Recommendations.RecommendedCPUs
            Swap = [math]::Min(4, $Recommendations.RecommendedSwapGB)
            Description = "Optimiert für Container-Workloads und Podman"
        }
    }
    
    foreach ($configName in $configs.Keys) {
        $config = $configs[$configName]
        Write-ColoredOutput "`n📋 $configName-Konfiguration:" "Yellow"
        Write-ColoredOutput "   $($config.Description)" "Gray"
        Write-ColoredOutput "   Memory: $($config.Memory) GB" "Green"
        Write-ColoredOutput "   Processors: $($config.Processors)" "Green"
        Write-ColoredOutput "   Swap: $($config.Swap) GB" "Green"
    }
    
    return $configs
}

function Create-WSLConfig {
    param($ConfigName, $Config)
    
    $wslConfigPath = "$env:USERPROFILE\.wslconfig"
    $backupPath = "$env:USERPROFILE\.wslconfig.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    
    # Backup erstellen falls Datei existiert
    if (Test-Path $wslConfigPath) {
        Copy-Item $wslConfigPath $backupPath
        Write-ColoredOutput "📄 Backup erstellt: $backupPath" "Yellow"
    }
    
    # Neue Konfiguration erstellen
    $configContent = @"
# WSL2-Konfiguration - Automatisch generiert
# Konfiguration: $ConfigName
# Generiert am: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

[wsl2]
# Speicher-Zuteilung
memory=${($Config.Memory)}GB

# CPU-Kerne
processors=$($Config.Processors)

# Swap-Speicher
swap=${($Config.Swap)}GB

# Netzwerk-Einstellungen
localhostForwarding=true

# Kernel-Parameter für bessere Performance
kernelCommandLine=cgroup_no_v1=all systemd.unified_cgroup_hierarchy=1

# Weitere Optimierungen
nestedVirtualization=true
debugConsole=false
"@

    $configContent | Out-File -FilePath $wslConfigPath -Encoding UTF8
    Write-ColoredOutput "✅ Neue WSL-Konfiguration erstellt: $wslConfigPath" "Green"
    
    Write-ColoredOutput "`n📋 ERSTELLTE KONFIGURATION:" "Cyan"
    Get-Content $wslConfigPath | ForEach-Object {
        Write-ColoredOutput "   $_" "Gray"
    }
    
    Write-ColoredOutput "`n⚠️  WICHTIG:" "Red"
    Write-ColoredOutput "   1. WSL muss neu gestartet werden: wsl --shutdown" "Yellow"
    Write-ColoredOutput "   2. Danach WSL erneut starten für neue Konfiguration" "Yellow"
    Write-ColoredOutput "   3. Bei Problemen Backup wiederherstellen: $backupPath" "Yellow"
}

function Start-InteractiveMode {
    param($SystemInfo, $Configs)
    
    Write-Section "INTERAKTIVE KONFIGURATION"
    
    Write-ColoredOutput "Wählen Sie eine Konfiguration:" "Cyan"
    $options = @()
    $i = 1
    foreach ($configName in $Configs.Keys) {
        $config = $Configs[$configName]
        Write-ColoredOutput "$i. $configName" "Yellow"
        Write-ColoredOutput "   $($config.Description)" "Gray"
        Write-ColoredOutput "   RAM: $($config.Memory)GB, CPU: $($config.Processors), Swap: $($config.Swap)GB" "White"
        $options += $configName
        $i++
    }
    Write-ColoredOutput "$i. Benutzerdefiniert" "Yellow"
    Write-ColoredOutput "0. Abbrechen" "Red"
    
    do {
        $choice = Read-Host "`nIhre Wahl (0-$i)"
    } while ($choice -notmatch "^\d+$" -or [int]$choice -lt 0 -or [int]$choice -gt $i)
    
    $choice = [int]$choice
    
    if ($choice -eq 0) {
        Write-ColoredOutput "Abgebrochen." "Yellow"
        return
    } elseif ($choice -eq $i) {
        # Benutzerdefinierte Konfiguration
        Write-ColoredOutput "`n🛠️  BENUTZERDEFINIERTE KONFIGURATION:" "Cyan"
        
        do {
            $customMemory = Read-Host "RAM in GB (1-$($SystemInfo.TotalMemoryGB))"
        } while ($customMemory -notmatch "^\d+$" -or [int]$customMemory -lt 1 -or [int]$customMemory -gt $SystemInfo.TotalMemoryGB)
        
        do {
            $customCPUs = Read-Host "CPU-Kerne (1-$($SystemInfo.CPULogicalProcessors))"
        } while ($customCPUs -notmatch "^\d+$" -or [int]$customCPUs -lt 1 -or [int]$customCPUs -gt $SystemInfo.CPULogicalProcessors)
        
        do {
            $customSwap = Read-Host "Swap in GB (0-16)"
        } while ($customSwap -notmatch "^\d+$" -or [int]$customSwap -lt 0 -or [int]$customSwap -gt 16)
        
        $selectedConfig = @{
            Memory = [int]$customMemory
            Processors = [int]$customCPUs
            Swap = [int]$customSwap
        }
        $selectedName = "Benutzerdefiniert"
    } else {
        $selectedName = $options[$choice - 1]
        $selectedConfig = $Configs[$selectedName]
    }
    
    Write-ColoredOutput "`n📋 GEWÄHLTE KONFIGURATION: $selectedName" "Green"
    Write-ColoredOutput "   RAM: $($selectedConfig.Memory) GB" "White"
    Write-ColoredOutput "   CPU: $($selectedConfig.Processors) Kerne" "White"
    Write-ColoredOutput "   Swap: $($selectedConfig.Swap) GB" "White"
    
    $confirm = Read-Host "`nKonfiguration erstellen? (j/N)"
    if ($confirm -match "^[jJ]") {
        Create-WSLConfig -ConfigName $selectedName -Config $selectedConfig
    } else {
        Write-ColoredOutput "Konfiguration nicht erstellt." "Yellow"
    }
}

# Hauptprogramm
Write-ColoredOutput "🔍 WSL Hardware-Analyzer und Ressourcen-Optimizer" "Green"
Write-ColoredOutput "=================================================" "Green"

# System-Hardware analysieren
$systemInfo = Get-SystemHardware

# Aktuelle WSL-Konfiguration anzeigen
Get-WSLCurrentConfig

# Optimale Ressourcen berechnen
$recommendations = Calculate-OptimalResources -SystemInfo $systemInfo

# Konfigurationsoptionen anzeigen
$configs = Show-ConfigurationOptions -SystemInfo $systemInfo -Recommendations $recommendations

# Je nach Parameter unterschiedlich verfahren
if ($Interactive) {
    Start-InteractiveMode -SystemInfo $systemInfo -Configs $configs
} elseif ($CreateConfig) {
    # Automatisch Balanced-Konfiguration erstellen
    Create-WSLConfig -ConfigName "Balanced" -Config $configs["Balanced"]
} else {
    Write-Section "NÄCHSTE SCHRITTE"
    Write-ColoredOutput "Optionen:" "Cyan"
    Write-ColoredOutput "  -Interactive    : Interaktive Konfiguration" "Yellow"
    Write-ColoredOutput "  -CreateConfig   : Balanced-Konfiguration automatisch erstellen" "Yellow"
    Write-ColoredOutput "  -Detailed       : Erweiterte Hardware-Informationen" "Yellow"
    Write-ColoredOutput "`nBeispiel: .\script.ps1 -Interactive" "Green"
}

Write-ColoredOutput "`n✅ Analyse abgeschlossen!" "Green"
```

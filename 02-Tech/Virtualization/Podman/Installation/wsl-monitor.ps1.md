
```PowerShell
# WSL Ressourcen-Monitor
# Überwacht WSL-Ressourcennutzung in Echtzeit

param(
    [int]$IntervalSeconds = 5,
    [switch]$Continuous,
    [switch]$LogToFile,
    [string]$LogPath = "$env:USERPROFILE\wsl-monitor.log"
)

function Get-WSLResourceUsage {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Windows-seitige Ressourcen
    $totalMemory = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
    $availableMemory = (Get-Counter "\Memory\Available MBytes").CounterSamples.CookedValue / 1024
    $usedMemory = $totalMemory - $availableMemory
    $memoryPercent = [math]::Round(($usedMemory / $totalMemory) * 100, 1)
    
    $cpuUsage = (Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue
    $cpuPercent = [math]::Round(100 - $cpuUsage, 1)
    
    # WSL-Status
    $wslRunning = $false
    $wslInstances = @()
    try {
        $wslList = wsl -l --running 2>$null
        if ($wslList -and $wslList.Count -gt 1) {
            $wslRunning = $true
            $wslInstances = $wslList | Where-Object { $_ -notmatch "Windows-Subsystem" -and $_ -ne "" }
        }
    } catch {}
    
    # WSL-Memory-Info (falls verfügbar)
    $wslMemoryInfo = $null
    if ($wslRunning) {
        try {
            $memInfo = wsl -e cat /proc/meminfo 2>$null
            if ($memInfo) {
                $memTotal = ($memInfo | Where-Object { $_ -match "^MemTotal:" }) -replace ".*:\s*(\d+).*", '$1'
                $memFree = ($memInfo | Where-Object { $_ -match "^MemFree:" }) -replace ".*:\s*(\d+).*", '$1'
                $memAvailable = ($memInfo | Where-Object { $_ -match "^MemAvailable:" }) -replace ".*:\s*(\d+).*", '$1'
                
                if ($memTotal -and $memAvailable) {
                    $wslTotalGB = [math]::Round([int]$memTotal / 1024 / 1024, 2)
                    $wslAvailableGB = [math]::Round([int]$memAvailable / 1024 / 1024, 2)
                    $wslUsedGB = [math]::Round($wslTotalGB - $wslAvailableGB, 2)
                    $wslMemPercent = [math]::Round(($wslUsedGB / $wslTotalGB) * 100, 1)
                    
                    $wslMemoryInfo = @{
                        Total = $wslTotalGB
                        Used = $wslUsedGB
                        Available = $wslAvailableGB
                        Percent = $wslMemPercent
                    }
                }
            }
        } catch {}
    }
    
    return @{
        Timestamp = $timestamp
        Windows = @{
            MemoryTotal = [math]::Round($totalMemory, 2)
            MemoryUsed = [math]::Round($usedMemory, 2)
            MemoryPercent = $memoryPercent
            CPUPercent = $cpuPercent
        }
        WSL = @{
            Running = $wslRunning
            Instances = $wslInstances
            Memory = $wslMemoryInfo
        }
    }
}

function Format-ResourceDisplay {
    param($ResourceData)
    
    Clear-Host
    
    Write-Host "🔍 WSL Ressourcen-Monitor" -ForegroundColor Green
    Write-Host "=========================" -ForegroundColor Green
    Write-Host "Zeit: $($ResourceData.Timestamp)" -ForegroundColor Cyan
    Write-Host ""
    
    # Windows-Ressourcen
    Write-Host "🖥️  WINDOWS-SYSTEM:" -ForegroundColor Yellow
    Write-Host "   RAM: $($ResourceData.Windows.MemoryUsed) GB / $($ResourceData.Windows.MemoryTotal) GB ($($ResourceData.Windows.MemoryPercent)%)" -ForegroundColor White
    
    # RAM-Balken
    $memBarLength = 40
    $memUsedBars = [math]::Floor(($ResourceData.Windows.MemoryPercent / 100) * $memBarLength)
    $memFreeBars = $memBarLength - $memUsedBars
    $memColor = if ($ResourceData.Windows.MemoryPercent -gt 80) { "Red" } elseif ($ResourceData.Windows.MemoryPercent -gt 60) { "Yellow" } else { "Green" }
    Write-Host "   [" -NoNewline
    Write-Host ("█" * $memUsedBars) -ForegroundColor $memColor -NoNewline
    Write-Host ("░" * $memFreeBars) -ForegroundColor DarkGray -NoNewline
    Write-Host "]"
    
    Write-Host "   CPU: $($ResourceData.Windows.CPUPercent)%" -ForegroundColor White
    
    # CPU-Balken
    $cpuUsedBars = [math]::Floor(($ResourceData.Windows.CPUPercent / 100) * $memBarLength)
    $cpuFreeBars = $memBarLength - $cpuUsedBars
    $cpuColor = if ($ResourceData.Windows.CPUPercent -gt 80) { "Red" } elseif ($ResourceData.Windows.CPUPercent -gt 60) { "Yellow" } else { "Green" }
    Write-Host "   [" -NoNewline
    Write-Host ("█" * $cpuUsedBars) -ForegroundColor $cpuColor -NoNewline
    Write-Host ("░" * $cpuFreeBars) -ForegroundColor DarkGray -NoNewline
    Write-Host "]"
    
    Write-Host ""
    
    # WSL-Status
    if ($ResourceData.WSL.Running) {
        Write-Host "🐧 WSL-INSTANZEN:" -ForegroundColor Yellow
        foreach ($instance in $ResourceData.WSL.Instances) {
            Write-Host "   ✅ $instance" -ForegroundColor Green
        }
        
        if ($ResourceData.WSL.Memory) {
            Write-Host ""
            Write-Host "💾 WSL-SPEICHER:" -ForegroundColor Yellow
            Write-Host "   RAM: $($ResourceData.WSL.Memory.Used) GB / $($ResourceData.WSL.Memory.Total) GB ($($ResourceData.WSL.Memory.Percent)%)" -ForegroundColor White
            
            # WSL RAM-Balken
            $wslMemUsedBars = [math]::Floor(($ResourceData.WSL.Memory.Percent / 100) * $memBarLength)
            $wslMemFreeBars = $memBarLength - $wslMemUsedBars
            $wslMemColor = if ($ResourceData.WSL.Memory.Percent -gt 80) { "Red" } elseif ($ResourceData.WSL.Memory.Percent -gt 60) { "Yellow" } else { "Green" }
            Write-Host "   [" -NoNewline
            Write-Host ("█" * $wslMemUsedBars) -ForegroundColor $wslMemColor -NoNewline
            Write-Host ("░" * $wslMemFreeBars) -ForegroundColor DarkGray -NoNewline
            Write-Host "]"
        }
    } else {
        Write-Host "🐧 WSL-STATUS:" -ForegroundColor Yellow
        Write-Host "   ⏹️ Keine WSL-Instanzen laufen" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "📊 LEGENDE:" -ForegroundColor Cyan
    Write-Host "   🟢 Niedrig (< 60%)  🟡 Mittel (60-80%)  🔴 Hoch (> 80%)" -ForegroundColor White
    
    if ($Continuous) {
        Write-Host ""
        Write-Host "⏸️  Drücken Sie Strg+C zum Beenden" -ForegroundColor Gray
        Write-Host "🔄 Nächste Aktualisierung in $IntervalSeconds Sekunden..." -ForegroundColor Gray
    }
}

function Write-LogEntry {
    param($ResourceData, $LogPath)
    
    $logEntry = "$($ResourceData.Timestamp)," +
                "$($ResourceData.Windows.MemoryPercent)," +
                "$($ResourceData.Windows.CPUPercent)," +
                "$($ResourceData.WSL.Running)," +
                "$(if ($ResourceData.WSL.Memory) { $ResourceData.WSL.Memory.Percent } else { 'N/A' })," +
                "$($ResourceData.WSL.Instances.Count)"
    
    # Header schreiben falls Datei nicht existiert
    if (!(Test-Path $LogPath)) {
        $header = "Timestamp,Windows_Memory_%,Windows_CPU_%,WSL_Running,WSL_Memory_%,WSL_Instances"
        $header | Out-File -FilePath $LogPath -Encoding UTF8
    }
    
    $logEntry | Out-File -FilePath $LogPath -Append -Encoding UTF8
}

function Show-WSLConfigInfo {
    Write-Host ""
    Write-Host "⚙️  AKTUELLE WSL-KONFIGURATION:" -ForegroundColor Cyan
    
    $wslConfigPath = "$env:USERPROFILE\.wslconfig"
    if (Test-Path $wslConfigPath) {
        $config = Get-Content $wslConfigPath | Where-Object { $_ -notmatch "^#" -and $_ -ne "" }
        foreach ($line in $config) {
            if ($line -match "memory=(.*)") {
                Write-Host "   📊 RAM-Limit: $($matches[1])" -ForegroundColor White
            }
            elseif ($line -match "processors=(.*)") {
                Write-Host "   🖥️  CPU-Limit: $($matches[1]) Kerne" -ForegroundColor White
            }
            elseif ($line -match "swap=(.*)") {
                Write-Host "   🔄 Swap-Limit: $($matches[1])" -ForegroundColor White
            }
        }
    } else {
        Write-Host "   ⚠️  Keine .wslconfig gefunden (Standard-Limits aktiv)" -ForegroundColor Yellow
    }
}

function Get-WSLPerformanceRecommendations {
    param($ResourceData)
    
    $recommendations = @()
    
    # Windows-Speicher-Analyse
    if ($ResourceData.Windows.MemoryPercent -gt 85) {
        $recommendations += "⚠️  Windows-Speicher sehr hoch (>85%) - WSL-Memory reduzieren"
    }
    
    # WSL-Speicher-Analyse
    if ($ResourceData.WSL.Memory -and $ResourceData.WSL.Memory.Percent -gt 90) {
        $recommendations += "🔴 WSL-Speicher kritisch (>90%) - Container prüfen"
    }
    
    # CPU-Analyse
    if ($ResourceData.Windows.CPUPercent -gt 80) {
        $recommendations += "🔥 Hohe CPU-Last - WSL-Prozessoren reduzieren erwägen"
    }
    
    # WSL nicht laufend
    if (!$ResourceData.WSL.Running) {
        $recommendations += "💡 WSL nicht aktiv - Ressourcen werden nicht genutzt"
    }
    
    return $recommendations
}

function Start-DetailedAnalysis {
    Write-Host "📈 DETAILLIERTE ANALYSE" -ForegroundColor Green
    Write-Host "======================" -ForegroundColor Green
    
    # Mehrere Messungen für genauere Durchschnittswerte
    $measurements = @()
    Write-Host "Sammle Daten (5 Messungen)..." -ForegroundColor Yellow
    
    for ($i = 1; $i -le 5; $i++) {
        Write-Host "  Messung $i/5..." -ForegroundColor Gray
        $measurements += Get-WSLResourceUsage
        if ($i -lt 5) { Start-Sleep -Seconds 2 }
    }
    
    # Durchschnittswerte berechnen
    $avgWindowsMemory = ($measurements | Measure-Object -Property { $_.Windows.MemoryPercent } -Average).Average
    $avgWindowsCPU = ($measurements | Measure-Object -Property { $_.Windows.CPUPercent } -Average).Average
    
    $avgWSLMemory = if ($measurements[0].WSL.Memory) {
        ($measurements | Where-Object { $_.WSL.Memory } | Measure-Object -Property { $_.WSL.Memory.Percent } -Average).Average
    } else { $null }
    
    Write-Host ""
    Write-Host "📊 DURCHSCHNITTSWERTE (5 Messungen):" -ForegroundColor Cyan
    Write-Host "   Windows RAM: $([math]::Round($avgWindowsMemory, 1))%" -ForegroundColor White
    Write-Host "   Windows CPU: $([math]::Round($avgWindowsCPU, 1))%" -ForegroundColor White
    if ($avgWSLMemory) {
        Write-Host "   WSL RAM: $([math]::Round($avgWSLMemory, 1))%" -ForegroundColor White
    }
    
    # Empfehlungen basierend auf Analyse
    Write-Host ""
    Write-Host "💡 OPTIMIERUNGSEMPFEHLUNGEN:" -ForegroundColor Yellow
    
    if ($avgWindowsMemory -lt 50) {
        Write-Host "   ✅ Windows-Speicher niedrig - WSL-Memory kann erhöht werden" -ForegroundColor Green
    } elseif ($avgWindowsMemory -gt 80) {
        Write-Host "   ⚠️  Windows-Speicher hoch - WSL-Memory reduzieren" -ForegroundColor Red
    } else {
        Write-Host "   ✅ Windows-Speicher ausgewogen" -ForegroundColor Green
    }
    
    if ($avgWindowsCPU -lt 30) {
        Write-Host "   ✅ CPU-Last niedrig - mehr WSL-Kerne möglich" -ForegroundColor Green
    } elseif ($avgWindowsCPU -gt 70) {
        Write-Host "   ⚠️  Hohe CPU-Last - WSL-Kerne reduzieren" -ForegroundColor Red
    } else {
        Write-Host "   ✅ CPU-Last ausgewogen" -ForegroundColor Green
    }
    
    if ($measurements[0].WSL.Running) {
        if ($avgWSLMemory -and $avgWSLMemory -gt 80) {
            Write-Host "   🔴 WSL-Speicher hoch - Container-Speicher prüfen" -ForegroundColor Red
        } else {
            Write-Host "   ✅ WSL-Speichernutzung normal" -ForegroundColor Green
        }
    }
}

# Hauptprogramm
try {
    if ($Continuous) {
        Write-Host "🔄 Starte kontinuierliches Monitoring..." -ForegroundColor Green
        Write-Host "Intervall: $IntervalSeconds Sekunden" -ForegroundColor Cyan
        if ($LogToFile) {
            Write-Host "Log-Datei: $LogPath" -ForegroundColor Cyan
        }
        Write-Host ""
        
        # Einmalig Konfiguration anzeigen
        Show-WSLConfigInfo
        
        while ($true) {
            $resourceData = Get-WSLResourceUsage
            Format-ResourceDisplay -ResourceData $resourceData
            
            # Empfehlungen anzeigen falls vorhanden
            $recommendations = Get-WSLPerformanceRecommendations -ResourceData $resourceData
            if ($recommendations.Count -gt 0) {
                Write-Host ""
                Write-Host "⚡ EMPFEHLUNGEN:" -ForegroundColor Yellow
                foreach ($rec in $recommendations) {
                    Write-Host "   $rec" -ForegroundColor White
                }
            }
            
            if ($LogToFile) {
                Write-LogEntry -ResourceData $resourceData -LogPath $LogPath
            }
            
            Start-Sleep -Seconds $IntervalSeconds
        }
    } else {
        # Einmalige Messung mit detaillierter Analyse
        Start-DetailedAnalysis
        
        Write-Host ""
        Show-WSLConfigInfo
        
        Write-Host ""
        Write-Host "🔄 Für kontinuierliches Monitoring verwenden Sie:" -ForegroundColor Cyan
        Write-Host "   .\wsl-monitor.ps1 -Continuous" -ForegroundColor White
        Write-Host "   .\wsl-monitor.ps1 -Continuous -LogToFile" -ForegroundColor White
    }
    
} catch {
    Write-Host "❌ Fehler beim Monitoring: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    if ($LogToFile -and (Test-Path $LogPath)) {
        Write-Host ""
        Write-Host "📄 Log-Datei gespeichert: $LogPath" -ForegroundColor Green
    }
}
```

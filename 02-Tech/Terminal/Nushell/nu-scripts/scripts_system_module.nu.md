```nu
# ============================================
# System Module - Systemverwaltungs-Commands
# ============================================

# Umfassende Systeminfo
def sysinfo [] {
    let os_info = (uname -a)
    let mem = (free -h 2>/dev/null | lines.1 | str trim | split row ' ' | select 1 2 3)
    let disk = (df -h / | lines.1 | str trim | split row ' ' | select 1 2 3 4)
    let uptime = (uptime | str trim)
    let cpu_count = (nproc 2>/dev/null || echo "N/A")
    
    {
        hostname: (hostname)
        os: $os_info
        cpu_cores: $cpu_count
        memory: {
            total: ($mem.0)
            used: ($mem.1)
            available: ($mem.2)
        }
        disk_root: {
            total: ($disk.0)
            used: ($disk.1)
            available: ($disk.2)
            percent: ($disk.3)
        }
        uptime: $uptime
        timestamp: (date now | format date "%Y-%m-%d %H:%M:%S")
    } | to text -t 2
}

# Enhanced `ls` mit Details
def lsd [
    --all (-a): bool = false
    path: string = "."
] {
    let cmd = if $all { 
        $"ls -lah ($path)" 
    } else { 
        $"ls -lh ($path)" 
    }
    
    let items = (^$nu.shell-path -c $cmd | lines)
    
    if ($items | length) > 0 {
        $items | each { |line|
            print $line
        }
    } else {
        print "Verzeichnis ist leer"
    }
}

# Port-Nutzung prüfen
def portinfo [port: int] {
    if ($port < 1) or ($port > 65535) {
        error make { msg: "Port muss zwischen 1 und 65535 liegen" }
    }
    
    let os = $nu.os-info.name
    
    if $os == "windows" {
        try {
            netstat -ano | grep $port | table -e
        } catch {
            print "❌ Keine Nutzung auf Port ($port) gefunden"
        }
    } else {
        try {
            lsof -i :$port | table -e
        } catch {
            print "❌ Keine Nutzung auf Port ($port) gefunden"
        }
    }
}

# Prozesse nach CPU/Memory sortiert
def top-processes [
    --limit (-n): int = 10
    --sort-by (-s): string = "memory"
] {
    let ps_output = (ps aux | lines | skip 1)
    
    let sorted = if $sort_by == "cpu" {
        $ps_output | sort -r -k 3
    } else {
        $ps_output | sort -r -k 4
    }
    
    $sorted | first $limit | table -e
}

# Disk-Nutzung nach Verzeichnis
def disk-usage [path: string = "."] {
    if not ($path | path exists) {
        error make { msg: $"Pfad existiert nicht: ($path)" }
    }
    
    du -sh $"($path)/*" 2>/dev/null | lines | each { |line|
        let parts = ($line | split row '\t')
        {
            size: ($parts.0)
            path: ($parts.1)
        }
    } | sort-by size -r | table -e
}

# Network-Status
def net-status [] {
    let interfaces = (ip addr show 2>/dev/null || ifconfig)
    let dns = (cat /etc/resolv.conf 2>/dev/null | grep nameserver)
    let routing = (ip route show 2>/dev/null)
    
    {
        interfaces: $interfaces
        dns: $dns
        routing: $routing
    } | to text -t 2
}
```
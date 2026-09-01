# System Module

Systemverwaltungs-Commands für Monitoring und Verwaltung.

## Commands

### `sysinfo`
Umfassende Systeminfo (OS, CPU, Memory, Disk, Uptime).

```
sysinfo
```

### `lsd [-a] [path]`
Enhanced `ls` mit Details (-a für hidden files).

```
lsd
lsd -a
lsd -a /tmp
```

### `portinfo [port]`
Prüfe, welcher Prozess einen Port nutzt.

```
portinfo 8080
portinfo 443
```

### `top-processes [-n N] [-s cpu|memory]`
Zeige Top N Prozesse sortiert nach CPU oder Memory.

```
top-processes
top-processes -n 20 -s cpu
top-processes -s memory
```

### `disk-usage [path]`
Zeige Disk-Nutzung nach Verzeichnis sortiert.

```
disk-usage
disk-usage /usr/local
```

### `net-status`
Zeige Network-Status (Interfaces, DNS, Routes).

```
net-status
```

---

**Autor:** fdoebbelin  
**Repo:** https://github.com/fdoebbelin/nu-scripts
### **1. Hardware-Analyzer (Script 1)**

- **Zweck**: Detaillierte Hardware-Analyse und WSL-Konfigurationsempfehlungen
- **Features**:
    - Vollständige Systemanalyse (CPU, RAM, Speicher)
    - Intelligente Ressourcenempfehlungen
    - Interaktive Konfigurationserstellung
    - Automatische .wslconfig-Generierung

### **2. Ressourcen-Monitor (Script 2)**

- **Zweck**: Live-Überwachung der WSL-Ressourcennutzung
- **Features**:
    - Echtzeit-Monitoring von RAM und CPU
    - WSL-spezifische Speicheranalyse
    - Logging-Funktionen
    - Performance-Empfehlungen

### **3. Kompletter Ressourcen-Manager (Script 3)**

- **Zweck**: All-in-One-Lösung mit GUI-ähnlichem Menü
- **Features**:
    - Interaktives Hauptmenü
    - Alle Funktionen der ersten beiden Scripts
    - System-Optimierung
    - Backup und Wiederherstellung

## **🚀 Verwendung**

### **Quick Start:**

```powershell
# Komplettanalyse mit Menü
.\wsl-resource-manager.ps1 -Interactive

# Automatische Balanced-Konfiguration
.\wsl-resource-manager.ps1 -Action Configure

# Live-Monitoring
.\wsl-resource-manager.ps1 -Action Monitor
```

### **Einzelne Tools:**

```powershell
# Nur Hardware-Analyse
.\hardware-analyzer.ps1 -Interactive

# Nur Monitoring
.\wsl-monitor.ps1 -Continuous

# Mit Logging
.\wsl-monitor.ps1 -Continuous -LogToFile
```

## **💡 Intelligente Ressourcen-Empfehlungen**

Die Scripts analysieren automatisch:

- **CPU-Kerne**: 50-75% der verfügbaren logischen Prozessoren
- **RAM**: 25-75% des Gesamt-RAMs je nach Systemleistung
- **Swap**: 50% der WSL-RAM-Zuteilung (max. 8GB)
- **Speicherplatz**: Warnung bei <50GB frei

## **🔧 Besondere Features**

- **Automatisches Backup** vor Konfigurationsänderungen
- **Live-Balkendiagramme** für Ressourcennutzung
- **Farbkodierte Ausgaben** für bessere Übersicht
- **Intelligente Hardwareerkennung** für optimale Empfehlungen
- **Ein-Klick-Konfiguration** für verschiedene Nutzungsszenarien
- **WSL-Neustart-Integration** nach Konfigurationsänderungen

Diese Lösung gibt Ihnen vollständige Kontrolle über Ihre WSL-Ressourcen und hilft dabei, die optimale Balance zwischen Windows- und WSL-Performance zu finden!
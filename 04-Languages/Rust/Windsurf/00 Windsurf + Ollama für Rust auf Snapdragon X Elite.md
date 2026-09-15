## **Schritt 1: Ollama installieren**

### **Download und Installation:**

```powershell
# PowerShell als Administrator öffnen
# Ollama für Windows ARM64 herunterladen
Invoke-WebRequest -Uri "https://ollama.com/download/windows" -OutFile "OllamaSetup.exe"
.\OllamaSetup.exe
```

**Alternativ:** Direkt von https://ollama.com/download herunterladen und "Windows ARM64" auswählen.

### **Ollama testen:**

```powershell
# Neues Terminal/PowerShell öffnen
ollama --version
# Sollte Version anzeigen (z.B. "ollama version is 0.1.x")
```

## **Schritt 2: Code-Modelle herunterladen**

```powershell
# Basis-Modell für Code (empfohlener Start)
ollama pull codeqwen:7b

# Kleines, schnelles Modell für Chat
ollama pull phi3:mini

# Optional: Größeres Modell (falls 7B gut läuft)
ollama pull deepseek-coder:6.7b
```

**Download-Zeit:** Je ~4-7 GB pro Modell, dauert je nach Internet 10-30 Minuten.

### **Modelle testen:**

```powershell
# Test mit CodeQwen
ollama run codeqwen:7b
# Eingabe: "Write a simple Rust function to calculate fibonacci"
# Mit /bye beenden

# Test mit Phi3
ollama run phi3:mini
# Eingabe: "Explain Rust ownership"
```

## **Schritt 3: Windsurf installieren**

### **Download:**

1. Gehen Sie zu https://codeium.com/windsurf
2. Download "Windows ARM64" Version
3. Installer ausführen

### **Erste Konfiguration:**

```
1. Windsurf starten
2. Welcome Screen → "Skip" (kein Account nötig für lokale LLMs)
3. Extensions → Install "rust-analyzer"
4. Extensions → Install "CodeLLDB" (für Debugging)
```

## **Schritt 4: Windsurf für lokale LLMs konfigurieren**

### **AI-Provider einrichten:**

```
1. Windsurf → Settings (Ctrl+,)
2. Search: "Codeium"
3. Codeium: Custom API URL → http://localhost:11434/v1
4. Codeium: API Key → "ollama" (beliebiger Text)
5. Codeium: Model → "codeqwen:7b"
```

### **Chat-Konfiguration:**

```
1. Settings → Search "chat"
2. Codeium Chat: Model → "phi3:mini"
3. Codeium Chat: Custom Endpoint → http://localhost:11434/v1
```

## **Schritt 5: Rust-Entwicklungsumgebung**

### **Rust installieren (falls noch nicht vorhanden):**

```powershell
# Rustup für ARM64 Windows
Invoke-RestMethod -Uri https://win.rustup.rs/aarch64 -OutFile rustup-init.exe
.\rustup-init.exe
# Defaults akzeptieren, dann Terminal neu starten
```

### **Test-Projekt erstellen:**

```powershell
cargo new rust_ai_test
cd rust_ai_test
code . # Windsurf öffnen
```

## **Schritt 6: Setup testen**

### **In Windsurf:**

```rust
// main.rs - Tippen Sie diesen Code:
fn main() {
    // Drücken Sie Ctrl+Shift+P
    // Suchen: "Codeium: Chat"
    // Fragen: "Add a function to calculate factorial"
}
```

### **Erwartete Performance:**

- **Code-Completion:** 1-3 Sekunden Latenz
- **Chat-Antworten:** 15-30 Sekunden für längere Antworten
- **RAM-Verbrauch:** ~6-8 GB total

## **Optimierungen für bessere Performance**

### **Ollama-Konfiguration optimieren:**

```powershell
# .env Datei erstellen (im Benutzerordner)
echo "OLLAMA_NUM_PARALLEL=1" >> $env:USERPROFILE\.ollama
echo "OLLAMA_MAX_LOADED_MODELS=2" >> $env:USERPROFILE\.ollama
```

### **Windows-Optimierungen:**

```
1. Windows Settings → System → Power → Best Performance
2. Task Manager → Startup → Unnötige Programme deaktivieren
3. Windows Defender → Ollama-Ordner ausschließen
```

## **Troubleshooting**

### **Häufige Probleme:**

**Ollama startet nicht:**

```powershell
# Service neu starten
Get-Service ollama | Restart-Service
# Oder manuell:
ollama serve
```

**Modelle laden langsam:**

```powershell
# Kleineres Modell probieren
ollama pull phi3:mini
# In Windsurf auf phi3:mini umstellen
```

**Windsurf erkennt Ollama nicht:**

```
1. Settings → Codeium → API URL prüfen
2. Browser öffnen: http://localhost:11434
3. Sollte "Ollama is running" zeigen
```

## **Nächste Schritte**

Nach erfolgreichem Setup können Sie:

1. Weitere Rust-spezifische Modelle testen
2. Custom Prompts für Rust-Patterns erstellen
3. Größere Modelle ausprobieren (13B, falls Performance gut)

Gibt es Probleme bei einem bestimmten Schritt? Dann kann ich gezielter helfen!
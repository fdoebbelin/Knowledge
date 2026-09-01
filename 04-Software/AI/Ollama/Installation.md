Ich helfe dir bei der Installation von Node.js und Ollama unter CachyOS mit nushell und paru. Hier ist eine vollständige Anleitung:

## 1. NVIDIA-Treiber vorbereiten

Zuerst sicherstellen, dass die NVIDIA-Treiber korrekt installiert sind:

```bash
# NVIDIA-Treiber installieren (falls noch nicht vorhanden)
paru -S nvidia nvidia-utils cuda

# Überprüfen
nvidia-smi
```

## 2. Node.js installieren

```bash
# Node.js mit paru installieren
paru -S nodejs npm

# Version überprüfen
node --version
npm --version
```

## 3. Ollama installieren

```bash
# Ollama installieren
paru -S ollama

# Ollama-Service starten
sudo systemctl start ollama
sudo systemctl enable ollama

# Status prüfen
sudo systemctl status ollama
```

## 4. NVIDIA-Unterstützung für Ollama konfigurieren

Ollama sollte automatisch die NVIDIA GPU erkennen. Überprüfe mit:

```bash
# Testen, ob NVIDIA erkannt wird
ollama serve
```

In einem neuen Terminal:

```bash
# Ein Modell herunterladen (z.B. llama2)
ollama pull llama2

# Oder ein kleineres Modell zum Testen
ollama pull llama3.2:1b

# Test mit GPU
ollama run llama2 "Hallo, teste die GPU-Beschleunigung"
```

## 5. Nushell-spezifische Konfiguration

Füge diese Aliase zu deiner nushell config hinzu (`~/.config/nushell/config.nu`):

```nushell
# Ollama Aliase
alias ollama-start = sudo systemctl start ollama
alias ollama-stop = sudo systemctl stop ollama
alias ollama-status = sudo systemctl status ollama
alias gpu-check = nvidia-smi
```

## 6. Node.js Testprojekt mit Ollama

Erstelle ein Testskript:

```bash
mkdir ~/ollama-test
cd ~/ollama-test
npm init -y
npm install ollama
```

Erstelle `test.js`:

```javascript
import ollama from 'ollama'

async function test() {
  const response = await ollama.chat({
    model: 'llama2',
    messages: [{ role: 'user', content: 'Warum ist der Himmel blau?' }],
  })
  console.log(response.message.content)
}

test()
```

In `package.json` füge hinzu:

```json
"type": "module"
```

Führe aus:

```bash
node test.js
```

## 7. GPU-Nutzung überwachen

Während Ollama läuft, in einem separaten Terminal:

```bash
# GPU-Auslastung live beobachten
watch -n 1 nvidia-smi
```

## 8. Nützliche Ollama-Befehle

```bash
# Verfügbare Modelle anzeigen
ollama list

# Modell entfernen
ollama rm <model-name>

# Modelle im AUR erkunden
ollama pull codellama  # Für Code-Generierung
ollama pull mistral    # Schnelleres Modell
```

**Wichtige Hinweise:**

- Die RTX 4070 Ti Super hat 16GB VRAM - perfekt für mittelgroße Modelle (bis 13B Parameter)
- Bei größeren Modellen (70B+) wird CPU/RAM als Fallback genutzt
- Ollama nutzt automatisch CUDA, wenn NVIDIA-Treiber korrekt installiert sind
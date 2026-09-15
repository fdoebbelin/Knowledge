## Systemvoraussetzungen

### Hardware
- **CPU**: x86-64 mit AVX2-Unterstützung (alle modernen CPUs)
- **RAM**: Mindestens 8 GB (16 GB+ empfohlen)
- **GPU**: NVIDIA mit CUDA-Unterstützung (optional, aber empfohlen)
- **Speicher**: 10+ GB für Modelle

### Software
- CachyOS (oder Arch-basiertes System)
- CUDA Toolkit (für GPU-Beschleunigung)
- Python 3.8+

### CPU-Unterstützung prüfen
```bash
# AVX2 Unterstützung prüfen
lscpu | grep -i avx2

# Sollte "avx2" anzeigen
```

---

## Installation der Desktop-Anwendung

### Schritt 1: Abhängigkeiten installieren

```bash
# FUSE für AppImage
sudo pacman -S fuse2

# GPU-Beschleunigung (falls NVIDIA-Karte vorhanden)
sudo pacman -S nvidia nvidia-utils cuda

# Python und pip (für später)
sudo pacman -S python python-pip
```

### Schritt 2: LM Studio herunterladen

```bash
# Download-Verzeichnis erstellen
mkdir -p ~/Downloads
cd ~/Downloads

# Neueste Version herunterladen
wget https://lmstudio.ai/releases/latest/linux/x86_64/LMStudio.AppImage

# Ausführbar machen
chmod +x LMStudio.AppImage
```

### Schritt 3: In lokales Verzeichnis installieren

```bash
# Lokales Applications-Verzeichnis erstellen
mkdir -p ~/Applications/LMStudio

# AppImage kopieren
cp ~/Downloads/LMStudio.AppImage ~/Applications/LMStudio/LMStudio.AppImage
```

### Schritt 4: Ersten Start testen

```bash
# LM Studio starten
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox
```

**Wichtig**: Das `--no-sandbox` Flag ist unter Linux oft erforderlich!

---

## Desktop-Integration

### Schritt 1: Icon herunterladen

```bash
# Icon-Verzeichnis erstellen
mkdir -p ~/.local/share/icons

# Icon von CDN herunterladen
wget https://unpkg.com/@lobehub/icons-static-png@latest/dark/lmstudio.png \
  -O ~/.local/share/icons/lmstudio.png
```

**Alternative**: Generisches Icon verwenden (falls Download fehlschlägt)
```bash
# Nutzt Standard-Icon "applications-science"
# Siehe Desktop-Entry unten
```

### Schritt 2: Desktop-Entry erstellen

```bash
# Desktop-Entry-Verzeichnis erstellen
mkdir -p ~/.local/share/applications

# Desktop-Entry erstellen
cat > ~/.local/share/applications/lmstudio.desktop << 'EOF'
[Desktop Entry]
Name=LM Studio
Comment=Run Local LLMs
Exec=$HOME/Applications/LMStudio/LMStudio.AppImage --no-sandbox
Icon=$HOME/.local/share/icons/lmstudio.png
Terminal=false
Type=Application
Categories=Development;Science;
EOF

# Ausführbar machen
chmod +x ~/.local/share/applications/lmstudio.desktop
```

**Mit generischem Icon** (falls Icon-Download nicht funktioniert):
```bash
cat > ~/.local/share/applications/lmstudio.desktop << 'EOF'
[Desktop Entry]
Name=LM Studio
Comment=Run Local LLMs
Exec=$HOME/Applications/LMStudio/LMStudio.AppImage --no-sandbox
Icon=applications-science
Terminal=false
Type=Application
Categories=Development;Science;
EOF

chmod +x ~/.local/share/applications/lmstudio.desktop
```

### Schritt 3: Desktop-Integration aktualisieren

```bash
# Desktop-Datenbank aktualisieren
update-desktop-database ~/.local/share/applications/
```

**LM Studio sollte jetzt im Anwendungsmenü erscheinen!**

---

## Python SDK Installation

### Schritt 1: Virtuelle Umgebung erstellen (empfohlen)

```bash
# Verzeichnis für Python-Projekte
mkdir -p ~/Projects/lmstudio-python
cd ~/Projects/lmstudio-python

# Virtuelle Umgebung erstellen
python -m venv venv

# Aktivieren
source venv/bin/activate
```

### Schritt 2: LM Studio SDK installieren

```bash
# In der aktivierten venv
pip install lmstudio

# Zusätzliche nützliche Pakete
pip install pydantic  # Für strukturierte Ausgaben
```

### Schritt 3: Installation testen

```bash
python -c "import lmstudio; print('✅ LM Studio SDK erfolgreich installiert')"
```

---

## Modelle herunterladen

### Via Desktop-GUI (Empfohlen für den Anfang)

1. **LM Studio starten**
   ```bash
   ~/Applications/LMStudio/LMStudio.AppImage --no-sandbox
   ```

2. **In der GUI:**
   - Klicke auf "Search" (🔍)
   - Suche nach einem Modell, z.B.:
     - `llama-3-8b-instruct` (ca. 5 GB, guter Allrounder)
     - `qwen2.5-7b-instruct` (ca. 4 GB, sehr gut für Code)
     - `phi-3-mini` (ca. 2 GB, klein und schnell)
   - Klicke auf "Download"

3. **Warten bis Download abgeschlossen**
   - Modelle werden gespeichert in: `~/.cache/lmstudio/models/`

### Via Kommandozeile (CLI)

```bash
# LM Studio muss laufen!
# In neuem Terminal:

# Modell suchen
lms ls --available | grep llama

# Modell herunterladen
lms get llama-3-8b-instruct

# Heruntergeladene Modelle anzeigen
lms ls
```

### Empfohlene Starter-Modelle

| Modell | Größe | Zweck |
|--------|-------|-------|
| `llama-3-8b-instruct` | ~5 GB | Allgemein, sehr gut |
| `qwen2.5-7b-instruct` | ~4 GB | Code & Technik |
| `phi-3-mini` | ~2 GB | Schnell, kompakt |
| `mistral-7b-instruct` | ~4 GB | Ausgewogen |

---

## Funktionstest

### Test 1: Desktop-GUI Test

1. **LM Studio starten**
   ```bash
   ~/Applications/LMStudio/LMStudio.AppImage --no-sandbox
   ```

2. **Modell laden**
   - Gehe zu "Local Server" (links)
   - Wähle ein heruntergeladenes Modell
   - Klicke "Load Model"
   - Warte bis Status "Loaded" erscheint

3. **Chat testen**
   - Gehe zu "Chat" (links)
   - Schreibe eine Frage: "Erkläre mir in einem Satz, was du bist"
   - Drücke Enter
   - **Erwartung**: Das Modell antwortet in wenigen Sekunden

4. **GPU-Nutzung prüfen** (falls NVIDIA)
   ```bash
   # In neuem Terminal
   nvidia-smi
   
   # Sollte GPU-Auslastung zeigen
   ```

### Test 2: Python SDK Test

**Voraussetzung**: LM Studio läuft und ein Modell ist geladen!

```bash
# Virtuelle Umgebung aktivieren
cd ~/Projects/lmstudio-python
source venv/bin/activate

# Test-Skript erstellen
cat > test_connection.py << 'EOF'
#!/usr/bin/env python3
import lmstudio as lms

print("🔍 Suche nach LM Studio Server...")

# Server suchen
api_host = lms.Client.find_default_local_api_host()

if api_host:
    print(f"✅ LM Studio Server gefunden: {api_host}")
else:
    print("❌ LM Studio Server nicht gefunden!")
    print("   Bitte starte die Desktop-App!")
    exit(1)

# Geladene Modelle auflisten
print("\n📦 Geladene Modelle:")
loaded = lms.list_loaded_models()

if not loaded:
    print("   Keine Modelle geladen!")
    print("   Bitte lade ein Modell in der Desktop-App.")
    exit(1)

for idx, model in enumerate(loaded, 1):
    print(f"   {idx}. {model.identifier}")

# Einfacher Test
print("\n💬 Teste Modell...")
model = loaded[0]
response = model.respond("Sage einfach nur 'Hallo Welt'")
print(f"   Antwort: {response}")

print("\n✅ Alle Tests erfolgreich!")
EOF

chmod +x test_connection.py
python test_connection.py
```

**Erwartete Ausgabe:**
```
🔍 Suche nach LM Studio Server...
✅ LM Studio Server gefunden: localhost:1234

📦 Geladene Modelle:
   1. llama-3-8b-instruct

💬 Teste Modell...
   Antwort: Hallo Welt

✅ Alle Tests erfolgreich!
```

---

## Python-Beispiele

### Beispiel 1: Einfache Textgenerierung

```python
#!/usr/bin/env python3
import lmstudio as lms

# Einfachste Verwendung
model = lms.llm()
result = model.respond("Was ist künstliche Intelligenz?")
print(result)
```

### Beispiel 2: Chat mit Kontext

```python
#!/usr/bin/env python3
import lmstudio as lms

# Modell laden
model = lms.llm()

# Chat-Session mit System-Prompt
chat = lms.Chat("Du bist ein hilfreicher Python-Tutor")

# Mehrere Fragen
questions = [
    "Was sind List Comprehensions?",
    "Zeige mir ein Beispiel",
    "Wann sollte ich sie verwenden?"
]

for question in questions:
    chat.add_user_message(question)
    print(f"\n👤 Frage: {question}")
    
    response = model.respond(chat)
    chat.add_assistant_response(response)
    
    print(f"🤖 Antwort: {response}")
    print("-" * 60)
```

### Beispiel 3: Streaming-Antworten

```python
#!/usr/bin/env python3
import lmstudio as lms

model = lms.llm()

print("🤖 Assistent: ", end="", flush=True)

# Token-für-Token ausgeben (wie ChatGPT)
for token in model.stream("Erzähle mir eine kurze Geschichte über einen Roboter"):
    print(token, end="", flush=True)

print("\n")
```

### Beispiel 4: Strukturierte Ausgabe (JSON)

```python
#!/usr/bin/env python3
import lmstudio as lms
from pydantic import BaseModel

# Datenstruktur definieren
class Book(BaseModel):
    title: str
    author: str
    year: int
    summary: str

# Modell laden
model = lms.llm()

# Strukturierte Antwort erzwingen
result = model.respond(
    "Nenne mir ein berühmtes Science-Fiction-Buch",
    response_format=Book
)

# Typsichere Ausgabe
book = result.parsed
print(f"📚 Titel: {book.title}")
print(f"✍️  Autor: {book.author}")
print(f"📅 Jahr: {book.year}")
print(f"📝 Zusammenfassung: {book.summary}")
```

### Beispiel 5: Mehrere Modelle verwenden

```python
#!/usr/bin/env python3
import lmstudio as lms

with lms.Client() as client:
    # Liste aller heruntergeladenen Modelle
    available = client.llm.list_downloaded()
    print("📦 Verfügbare Modelle:")
    for model in available:
        print(f"  - {model.identifier}")
    
    # Spezifisches Modell laden und nutzen
    model1 = client.llm.model("llama-3-8b-instruct")
    model2 = client.llm.model("qwen2.5-7b-instruct")
    
    # Beide Modelle befragen
    question = "Was ist 2+2?"
    
    response1 = model1.respond(question)
    print(f"\n🦙 Llama: {response1}")
    
    response2 = model2.respond(question)
    print(f"🐉 Qwen: {response2}")
```

### Beispiel 6: Vollständiges interaktives Chat-Programm

```python
#!/usr/bin/env python3
import lmstudio as lms

def main():
    print("=" * 60)
    print("🤖 LM Studio Chat")
    print("=" * 60)
    
    # Modell laden
    try:
        model = lms.llm()
    except Exception as e:
        print(f"❌ Fehler: {e}")
        print("\nBitte stelle sicher, dass:")
        print("1. LM Studio läuft")
        print("2. Ein Modell geladen ist")
        return
    
    # Chat-Session starten
    chat = lms.Chat("Du bist ein freundlicher Assistent")
    
    print("\n💡 Gib 'exit' oder 'quit' ein zum Beenden\n")
    
    while True:
        # Eingabe
        user_input = input("👤 Du: ")
        
        # Beenden?
        if user_input.lower() in ['exit', 'quit', 'q']:
            print("\n👋 Auf Wiedersehen!")
            break
        
        if not user_input.strip():
            continue
        
        # Nachricht senden
        chat.add_user_message(user_input)
        
        # Streaming-Antwort
        print("🤖 Bot: ", end="", flush=True)
        response = ""
        
        for token in model.stream(chat):
            print(token, end="", flush=True)
            response += token
        
        print()  # Neue Zeile
        
        # Antwort zum Chat hinzufügen
        chat.add_assistant_message(response)

if __name__ == "__main__":
    main()
```

---

## Troubleshooting

### Problem 1: LM Studio startet nicht

**Symptom**: AppImage startet nicht oder stürzt ab

**Lösung**:
```bash
# Mit --no-sandbox Flag starten
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox

# Falls das nicht hilft, Log prüfen:
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox 2>&1 | tee lmstudio.log
```

### Problem 2: GPU wird nicht erkannt

**Symptom**: Modelle laufen auf CPU statt GPU

**Lösung**:
```bash
# CUDA-Installation prüfen
nvidia-smi

# CUDA-Toolkit installieren
sudo pacman -S cuda

# LM Studio neu starten
```

### Problem 3: Python SDK findet Server nicht

**Symptom**: `find_default_local_api_host()` gibt `None` zurück

**Lösung**:
```bash
# 1. LM Studio muss laufen!
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox &

# 2. Server-Status prüfen
lms server status

# 3. Server manuell starten (falls nötig)
lms server start

# 4. Port prüfen (Default: 1234)
netstat -tlnp | grep 1234
```

### Problem 4: "Module not found: lmstudio"

**Symptom**: Python kann lmstudio nicht importieren

**Lösung**:
```bash
# Virtuelle Umgebung aktiviert?
source venv/bin/activate

# LM Studio SDK installiert?
pip install lmstudio

# Installation prüfen
pip list | grep lmstudio
```

### Problem 5: Modelle werden nicht angezeigt

**Symptom**: `list_loaded_models()` ist leer

**Lösung**:
```bash
# In der Desktop-GUI:
# 1. Gehe zu "Local Server"
# 2. Wähle ein Modell aus
# 3. Klicke "Load Model"
# 4. Warte bis Status "Loaded" erscheint

# Per CLI:
lms load llama-3-8b-instruct
```

### Problem 6: "Out of memory" Fehler

**Symptom**: Modell lädt nicht, OOM-Fehler

**Lösung**:
```bash
# Kleineres Modell verwenden
# Statt: llama-3-70b (zu groß)
# Nutze: llama-3-8b oder phi-3-mini

# Oder quantisiertes Modell nutzen:
# - Q4_0 (4-bit, klein)
# - Q5_0 (5-bit, mittel)
# - Q8_0 (8-bit, groß)
```

---

## Nützliche Befehle

### LM Studio Management

```bash
# LM Studio starten
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox

# Im Hintergrund starten
~/Applications/LMStudio/LMStudio.AppImage --no-sandbox &

# Server-Status prüfen
lms server status

# Server starten/stoppen
lms server start
lms server stop

# Heruntergeladene Modelle anzeigen
lms ls

# Geladene Modelle anzeigen
lms ps

# Modell laden
lms load llama-3-8b-instruct

# Modell entladen
lms unload llama-3-8b-instruct
```

### Python Schnellbefehle

```bash
# SDK installieren
pip install lmstudio

# Python REPL mit LM Studio
python -c "import lmstudio as lms; print(lms.llm().respond('Hallo'))"

# Interaktiver Chat
python << 'EOF'
import lmstudio as lms
model = lms.llm()
while True:
    q = input("Du: ")
    if q == "exit": break
    print(f"Bot: {model.respond(q)}")
EOF
```

### GPU Monitoring

```bash
# GPU-Nutzung live anzeigen
watch -n 1 nvidia-smi

# Oder mit nvtop (schöner)
yay -S nvtop
nvtop
```

### Modell-Cache verwalten

```bash
# Cache-Größe prüfen
du -sh ~/.cache/lmstudio/

# Modelle manuell löschen
rm -rf ~/.cache/lmstudio/models/MODEL_NAME

# Kompletten Cache leeren (VORSICHT!)
# rm -rf ~/.cache/lmstudio/
```

---

## Zusammenfassung

### ✅ Checkliste: Installation erfolgreich

- [ ] LM Studio Desktop-App läuft
- [ ] Icon im Anwendungsmenü sichtbar
- [ ] Mindestens ein Modell heruntergeladen
- [ ] Modell in Desktop-App geladen
- [ ] GPU-Beschleunigung funktioniert (falls NVIDIA)
- [ ] Python SDK installiert
- [ ] Python-Test erfolgreich
- [ ] Erstes Skript funktioniert

### 📁 Wichtige Pfade

```bash
# Desktop-App
~/Applications/LMStudio/LMStudio.AppImage

# Desktop-Entry
~/.local/share/applications/lmstudio.desktop

# Modelle
~/.cache/lmstudio/models/

# Python venv
~/Projects/lmstudio-python/venv/

# Config
~/.config/LM_Studio/
```

### 🚀 Nächste Schritte

1. **Experimentiere mit verschiedenen Modellen**
   - Teste unterschiedliche Größen
   - Vergleiche Geschwindigkeit vs. Qualität

2. **Erweitere deine Python-Skripte**
   - Integriere in eigene Projekte
   - Baue Tools und Automatisierungen

3. **Fortgeschrittene Features erkunden**
   - Function Calling
   - Structured Outputs
   - RAG (Retrieval Augmented Generation)

4. **Community beitreten**
   - [LM Studio Discord](https://discord.gg/lmstudio)
   - [GitHub Discussions](https://github.com/lmstudio-ai)

---

## Weiterführende Ressourcen

- **Offizielle Dokumentation**: https://lmstudio.ai/docs
- **Python SDK Docs**: https://lmstudio.ai/docs/python
- **CLI Referenz**: https://lmstudio.ai/docs/cli
- **Modell-Hub**: https://lmstudio.ai/models
- **Blog**: https://lmstudio.ai/blog


# KI-Leitfaden für Dell XPS 13 mit Snapdragon X Elite

## 🚀 Phase 1: Grundausstattung (Tag 1-2)

### System vorbereiten
1. **Windows 11 aktualisieren**
   - Stelle sicher, dass du die neueste Version hast
   - Aktiviere Windows Subsystem for Linux (WSL2) optional

2. **Package Manager installieren**
   ```powershell
   # Winget sollte bereits installiert sein, falls nicht:
   # Über Microsoft Store "App Installer" installieren
   ```

### Erste KI-Tools installieren

3. **Ollama installieren** (Einfachster Einstieg)
   - Gehe zu: https://ollama.ai/download
   - Lade Windows ARM64-Version herunter
   - Installiere und starte

4. **Erstes Modell testen**
   ```cmd
   ollama pull phi3:mini
   ollama run phi3:mini
   ```
   - Probiere einfache Fragen aus
   - Teste die Performance

## 🔧 Phase 2: Entwicklungsumgebung (Tag 3-5)

### Python-Setup
5. **Miniconda installieren**
   - Download: https://docs.conda.io/en/latest/miniconda.html
   - Wähle Windows ARM64-Version
   - Installiere mit Standard-Einstellungen

6. **KI-Environment erstellen**
   ```bash
   # Terminal/PowerShell öffnen
   conda create -n ki python=3.11
   conda activate ki
   
   # Basis-Pakete installieren
   pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
   pip install transformers datasets huggingface-hub
   pip install numpy pandas matplotlib jupyter
   ```

### Visual Studio Code Setup
7. **VS Code installieren**
   - Download ARM64-Version von: https://code.visualstudio.com/
   - Installiere Python-Extension
   - Installiere Jupyter-Extension

## 🤖 Phase 3: Erste KI-Projekte (Tag 6-10)

### Lokale Chatbots
8. **LM Studio testen**
   - Download: https://lmstudio.ai/
   - Installiere ARM64-Version
   - Lade Phi-3-Mini oder Llama-3.2-3B herunter
   - Experimentiere mit verschiedenen Prompts

### Hugging Face experimentieren
9. **Erstes Python-Projekt**
   ```python
   # test_ki.py
   from transformers import pipeline
   
   # Text-Generierung
   generator = pipeline('text-generation', 
                       model='microsoft/Phi-3-mini-4k-instruct',
                       device_map='cpu')
   
   result = generator("Erkläre mir Quantencomputing:", 
                     max_length=200)
   print(result[0]['generated_text'])
   ```

### Spracherkennung testen
10. **Whisper.cpp installieren**
    - GitHub: https://github.com/ggerganov/whisper.cpp
    - Compiliere für ARM64 oder nutze Releases
    - Teste lokale Spracherkennung

## 🎯 Phase 4: Spezialisierte Anwendungen (Tag 11-15)

### Bildverarbeitung
11. **Stable Diffusion (ONNX)**
    ```python
    # Installiere ONNX Runtime
    pip install onnxruntime
    pip install diffusers[onnx]
    
    # Teste einfache Bildgenerierung
    from diffusers import OnnxStableDiffusionPipeline
    # Code für Bildgenerierung...
    ```

### Textanalyse
12. **Sentiment Analysis & NLP**
    ```python
    from transformers import pipeline
    
    # Sentiment-Analyse
    sentiment = pipeline('sentiment-analysis')
    result = sentiment("Ich liebe KI-Entwicklung!")
    
    # Named Entity Recognition
    ner = pipeline('ner', aggregation_strategy='simple')
    entities = ner("Berlin ist die Hauptstadt von Deutschland")
    ```

## 🔬 Phase 5: Fortgeschrittene Projekte (Tag 16-30)

### Eigene Modelle fine-tunen
13. **LoRA Fine-tuning**
    ```python
    pip install peft accelerate
    # Kleine Modelle auf eigenen Daten trainieren
    ```

### API-Server aufsetzen
14. **LocalAI installieren**
    - Erstelle lokalen API-Server
    - Integriere verschiedene Modelle
    - Teste mit REST-API

### NPU-Optimierung erforschen
15. **Qualcomm AI Engine Direct**
    - Experimentiere mit NPU-Beschleunigung
    - Teste ONNX mit QNN Provider
    - Messe Performance-Unterschiede

## 📊 Empfohlene Modelle für dein System

| Modell | Größe | Zweck | RAM-Bedarf |
|--------|-------|-------|------------|
| Phi-3-Mini | 3.8B | Allgemein-Chat | 4-6GB |
| Llama-3.2-3B | 3B | Code & Text | 4-5GB |
| Gemma-2-2B | 2B | Effizienz | 3-4GB |
| Qwen2.5-1.5B | 1.5B | Schnell | 2-3GB |

## 🛠️ Nützliche Befehle

### Ollama
```bash
# Modelle auflisten
ollama list

# Modell herunterladen
ollama pull [model-name]

# Modell löschen
ollama rm [model-name]

# API-Server starten
ollama serve
```

### Conda Environment
```bash
# Environment aktivieren
conda activate ki

# Pakete auflisten
conda list

# Environment klonen
conda create --clone ki --name ki-backup
```

## 🚨 Troubleshooting

### Häufige Probleme
- **Out of Memory:** Kleinere Modelle verwenden (1B-3B Parameter)
- **Langsame Performance:** Mehr RAM zuweisen, Background-Apps schließen
- **Installation-Fehler:** ARM64-Versionen explizit wählen
- **NPU nicht erkannt:** Windows Updates prüfen, Treiber aktualisieren

### Performance-Tipps
- Schließe Browser und andere speicherhungrige Apps
- Nutze Task Manager um RAM-Verbrauch zu überwachen
- Experimentiere mit verschiedenen Quantisierungen (4-bit, 8-bit)
- Teste verschiedene Batch-Größen

## 📚 Weiterführende Ressourcen

- **Hugging Face Hub:** https://huggingface.co/models
- **Ollama Modell-Library:** https://ollama.ai/library
- **ARM64 PyTorch:** https://pytorch.org/get-started/locally/
- **Qualcomm AI:** https://developer.qualcomm.com/software/qualcomm-ai-engine-direct

## 🎯 30-Tage-Ziele

**Woche 1:** Grundtools installiert, erste Modelle laufen
**Woche 2:** Python-Entwicklung, eigene Skripte
**Woche 3:** Spezialisierte Anwendungen (Bild, Sprache, Text)
**Woche 4:** Optimierung, NPU-Integration, eigene Projekte

Viel Erfolg bei deiner KI-Reise! 🚀
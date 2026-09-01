
## Lokales Vibe Coding auf CachyOS mit NVIDIA RTX

Dieses Dokument beschreibt die Einrichtung eines lokalen
AI-Coding-Workflows mit:

- LLM-Server: Ollama
- Client: Aider
- Modelle: Hugging Face
- GPU: NVIDIA RTX (z. B. 4070 Ti Super)

Ziel:
➡️ Schnelles, cloud-freies Vibe Coding direkt auf dem Desktop.

---

## 📋 Voraussetzungen

### Hardware
- 32 GB RAM (empfohlen)
- NVIDIA-GPU mit CUDA (>= 12 GB VRAM)

### Software
- CachyOS / Arch-basiert
- Aktuelle NVIDIA-Treiber
- Python ≥ 3.10
- Git

---

## ✅ Schritt 1: NVIDIA-Treiber prüfen

Zuerst sicherstellen, dass CUDA funktioniert:

```bash
nvidia-smi
````

Erwartet:

- GPU wird angezeigt
    
- Treiberversion sichtbar
    

Falls nicht → erst Treiber installieren.

---

## ✅ Schritt 2: Ollama installieren

### Installation (offiziell)

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Oder über AUR:

```bash
yay -S ollama
```

---

### Dienst starten

```bash
systemctl --user enable ollama
systemctl --user start ollama
```

Oder manuell:

```bash
ollama serve
```

API läuft dann auf:

[http://localhost:11434](http://localhost:11434/)

---

## ✅ Schritt 3: Hugging-Face-Modell laden

Ollama kann direkt von Hugging Face laden.

### Empfohlenes Coding-Modell (14B)

```bash
ollama pull hf.co/Qwen/Qwen2.5-Coder-14B-Instruct
```

Alternative (kleiner, schneller):

```bash
ollama pull hf.co/deepseek-ai/deepseek-coder-6.7b-instruct
```

---

### Test

```bash
ollama run qwen2.5-coder
```

Wenn eine Antwort kommt → OK ✅

---

## ✅ Schritt 4: Aider installieren

Empfohlen: via pipx

### pipx installieren

```bash
sudo pacman -S python-pipx
pipx ensurepath
```

Neues Terminal öffnen!

---

### Aider installieren

```bash
pipx install aider-chat
```

Test:

```bash
aider --version
```

---

## ✅ Schritt 5: Aider mit Ollama verbinden

Aider erwartet eine OpenAI-kompatible API.

Ollama bietet diese automatisch.

---

### Umgebungsvariablen setzen

#### Bash / Zsh

```bash
export OPENAI_API_BASE=http://localhost:11434/v1
export OPENAI_API_KEY=dummy
```

#### Dauerhaft (optional)

In ~/.bashrc oder ~/.zshrc eintragen.

---

## ✅ Schritt 6: Aider starten

Im Projektordner:

```bash
cd mein-projekt
aider --model qwen2.5-coder
```

Oder:

```bash
aider --model deepseek-coder
```

Fertig: Lokaler Coding-Assistant ist aktiv 🚀

---

## 🧠 Empfohlene Profile

### Balanced (Standard)

```text
Model: Qwen2.5-Coder-14B
VRAM: ~10 GB
Speed: Hoch
Quality: Sehr hoch
```

### Fast Mode

```text
Model: DeepSeek-Coder-6.7B
VRAM: ~6 GB
Speed: Sehr hoch
Quality: Gut
```

### Quality Mode

```text
Model: 20B Q4 (experimentell)
VRAM: ~14 GB
Speed: Mittel
Quality: Sehr hoch
```

---

## ⚙️ Schritt 7: Optionales Ollama-Tuning

Datei erstellen:

~/.ollama/config.yaml

Beispiel:

```yaml
gpu: true
num_gpu_layers: -1
num_thread: 16
```

Dann Ollama neu starten.

---

## 🔄 Schritt 8: Workflow mit Git

Empfohlener Ablauf:

```bash
git init
git add .
git commit -m "init"

aider
```

In Aider:

> Refactor this module  
> Add tests  
> Improve error handling

Dann:

```bash
git diff
git commit
```

Aider arbeitet direkt mit Git.

---

## 🛠️ Typische Probleme

### ❌ GPU wird nicht genutzt

Prüfen:

```bash
ollama info
```

Wenn "cuda" fehlt → Treiberproblem.

---

### ❌ Aider verbindet sich nicht

Prüfen:

```bash
curl http://localhost:11434/v1/models
```

Wenn keine Antwort → Ollama läuft nicht.

---

### ❌ Zu langsam

Lösungen:

- Kleineres Modell
    
- Q4/Q5 nutzen
    
- Context reduzieren
    

---

## 📊 Performance-Erwartung (RTX 4070 Ti Super)

|Bereich|Erwartung|
|---|---|
|Tokens/s|40–120+|
|Latenz|< 1 Sekunde|
|Repos|Groß|
|Sessions|Stundenlang|

Nahe Cloud-Niveau.

---

## 🏁 Fazit

Mit diesem Setup erhältst du:

✅ Voll lokal  
✅ Datenschutzfreundlich  
✅ Sehr schnell  
✅ Cloud-unabhängig  
✅ Ideal für Vibe Coding

Geeignet für:

- Produktives Arbeiten
- Schulungen
- Demos
- Langzeitprojekte

---

## 📎 Referenz-Stack

- LLM-Server: Ollama
- Modelle: Hugging Face
- Client: Aider
- GPU: NVIDIA CUDA
- OS: CachyOS
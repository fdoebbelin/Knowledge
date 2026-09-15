## 1. Systemvoraussetzungen auf CachyOS

### 1.1 `libgomp` / GCC-Libs installieren

Auf CachyOS (Arch-basiert) ist `libgomp` normalerweise im Paket **gcc-libs** enthalten.[^1][^2]

```bash
sudo pacman -S gcc-libs
```

Falls das Paket bereits installiert ist, aber die Bibliothek nicht gefunden wird:

```bash
ldconfig -p | grep libgomp
```

Falls auf deinem System ein separates Paket **libgomp** existiert, kannst du es alternativ installieren:

```bash
sudo pacman -S libgomp
```

Paketdatenbank aktualisieren:

```bash
sudo pacman -Syu
```

Bei weiterhin fehlenden OpenMP-Bibliotheken kann das vollständige **gcc**-Paket helfen:

```bash
sudo pacman -S gcc
```


***

## 2. Nexa SDK mit NVIDIA-GPU installieren

### 2.1 Python-SDK installieren

Für GPU-Nutzung gibt es derzeit das GPU-Paket `nexaai-gpu`:[^3][^4]

```bash
# CPU-Variante
pip install nexaai

# GPU-Variante (CUDA/Vulkan, je nach Backend)
pip install nexaai-gpu
```

Wenn deine bisherige Doku auf `pip install nexaai[cuda]` oder `nexaai[cuda11]` verweist, prüfe die aktuelle README/Docs deines konkreten Releases, da sich die Extras geändert haben können.[^4][^3]

***

## 3. (Optionale) Lizenz / Token einrichten

Für reine CPU/GPU-Nutzung ist eine Lizenz in vielen Szenarien optional, bestimmte Features (z.B. NPU-Unterstützung) können jedoch einen Token erfordern.[^4]

```bash
# Linux/macOS – Beispiel für Umgebungsvariable
export NEXA_TOKEN="key/dein-token-hier"
```

Falls du einen Nexa-spezifischen Lizenzbefehl nutzt, ist der typische CLI-Stil:

```bash
nexa config set license 'dein-token-hier'
nexa whoami
```

Abmelden:

```bash
nexa logout
```

Konkrete Token-Quelle (Account anlegen, Token kopieren) bitte in der jeweils aktuellen Nexa-Dokumentation nachlesen.[^4]

***

## 4. NVIDIA-GPU-Verfügbarkeit prüfen

```bash
# NVIDIA-Treiber / CUDA-Verfügbarkeit checken
nvidia-smi
```

Ein einfacher Python-Test (abhängig von deiner Nexa-Python-API-Version, hier exemplarisch):

```python
from nexa.gguf import NexaTextInference

inference = NexaTextInference(
    model_path="NexaAI/Qwen3-0.6B-GGUF",
    local_path=None,
    n_gpu_layers=-1  # alle Layer auf GPU
)

response = inference.create_completion(
    prompt="Erkläre mir in einem Satz, was Python ist.",
    max_tokens=100
)

print(response)
```

Die exakte Import-Struktur (`from nexa.gguf import ...` vs. neues Modul-Layout) kann je nach Nexa-SDK-Version leicht abweichen, daher im Zweifel kurz die aktuelle Quickstart-Seite prüfen.[^4]

***

## 5. Modelle mit Nexa-CLI verwalten

### 5.1 Verfügbare Modelle auflisten

```bash
nexa list
```


### 5.2 Kleine Modelle herunterladen

Korrekte vollständige Repository-Namen verwenden (z.B. wie in der offiziellen Doku):[^5][^6]

```bash
# Sehr kleines Qwen3-Modell
nexa pull NexaAI/Qwen3-0.6B-GGUF

# Etwas größeres Qwen3-Modell
nexa pull ggml-org/Qwen3-1.7B-GGUF
```

Alternative kleine Modelle (Bezeichnungen können je nach Registry variieren; bitte gegen aktuelle Model-Hub-Namen abgleichen):[^5]

```bash
# Beispiel Gemma
nexa pull gemma-2b-it-GGUF

# Beispiel Llama
nexa pull llama-3.2-1b-instruct-GGUF
```


### 5.3 Modelle ausführen

```bash
# Direktes Ausführen
nexa run NexaAI/Qwen3-0.6B-GGUF

# Interaktiver Chat
nexa infer NexaAI/Qwen3-0.6B-GGUF
```

Wenn du unsicher bist, welches Modell du wählen sollst:

```bash
nexa infer
```

Die CLI fragt dich dann nach einem Modellnamen.[^5]

***

## 6. Minimaler GPU-Testlauf

Empfehlung zum schnellen Test auf CachyOS mit NVIDIA-GPU:

```bash
# 1. System aktualisieren und GCC-Libs sicherstellen
sudo pacman -Syu
sudo pacman -S gcc-libs

# 2. Nexa GPU-SDK installieren
pip install nexaai-gpu

# 3. Kleines Modell ziehen
nexa pull NexaAI/Qwen3-0.6B-GGUF

# 4. Interaktiv testen
nexa infer NexaAI/Qwen3-0.6B-GGUF
```

Wenn du möchtest, kann ich dir daraus noch eine extrem kompakte README‑Sektion für dein persönliches Setup auf CachyOS formulieren.
<span style="display:none">[^10][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: https://bbs.archlinux.org/viewtopic.php?id=134265

[^2]: https://www.reddit.com/r/archlinux/comments/1r22zrx/does_anyone_know_what_happened_to_gcclibs_why_was/

[^3]: https://pypi.org/project/nexaai-gpu/

[^4]: https://docs.nexa.ai/en/nexa-sdk-python/quickstart

[^5]: https://docs.nexa.ai/en/nexa-sdk-go/NexaAPI

[^6]: https://github.com/NexaAI/nexa-sdk/issues/868

[^7]: https://github.com/CachyOS/linux-cachyos

[^8]: https://github.com/NexaAI/nexa-sdk-enterprise

[^9]: https://huggingface.co/NexaAI/Qwen3-0.6B

[^10]: https://discuss.cachyos.org/t/pacman-update-issue/20668


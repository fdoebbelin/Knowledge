---
title: Aider mit lokalem LLM auf dem XPS 13 9345 (Snapdragon) – Python-Entwicklung
tags:
  - aider
  - llm
  - foundry-local
  - olive
  - npu
  - snapdragon
  - python
  - vibe-coding
created: 2026-06-22
status: Leitfaden
hardware: Dell XPS 13 9345 · Snapdragon X Elite · 32 GB
voraussetzung: "[[Foundry Local auf dem Dell XPS 13 9345 (Snapdragon X Elite)]]"
---

# Aider mit lokalem LLM auf dem XPS (Snapdragon)

> [!abstract] Ziel
> Aider als lokales Pair-Programming-Tool für Python, gespeist von einem für den Snapdragon X Elite passenden lokalen LLM – wahlweise ein fertiges Katalog-Modell oder ein selbst mit **Olive** kompiliertes ONNX-Modell. Anbindung läuft über den **OpenAI-kompatiblen Endpoint** von Foundry Local.
>
> Setzt das Setup aus [[Foundry Local auf dem Dell XPS 13 9345 (Snapdragon X Elite)]] voraus.

---

## 0. Realitäts-Check zuerst (wichtig!)

Bevor du Zeit investierst – drei harte Fakten, die deine Modellwahl bestimmen:

> [!warning] Es gibt kein QNN/NPU-Coder-Modell im Katalog
> Im Foundry-Local-Katalog existiert **kein** `qwen2.5-coder-*-qnn-npu`. Versuchst du es, bekommst du „Model not found" und den Vorschlag `qwen2.5-7b-instruct-qnn-npu`. Die `qwen2.5-coder-0.5b`-**NPU**-Variante im Katalog ist eine **OpenVINO**-Variante (= Intel-NPU) und läuft **nicht** auf der Qualcomm-Hexagon-NPU.

> [!warning] Aider mag keine kleinen Modelle
> Aiders Edit-Formate (`diff`/`udiff`) brauchen ein recht fähiges Modell. Unter ~7B wird das Editieren unzuverlässig. Auf dem Snapdragon ist 7B int4 praktisch die Obergrenze für angenehme Geschwindigkeit. Erwartung: brauchbar für kleine Dateien, Snippets, Refactorings – **kein** Claude-/GPT-4-Ersatz.

> [!tip] Dein bester Hebel: der Desktop
> Für ernsthafte Aider-Arbeit ist dein **RTX 4070 Ti Super**-Desktop um Welten besser als die XPS-NPU. Der NPU-Weg hier ist für **mobil/offline**. Siehe Abschnitt 7 für die Netzwerk-Anbindung an den Desktop.

---

## 1. Entscheidungsmatrix – welches Modell für welchen Zweck?

| Pfad | Modell | Läuft auf | Coding-Qualität | Speed | Aufwand |
|---|---|---|---|---|---|
| **A – Start, empfohlen** | `qwen2.5-7b-instruct-qnn-npu` | **Hexagon-NPU** (int4) | ⭐⭐⭐ (general, gut in Python) | schnell | gering |
| **B – Coder, aber CPU** | `qwen2.5-coder-7b` (generic-cpu) | **CPU** (keine QNN-Variante!) | ⭐⭐⭐⭐ (coder-tuned) | langsam | gering |
| **C – eigenes ONNX via Olive** | z. B. Qwen2.5-Coder-1.5B/3B | CPU / NPU (experimentell) | ⭐⭐⭐ skaliert mit Größe | variabel | hoch |

> [!note] Empfehlung
> **Mit A starten.** Es nutzt die NPU, ist flott und in Python kompetent. Wenn dir die Code-Qualität nicht reicht und du Latenz tolerierst, **B** testen. **C** ist der Lern-/Bastelpfad, wenn du eigene/fein­getunte Modelle brauchst – nicht der schnellste Weg zu „läuft einfach".

---

## 2. Aider installieren

Empfohlen über den isolierten Installer (vermeidet Dependency-Konflikte mit deinem Projekt):

```powershell
python -m pip install aider-install
aider-install
```

Alternativ mit `uv` (passt zu deinem Workflow):

```powershell
uv tool install --python python3.12 aider-chat
```

Verifizieren: `aider --version`.

---

## 3. Pfad A – Qwen2.5-7B auf der NPU (empfohlener Start)

### 3.1 Modell laden

```powershell
# lädt die NPU-Variante (QNN) und cached sie
foundry model run qwen2.5-7b-instruct-qnn-npu:3
# kurz testen, dann /exit
```

Exakte Model-ID prüfen (Version kann variieren, z. B. `:2`):

```powershell
foundry model list --filter alias=qwen2.5-7b
```

### 3.2 Endpoint ermitteln

> [!danger] Port ist dynamisch
> Foundry Local vergibt den Port bei jedem Dienststart neu. **Nie hartkodieren** – immer aus `foundry service status` lesen.

```powershell
foundry service status
# -> notiere die URL, z. B. http://127.0.0.1:5273/  →  Endpoint = .../v1
```

### 3.3 Aider verbinden

Direkt per Flags (am robustesten, weil portabel pro Session):

```powershell
aider `
  --openai-api-base http://127.0.0.1:5273/v1 `
  --openai-api-key dummy `
  --model openai/qwen2.5-7b-instruct-qnn-npu `
  --edit-format whole `
  --no-show-model-warnings
```

> [!info] Warum diese Flags?
> - `--openai-api-key dummy` → Aider **verlangt** einen Key, prüft ihn aber nicht. Jeder String genügt.
> - `openai/`-Präfix → sagt LiteLLM (Aiders Backend): rede OpenAI-kompatibel. Der Teil dahinter wird als `model` an Foundry Local geschickt – muss zur ID/zum Alias passen.
> - `--edit-format whole` → schreibt ganze Dateien statt Diffs. Für kleinere Modelle deutlich zuverlässiger.
> - `--no-show-model-warnings` → unterdrückt die „unbekanntes Modell"-Warnung (siehe 5. für Metadaten).

---

## 4. Pfad B – Qwen2.5-Coder-7B (coder-tuned, CPU)

Coder-getuntes Modell, bessere Code-Qualität – auf dem Snapdragon aber **CPU** (es gibt keine QNN-Variante):

```powershell
foundry model run qwen2.5-coder-7b      # wählt generic-cpu auf Snapdragon
foundry model list --filter alias=qwen2.5-coder
```

> [!tip] GPU statt CPU testen
> Prüfe, ob eine `generic-gpu`-Variante existiert – die könnte über WebGPU/DirectML auf der **Adreno-GPU** laufen und schneller sein als reine CPU:
> ```powershell
> foundry model list --filter alias=qwen2.5-coder --filter device=GPU
> ```
> Wenn ja, gezielt die GPU-Model-ID an `foundry model run` übergeben.

Aider-Aufruf identisch zu 3.3, nur mit der passenden Model-ID:

```powershell
aider --openai-api-base http://127.0.0.1:5273/v1 --openai-api-key dummy `
  --model openai/qwen2.5-coder-7b-instruct-generic-cpu --edit-format whole
```

---

## 5. Modell-Metadaten registrieren (Kontextfenster, Warnungen weg)

Aider kennt deine lokalen Modelle nicht und nimmt konservative Defaults an. Mit einer Metadaten-Datei legst du Kontextgröße & Co. fest. Lege im Projekt (oder `~/`) `.aider.model.metadata.json` an:

```json
{
  "openai/qwen2.5-7b-instruct-qnn-npu": {
    "max_input_tokens": 8192,
    "max_output_tokens": 4096,
    "input_cost_per_token": 0,
    "output_cost_per_token": 0,
    "litellm_provider": "openai",
    "mode": "chat"
  }
}
```

Aufruf dann mit `--model-metadata-file .aider.model.metadata.json`.

> [!note] Kontextfenster realistisch halten
> Phi-3.5-mini hat nur ~4K Kontext; die Qwen-7B-QNN-Variante meist 8K–32K – aber **praktische** Token-Budgets niedriger halten, sonst leidet Latenz spürbar. Für Aider lieber wenige Dateien mit `/add` gezielt einbinden statt das halbe Repo.

---

## 6. Komfort: Startskript (Port automatisch holen)

Damit du nicht jedes Mal `service status` abtippst.

### PowerShell (`Start-Aider.ps1`)

```powershell
$status = foundry service status | Out-String
$base = ([regex]'http://127\.0\.0\.1:\d+').Match($status).Value + "/v1"
$env:OPENAI_API_BASE = $base
$env:OPENAI_API_KEY  = "dummy"
Write-Host "Aider -> $base"
aider --model openai/qwen2.5-7b-instruct-qnn-npu --edit-format whole `
  --model-metadata-file .aider.model.metadata.json
```

### Nushell (passt zu deinem Daily Driver)

```nu
def start-aider [] {
  let status = (foundry service status | str join)
  let base = ($status | parse --regex 'http://127\.0\.0\.1:(?<p>\d+)' | get p.0)
  $env.OPENAI_API_BASE = $"http://127.0.0.1:($base)/v1"
  $env.OPENAI_API_KEY = "dummy"
  print $"Aider -> ($env.OPENAI_API_BASE)"
  aider --model openai/qwen2.5-7b-instruct-qnn-npu --edit-format whole
}
```

> [!tip] QNN-Eigenheit beachten
> Kein künstlicher Warmup-Ping – der erste **echte** Aider-Request lädt das Modell. Bei QNN kann Warmup den Runtime destabilisieren. Erste Antwort dauert daher etwas (Modell-Load), danach läuft's flüssig.

---

## 7. Alternative: Aider gegen den Desktop (RTX 4070 Ti Super)

Für echte Produktivität: Foundry Local (CUDA) oder Ollama auf dem Desktop laufen lassen, vom XPS aus anbinden. Du kannst dann ein **deutlich größeres/besseres** Coder-Modell fahren (z. B. Qwen2.5-Coder-14B/32B) mit `diff`-Edit-Format.

```powershell
# Desktop: Dienst im LAN erreichbar machen (Firewall/Port beachten)
# XPS:
aider --openai-api-base http://<desktop-ip>:<port>/v1 --openai-api-key dummy `
  --model openai/qwen2.5-coder-32b --edit-format diff
```

> [!warning] Nur im vertrauenswürdigen LAN
> Der Endpoint hat keine echte Auth. Nicht ungeschützt ins Internet exponieren. Für Remote-Zugriff lieber SSH-Tunnel/WireGuard statt offener Port.

---

## 8. Pfad C – Eigenes ONNX-Modell mit Olive

Wenn du ein Modell brauchst, das nicht im Katalog ist (eigenes Fine-Tuning, neuere HF-Modelle), konvertierst du es mit **Olive** und registrierst es in Foundry Local.

### 8.1 Olive installieren

```powershell
# eigene venv/conda-Umgebung empfohlen
pip install olive-ai
pip install transformers onnxruntime-genai
huggingface-cli login   # falls Modell Auth braucht
```

### 8.2 Konvertieren & quantisieren (CPU/int4 – der zuverlässige Weg)

```powershell
olive auto-opt `
  --model_name_or_path Qwen/Qwen2.5-Coder-1.5B-Instruct `
  --trust_remote_code `
  --output_path models/qwen-coder-1.5b `
  --device cpu `
  --provider CPUExecutionProvider `
  --use_model_builder `
  --use_ort_genai `
  --precision int4 `
  --log_level 1
```

> [!info] Flags
> `--use_ort_genai` → erzeugt das Format, das Foundry Local konsumiert. `--use_model_builder` → exportiert die Transformer-Layer sauber nach ONNX. `--precision int4` → max. Kompression (für bessere Qualität `int8`).

### 8.3 Ordner umbenennen & Chat-Template anlegen

```powershell
cd models/qwen-coder-1.5b
Rename-Item -Path "model" -NewName "qwen-coder-1.5b"
```

Foundry Local braucht eine `inference_model.json` im Modellordner. Minimal:

```json
{
  "Name": "qwen-coder-1.5b:1",
  "PromptTemplate": {
    "assistant": "{Content}",
    "prompt": "<|im_start|>system\nYou are a helpful coding assistant.<|im_end|>\n<|im_start|>user\n{Content}<|im_end|>\n<|im_start|>assistant\n"
  }
}
```

> [!warning] Prompt-Template muss zum Modell passen
> Das obige nutzt das **ChatML**-Format (Qwen). Für andere Familien (Llama, Phi) die jeweiligen Spezial-Tokens verwenden, sonst wird die Ausgabe Müll. Am sichersten: mit Hugging Faces `tokenizer.apply_chat_template()` generieren lassen.

### 8.4 In Foundry Local registrieren & nutzen

```powershell
foundry cache cd path\to\models      # Cache auf dein Modellverzeichnis zeigen
foundry cache ls                      # Modell sollte erscheinen
foundry model run qwen-coder-1.5b     # testen
```

Danach in Aider wie gewohnt: `--model openai/qwen-coder-1.5b`.

### 8.5 NPU/QNN-Konvertierung – die ehrliche Einordnung

> [!danger] QNN ist der schwierige Pfad
> `--device npu --provider QNNExecutionProvider` ist theoretisch möglich, aber: QNN hat **begrenzte Operator-Abdeckung**, braucht das **Qualcomm AI Engine Direct (QNN) SDK**, und `auto-opt` „funktioniert" für ein 7B-Coder-Modell oft **nicht** out-of-the-box. Erwarte Debugging.
>
> Pragmatisch: Für NPU bei den **fertigen** QNN-Katalogmodellen bleiben (Pfad A). Für Custom-Modelle den **CPU/int4**- oder **generic-gpu**-Weg nehmen (zuverlässig). Wenn du QNN unbedingt willst: starte bei den **Olive Recipes** (`github.com/microsoft/olive-recipes`), die hardware-spezifische, getestete Konfigurationen liefern – nicht bei selbstgebauten Flags.

---

## 9. Troubleshooting

| Symptom | Fix |
|---|---|
| Aider: „model not found" | exakte ID/Alias aus `foundry model list` bzw. `foundry service ps` nehmen |
| `litellm.APIError` / Connection refused | `foundry service status` → Port stimmt? Dienst läuft? `foundry service restart` |
| Aider startet, antwortet aber leer | WinML/Backend-Problem; auf physischer HW mit iGPU/NPU prüfen, ggf. anderes Variant |
| Leerer Output + Fehlercode 5005 (`Failed to load from EpContext model`) | NPU-Treiberkonflikt → **Reboot**; persistiert es: Qualcomm-Treiber via Software Center updaten |
| Aider macht kaputte Edits | `--edit-format whole`, weniger Dateien per `/add`, kleinere Aufgaben |
| Erste Antwort sehr langsam | normal: Modell-Load beim ersten Request (QNN, kein Warmup) |
| Port ändert sich ständig | Startskript aus Abschnitt 6 nutzen |
| pip-Konflikt `onnxruntime-core` | nicht `foundry-local-sdk` **und** `-winml` gleichzeitig installieren |

---

## 10. Realistische Erwartung & Workflow-Tipps

- **Architect/Editor-Split** (`--architect`) lohnt lokal selten – kostet Tokens/Zeit, der Gewinn ist bei 7B klein. Erst auf dem Desktop mit großem Modell interessant.
- **Kleine, klar umrissene Aufgaben** geben Aider lokal die besten Ergebnisse: eine Funktion, ein Test, ein Refactor.
- **Git-Disziplin**: Aider committet automatisch – nutze das, um schlechte Edits schnell per `git reset` zu verwerfen.
- **Whisper-Bonus**: Foundry Local kann auch `whisper-base` lokal – falls du Voice-Input in deinen Vibe-Coding-Workflow ziehen willst.

---

## Verwandte Notizen

- [[Foundry Local auf dem Dell XPS 13 9345 (Snapdragon X Elite)]]
- [[Vibe Coding – Helix + Aider + WezTerm]]
- [[Zwei-Tier-Architektur – Desktop-GPU + XPS-Client]]
- [[Olive Recipes – ONNX-Konvertierung Cheatsheet]]

---
title: Foundry Local auf dem Dell XPS 13 9345 (Snapdragon X Elite)
tags:
  - llm
  - foundry-local
  - npu
  - snapdragon
  - windows-arm
  - lokale-ki
created: 2026-06-22
status: active
type: anleitung
hardware: Dell XPS 13 9345 · Snapdragon X Elite · 32 GB
---

# Foundry Local auf dem Dell XPS 13 9345

> [!abstract] Worum geht es?
> Foundry Local ist Microsofts lokale KI-Runtime auf Basis der **ONNX Runtime**. Sie bringt ihre **eigene CLI** (`foundry`) mit – ein separates CLI-Tool brauchst du also nicht. Die CLI ist genau für interaktives Experimentieren, Modell-Browsing und Cache-Verwaltung im Terminal gedacht. Der Snapdragon X Elite wird inkl. **NPU-Beschleunigung** über den **QNN Execution Provider** offiziell unterstützt.

> [!warning] Public Preview
> Foundry Local ist zum Stand dieses Guides **Public Preview**: kein SLA, keine Abwärtskompatibilitäts-Garantie, Verhalten kann sich zwischen Releases ändern. Aktuelle Version zur Zeit dieses Guides: ~`0.8.x`.

---

## 1. Einordnung – was Foundry Local ist und was nicht

| Aspekt | Foundry Local | Vergleich Ollama / LM Studio |
|---|---|---|
| Primärzweck | Runtime + SDK zum **Ausliefern** von Apps | freies Modell-Experimentieren |
| Modellkatalog | **kuratiert**, auf Consumer-HW getestet | offen (quasi alles von HF) |
| Format | ONNX (+ Olive-Konvertierung) | GGUF |
| HW-Abstraktion | automatisch: NPU / GPU / CPU via ONNX EPs | meist CPU/GPU (GGUF) |
| API | OpenAI-kompatibel (optionaler lokaler Server) | OpenAI-kompatibel |

> [!note] Realistische Erwartung
> Microsoft positioniert Foundry Local als **Runtime zum Einbetten in Apps**, nicht als allgemeine Spielwiese. Der Katalog ist bewusst eng. Für „beliebige HF-Modelle ausprobieren" bleibt Ollama/LM Studio flexibler. Stärke von Foundry Local: **NPU-Nutzung out-of-the-box** und ein OpenAI-kompatibler Endpoint für deine Tools (z. B. Aider).

---

## 2. Voraussetzungen (XPS-spezifisch)

- [x] **OS:** Windows 11, mindestens **24H2** (Pflicht für neue NPUs auf Copilot+-PCs)
- [x] **Hardware:** Snapdragon X Elite ✔ (offiziell genannt, ab 8 GB Speicher – du hast 32 GB)
- [x] **Speicher:** ≥ 3 GB frei (empfohlen ≥ 15 GB für mehrere Modelle)
- [x] **Paketmanager:** `winget` vorhanden
- [x] **Adminrechte** zum Installieren
- [x] **Internet** für den ersten Download (Execution Provider + Modelle); danach offline nutzbar

> [!tip] Snapdragon-Vorteil
> Mit 32 GB RAM kannst du auf der NPU auch die **7B-QNN-Varianten** (z. B. Qwen2.5-7B) komfortabel laden, nicht nur die kleinen Phi-Modelle.

---

## 3. Installation

PowerShell öffnen (für die `foundry`-Befehle ist die Shell egal – Nushell geht später auch):

```powershell
winget install -e --id Microsoft.FoundryLocal
```

Danach **Terminal schließen und neu öffnen**, damit `foundry` im PATH ist. Verifizieren:

```powershell
foundry --version
```

> [!bug] Fallback bei winget-Fehler
> Schlägt `winget install Microsoft.FoundryLocal --scope machine` mit „The current system configuration doesn't support the installation of this package." fehl: `.msix` + Dependency-Paket manuell laden und mit `Add-AppxProvisionedPackage` in einer **Administrator**-PowerShell installieren.

---

## 4. Dienst prüfen

Foundry Local läuft als Hintergrunddienst, der einen OpenAI-kompatiblen REST-Endpoint bereitstellt (**dynamischer Port!**):

```powershell
foundry service status
```

Falls „Request to local service failed":

```powershell
foundry service restart
```

Weitere Dienst-Befehle:

```powershell
foundry service start      # Dienst starten
foundry service stop       # Dienst stoppen
foundry service ps          # geladene Modelle anzeigen
foundry service logs        # Logs (inkl. ONNX-Runtime-Ausgaben)
```

---

## 5. Modelle finden und nach NPU filtern

Beim **ersten** `model list` lädt Foundry Local automatisch die passenden Execution Provider für deine Hardware (Fortschrittsbalken):

```powershell
foundry model list
```

Gezielt filtern:

```powershell
# nur NPU-Modelle (relevant für den Snapdragon)
foundry model list --filter device=NPU

# nur Chat-Modelle
foundry model list --filter task=chat-completion

# nach Execution Provider
foundry model list --filter provider=QNNExecutionProvider

# Negation: GPU ausschließen
foundry model list --filter device=!GPU

# Wildcard (nur bei alias): alle qwen-Modelle
foundry model list --filter alias=qwen*
```

> [!info] Alias vs. Model-ID
> - **Alias** (z. B. `phi-4-mini`) → Foundry Local wählt automatisch die beste Variante für deine HW. Auf dem Snapdragon also die **QNN-NPU-Variante**.
> - **Model-ID** (z. B. `phi-3.5-mini-instruct-qnn-npu:1`) → erzwingt eine konkrete Variante.
>
> Typische QNN-NPU-IDs (Format kann sich im Preview ändern – immer mit `model list` gegenprüfen):
> `phi-3.5-mini-instruct-qnn-npu`, `phi-3-mini-4k-instruct-qnn-npu`, `qwen2.5-7b-instruct-qnn-npu`.

Gute Einstiegs-Aliase: `qwen2.5-0.5b` (kleinstes, schneller Smoke-Test), `phi-3.5-mini`, `phi-4-mini`.

---

## 6. Modell interaktiv ausführen

```powershell
# Alias → beste HW-Variante (auf Snapdragon: NPU)
foundry model run phi-3.5-mini

# Smoke-Test, sehr klein
foundry model run qwen2.5-0.5b
```

Foundry Local lädt das Modell beim ersten Lauf herunter, lädt es in den Speicher und öffnet einen Chat-Prompt. Beenden mit:

```
/exit
```

Nur vorab cachen (ohne Start):

```powershell
foundry model download phi-3.5-mini
foundry model info phi-3.5-mini
```

> [!example] CPU bewusst erzwingen
> Zum Vergleich NPU vs. CPU einfach die generische CPU-Variante starten:
> ```powershell
> foundry model run qwen2.5-0.5b-instruct-generic-cpu
> ```

---

## 7. NPU-Nutzung verifizieren

So bestätigst du, dass wirklich die NPU läuft und nicht der CPU-Fallback:

1. **Beim Modellstart** erscheint eine Zeile à la:
   `Successfully downloaded and registered the following EPs: QNNExecutionProvider`
   und `Valid EPs: CPUExecutionProvider, QNNExecutionProvider`.
2. **Task-Manager** → Reiter *Leistung* → **NPU**-Auslastung während einer Anfrage beobachten.
3. **Logs** zur Kontrolle:
   ```powershell
   foundry service logs
   ```

> [!warning] Qualcomm-Eigenheit: kein Warmup
> Aus Preview-Erfahrungen: Bei Qualcomm/QNN kann ein **Warmup-Ping den QNN-Runtime destabilisieren** (anders als bei Intel-NPUs, die von Keepalive profitieren). Lass das Modell durch die **erste echte Anfrage** laden, nicht durch künstliche Warmup-Calls. Das ist eine Preview-Beobachtung und kann sich ändern.

---

## 8. Cache verwalten

```powershell
foundry cache location      # Cache-Verzeichnis anzeigen
foundry cache list          # gespeicherte Modelle
foundry cache remove <id>   # Modell aus dem Cache löschen
foundry cache cd <pfad>     # Cache-Verzeichnis verschieben
```

> [!tip] Platz sparen
> NPU-Varianten sind oft 2–3 GB (Phi-Mini) bis mehrere GB (7B). Nicht genutzte Varianten regelmäßig per `cache remove` entfernen.

---

## 9. OpenAI-kompatibler Endpoint (für Aider & Co.)

Der Dienst stellt einen OpenAI-kompatiblen Server bereit. **Port ist dynamisch** – immer per `foundry service status` ermitteln, nicht hartkodieren.

```powershell
foundry service status
# -> z. B. http://127.0.0.1:5272/  (Port variiert!)
```

Minimaler Python-Test gegen den Endpoint:

```python
from openai import OpenAI

# base_url aus `foundry service status` einsetzen, Pfad /v1 anhängen
client = OpenAI(base_url="http://127.0.0.1:5272/v1", api_key="not-needed")

resp = client.chat.completions.create(
    model="phi-3.5-mini",
    messages=[{"role": "user", "content": "Erklär mir den goldenen Schnitt in 2 Sätzen."}],
)
print(resp.choices[0].message.content)
```

> [!note] Sauberer Weg für Apps: das SDK
> Für eingebettete Apps ist das **SDK** robuster als der feste Port (es übernimmt Endpoint-Discovery). Auf Windows mit HW-Beschleunigung:
> ```powershell
> pip install foundry-local-sdk-winml
> ```
> ⚠️ **Nicht** gleichzeitig `foundry-local-sdk` und `foundry-local-sdk-winml` installieren (konkurrierende `onnxruntime-core`-Abhängigkeiten). Und nicht mit dem inoffiziellen PyPI-Paket `foundry-local` (v0.0.1) verwechseln.

---

## 10. Eigene Modelle: Olive (optional)

Foundry Local lädt standardmäßig aus dem Azure-AI-Foundry-Katalog. Eigene/HF-Modelle gehen über **ONNX + Olive** (Konvertierung, Quantisierung, Optimierung):

```bash
pip install olive-ai onnxruntime huggingface_hub[cli]
huggingface-cli login

olive auto-opt \
  --model_name_or_path Qwen/Qwen2.5-0.5B-Instruct \
  --trust_remote_code \
  --output_path models/qwen \
  --device npu \
  --provider QNNExecutionProvider \
  --use_ort_genai \
  --precision int4
```

> [!tip] Anknüpfung an deine Nexa-Erfahrung
> Konzeptionell wie bei Nexa: ein int4-quantisiertes Modell für den QNN-Provider bauen und lokal laden. Der Unterschied ist primär das Toolchain-Ökosystem (Olive/ONNX statt Nexa SDK).

---

## 11. Troubleshooting

| Symptom | Ursache / Fix |
|---|---|
| `Request to local service failed` | `foundry service restart` |
| `foundry` nicht gefunden | Terminal nach Installation neu öffnen (PATH) |
| `Failed to process model #0 on page 1` (Preview-Bug) | bekannte Katalog-/Seitenfehler im Preview; trotzdem läuft das Modell oft – mit `foundry model list` die exakte ID gegenprüfen |
| Modell „not found in catalog" trotz korrektem Namen | Variante/Version stimmt nicht – `model list` zeigt die gültige ID inkl. `:version` |
| Läuft auf CPU statt NPU | Windows < 24H2? EPs nicht geladen? Beim Start auf `QNNExecutionProvider` in der EP-Zeile achten |
| Port im Code bricht nach Neustart | Port ist dynamisch → `foundry service status` bzw. SDK-Discovery nutzen |

---

## 12. Quick Reference

```text
# Setup
winget install -e --id Microsoft.FoundryLocal
foundry --version
foundry service status

# Modelle
foundry model list --filter device=NPU
foundry model run phi-3.5-mini      # NPU-Variante
/exit                                # Chat verlassen
foundry model download <alias>
foundry model info <alias>

# Service
foundry service restart | start | stop | ps | logs

# Cache
foundry cache list | location
foundry cache remove <id>
```

---

## Verwandte Notizen

- [[Nexa SDK – NPU-Inferenz auf dem XPS]]
- [[Lokale LLM-Tooling – Übersicht]]
- [[XPS 13 9345 – Mobiler Python-Dev-Workstation Setup]]
- [[Aider – lokale Modelle anbinden]]

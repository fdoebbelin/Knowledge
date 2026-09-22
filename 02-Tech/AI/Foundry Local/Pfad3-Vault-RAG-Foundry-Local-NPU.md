---
title: Vault-RAG lokal & NPU-beschleunigt – Foundry Local (Demo: jetzt vs. Nexa SDK)
tags:
  - rag
  - foundry-local
  - npu
  - snapdragon
  - obsidian
  - nexa-sdk
  - qualcomm
  - demo
created: 2026-06-22
status: active
type: runbook
hardware: Dell XPS 13 9345 · Snapdragon X Elite · 32 GB
script: "[[vault_rag.py]]"
---

# Vault-RAG lokal & NPU-beschleunigt (Pfad 3)

> [!abstract] Demo-Ziel
> Live zeigen, dass ein **kompletter RAG-Stack über den eigenen Obsidian-Vault** heute schon **on-device auf der Snapdragon-NPU** läuft – ohne Cloud, ohne API-Keys, im Flugmodus. Und sauber einordnen, **was als Nächstes kommt**, sobald die Nexa-SDK-Integration unter dem Qualcomm AI Hub voll nutzbar ist.

---

## 0. Die Demo-Erzählung in einem Satz

> **Heute** demonstrieren wir on-device RAG mit dem, was **stabil verfügbar** ist (Microsoft Foundry Local, ONNX/QNN auf der Hexagon-NPU). **Demnächst** läuft derselbe Use Case mit **aktuelleren, größeren und multimodalen Modellen**, sobald der Qualcomm-/Nexa-Stack vollständig ausgerollt ist – gleiche NPU, breiterer Modellzugang.

Das ist didaktisch stark, weil es den Azubis den **Mechanismus** (RAG-Pipeline) zeigt und ihn von der **Modell-Verfügbarkeit** trennt – zwei Dinge, die Einsteiger gern verwechseln.

---

## 1. Architektur – die drei RAG-Schichten

```
        Obsidian-Vault (*.md)
                │
   ┌────────────▼─────────────┐   1) INGESTION
   │ Parsen · Frontmatter ab  │      reine Python-Logik
   │ Wikilinks/MD bereinigen  │
   │ in Chunks zerlegen       │
   └────────────┬─────────────┘
                │  Text-Chunks
   ┌────────────▼─────────────┐   2) EMBEDDING  ← Foundry Local
   │ Embedding-Modell         │      (NPU/CPU, ONNX Runtime)
   └────────────┬─────────────┘
                │  Vektoren
   ┌────────────▼─────────────┐   3) VEKTORSTORE
   │ ChromaDB (lokal, on-disk)│
   └────────────┬─────────────┘
                │  Top-k Treffer
   ┌────────────▼─────────────┐   4) GENERATION ← Foundry Local
   │ Chat-Modell + Kontext    │      (Hexagon-NPU, QNN)
   │ → Antwort mit Quellen    │
   └──────────────────────────┘
```

> [!info] Welche Schicht nutzt die NPU?
> Die **NPU** beschleunigt die Modell-Inferenz (Embedding + Chat) über die ONNX Runtime mit QNN-Provider. **Parsing und Vektorsuche** sind normale CPU-Logik – Chroma rechnet Ähnlichkeiten auf der CPU, das ist bei einem persönlichen Vault aber vernachlässigbar.

---

## 2. Setup

### 2.1 Foundry Local v1.1+ (Embeddings nötig!)

Embeddings kamen erst mit **v1.1** dazu. Version prüfen / aktualisieren:

```powershell
foundry --version
winget upgrade --id Microsoft.FoundryLocal
```

Hardware-Beschleuniger (Execution Providers inkl. QNN-NPU) sicherstellen – beim ersten `model list` lädt Foundry sie automatisch:

```powershell
foundry service status
foundry model list --filter device=NPU
```

### 2.2 Modelle laden

```powershell
# Chat (auf Snapdragon automatisch die QNN-NPU-Variante; gut in Deutsch)
foundry model run qwen2.5-7b-instruct
# kurz testen, dann /exit  → bleibt gecached

# Embedding-Modell – exakten Alias aus der Liste nehmen:
foundry model list --filter task=embedding
foundry model load qwen3-embedding-0.6b
```

> [!warning] Embedding evtl. auf CPU
> Ein **QNN-NPU-Embedding** ist im Katalog nicht garantiert. Läuft das Embedding-Modell als CPU-Variante, ist das für einen persönlichen Vault unkritisch (Indexieren ist einmalig). Für die Demo ehrlich benennen: „Chat auf NPU, Embedding ggf. CPU".

> [!tip] Multilingual für deutschen Vault
> `qwen3-embedding` ist mehrsprachig (100+ Sprachen, inkl. Code) – passt zu deinen deutschen Lehrmaterialien besser als rein englische Embeddings.

### 2.3 Python-Umgebung

```powershell
uv venv && .\.venv\Scripts\activate     # oder python -m venv
uv pip install openai chromadb pyyaml
```

---

## 3. Das RAG-Skript

Die vollständige, kommentierte Fassung liegt als [[vault_rag.py]] bei. Kernidee: Es spricht Foundry Local über den **OpenAI-kompatiblen Endpoint** an (versionsrobust, unabhängig von SDK-internen Methodennamen) und liest den **dynamischen Port** selbst aus `foundry service status`.

Die vier Schritte im Code:

1. `get_endpoint()` – Port aus `foundry service status` parsen, `/v1` anhängen.
2. `build_index()` – Notizen lesen, Frontmatter trennen, Markdown/Wikilinks bereinigen, chunken, batchweise embedden, in ChromaDB ablegen (mit Pfad + Titel als Metadaten, Dedup über Chunk-Hash).
3. `ask()` – Frage embedden, Top-k aus Chroma holen, als Kontext ins Chat-Modell, Antwort streamen.
4. Quellen-Notizen am Ende ausgeben → nachvollziehbar, welche Notiz die Antwort stützt.

> [!note] Bewusst schlank gehalten
> In-Memory-Dedup, Sliding-Window-Chunking, kein Reranking. Genau richtig zum **Erklären**. Erweiterungsideen siehe Abschnitt 7 – ideal als Übungsaufgaben.

---

## 4. Demo-Runbook (live vorführen)

**Schritt 1 — Index bauen** (einmalig, zeigt die Ingestion):

```powershell
python vault_rag.py --vault "C:\Users\<du>\Obsidian\MeinVault" --index
```

**Schritt 2 — Eine Frage, die mehrere Notizen verknüpft** (zeigt die Stärke von RAG):

```powershell
python vault_rag.py --vault "C:\Users\<du>\Obsidian\MeinVault" `
  "Fasse zusammen, was ich zu RCD-Verdrahtung und Wallbox-Installation notiert habe"
```

**Schritt 3 — die „Wow"-Momente für das Publikum:**

- 🧠 **Task-Manager → Leistung → NPU**: Auslastung steigt während der Antwort. Beweist: läuft auf der Hexagon-NPU, nicht nur CPU.
- ✈️ **Flugmodus an** und Frage wiederholen: läuft weiter. Beweist: 100 % on-device, kein Cloud-Call.
- 📄 **Quellenangabe**: Die genannten Notiz-Pfade in Obsidian öffnen – die Antwort ist nachvollziehbar, keine Halluzination aus dem Nichts.
- ⏱️ Optional **tok/s** und Erstlatenz erwähnen (erste Antwort lädt das Modell; QNN ohne Warmup, siehe Foundry-Local-Notiz).

> [!tip] Sauberer Auftritt
> Vorher `--index` einmal laufen lassen, damit live nur noch die Frage kommt. Eine bewusst „vernetzte" Frage stellen, deren Antwort in **mehreren** Notizen steckt – das verkauft RAG besser als ein Faktenabruf aus einer einzigen Datei.

---

## 5. Was heute geht (Stand der Demo)

- ✅ Vollständiges on-device RAG über den Vault, Chat-Inferenz **NPU-beschleunigt** (QNN).
- ✅ Multimodal denkbar: Foundry Local 1.1 brachte ein **Vision-Language-Modell** (Qwen3.5 VLM) in den Katalog – damit ließen sich z. B. Diagramme/Screenshots aus dem Vault auswerten.
- ⚠️ **Kuratierter Katalog**: nur getestete Modelle; neue HF-Modelle erscheinen verzögert. Kein Coder-NPU-Modell (siehe Aider-Notiz).
- ⚠️ **QNN-Operator-Abdeckung** begrenzt; eigene Olive→QNN-Konvertierungen sind fummelig.
- ⚠️ **Preview**: kein SLA, Verhalten/IDs können sich zwischen Releases ändern.

---

## 6. Was kommt: Nexa SDK unter dem Qualcomm AI Hub

> [!info] Öffentlich belegter Stand (Juni 2026)
> - Qualcomms **Übernahme von Nexa AI ist abgeschlossen** (angekündigt März 2026); Nexa ist jetzt **Teil des Qualcomm AI Hub**, Gründer als Director of Engineering bei Qualcomm.
> - Das **NexaSDK** (jetzt unter `github.com/qualcomm/nexa-sdk`) fährt **Frontier-LLMs und VLMs mit Day-0-Support über CPU/GPU/NPU** und wirbt mit „erstem Day-0-Support auf der Qualcomm **Hexagon-NPU**" – für PC, Mobile und IoT.
> - Qualcomm + Nexa + Docker haben **NexaSDK for Linux** für NPU-first-Deployment in IoT/Robotik vorgestellt (relevant für deine MetaRow-IoT-Pläne).
> - Qualcomm AI Hub kommuniziert „exciting updates coming soon"; die alte Nexa-SDK-Seite leitet bereits dorthin.

Dazu dein **direkter Draht zum Qualcomm-Support**: Laut Auskunft wird das SDK **post-acquisition** überarbeitet und in ein **neues Produkt (mit neuem Link)** integriert, Launch in wenigen Wochen.

> [!warning] Ehrlich framen
> Konkrete Fähigkeiten/Termine des neuen Produkts sind **noch nicht final** – als **angekündigte Richtung** präsentieren, nicht als Zusage. Für die Demo reicht die Aussage: *„Die NPU ist dieselbe; was sich ändert, ist der Modellzugang – von Microsofts kuratiertem ONNX-Katalog hin zu Day-0-Frontier-Modellen über den Qualcomm-/Nexa-Stack."*

### Der didaktische Kontrast in einer Tabelle

| Dimension | Heute: Foundry Local | Demnächst: Qualcomm AI Hub / Nexa |
|---|---|---|
| NPU-Zugang | ONNX Runtime + QNN-EP | NexaSDK, NPU-first |
| Modellaktualität | kuratiert, verzögert | **Day-0**-Frontier-Modelle |
| Modalitäten | Text + erstes VLM | LLM, VLM, ASR/TTS |
| Plattform | PC (Win/Mac/Linux) | PC, Mobile, Auto, IoT |
| Reife | Public Preview, stabil nutzbar | im Umbau (neuer Launch) |

---

## 7. Erweiterungen (Übungsaufgaben / Ausbaustufen)

- **Inkrementelles Update** per Datei-Mtime/Checksum statt Voll-Reindex.
- **Reranking** der Top-k (z. B. Qwen3-Reranker) für bessere Trefferqualität.
- **Heading-bewusstes Chunking** statt Sliding-Window (Markdown-Struktur nutzen).
- **Obsidian-Integration**: Skript per Hotkey/Shell-Plugin aus dem Vault heraus aufrufen.
- **Tausch-Experiment**: dasselbe Skript gegen den **RTX-4070-Ti-Super-Desktop** (CUDA) laufen lassen und Latenz/tok/s vergleichen – zeigt den Hardware-Hebel.
- **Umstieg vorbereiten**: sobald das neue Qualcomm-/Nexa-Produkt da ist, nur die Inferenz-Schicht tauschen – Ingestion + Vektorstore bleiben gleich (gutes Argument für saubere Schichtung).

---

## 8. Stolpersteine

| Symptom | Fix |
|---|---|
| `embeddings.create` schlägt fehl | Embedding-Modell nicht geladen → `foundry model load <embed>`; v1.1+ nötig |
| Connection refused | `foundry service status` → Port/Dienst; ggf. `foundry service restart` |
| Antwort „weiß ich nicht" trotz Treffern | `TOP_K`/`CHUNK_CHARS` erhöhen, Frage konkreter stellen |
| NPU bleibt im Task-Manager leer | Windows 24H2? QNN-Variante geladen? generic-cpu erwischt? |
| Deutsche Umlaute zerschossen | Dateien als UTF-8; Skript liest bereits `errors="ignore"` |
| Erste Antwort langsam | normal: Modell-Load beim ersten Request (QNN, kein Warmup) |

---

## Verwandte Notizen

- [[Foundry Local auf dem Dell XPS 13 9345 (Snapdragon X Elite)]]
- [[Aider mit lokalem LLM auf dem XPS (Snapdragon)]]
- [[Nexa SDK – NPU-Inferenz auf dem XPS]]
- [[Qualcomm AI Hub – Übernahme Nexa AI, Edge-AI-Roadmap]]
- [[vault_rag.py]]

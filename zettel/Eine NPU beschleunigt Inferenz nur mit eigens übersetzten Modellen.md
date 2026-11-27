---
id: 202611271316
title: Eine NPU beschleunigt Inferenz nur mit eigens übersetzten Modellen
type: zettel
tags:
  - ki/lokal
created: 2026-11-27
herkunft:
  - 02-Tech/AI/LLM-Basics/DirectML für NPUs Vorteile.md
  - 02-Tech/AI/Foundry Local
  - 02-Tech/AI/Nexa SDK
  - 02-Tech/AI/AnythingLLM vs Nexa SDK.md
---

Eine **NPU** (Neural Processing Unit) ist ein Rechenwerk, das auf die Operationen neuronaler Netze zugeschnitten ist, vor allem Matrixmultiplikationen in niedriger Genauigkeit. Sie steckt heute in vielen Notebook- und Smartphone-Prozessoren, etwa als Hexagon-NPU im Snapdragon X Elite. Ihr Vorteil gegenüber der Grafikkarte ist der geringe Stromverbrauch, nicht die rohe Leistung.

Anders als eine GPU führt eine NPU kein beliebiges Modell aus. Jeder Hersteller hat einen eigenen Befehlssatz und eine eigene Laufzeit – Qualcomm QNN, Intel OpenVINO, AMD Ryzen AI. Ein Modell muss dafür eigens übersetzt werden: in ein passendes Format (meist ONNX), mit fester Bitbreite und oft festen Tensorgrößen.

Daraus folgen drei praktische Grenzen:

- **Kleiner Katalog:** Nutzbar ist nur, was jemand für genau diese NPU übersetzt hat. Microsofts Foundry Local bot für die Hexagon-NPU zum Beispiel ein allgemeines Qwen2.5-7B, aber kein Coder-Modell an.
- **Kein Austausch zwischen Herstellern:** Eine Variante, die im Katalog als „NPU“ geführt wird, kann für Intel übersetzt sein und läuft auf Qualcomm nicht.
- **Verzögerung:** Neue Modelle erscheinen zuerst für GPU und CPU, für NPUs erst Wochen oder Monate später.

Gängige Werkzeuge wie Ollama oder LM Studio nutzen die NPU deshalb meist gar nicht, sondern rechnen auf CPU oder GPU.

## Verbindungen

- [[Quantisierung tauscht Genauigkeit gegen Speicher und Tempo]] – NPUs setzen eine niedrige, feste Bitbreite voraus
- [[Lokale Modellserver sprechen die OpenAI-API]] – auch NPU-Laufzeiten wie Foundry Local bieten diese Schnittstelle
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

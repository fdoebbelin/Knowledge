---
title: Freie LLMs für Python-Refactoring mit aider (RTX 4070 Ti Super)
tags:
  - ki
  - aider
  - llm
  - refactoring
created: 2025-09-18
updated: 2026-09-15
source: Perplexity (zwei Anfragen vom 2025-09-18, zusammengeführt)
---

# Freie LLMs für Python-Refactoring mit aider auf einer RTX 4070 Ti Super (16 GB)

> [!abstract] Zusammengeführt
> Vereint zwei Perplexity-Antworten vom 2025-09-18 (allgemeines Refactoring und speziell das Aufteilen zu komplexer Funktionen/Methoden). Stand: September 2025.

## Empfehlung auf einen Blick

| Modell | Größen | Stärke | Auf 16 GB |
|---|---|---|---|
| **Qwen 2.5 Coder** | 7B / 14B / 32B | Top bei Python-Umstrukturierung, Fill-in-the-middle, Apache 2.0 | 7B/14B nativ, 32B quantisiert (Q4) |
| **DeepSeek Coder V2** | 6.7B / 33B | Refactoring, Variable Extraction, Clean-Code-Prinzipien | 6.7B flüssig, 33B als 4-bit |
| **Code Llama** | 7B / 13B / 34B / 70B | große Kontextfenster, FIM, Instruction-Varianten; saubere Methodensignaturen beim Aufteilen langer Funktionen | 7B/13B flüssig, 34B quantisiert, 70B nur mit Offloading |
| **Codestral 25.01 / 22B** (Mistral) | 22B | schneller, robuster Editor für Routine-Umstrukturierungen, FIM | quantisiert |
| **Gemma 2** (Google) | 9B / 27B | schnell, speichereffizient, Apache 2.0 | 9B nativ |
| Phi-3, StarCoder2 15B | klein bis 15B | leicht, methodisches Refactoring | nativ |
| Mixtral 8x7B, OpenHermes Mistral 7B | 7B / 8x7B | solide Generierung, gute Integration in LM Studio/Ollama | 7B nativ, 8x7B quantisiert |
| SauerkrautLM-UNA-SOLAR-Instruct | 10.7B | experimentell, gute Ergebnisse bei Strukturänderungen | nativ |

**Fazit:** Qwen 2.5 Coder (32B oder 14B), Code Llama 34B/13B, DeepSeek Coder V2 und Codestral sind die besten freien Modelle für lokales Python-Refactoring. Für das Aufteilen und Vereinfachen komplexer Funktionen sind Qwen 2.5 Coder 32B und Code Llama 34B die soliden Allrounder, Codestral der schnelle Editor.

## Praktische Nutzung mit aider

- **Anbindung:** aider spricht lokale Modelle über **Ollama**, **LM Studio**, OpenAI-kompatible APIs oder eigene vLLM-Server an. Siehe [[Ollama + Aider + Hugging Face Setup]].
- **Quantisierung:** Für 16 GB VRAM quantisierte Varianten (Q4 bis Q8, GGUF oder GPTQ) wählen; damit laufen auch 13B/33B-Modelle mit akzeptabler Geschwindigkeit und Kontextgröße.
- **Architect/Editor-Modus:** Die besten Ergebnisse liefert die Kombination aus einem „architect“-Modell für Analyse und Planung und einem „editor“-Modell für die Code-Überarbeitung, z. B. Qwen 2.5 Coder oder Codestral als Architect und Code Llama als Editor. Auswahl in aider mit `--model` und `--editor-model`.
- Feintuning, Settings und Prompt-Optimierung verbessern die Praxistauglichkeit für spezifische Refactoring-Szenarien.

## Benchmarks zur Modellauswahl

- Refactoring Leaderboard: https://aider.chat/docs/leaderboards/refactor.html
- Code Editing Leaderboard: https://aider.chat/docs/leaderboards/edit.html
- Refactor-Benchmark-Repo: https://github.com/Aider-AI/refactor-benchmark

## Quellen

- https://aider.chat/docs/llms.html
- https://www.blopig.com/blog/2024/10/aider-and-cheap-free-and-local-llms/
- https://codenotary.com/blog/step-by-step-guide-refactoring-a-large-rust-codebase-with-aiderdev-and-custom-llms
- https://apxml.com/posts/best-local-llm-rtx-40-gpu
- https://www.hardware-corner.net/rtx-4070-for-llm/
- https://www.cognativ.com/blogs/post/local-llm-for-python-coding-top-picks-and-insights/261
- https://www.openxcell.com/blog/best-llm-for-coding/
- https://www.leanware.co/insights/best-llms-for-coding
- https://klu.ai/blog/open-source-llm-models
- https://www.reddit.com/r/LocalLLaMA/comments/1jbi8xm/whats_the_best_local_llm_for_code_in_python/
- https://www.reddit.com/r/LocalLLaMA/comments/1jhjbgj/best_llm_for_code_through_api_with_aider/
- https://padron.sh/blog/local-vs-cloud-ai-coding-assistants-2025/

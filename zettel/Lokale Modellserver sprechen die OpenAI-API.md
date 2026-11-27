---
id: 202611271315
title: Lokale Modellserver sprechen die OpenAI-API
type: zettel
tags:
  - ki/lokal
created: 2026-11-27
herkunft:
  - 02-Tech/AI/LM-Studio
  - 02-Tech/AI/Ollama
  - 02-Tech/AI/Foundry Local
  - 02-Tech/AI/Aider
---

Die Schnittstelle von OpenAI – vor allem `POST /v1/chat/completions` – ist zum Quasi-Standard geworden. Lokale Modellserver bieten sie deshalb nach, jeder auf seinem eigenen Port:

| Server | Adresse |
|---|---|
| Ollama | `http://localhost:11434/v1` |
| LM Studio | `http://localhost:1234/v1` |
| Foundry Local | dynamischer Port, abzulesen mit `foundry service status` |

Für ein Programm ist der Wechsel vom Cloud-Dienst zum eigenen Rechner damit nur eine andere Basis-URL. Der API-Schlüssel wird lokal nicht geprüft, muss aber oft gesetzt sein:

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:11434/v1", api_key="lokal")
antwort = client.chat.completions.create(
    model="qwen2.5-coder:14b",
    messages=[{"role": "user", "content": "Was macht ss -tlnp?"}],
)
print(antwort.choices[0].message.content)
```

Werkzeuge, die die OpenAI-API sprechen, lassen sich genauso umstecken – Aider etwa mit `--openai-api-base`. Wer gegen diese Schnittstelle programmiert statt gegen das SDK eines einzelnen Servers, kann das Modell und den Server später tauschen, ohne den Code anzufassen.

Die Kompatibilität ist allerdings nicht vollständig: Neuere Funktionen wie Werkzeugaufrufe oder strukturierte Ausgaben unterstützen nicht alle Server und nicht alle Modelle gleich gut.

## Verbindungen

- [[Der Speicherbedarf eines Sprachmodells folgt aus Parameterzahl und Bitbreite]] – welches Modell der lokale Server überhaupt laden kann
- [[RAG gibt dem Modell passende Textstellen aus den eigenen Dokumenten mit]] – ein Anwendungsfall, der über diese Schnittstelle lokal läuft
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

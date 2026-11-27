---
id: 202611271313
title: Der Speicherbedarf eines Sprachmodells folgt aus Parameterzahl und Bitbreite
type: zettel
tags:
  - ki/lokal
created: 2026-11-27
herkunft:
  - 02-Tech/AI/LLM-Basics/Quantisierungs-Optionen für RTX 4070 Ti Super.md
  - 02-Tech/AI/LM-Studio
---

Ob ein Modell auf eine Grafikkarte passt, lässt sich vor dem Download überschlagen. Ein Sprachmodell besteht im Wesentlichen aus seinen Gewichten, und jedes Gewicht belegt so viele Bits, wie das Zahlenformat vorgibt:

```text
Speicher für die Gewichte ≈ Parameterzahl × Bit je Gewicht ÷ 8
```

Für ein Modell mit 7 Milliarden Parametern (7B):

| Format | Bit je Gewicht | Gewichte |
|---|---|---|
| FP16 | 16 | ≈ 14 GB |
| 8 Bit (Q8_0) | ≈ 8,5 | ≈ 7,5 GB |
| 4 Bit (Q4_K_M) | ≈ 4,5–5 | ≈ 4–4,5 GB |

Dazu kommt der Speicher für den Kontext (KV-Cache), der mit der Länge des Gesprächs wächst, und etwas für die Laufzeitumgebung. Als Faustregel plant man 1–2 GB Reserve ein.

Damit wird klar, warum eine Karte mit 16 GB ein 7B-Modell in FP16 gerade noch fasst, ein 14B-Modell aber nur quantisiert und ein 70B-Modell gar nicht. Passt das Modell nicht ganz in den Grafikspeicher, lagern Werkzeuge wie llama.cpp Schichten in den Hauptspeicher aus – es läuft dann, aber um ein Vielfaches langsamer.

Die Rechnung schützt auch vor falschen Tabellen: Eine Angabe wie „7B in FP16 braucht 5–6 GB“ kann nicht stimmen.

## Verbindungen

- [[Quantisierung tauscht Genauigkeit gegen Speicher und Tempo]] – wie man die Bitbreite verkleinert und was es kostet
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

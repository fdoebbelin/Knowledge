---
id: 202611271314
title: Quantisierung tauscht Genauigkeit gegen Speicher und Tempo
type: zettel
tags:
  - ki/lokal
created: 2026-11-27
herkunft: 02-Tech/AI/LLM-Basics/Quantisierungs-Optionen für RTX 4070 Ti Super.md
---

Trainiert werden Sprachmodelle mit Gleitkommazahlen von 16 oder 32 Bit. Für die Nutzung braucht es diese Genauigkeit meist nicht. **Quantisierung** speichert die Gewichte mit weniger Bits – etwa 8, 6, 5 oder 4 – und rechnet sie beim Ausführen zurück.

Das bringt zweierlei: Das Modell braucht weniger Speicher, und es wird schneller, weil beim Erzeugen jedes Tokens weniger Daten aus dem Speicher gelesen werden müssen. Der Preis ist ein Verlust an Genauigkeit, der bei 8 Bit kaum messbar ist und unter 4 Bit deutlich wird.

Im verbreiteten GGUF-Format von llama.cpp tragen die Stufen Namen wie diese:

| Stufe | Einordnung |
|---|---|
| F16 | unquantisiert, Referenz |
| Q8_0 | praktisch verlustfrei |
| Q6_K, Q5_K_M | guter Kompromiss |
| Q4_K_M | üblicher Standard für knappen Speicher |
| Q3, Q2 | nur, wenn sonst nichts passt |

Die K-Varianten quantisieren in Blöcken mit eigenem Skalierungsfaktor und halten so mehr Genauigkeit bei gleicher Größe.

Die Wahl folgt dem Speicher: Man nimmt die höchste Stufe, die mit Reserve für den Kontext in den Grafikspeicher passt. Ein größeres Modell in Q4 ist dabei oft besser als ein kleineres in Q8.

## Verbindungen

- [[Der Speicherbedarf eines Sprachmodells folgt aus Parameterzahl und Bitbreite]] – die Rechnung, mit der man die passende Stufe findet
- [[Eine NPU beschleunigt Inferenz nur mit eigens übersetzten Modellen]] – NPUs verlangen meist eine feste, niedrige Bitbreite
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

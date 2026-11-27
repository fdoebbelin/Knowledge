---
id: 202611271308
title: Künstliche Intelligenz
type: struktur
tags:
  - ki
created: 2026-11-27
---

Wie KI-Systeme arbeiten und wie man sie sicher einsetzt. Der Lesepfad beginnt bei Sprachmodellen auf dem eigenen Rechner – was sie an Hardware brauchen und wie man sie anspricht – und geht dann zu den Agenten: was sie von einem Chatbot unterscheidet, wie sie vorgehen und welche Grenzen sie brauchen, bevor sie auf echten Systemen arbeiten.

## Lokale Modelle

- [[Der Speicherbedarf eines Sprachmodells folgt aus Parameterzahl und Bitbreite]] – vor dem Download ausrechnen, ob ein Modell passt
- [[Quantisierung tauscht Genauigkeit gegen Speicher und Tempo]] – die Stufen von F16 bis Q4 und wie man wählt
- [[Eine NPU beschleunigt Inferenz nur mit eigens übersetzten Modellen]] – warum der KI-Chip im Notebook so wenig Modelle ausführt
- [[Lokale Modellserver sprechen die OpenAI-API]] – Ollama, LM Studio und Co. mit derselben Schnittstelle ansprechen
- [[RAG gibt dem Modell passende Textstellen aus den eigenen Dokumenten mit]] – Fragen an die eigenen Notizen

## Agenten

- [[Ein KI-Agent handelt, ein Chatbot antwortet]] – der Grundunterschied: Werkzeuge, eigene Schrittfolge, Ergebnisprüfung
- [[Der ReAct-Zyklus wechselt zwischen Denken, Handeln und Beobachten]] – wie ein Agent Schritt für Schritt vorgeht
- [[Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung]] – wie man einen Agenten beauftragt

## Agenten absichern

- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – wo der Mensch entscheidet
- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – die technische Grenze, die immer hält
- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – der Angriff über die Daten, die der Agent verarbeitet
- [[Ein Agent meldet Erfolg erst nach geprüftem Ergebnis]] – Halluzinationen abfangen, bevor sie Folgen haben

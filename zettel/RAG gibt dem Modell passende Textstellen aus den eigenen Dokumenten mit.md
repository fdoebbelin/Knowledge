---
id: 202611271317
title: RAG gibt dem Modell passende Textstellen aus den eigenen Dokumenten mit
type: zettel
tags:
  - ki/rag
created: 2026-11-27
herkunft: 02-Tech/AI/Foundry Local
---

Ein Sprachmodell kennt nur, was in seinen Trainingsdaten stand. Fragen zu den eigenen Notizen kann es nicht beantworten – es sei denn, man gibt ihm die passenden Stellen mit. Das ist **Retrieval-Augmented Generation (RAG)**: erst suchen, dann mit dem Gefundenen antworten.

Ein RAG-System hat zwei Phasen:

1. **Indexieren (einmalig):** Die Dokumente werden in Abschnitte (*Chunks*) zerlegt. Ein **Embedding-Modell** macht aus jedem Abschnitt einen Vektor, der seine Bedeutung abbildet. Die Vektoren landen in einer Vektordatenbank, etwa ChromaDB.
2. **Fragen (jedes Mal):** Die Frage wird ebenso in einen Vektor verwandelt. Die Datenbank liefert die Abschnitte mit den ähnlichsten Vektoren. Diese stehen zusammen mit der Frage im Prompt an das Chat-Modell, das daraus antwortet und die Fundstellen nennen kann.

Dabei kommen zwei verschiedene Modelle zum Einsatz: ein kleines Embedding-Modell für die Suche und ein Chat-Modell für die Antwort. Für deutsche Texte muss das Embedding-Modell mehrsprachig sein.

Die Qualität hängt mehr an der Suche als am Chat-Modell: Findet sie die richtige Stelle nicht, hilft das beste Modell nichts. Stellschrauben sind die Chunk-Größe, die Zahl der Treffer und ein Zerlegen entlang der Überschriften statt nach fester Länge.

Weil nur die Inferenz an einem Modell hängt, lässt sich das Modell tauschen, ohne Index und Suche neu zu bauen.

## Verbindungen

- [[Lokale Modellserver sprechen die OpenAI-API]] – über diese Schnittstelle laufen Embedding und Antwort auch ganz ohne Cloud
- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – was im Index steht, landet ungeprüft im Prompt
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

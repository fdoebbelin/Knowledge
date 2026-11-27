---
id: 202611271302
title: Der ReAct-Zyklus wechselt zwischen Denken, Handeln und Beobachten
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 01-Courses/AI
---

**ReAct** steht für *Reasoning + Acting*. Das Muster beschreibt, wie ein Sprachmodell als Agent arbeitet: Es schreibt nicht gleich eine Antwort, sondern durchläuft eine Schleife.

1. **Thought** – Was ist das Ziel, was weiß ich schon, welcher Schritt hilft jetzt?
2. **Action** – ein Werkzeug aufrufen, etwa einen Shell-Befehl.
3. **Observation** – die Ausgabe lesen und bewerten.

Danach beginnt die Schleife von vorn, bis das Ziel erreicht ist oder der Agent nicht weiterweiß und nachfragt. Ein verkürzter Ablauf:

```text
Thought: Prüfen, ob nginx läuft.
Action: systemctl status nginx
Observation: failed – bind() to 0.0.0.0:80 failed (Address already in use)
Thought: Wer belegt Port 80?
Action: ss -tlnp 'sport = :80'
Observation: apache2, PID 3421
Answer: apache2 blockiert Port 80. Soll ich apache2 stoppen und nginx starten?
```

Der Wert liegt darin, dass jede Beobachtung den nächsten Gedanken bestimmt: Der Agent rät die Ursache nicht auf einmal, sondern grenzt sie ein – wie ein Admin bei der Fehlersuche. Und weil die Gedanken mitgeschrieben werden, lässt sich nachvollziehen, *warum* er etwas getan hat.

## Verbindungen

- [[Ein KI-Agent handelt, ein Chatbot antwortet]] – ReAct ist der Mechanismus hinter der eigenen Schrittfolge
- [[Ein Agent meldet Erfolg erst nach geprüftem Ergebnis]] – die Observation ist der Ort, an dem geprüft wird
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

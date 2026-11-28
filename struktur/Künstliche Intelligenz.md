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
- [[Ein Agentengedächtnis aus Markdown-Dateien wird durch einen Suchindex nutzbar]] – wie ein Agent über Sitzungen hinweg etwas behält

## Coding-Agenten

- [[AGENTS.md ist das Projektgedächtnis eines Coding-Agenten]] – was ein Agent bei jedem Start über das Projekt erfährt
- [[Ein Skill ist ein Ordner mit einer SKILL.md, die der Agent erst bei Bedarf lädt]] – Verfahren mitgeben, ohne den Kontext zu füllen
- [[Einen Skill mit Nebenwirkungen startet nur der Mensch]] – das Laden bei Bedarf gezielt abschalten
- [[additionalDirectories gibt Claude Code nur Dateizugriff]] – Nachbarordner freigeben, ohne deren Konfiguration zu laden
- [[Das Kontextfenster begrenzt ein Gespräch, das Nutzungslimit die Zeit]] – die beiden Grenzen, an die man stößt
- [[Aider macht jede Änderung zu einem Git-Commit]] – Git als Sicherheitsnetz für Agentenarbeit

## Programmieren mit KI

- [[Vibe Coding übernimmt KI-Code, ohne ihn zu prüfen]] – der Begriff und die Grenze zur verantworteten Entwicklung
- [[Mit Coding-Agenten verschiebt sich Entwicklerarbeit vom Schreiben zum Vorgeben und Prüfen]] – was dabei vom Menschen verlangt ist
- [[Gefühlte Beschleunigung durch KI ist kein Messergebnis]] – warum man den Nutzen messen sollte

Wie man dabei programmieren lernt, steht unter [[Programmieren lernen]].

## Agenten absichern

- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – wo der Mensch entscheidet
- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – die technische Grenze, die immer hält
- [[Indirekte Prompt Injection versteckt Anweisungen in Daten, die der Agent liest]] – der Angriff über die Daten, die der Agent verarbeitet
- [[Ein dauerhaftes Gedächtnis macht aus einer Prompt Injection ein bleibendes Problem]] – was sich ändert, wenn der Agent sich erinnert
- [[Ein per Messenger erreichbarer Agent braucht eine Liste erlaubter Absender]] – wer dem Agenten Aufträge geben darf
- [[Ein offenes Kontrollpanel eines Agenten gibt seine Zugangsdaten preis]] – die Verwaltungsoberfläche schützen
- [[Ein fremder Skill ist ungeprüfter Code mit den Rechten des Agenten]] – Vorsicht bei Erweiterungen aus fremder Hand
- [[Ein dauerhaft laufender Agent braucht eine Kostengrenze]] – die Grenze für das, was unbemerkt Geld kostet
- [[Ein Agent meldet Erfolg erst nach geprüftem Ergebnis]] – Halluzinationen abfangen, bevor sie Folgen haben
- [[Ein Geheimnis-Check sucht nach echten Werten statt nach Wörtern]] – eine Prüfregel, die nicht ständig falsch anschlägt
- [[Ein gepushtes Geheimnis muss man austauschen]] – was zu tun ist, wenn doch eines durchgerutscht ist

## Weitere Quellen

Entwürfe, aus denen noch keine Zettel entstanden sind:

- [[Anthropic – Open-sourcing circuit-tracing tools]] – Werkzeuge, um interne Schritte eines Sprachmodells zu untersuchen
- [[Tian'anmen-Frage an DeepSeek und an Perplexity mit DeepSeek R1]] – ein einzelner Vergleich zweier Antworten auf eine politisch heikle Frage

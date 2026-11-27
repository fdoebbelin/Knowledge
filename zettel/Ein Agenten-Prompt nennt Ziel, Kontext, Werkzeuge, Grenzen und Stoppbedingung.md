---
id: 202611271307
title: Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung
type: zettel
tags:
  - ki/agenten
created: 2026-11-27
herkunft: 01-Courses/AI
---

Ob ein Modell erklärt oder arbeitet, entscheidet sich schon im Prompt. „Was sind häufige Ursachen für hohe CPU-Last?“ liefert eine Erklärung. Ein Auftrag dagegen liefert eine Untersuchung – wenn er dem Agenten sagt, was er wissen muss:

- **Ziel:** Was soll am Ende vorliegen? („Ursache finden und drei Maßnahmen vorschlagen“)
- **Kontext:** Umgebung und Ausgangslage („CPU seit zwei Stunden über 95 %, server-prod-01“)
- **Werkzeuge:** Was darf er benutzen? („SSH, top, ps, journalctl“)
- **Grenzen:** Was darf er nicht tun oder entscheiden?
- **Stoppbedingung:** Wann hält er an und fragt? („vor jeder Änderung, die sich nicht zurücknehmen lässt“)
- **Ausgabeformat:** Wie soll das Ergebnis aussehen? (Bericht in Markdown, je Schritt Befehl und Befund)

```text
Die CPU-Last auf server-prod-01 liegt seit zwei Stunden über 95 %.
Finde die Ursache. Du darfst per SSH top, ps und journalctl nutzen.
Ändere nichts, sondern frage vorher. Liefere am Ende die Ursache
und drei Maßnahmen, nach Dringlichkeit geordnet.
```

Für einen selbst bleibt eine siebte Frage: Wie prüfe ich das Ergebnis, bevor ich danach handle?

## Verbindungen

- [[Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe]] – woraus sich die Stoppbedingung ableitet
- [[Ein Agent meldet Erfolg erst nach geprüftem Ergebnis]] – die siebte Frage, aus Sicht des Agenten
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

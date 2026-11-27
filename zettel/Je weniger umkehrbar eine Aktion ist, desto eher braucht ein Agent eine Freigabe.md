---
id: 202611271303
title: Je weniger umkehrbar eine Aktion ist, desto eher braucht ein Agent eine Freigabe
type: zettel
tags:
  - ki/agenten
  - ki/sicherheit
created: 2026-11-27
herkunft: 01-Courses/AI
---

*Human-in-the-Loop* heißt: An bestimmten Stellen hält der Agent an, und ein Mensch entscheidet. Wo diese Stellen liegen, richtet sich nicht danach, wie schwierig eine Aufgabe ist, sondern danach, ob sich ihre Folgen zurücknehmen lassen.

| Stufe | Beispiele | Freigabe |
|---|---|---|
| Analysieren, berichten | Logs auswerten, Metriken sammeln | keine |
| Empfehlen | Fix vorschlagen, Ticket entwerfen | keine |
| Umkehrbar handeln | Dienst in der Testumgebung neu starten | protokollieren, ggf. Freigabe |
| Unumkehrbar handeln | Daten löschen, Produktionsdatenbank ändern, E-Mails an Kunden senden | immer |

Daraus folgt eine einfache Arbeitsteilung: Für Diagnose und Empfehlung darf ein Agent so selbstständig sein wie möglich – dort spart er die meiste Zeit und kann wenig zerstören. Für Änderungen an Produktivsystemen bereitet er alles vor und wartet.

Ein guter Agent fragt bei „Lösche alle Dateien in /tmp, die älter als 90 Tage sind“ deshalb nach, bevor er löscht – auch wenn der Befehl selbst trivial ist.

## Verbindungen

- [[Ein KI-Agent bekommt nur die Rechte, die seine Aufgabe braucht]] – die technische Absicherung, falls die Freigabe übergangen wird
- [[Ein Agenten-Prompt nennt Ziel, Kontext, Werkzeuge, Grenzen und Stoppbedingung]] – die Stoppbedingung im Prompt legt fest, wann gefragt wird
- [[Künstliche Intelligenz]] – Strukturzettel zu diesem Thema

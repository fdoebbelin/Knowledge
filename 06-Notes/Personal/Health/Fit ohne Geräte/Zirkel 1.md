---
title: "Zirkel 1"
program: "Anfängerprogramm"
zirkel: 1
beschreibung: "Schulter-Mobilität und Unterkörper-Kraft"
rounds: 3
training_duration: 40
rest_duration: 20
total_duration_min: 9
sequenz:
  - uebung: "Y-Handschellen"
    seite: ~
    training_duration: 40
    rest_duration: 20
  - uebung: "Kniender Ausfallschritt"
    seite: links
    training_duration: 40
    rest_duration: 20
  - uebung: "Kniender Ausfallschritt"
    seite: rechts
    training_duration: 40
    rest_duration: 20
schwierigkeit: Anfänger
tags: [zirkel, anfänger, schulter, unterkörper]
---

# Zirkel 1 – `= this.beschreibung`

```dataview
TABLE WITHOUT ID
  program AS Programm,
  zirkel AS "Nr.",
  rounds + " × " + length(sequenz) + " Sätze" AS Aufbau,
  training_duration + "s / " + rest_duration + "s" AS "Training / Pause",
  total_duration_min + " min" AS Dauer,
  schwierigkeit AS Niveau
WHERE file = this.file
```

## Übungsfolge

```dataview
TABLE WITHOUT ID
  ("[[" + sequenz.uebung + "]]") AS Übung,
  choice(sequenz.seite = null, "beidseitig", sequenz.seite) AS Seite,
  sequenz.training_duration + "s" AS Training,
  sequenz.rest_duration + "s" AS Pause
FLATTEN sequenz
WHERE file = this.file
```

> **`= this.rounds` Runden** dieser Folge · `= this.training_duration`s Training · `= this.rest_duration`s Pause  
> Gesamtdauer: **`= this.total_duration_min` Minuten**

---

## Übungen

- [[Y-Handschellen]]
- [[Kniender Ausfallschritt]]

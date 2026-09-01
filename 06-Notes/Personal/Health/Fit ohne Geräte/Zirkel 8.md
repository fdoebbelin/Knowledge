---
title: "Zirkel 8"
program: "Anfängerprogramm"
zirkel: 8
beschreibung: "Beinbreite und seitliche Rumpf-Kraft"
rounds: 3
training_duration: 40
rest_duration: 20
total_duration_min: 9
sequenz:
  - uebung: "Breite Kniebeuge"
    seite: ~
    training_duration: 40
    rest_duration: 20
  - uebung: "Side Kick"
    seite: links
    training_duration: 40
    rest_duration: 20
  - uebung: "Side Kick"
    seite: rechts
    training_duration: 40
    rest_duration: 20
schwierigkeit: Anfänger
tags: [zirkel, anfänger, beine, rumpf, dehnung]
---

# Zirkel 8 – `= this.beschreibung`

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

> **`= this.rounds` Runden** · `= this.training_duration`s Training · `= this.rest_duration`s Pause · **`= this.total_duration_min` Minuten**

---

## Übungen

- [[Breite Kniebeuge]]
- [[Side Kick]]

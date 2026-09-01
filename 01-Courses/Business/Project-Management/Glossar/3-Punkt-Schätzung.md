Die **3-Punkt-Schätzung** verwendet eine gewichtete Durchschnittsformel, die auf der **PERT-Methode** (Program Evaluation and Review Technique) basiert:

## Die Formel

```
Erwartete Dauer = (O + 4×R + P) ÷ 6
```

**Dabei bedeuten:**

- **O** = Optimistische Schätzung (Best Case)
- **R** = Realistische Schätzung (Most Likely Case)
- **P** = Pessimistische Schätzung (Worst Case)

## Warum diese Gewichtung?

### Mathematischer Hintergrund

Die Formel basiert auf der **Beta-Verteilung**, einer statistischen Verteilung, die sich besonders gut für Projektschätzungen eignet, weil sie:

- Asymmetrische Verteilungen abbilden kann
- Natürliche Grenzen (Minimum/Maximum) berücksichtigt
- Realistische Wahrscheinlichkeitsverteilungen für Projektrisiken darstellt

### Gewichtung erklärt

- **Optimistisch (1x)**: Niedrige Gewichtung, da dieser Fall selten eintritt
- **Realistisch (4x)**: Höchste Gewichtung, da dies der wahrscheinlichste Fall ist
- **Pessimistisch (1x)**: Niedrige Gewichtung, aber wichtig für Risikobetrachtung
- **Teiler 6**: Ergibt sich aus der Summe der Gewichtungen (1+4+1=6)

## Beispielrechnung aus dem Firmenjubiläum

**Arbeitspaket: "Veranstaltungsort buchen"**

- O = 4 Stunden (optimistisch)
- R = 8 Stunden (realistisch)
- P = 16 Stunden (pessimistisch)

```
Erwartete Dauer = (4 + 4×8 + 16) ÷ 6
                = (4 + 32 + 16) ÷ 6
                = 52 ÷ 6
                = 8,7 Stunden
```

## Warum nicht einfacher Durchschnitt?

Ein **einfacher Durchschnitt** würde lauten:

```
(4 + 8 + 16) ÷ 3 = 9,3 Stunden
```

Die **PERT-Formel ergibt 8,7 Stunden** - also einen niedrigeren Wert, weil:

- Der realistische Wert stärker gewichtet wird
- Dies der Projekterfahrung entspricht, dass "normale" Fälle häufiger auftreten
- Extreme Fälle (sehr gut/sehr schlecht) seltener sind

## Zusätzliche Berechnungen

### Standardabweichung (Unsicherheit)

```
Standardabweichung = (P - O) ÷ 6
```

Für unser Beispiel: (16 - 4) ÷ 6 = **2 Stunden**

### Konfidenzintervall

- **68% Wahrscheinlichkeit**: 8,7 ± 2 = zwischen 6,7 und 10,7 Stunden
- **95% Wahrscheinlichkeit**: 8,7 ± (2×2) = zwischen 4,7 und 12,7 Stunden

## Praktische Anwendung

### Schätzungsregeln

1. **Optimistisch**: "Wenn alles perfekt läuft" (ca. 10% Eintrittswahrscheinlichkeit)
2. **Realistisch**: "Der wahrscheinlichste Fall" (ca. 50% Eintrittswahrscheinlichkeit)
3. **Pessimistisch**: "Wenn vieles schief geht" (ca. 10% Eintrittswahrscheinlichkeit)

### Vorteile der 3-Punkt-Schätzung

- **Realitätsnäher** als Einpunkt-Schätzungen
- **Berücksichtigt Unsicherheiten** explizit
- **Quantifiziert Risiken** durch Standardabweichung
- **Verbessert Planungsqualität** durch strukturierte Risikobetrachtung

Die Formel hilft dabei, sowohl **optimistische Selbstüberschätzung** als auch **übertriebenen Pessimismus** zu vermeiden und zu einer ausgewogenen, statistisch fundierten Schätzung zu gelangen.
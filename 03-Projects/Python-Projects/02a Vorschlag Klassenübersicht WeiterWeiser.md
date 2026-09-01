## Übersicht aller zentralen Klassen

- **WetterDaten** – Verantwortlich für das Einlesen, Bereinigen und Halten der Wetterdaten.
- **WetterAnalyse** – Führt statistische Auswertungen und Berechnungen durch, z.B. Mittelwerte und Extremwerte.
- **WetterPlots** – Visualisiert Temperatur- und Niederschlagsverläufe und exportiert Diagramme für Berichte.

Erweiterungen für Machine Learning, Monats-/Jahresstatistik oder Detektion von Wetterereignissen können als zusätzliche Klassen oder Methoden integriert werden.

***

## Beispielhafte Implementierung und Zusammenspiel

### Klasse WetterDaten

```python
import pandas as pd

class WetterDaten:
    def __init__(self, dateipfad):
        self.df = pd.read_csv(dateipfad)
        self.df["Datum"] = pd.to_datetime(self.df["Datum"])
    
    def grundinfo(self):
        print(self.df.info())
        print(self.df.head())
```

**Praxisdemo**: Wetterdaten einlesen und prüfen

```python
daten = WetterDaten("wetter.csv")
daten.grundinfo()
```

*Im Kurs wird das Lesen und Validieren echter CSV-Wetterdaten demonstriert*.

***

### Klasse WetterAnalyse

```python
class WetterAnalyse:
    def __init__(self, wetterdaten):
        self.df = wetterdaten.df
    
    def jahresstatistik(self):
        print("Durchschnittstemperatur:", self.df["Temperatur"].mean())
        print("Maximaltemperatur:", self.df["Temperatur"].max())
        print("Minimaltemperatur:", self.df["Temperatur"].min())
        print("Gesamtniederschlag:", self.df["Niederschlag"].sum())
```

**Praxisdemo**: Statistische Auswertung von Temperatur- und Niederschlagswerten

```python
analyse = WetterAnalyse(daten)
analyse.jahresstatistik()
```

*Methoden können schrittweise erklärt und um Monats-/Jahres-Auswertungen erweitert werden*.

***

### Klasse WetterPlots

```python
import matplotlib.pyplot as plt
import seaborn as sns

class WetterPlots:
    def __init__(self, wetterdaten):
        self.df = wetterdaten.df
    
    def temperaturverlauf(self, pfad="temperaturverlauf.png"):
        plt.figure(figsize=(10, 4))
        sns.lineplot(data=self.df, x="Datum", y="Temperatur")
        plt.title("Temperaturverlauf")
        plt.savefig(pfad)
        plt.close()
    
    def niederschlagsverlauf(self, pfad="niederschlag.png"):
        plt.figure(figsize=(10, 4))
        sns.barplot(data=self.df, x="Datum", y="Niederschlag")
        plt.title("Niederschlagsverlauf")
        plt.savefig(pfad)
        plt.close()
```

**Praxisdemo**: Diagramme erzeugen und exportieren

```python
plots = WetterPlots(daten)
plots.temperaturverlauf()
plots.niederschlagsverlauf()
```

*Im Kurs können die Grafiken direkt gezeigt und in Berichte übernommen werden*.

***

## Zusammenspiel der Klassen

- **WetterDaten** dient als Datenbasis für **WetterAnalyse** und **WetterPlots**.
- Analyse- und Visualisierungsmethoden greifen direkt und flexibel auf die Datenobjekte zu.
- Erweiterungen für ML, Monatsberichte, Wetterereignis-Erkennung oder cloudbasierte Speicherung können in eigenen Modulen umgesetzt und angebunden werden.
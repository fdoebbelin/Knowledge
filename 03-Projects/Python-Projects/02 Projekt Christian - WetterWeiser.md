# **🌦️ WetterWeiser – Python-Projekt zur Wetterdatenanalyse**

## 📋 Projektbeschreibung

Mit **WetterWeiser** analysierst du echte Wetterdaten, entdeckst Trends und visualisierst Temperatur- und Niederschlagsverläufe in Python. Der modulare Aufbau ermöglicht Statistik, professionelle Visualisierung und zukünftige Erweiterung zum Machine-Learning-basierten Wettertrend-Tool.

***

## 🛠️ Voraussetzungen

- Python 3.x
- Bibliotheken: `pandas`, `matplotlib`, `seaborn`

**Installation:**

```sh
pip install pandas matplotlib seaborn
```


***

## 📁 Projektstruktur (Vorschlag)

```text
wetterweiser/
  ├── main.py              # Hauptskript (Datenanalyse, Auswertungen)
  ├── data_prep.py         # Datenaufbereitung (Einlesen, Bereinigen)
  ├── analyse.py           # Statistische Auswertungen
  ├── plots.py             # Visualisierung und Export
  └── daten/               # Echte CSV-Wetterdaten
```


***

## 🚀 Funktionen \& OOP-Prinzip (Beispiele)

### Einlesen und Vorbereiten von Wetterdaten

```python
import pandas as pd

class WetterDaten:
    def __init__(self, dateipfad):
        self.df = pd.read_csv(dateipfad)
        self.df['Datum'] = pd.to_datetime(self.df['Datum'])

    def grundinfo(self):
        print(self.df.info())
        print(self.df.head())
```


***

### Statistik: Mittelwerte, Extrema

```python
class WetterAnalyse:
    def __init__(self, wetterdaten):
        self.df = wetterdaten.df

    def jahresstatistik(self):
        print("Durchschnittstemperatur:", self.df['Temperatur'].mean())
        print("Maximaltemperatur:", self.df['Temperatur'].max())
        print("Minimaltemperatur:", self.df['Temperatur'].min())
        print("Gesamtniederschlag:", self.df['Niederschlag'].sum())
```


***

### Plotten und Exportieren

```python
import matplotlib.pyplot as plt
import seaborn as sns

class WetterPlots:
    def __init__(self, wetterdaten):
        self.df = wetterdaten.df

    def temperaturverlauf(self, pfad="temperaturverlauf.png"):
        plt.figure(figsize=(10,4))
        sns.lineplot(data=self.df, x='Datum', y='Temperatur')
        plt.title("Temperaturverlauf")
        plt.savefig(pfad)
        plt.close()

    def niederschlagsverlauf(self, pfad="niederschlag.png"):
        plt.figure(figsize=(10,4))
        sns.barplot(data=self.df, x='Datum', y='Niederschlag')
        plt.title("Niederschlagsverlauf")
        plt.savefig(pfad)
        plt.close()
```


***

## 📑 Aufgabenstellungen

1. Passe die Klassen an das eigene gewählte CSV-Datenformat an.
2. Erweitere die Analyse um Monats- und Jahresauswertungen.
3. Exportiere verschiedene Plots als PNG und füge sie in ein Berichtsdokument ein.
4. (Für Fortgeschrittene:) Entwickle eine Methode zur Erkennung von Hitzewellen oder extremen Regenperioden.
5. Skizziere, wie ein Machine-Learning-Modul zur Wettervorhersage eingebunden werden kann.

***

## 🌱 Ausblick

- Erweiterbar um Machine Learning: Prognose künftiger Temperaturen und Trends
- Gute Basis für Gruppenarbeiten und individuelle Analysen
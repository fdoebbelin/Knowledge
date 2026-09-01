## Übersicht aller zentralen Klassen

- **KeySignal** – Repräsentiert einzelne Funksignale in Form komplexwertiger Zeitreihen und enthält Methoden zur Modulations- und Feature-Berechnung.
- **SignalDemo/Main** – Hauptskript zur Demonstration, Simulation und Analyse von Signalsamples (für Kursbeispiele und Prüfzwecke).
- **LabeledKeySignal** – Erweiterte Klasse mit Metadaten (Marke, Modell, Jahr) für ML-Pipelines und Labeling-Aufgaben.

Erweiterungen/Module für ASK/PSK-Demodulation, Feature-Extraktion, automatische Erkennung und Machine Learning (PyTorch) sind vorgesehen.

***

## Beispielhafte Implementierung und Zusammenspiel

### Klasse KeySignal

```python
import numpy as np

class KeySignal:
    def __init__(self, iqdata, samplingrate, desc=None):
        self.iqdata = iqdata
        self.samplingrate = samplingrate
        self.desc = desc
        self.modulation = None
        self.features = {}
        
    def set_modulation(self, modulation_type):
        self.modulation = modulation_type
        
    def demodulate(self):
        if self.modulation == "ASK":
            return np.abs(self.iqdata)
        elif self.modulation == "PSK":
            return np.angle(self.iqdata)
        else:
            raise NotImplementedError("Modulation nicht unterstützt")
        
    def extract_features(self):
        self.features = {
            "mean_amplitude": np.mean(np.abs(self.iqdata)),
            "std_amplitude": np.std(np.abs(self.iqdata)),
            "mean_phase": np.mean(np.angle(self.iqdata)),
            "std_phase": np.std(np.angle(self.iqdata)),
        }
        return self.features
    
    def __repr__(self):
        return f"KeySignal {self.desc} Modulation {self.modulation}"
```

**Praxisdemo**: Signal simulieren, analysieren, Features berechnen

```python
fs = 10000
t = np.arange(0, 0.01, 1/fs)
bits = np.random.choice([0, 1], size=len(t))
carrier = np.exp(1j * 2 * np.pi * 2000 * t)
iqask = bits * carrier

signal = KeySignal(iqask, fs, desc="Demo ASK")
signal.set_modulation("ASK")
demod = signal.demodulate()
print("Extrahierte Features:", signal.extract_features())
```

*Kurszweck*: Signalverarbeitung Schritt für Schritt anhand eines realistischen Beispiels erläutern.

***

### Klasse LabeledKeySignal (erweitert für ML/Projektlabeling)

```python
class LabeledKeySignal(KeySignal):
    def __init__(self, iqdata, samplingrate, desc, marke, modell, jahr):
        super().__init__(iqdata, samplingrate, desc)
        self.marke = marke
        self.modell = modell
        self.jahr = jahr
```

**Praxisdemo**: Klassifizieren und Parameter zuweisen

```python
labeled_signal = LabeledKeySignal(iqask, fs, "ASK Demo", "VW", "Golf", 2021)
print(labeled_signal)
```

*Basis für Gruppen-Aufgaben wie Labeling und automatisierte ML-Auswertung*.

***

### Zusammenspiel und weitere Module

- **KeySignal** ist zentrale Datenstruktur für alle Signaloperationen.
- Methoden für Demodulation und Feature-Berechnung können in separaten Modulen (z.B. „demod.py“) organisiert werden.
- Hauptskript für Simulation, Analyse und Visualisierung (z.B. mit matplotlib).
- Erweiterungen für Plotting, automatische Erkennung, und komplexere Feature-Extraktion sind modular anschließbar.
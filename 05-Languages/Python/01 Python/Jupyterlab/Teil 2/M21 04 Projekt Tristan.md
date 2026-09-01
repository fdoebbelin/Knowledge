## Aufgabenstellungen für KeyRegognition (M21)

### 1. Signal-Klasse entwickeln

- Implementiere eine Klasse `KeySignal` mit Attributen für die IQ-Daten, die Abtastrate und eine optionale Beschreibung.
- Füge Methoden hinzu, um Modulationsarten (z. B. ASK, PSK) zu setzen, Signale zu demodulieren und statistische Merkmale (Features) zu extrahieren.

```python
import numpy as np

class KeySignal:
    def __init__(self, iqdata, samplingrate, desc=None):
        self.iqdata = iqdata
        self.samplingrate = samplingrate
        self.desc = desc
        self.modulation = None

    def set_modulation(self, modulationtype):
        self.modulation = modulationtype

    def demodulate(self):
        if self.modulation == "ASK":
            return np.abs(self.iqdata)
        elif self.modulation == "PSK":
            return np.angle(self.iqdata)
        else:
            raise NotImplementedError("Modulation nicht unterstützt")

    def extract_features(self):
        return {
            "mean_ampl": np.mean(np.abs(self.iqdata)),
            "std_ampl": np.std(np.abs(self.iqdata)),
            "mean_phase": np.mean(np.angle(self.iqdata)),
            "std_phase": np.std(np.angle(self.iqdata))
        }
```


***

### 2. Simulation und Visualisierung

- Simuliere ein einfaches ASK- oder PSK-Signal und verwende deine Klasse, um das Signal zu analysieren und grafisch darzustellen (z. B. via matplotlib).

```python
import matplotlib.pyplot as plt

fs = 10000
t = np.arange(0, 0.01, 1/fs)
bits = np.random.choice([0, 1], size=len(t))
carrier = np.exp(1j*2*np.pi*2000*t)
iq_ask = bits * carrier

signal = KeySignal(iq_ask, fs, desc="Demo ASK")
signal.set_modulation("ASK")
demod = signal.demodulate()
plt.plot(t, demod)
plt.title("ASK-Demodulation")
plt.xlabel("Zeit (s)")
plt.ylabel("Amplitude")
plt.show()
```


***

### 3. Erweiterung: Abgeleitete Signal-Klasse

- Entwickle eine Klasse `LabeledKeySignal`, die von `KeySignal` erbt und um Attribute für Marke, Modell und Baujahr ergänzt wird.
- Stelle sicher, dass auch erweiterte Features und Metadaten verarbeitet werden können.

***

### 4. Automatisierung und Machine Learning (optional)

- Skizziere, wie eine Schnittstelle zu Machine-Learning-Methoden aussieht (z. B. Integration mit PyTorch für automatische Signal-Klassifikation).

***

Diese Aufgabenstellungen bilden die Brücke zwischen OOP-Grundlagen und anspruchsvoller Signalverarbeitung – praxistauglich am Beispiel KeyRecognition umgesetzt.
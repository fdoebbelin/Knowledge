## 📋 Projektbeschreibung

**KeyRecognition** ist ein modulares Python-Projekt zur Aufnahme, Analyse und Erkennung von Funksignalen moderner Autoschlüssel. Im Fokus stehen Datenverarbeitung mit Python, Objektorientierung, Signalvisualisierung und die Vorbereitung maschineller Lernverfahren zur automatisierten Zuordnung von Schlüsselsignalen zu Fahrzeugtypen.

***

## 🛠️ Voraussetzungen

- Python 3.x
- Bibliotheken: `numpy`, `matplotlib`
- Optionale Bibliotheken: `pandas`, `scipy`, `pytorch`
- Hardware: RTL-SDR (z.B. Nooelec NESDR Smart)
- Voraussetzung: IQ-Rohdaten (komplexwertige Zeitreihen, z.B. als `.npy` oder `.csv`)

***

## 📁 Projektstruktur (Vorschlag)

```text
keyrecognition/
  ├── main.py                # Hauptskript (Analyse, Demo)
  ├── signal.py              # OOP-Klassen zur Signalverarbeitung
  ├── demod.py               # ASK/PSK-Demodulationen und Feature-Extraction
  ├── ml_pipeline.py         # Optional: Machine-Learning-Erweiterungen (PyTorch)
  ├── daten/                 # Beispielhafte IQ-Datensätze für die Analyse
```


***

## 🚀 Funktionen \& OOP-Prinzip (Beispiele)

### OOP: Klasse für Funksignale

```python
import numpy as np

class KeySignal:
    def __init__(self, iq_data, sampling_rate, desc=None):
        self.iq_data = iq_data
        self.sampling_rate = sampling_rate
        self.desc = desc
        self.modulation = None
        self.features = {}

    def set_modulation(self, modulation_type):
        """Modulationsart setzen ('ASK', 'PSK' etc.)"""
        self.modulation = modulation_type

    def demodulate(self):
        if self.modulation == 'ASK':
            return np.abs(self.iq_data)
        elif self.modulation == 'PSK':
            return np.angle(self.iq_data)
        else:
            raise NotImplementedError("Modulation nicht unterstützt")

    def extract_features(self):
        self.features = {
            "mean_ampl": np.mean(np.abs(self.iq_data)),
            "std_ampl": np.std(np.abs(self.iq_data)),
            "mean_phase": np.mean(np.angle(self.iq_data)),
            "std_phase": np.std(np.angle(self.iq_data)),
        }
        return self.features

    def __repr__(self):
        return f"<KeySignal: {self.desc} / Modulation: {self.modulation}>"
```


***

### Demo: Signal simulieren, analysieren und plotten

```python
import matplotlib.pyplot as plt

# Simulierte ASK-Daten erzeugen
fs = 10000
t = np.arange(0, 0.01, 1/fs)
bits = np.random.choice([0, 1], size=len(t))
carrier = np.exp(1j*2*np.pi*2000*t)
iq_ask = bits * carrier

signal = KeySignal(iq_ask, fs, desc="Demo ASK")
signal.set_modulation('ASK')
demod = signal.demodulate()

plt.plot(t, demod)
plt.title("ASK-Demodulation")
plt.xlabel("Zeit [s]")
plt.ylabel("Amplitude")
plt.show()

print("Extrahierte Features:", signal.extract_features())
```


***

### Aufgabenstellungen

1. Ergänze Methoden für die automatische Erkennung von Trägerfrequenz und Symbolrate.
2. Simuliere ein PSK-Signal und visualisiere den Phasengang.
3. Entwickle eine abgeleitete Klasse `LabeledKeySignal` mit Attributen für Marke, Modell und Jahr und pipeline-fähiger Feature-Extraktion.
4. Skizziere, wie ein ML-Modul (z.B. mit PyTorch) integriert werden kann, um Schlüssel automatisch zu klassifizieren.

***

## 🌱 Ausblick

- Erweiterbar auf weitere Modulationsarten (FSK, QAM)
- Datensammlung und -labeling als Basis für gemeinsame Gruppenprojekte
- Optimal für weiterführende Machine-Learning-Experimente mit echten Signalrohdaten

# Key Recognizer

![](_resources/0e342786659e236a6388a87062ebc4c4_MD5.svg)
![](_resources/06acbe8becb44b49a6552835d855352c_MD5.svg)
![](_resources/629c5155780c6a91059de96927a1b876_MD5.svg)

**Key Recognizer** ist ein modulares grafisches Desktop-Programm zur Klassifikation von Funkschlüsseln anhand ihres Funksignals.

## 🎯 Projektziele

### Kernfunktionen
- **Aufzeichnung**: Automatische Aufzeichnung von Signalen mithilfe eines RTL-SDR [Nooelec NESDR smart](https://www.nooelec.com/store/sdr/sdr-receivers/nesdr-smart-sdr.html).
- **Speichern der Signale**: Abspeichern der IQ-Daten eines Signals als binärdatei bestehend aus Tupeln mit 64bit Werten für realen und irregulären Teil des Samples.
- **Analyse des Signals**: Automatische Analyse wichtiger Parameter eines Signals (z.B.: Modulationsart, Baudrate, Frequenzabweichung, Bandbreite, ...)
- **Visualisierung**: Grafische Darstellung des Signals in Zeit- und Frequenzdomäne
- **Klassifikation**: Klassifikation des Signals um Hersteller, Modell und Baujahr (Zeitraum) zu bestimmen

### Didaktische Ziele
- Praxisnahe Vermittlung von Grundlagen der Funktechnik
- Grundlagen OOP in Python
- Grundlagen der Softwareentwicklung

## 🛠️ Technologie-Stack

### Kernbibliotheken
- **Interfacing mit RTL-SDR**: `pyrtlsdr`
- **Mathematische Funktionen zur Signalverarbeitung**: `scipy`
- **Nummerische Operationen und Array-Manipulation**: `numpy`
- **Datenvisualisierung** `matplotlib``
- **Training und Interface mit Deep Learing Modell** `pytorch`
- **GUI** `customtkinter`

## 🏗️ Architektur

### Hauptkomponenten

```
Key_Recognition/                    |
├── README.md                       |
├── gui.py                          |   Graphical User Interface
├── files.py                        |   Funktionen zum Speichern und Lesen der Signale
├── SDR.py                          |   Interface mit dem SDR
├── plot_ui.py                      |   Datenvisualisierung mit Matplotlib
├── Signal.py                       |   Klasse, die ein Signal repräsentiert
├── recordings                      |   Ordner für gespeicherte Signale
│   └── "all recording files"       |  
```

## 🎯 Roadmap

### Phase 1: Grundlagen
- [x] Projektstruktur definieren
- [x] Automatische Aufzeichnung von Signalen
- [x] Abspeichern von Signalen
- [x] Datenvisualisierung in Zeit- und Frequenzdomäne
- [x] Grafisches User-Interface

### Phase 2: Kernfunktionalität
- [ ] **Sammeln von Signalen**: Sammeln von Signalen relevanter Schlüssel
- [ ] **Beschriften des Datensatzes**: Versehen des Datensatzes mit Meta-Daten um PyTorch-Modell trainieren zu können
- [ ] **Training und Interface mit ML-Modell**
- [ ] **Integration der Ergebnisse in das GUI**

## Screenshots
![Screenshot_GUI_1.png](blob/Screenshot_GUI_1.png)
![Screenshot_GUI_2.png](blob/Screenshot_GUI_2.png)
## 📜 Lizenz

Dieses Projekt steht unter der MIT-Lizenz. Siehe [LICENSE](../../../../02-Tech/DevTools/Nushell/nu-scripts/LICENSE.md) für Details.
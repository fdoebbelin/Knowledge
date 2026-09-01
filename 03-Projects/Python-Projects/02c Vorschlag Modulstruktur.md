## Empfohlene Dateistruktur

```
wetterweiser/
├── models.py           # Datenmodelle und Enums
├── analysis.py         # Datenanalyse und Statistiken  
├── data_sources.py     # Externe Datenquellen (API, GitHub)
├── ui_components.py    # UI-Komponenten für Streamlit
├── config.py          # Konfiguration und Konstanten
├── utils.py           # Hilfsfunktionen
├── app.py             # Hauptanwendung (Streamlit-UI)
├── __init__.py        # Package-Initialisierung
├── requirements.txt   # Python-Abhängigkeiten
├── .streamlit/
│   └── secrets.toml   # Geheime Konfigurationsdaten
└── README.md          # Projektdokumentation
```

## Modulbeschreibungen

### models.py
**Zweck:** Zentrale Datenstrukturen und Enums
- `QuelleEnum`: Enum für Datenquellen (MANUELL, SIMULIERT, LIVE)
- `WetterMessung`: Klasse für einzelne Wettermessungen
- `WetterDaten`: Klasse für Sammlung von Wettermessungen

**Imports:**
```python
from enum import Enum
import uuid
import pandas as pd
import datetime
import random
```

### analysis.py
**Zweck:** Datenanalyse und statistische Berechnungen
- `WetterAnalyse`: Erweitert WetterDaten um Analysefunktionen
- Extremwerte, Jahresstatistiken, Durchschnitte
- Prognose-Funktionen
- Plot-Funktionen für Diagramme

**Imports:**
```python
from models import WetterDaten
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```

### data_sources.py
**Zweck:** Integration externer Datenquellen
- GitHub-API Integration (Import/Export)
- OpenWeatherMap API-Integration
- Daten-Synchronisation

**Imports:**
```python
from models import WetterMessung, WetterDaten, QuelleEnum
import requests
import base64
import json
import streamlit as st
from config import get_config
```

### ui_components.py
**Zweck:** Wiederverwendbare UI-Komponenten für Streamlit
- Manuelle Eingabe-Formulare
- Simulation-Interface
- Datenanzeige und Löschfunktionen
- Export-Funktionen

**Imports:**
```python
import streamlit as st
import datetime
import numpy as np
from models import WetterMessung, QuelleEnum
from data_sources import get_live_weather
```

### config.py
**Zweck:** Konfiguration und Konstanten
- Streamlit Secrets-Management
- API-Schlüssel Verwaltung
- GitHub-Konfiguration
- Konstanten definieren

**Imports:**
```python
import streamlit as st
```

**Inhalt:**
```python
def get_config():
    return {
        'GITHUB_REPO': st.secrets.get("Legacy91988", {}).get("Wetterweiser"),
        'GITHUB_BRANCH': st.secrets.get("Legacy91988", {}).get("branch", "main"),
        'GITHUB_TOKEN': st.secrets.get("Legacy91988", {}).get("githubtoken"),
        'GITHUB_JSON_PATH': "wetterdaten.json",
        'OWM_API_KEY': st.secrets.get("Legacy91988", {}).get("OWMAPIKEY")
    }
```

### utils.py
**Zweck:** Hilfsfunktionen und Utilities
- Datenvalidierung
- Fehlerbehandlung
- Formatierungsfunktionen
- Debug-Utilities

**Imports:**
```python
import traceback
import datetime
```

### app.py
**Zweck:** Hauptanwendung und Streamlit-Interface
- Main-Funktion
- UI-Layout und Navigation
- Koordination zwischen Modulen

**Imports:**
```python
import streamlit as st
from models import WetterDaten
from analysis import WetterAnalyse
from ui_components import manuelleeingabe, wettersimulation, anzeigenundloeschen
from data_sources import load_github_data
```

## Vorteile der modularen Struktur

### Wartbarkeit
- **Separation of Concerns**: Jedes Modul hat eine klare Verantwortlichkeit
- **Einfachere Fehlersuche**: Probleme können gezielt lokalisiert werden
- **Bessere Testbarkeit**: Module können isoliert getestet werden

### Erweiterbarkeit
- **Neue Features**: Können ohne Änderung bestehender Module hinzugefügt werden
- **Alternative Implementierungen**: z.B. andere API-Provider in data_sources.py
- **UI-Variationen**: Verschiedene Interfaces ohne Backend-Änderungen

### Wiederverwendbarkeit
- **Modulare Komponenten**: UI-Komponenten können in anderen Projekten verwendet werden
- **Klare APIs**: Module können als Libraries verwendet werden
- **Dokumentation**: Jedes Modul kann einzeln dokumentiert werden

## Migration von der monolithischen Struktur

### Schritt 1: Basis-Module erstellen
1. `models.py` mit den Datenklassen erstellen
2. `config.py` für Konfiguration anlegen
3. `__init__.py` für Package-Struktur

### Schritt 2: Funktionalitäten aufteilen
1. Analysefunktionen nach `analysis.py` verschieben
2. API-Funktionen nach `data_sources.py` verschieben
3. UI-Funktionen nach `ui_components.py` verschieben

### Schritt 3: Hauptanwendung anpassen
1. `app.py` als schlanke Hauptdatei erstellen
2. Imports entsprechend der neuen Struktur anpassen
3. Funktionsaufrufe auf Module verteilen

### Schritt 4: Testing und Validierung
1. Jedes Modul einzeln testen
2. Integration zwischen Modulen prüfen
3. Streamlit-App auf Funktionsfähigkeit testen

## Import-Übersicht der neuen Struktur

```python
# app.py - Hauptdatei
from models import WetterDaten
from analysis import WetterAnalyse  
from ui_components import manuelleeingabe, wettersimulation, anzeigenundloeschen
from data_sources import load_github_data, get_live_weather

# analysis.py - Datenanalyse
from models import WetterDaten

# data_sources.py - API-Integration  
from models import WetterMessung, WetterDaten, QuelleEnum
from config import get_config

# ui_components.py - UI-Komponenten
from models import WetterMessung, QuelleEnum  
from data_sources import get_live_weather
```

Diese modulare Struktur macht das Projekt wartbarer, testbarer und erweiterbar, während die Funktionalität vollständig erhalten bleibt.
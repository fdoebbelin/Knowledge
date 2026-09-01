## Aktuelle Modulstruktur

### Abhängigkeitsdiagramm
```
gui.py -> SDR.py -> Signal.py
gui.py -> plot_ui.py -> Signal.py
```

### Modul-Übersicht
- **SDR.py**: Hardware-Abstraktion, Threading, Signal-Detection
- **Signal.py**: Datencontainer für IQ-Data, FFT-Verarbeitung  
- **gui.py**: Monolithische GUI mit Matplotlib-Integration
- **plot_ui.py**: Plotting-Funktionalität

## Kritische Problembereiche

### 1. Testbarkeit-Hindernisse
- ❌ Hardware-Abhängigkeit (rtlsdr) fest verdrahtet
- ❌ GUI direkt mit Business-Logik gekoppelt
- ❌ Threading-Logik vermischt mit Funktionalität
- ❌ Globale Konstanten verstreut
- ❌ Exception Handling verschluckt Details
- ❌ Fehlende Input-Validierung

### 2. Architektur-Mängel
- ❌ Monolithische GUI-Klasse (500+ Zeilen)
- ❌ Queue-basierte Kommunikation schwer testbar
- ❌ Matplotlib fest eingebaut
- ❌ Datei-I/O direkt in GUI

## Refactoring-Strategie

### Phase 1: Foundation

#### 1.1 Abstrakte Interfaces definieren
```python
from abc import ABC, abstractmethod
from typing import Protocol

class RadioInterface(ABC):
    @abstractmethod
    def read_samples(self, n: int) -> 'Signal':
        pass
    
    @abstractmethod
    def configure(self, config: 'SDRConfig') -> bool:
        pass

class EventListener(Protocol):
    def on_signal_detected(self, signal: Signal) -> None: ...
    def on_running_changed(self, running: bool) -> None: ...
    def on_error(self, error: Exception) -> None: ...
```

#### 1.2 Configuration Pattern
```python
from dataclasses import dataclass
from typing import Union

@dataclass
class SDRConfig:
    sample_rate: float = 2.048e6
    center_freq: float = 868.3e6
    gain: Union[str, float] = "auto"
    detection_threshold_upper: float = 2.0
    detection_threshold_lower: float = 1.8
    samples_per_read: int = 2048 * 4
    
    def validate(self) -> bool:
        return (self.sample_rate > 0 and 
                self.center_freq > 0 and
                self.detection_threshold_upper > self.detection_threshold_lower)
```

#### 1.3 Signal-Klasse verbessern
```python
from typing import Optional, Tuple
import numpy as np

class Signal:
    def __init__(self, 
                 iq_data: np.ndarray,
                 sample_rate: float = 2.048e6,
                 center_freq: float = 868.3e6):
        self._validate_inputs(iq_data, sample_rate, center_freq)
        self._iq_data = iq_data
        self._sample_rate = sample_rate
        self._center_freq = center_freq
    
    def _validate_inputs(self, iq_data: np.ndarray, 
                        sample_rate: float, center_freq: float):
        if sample_rate <= 0:
            raise ValueError("Sample rate must be positive")
        if center_freq <= 0:
            raise ValueError("Center frequency must be positive")
        if not isinstance(iq_data, np.ndarray):
            raise TypeError("IQ data must be numpy array")
```

### Phase 2: Entkopplung

#### 2.1 Observer Pattern implementieren
```python
class SDR:
    def __init__(self, radio: RadioInterface, config: SDRConfig = None):
        self.radio = radio
        self.config = config or SDRConfig()
        self._listeners: List[EventListener] = []
        
    def add_listener(self, listener: EventListener):
        self._listeners.append(listener)
        
    def _notify_signal(self, signal: Signal):
        for listener in self._listeners:
            try:
                listener.on_signal_detected(signal)
            except Exception as e:
                self._notify_error(e)
```

#### 2.2 Command Pattern für GUI Actions
```python
class Command(ABC):
    @abstractmethod
    def execute(self) -> None:
        pass

class StartListeningCommand(Command):
    def __init__(self, sdr_service: 'SDRService', config: SDRConfig):
        self.sdr_service = sdr_service
        self.config = config
        
    def execute(self) -> None:
        self.sdr_service.start_listening(self.config)
```

#### 2.3 Repository Pattern für Persistierung
```python
class SignalRepository(ABC):
    @abstractmethod
    def save_signal(self, signal: Signal, metadata: dict) -> str:
        pass
    
    @abstractmethod
    def load_signal(self, identifier: str) -> Signal:
        pass

class FileSignalRepository(SignalRepository):
    def __init__(self, base_path: Path):
        self.base_path = base_path
        
    def save_signal(self, signal: Signal, metadata: dict) -> str:
        # Implementierung für Datei-Speicherung
        pass
```

### Phase 3: Testing Infrastructure

#### 3.1 Mock-Implementierungen
```python
class MockRadio(RadioInterface):
    def __init__(self, signal_generator=None):
        self.signal_generator = signal_generator or self._default_generator
        
    def read_samples(self, n: int) -> Signal:
        return Signal(iq_data=self.signal_generator(n))
        
    def _default_generator(self, n: int) -> np.ndarray:
        return np.random.random(n) + 1j * np.random.random(n)

class TestEventListener:
    def __init__(self):
        self.signals_received = []
        self.errors_received = []
        
    def on_signal_detected(self, signal: Signal):
        self.signals_received.append(signal)
        
    def on_error(self, error: Exception):
        self.errors_received.append(error)
```

#### 3.2 Test-Struktur
```python
# tests/unit/test_signal.py
import pytest
from src.signal import Signal

class TestSignal:
    def test_signal_creation_valid_data(self):
        iq_data = np.array([1+1j, 2+2j, 3+3j])
        signal = Signal(iq_data, sample_rate=1e6, center_freq=100e6)
        assert np.array_equal(signal.iq_data, iq_data)
        
    def test_signal_creation_invalid_sample_rate(self):
        with pytest.raises(ValueError, match="Sample rate must be positive"):
            Signal(np.array([1+1j]), sample_rate=-1)
            
    def test_average_power_calculation(self):
        iq_data = np.array([1+0j, 0+1j, -1+0j, 0-1j])
        signal = Signal(iq_data)
        expected_power = np.var(iq_data)
        assert signal.average_power() == pytest.approx(expected_power)
```

## Empfohlene Projektstruktur

```
project/
├── docs/
│   ├── architecture/
│   │   ├── overview.md          # Systemarchitektur
│   │   ├── dependencies.md      # Abhängigkeitsdiagramm
│   │   └── patterns.md          # Design Patterns
│   ├── api/
│   │   ├── signal.md           # Signal API Documentation
│   │   ├── sdr.md              # SDR API Documentation
│   │   └── gui.md              # GUI Component Documentation
│   └── testing/
│       ├── strategy.md         # Testing Strategy
│       ├── fixtures.md         # Test Fixtures
│       └── mocking.md          # Mock Guidelines
├── tests/
│   ├── unit/
│   │   ├── test_signal.py
│   │   ├── test_sdr.py
│   │   └── test_config.py
│   ├── integration/
│   │   ├── test_sdr_signal_flow.py
│   │   └── test_gui_backend.py
│   ├── e2e/
│   │   └── test_complete_workflow.py
│   └── fixtures/
│       ├── mock_radio.py
│       ├── sample_signals.py
│       └── test_data/
└── src/
    ├── core/
    │   ├── interfaces.py        # Abstrakte Interfaces
    │   ├── config.py           # Configuration Classes
    │   └── exceptions.py       # Custom Exceptions
    ├── hardware/
    │   ├── radio_interface.py  # Hardware Abstraction
    │   ├── rtl_sdr_impl.py    # RTL-SDR Implementation
    │   └── mock_radio.py      # Mock für Tests
    ├── signal/
    │   ├── signal.py          # Refactored Signal Class
    │   ├── processing.py      # Signal Processing
    │   └── analysis.py        # Signal Analysis
    ├── gui/
    │   ├── main_window.py     # Hauptfenster
    │   ├── plot_widget.py     # Plot Components
    │   └── controls.py        # Control Widgets
    └── services/
        ├── signal_service.py   # Business Logic
        ├── file_service.py     # File Operations
        └── threading_service.py # Threading Management
```

## Testing-Strategie

### Unit Tests
- **Signal-Klasse**: Validierung, FFT, Power-Berechnung
- **Configuration**: Serialization, Validation
- **Commands**: Execute-Logik isoliert testen
- **Repository**: Save/Load-Funktionalität

### Integration Tests
- **SDR + Signal Integration**: Mit Mock-Radio
- **GUI Event Flow**: Mit Mock-Backend
- **File I/O Operations**: Mit temporären Dateien
- **Threading Behavior**: Mit kontrollierten Szenarien

### End-to-End Tests
- **Komplette User Journeys**: Simulierte Hardware
- **Performance Tests**: Unter realistischer Last
- **Error Handling**: Fehlerszenarien durchspielen

## Dokumentations-Vorgehen

### 1. API-Dokumentation mit Sphinx
```python
class Signal:
    """Repräsentiert ein IQ-Datensignal mit Metadaten.
    
    Args:
        iq_data: Complex numpy array mit I/Q samples
        sample_rate: Abtastrate in Hz
        center_freq: Zentrumsfrequenz in Hz
        
    Raises:
        ValueError: Bei ungültigen Parameterwerten
        TypeError: Bei falschen Datentypen
        
    Example:
        >>> signal = Signal(np.array([1+1j, 2+2j]), 
        ...                 sample_rate=1e6, center_freq=100e6)
        >>> power = signal.average_power()
    """
```

### 2. Architektur-Dokumentation
- **Komponentendiagramme** mit draw.io/mermaid
- **Sequenzdiagramme** für kritische Workflows
- **API-Referenz** mit automatischer Generierung

### 3. Test-Dokumentation
- **Testing Guidelines** für neue Features
- **Mock-Strategien** dokumentieren
- **Performance-Benchmarks** festhalten

## Sofortige Maßnahmen (Quick Wins)

1. **Type Hints hinzufügen**
2. **Input-Validierung** in Signal-Klasse
3. **Globale Konstanten** in Config-Klasse
4. **Exception-Handling** verbessern
5. **Erste Unit Tests** für Signal-Klasse

## Erfolgsmessung

### Metriken vor Refactoring
- **Testabdeckung**: 0%
- **Zyklomatische Komplexität**: Hoch (GUI ~50, SDR ~40)
- **Kopplungsgrad**: Sehr hoch
- **Maintainability Index**: Niedrig

### Ziel-Metriken nach Refactoring
- **Testabdeckung**: >90%
- **Zyklomatische Komplexität**: <10 pro Methode
- **Kopplungsgrad**: Niedrig durch Interfaces
- **Maintainability Index**: Hoch (>70)

### Tools für Überwachung
```bash
# Code Coverage
pytest --cov=src --cov-report=html

# Code Quality
pylint src/
mypy src/
flake8 src/

# Complexity Analysis  
radon cc src/ -a
radon mi src/
```

Dieses Vorgehen ermöglicht schrittweise Verbesserung der Testbarkeit bei minimaler Unterbrechung der aktuellen Funktionalität.
## Einführung in das Modul

Unit Testing ist weit mehr als nur das Schreiben einfacher Testfälle - es ist eine Kunstform der Softwareentwicklung, die Qualität, Wartbarkeit und Vertrauen in den Code schafft. In diesem Modul vertiefen wir uns in die fortgeschrittenen Aspekte des Unit Testing und betrachten Testing als integralen Bestandteil eines professionellen Entwicklungsworkflows.

Nachdem Sie in den vorherigen Modulen die Grundlagen und Anwendung von Unit Testing kennengelernt haben, führt Sie dieses Modul zu den Meisterschaftstechniken: **CI-Integration**, **komplexe OOP-Strukturen testen** und **TDD für Refactoring anwenden**. Diese Fähigkeiten sind entscheidend für die Entwicklung robuster, skalierbarer und professionell wartbarer Python-Anwendungen.

## CI-Integration: Continuous Integration mit Tests

### Grundlagen der CI-Integration

Continuous Integration (CI) bedeutet, dass Tests automatisch bei jedem Code-Commit ausgeführt werden. Dies gewährleistet, dass Fehler sofort erkannt und behoben werden können.

#### GitHub Actions für Python-Tests

Erstellen einer `.github/workflows/tests.yml` Datei:

```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, '3.10', 3.11]
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v3
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install pytest pytest-cov flake8
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
    - name: Run tests with coverage
      run: |
        pytest --cov=src --cov-report=xml --cov-report=term-missing
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v2
```


#### Test-Konfiguration mit pytest.ini

```ini
[tool:pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = 
    --strict-markers
    --strict-config
    --verbose
    --cov=src
    --cov-report=term-missing:skip-covered
    --cov-report=html:htmlcov
    --cov-report=xml
    --cov-branch
    --cov-fail-under=90
markers =
    unit: Unit tests
    integration: Integration tests
    slow: Slow running tests
    external: Tests that require external services
```


#### Praktisches Beispiel: CI-Pipeline Setup

```python
# conftest.py - Zentrale Testkonfiguration
import pytest
import tempfile
import os
from pathlib import Path

@pytest.fixture(scope="session")
def test_data_dir():
    """Bereitstellung eines temporären Testdaten-Verzeichnisses."""
    with tempfile.TemporaryDirectory() as temp_dir:
        yield Path(temp_dir)

@pytest.fixture
def sample_config():
    """Standard-Konfiguration für Tests."""
    return {
        'database_url': 'sqlite:///:memory:',
        'debug': True,
        'testing': True
    }

# Marker für verschiedene Testtypen
def pytest_configure(config):
    config.addinivalue_line("markers", "unit: Unit tests")
    config.addinivalue_line("markers", "integration: Integration tests")
    config.addinivalue_line("markers", "slow: Slow running tests")
```


### Erweiterte CI-Workflows

#### Multi-Stage Testing Pipeline

```python
# tests/test_ci_stages.py
import pytest
import subprocess
import sys

class TestCodeQuality:
    """Tests für Code-Qualität in CI-Pipeline."""
    
    @pytest.mark.unit
    def test_code_formatting_with_black(self):
        """Prüft ob Code korrekt formatiert ist."""
        result = subprocess.run([
            sys.executable, "-m", "black", 
            "--check", "--diff", "src/"
        ], capture_output=True, text=True)
        
        assert result.returncode == 0, f"Code nicht formatiert:\n{result.stdout}"
    
    @pytest.mark.unit  
    def test_import_sorting_with_isort(self):
        """Prüft Import-Reihenfolge."""
        result = subprocess.run([
            sys.executable, "-m", "isort", 
            "--check-only", "--diff", "src/"
        ], capture_output=True, text=True)
        
        assert result.returncode == 0, f"Imports nicht sortiert:\n{result.stdout}"
    
    @pytest.mark.unit
    def test_type_checking_with_mypy(self):
        """Prüft Typ-Annotationen."""
        result = subprocess.run([
            sys.executable, "-m", "mypy", "src/"
        ], capture_output=True, text=True)
        
        assert result.returncode == 0, f"Type-Checking Fehler:\n{result.stdout}"
```


#### Performance und Security Tests in CI

```python
# tests/test_performance.py
import pytest
import time
from memory_profiler import profile
from contextlib import contextmanager

@contextmanager
def time_limit(seconds):
    """Context Manager für Performance-Tests."""
    start = time.time()
    yield
    elapsed = time.time() - start
    assert elapsed < seconds, f"Zu langsam: {elapsed:.2f}s > {seconds}s"

class TestPerformance:
    
    @pytest.mark.slow
    def test_database_query_performance(self, db_connection):
        """Testet Datenbankabfrage-Performance."""
        with time_limit(0.5):  # Maximal 500ms
            result = db_connection.execute("SELECT * FROM users LIMIT 1000")
            assert len(result) <= 1000
    
    @pytest.mark.slow
    def test_memory_usage(self):
        """Testet Speicherverbrauch."""
        @profile
        def memory_intensive_function():
            # Große Datenstruktur erstellen
            data = [i for i in range(100000)]
            return sum(data)
        
        result = memory_intensive_function()
        assert result == sum(range(100000))
```


## Komplexe OOP-Strukturen testen

### Testen von Vererbungshierarchien

```python
# src/shapes.py - Beispiel einer komplexen OOP-Struktur
from abc import ABC, abstractmethod
import math
from typing import Protocol, runtime_checkable

@runtime_checkable
class Drawable(Protocol):
    """Protocol für zeichenbare Objekte."""
    def draw(self) -> str: ...
    def get_area(self) -> float: ...

class Shape(ABC):
    """Abstrakte Basisklasse für geometrische Formen."""
    
    def __init__(self, name: str):
        self.name = name
        self._created_at = None
    
    @abstractmethod
    def get_area(self) -> float:
        """Berechnet die Fläche der Form."""
        pass
    
    @abstractmethod  
    def get_perimeter(self) -> float:
        """Berechnet den Umfang der Form."""
        pass
    
    def draw(self) -> str:
        """Standard-Zeichenmethode."""
        return f"Drawing {self.name} with area {self.get_area():.2f}"
    
    def __str__(self) -> str:
        return f"{self.name}(area={self.get_area():.2f})"

class Circle(Shape):
    """Kreisklasse."""
    
    def __init__(self, radius: float):
        super().__init__(f"Circle(r={radius})")
        if radius <= 0:
            raise ValueError("Radius must be positive")
        self.radius = radius
    
    def get_area(self) -> float:
        return math.pi * self.radius ** 2
    
    def get_perimeter(self) -> float:
        return 2 * math.pi * self.radius

class Rectangle(Shape):
    """Rechteckklasse."""
    
    def __init__(self, width: float, height: float):
        super().__init__(f"Rectangle({width}x{height})")
        if width <= 0 or height <= 0:
            raise ValueError("Width and height must be positive")
        self.width = width
        self.height = height
    
    def get_area(self) -> float:
        return self.width * self.height
    
    def get_perimeter(self) -> float:
        return 2 * (self.width + self.height)

class ShapeCollection:
    """Sammlung von Formen mit erweiterten Operationen."""
    
    def __init__(self):
        self._shapes: list[Shape] = []
    
    def add_shape(self, shape: Shape) -> None:
        if not isinstance(shape, Shape):
            raise TypeError("Only Shape instances allowed")
        self._shapes.append(shape)
    
    def get_total_area(self) -> float:
        return sum(shape.get_area() for shape in self._shapes)
    
    def get_shapes_by_type(self, shape_type: type) -> list[Shape]:
        return [s for s in self._shapes if isinstance(s, shape_type)]
    
    def __len__(self) -> int:
        return len(self._shapes)
    
    def __iter__(self):
        return iter(self._shapes)
```


### Umfassende Tests für OOP-Strukturen

```python
# tests/test_shapes.py
import pytest
import math
from src.shapes import Shape, Circle, Rectangle, ShapeCollection, Drawable

class TestShapeInheritance:
    """Tests für die Shape-Vererbungshierarchie."""
    
    def test_abstract_shape_cannot_be_instantiated(self):
        """Abstrakte Basisklasse kann nicht instanziiert werden."""
        with pytest.raises(TypeError):
            Shape("test")
    
    def test_circle_implements_shape_interface(self):
        """Circle implementiert alle abstrakten Methoden."""
        circle = Circle(5.0)
        
        assert isinstance(circle, Shape)
        assert isinstance(circle, Drawable)  # Protocol checking
        assert hasattr(circle, 'get_area')
        assert hasattr(circle, 'get_perimeter')
        assert hasattr(circle, 'draw')

class TestCircle:
    """Umfassende Tests für Circle-Klasse."""
    
    @pytest.fixture
    def standard_circle(self):
        """Standard-Kreis für Tests."""
        return Circle(5.0)
    
    def test_circle_creation_valid_radius(self, standard_circle):
        """Gültiger Kreis wird korrekt erstellt."""
        assert standard_circle.radius == 5.0
        assert "Circle(r=5.0)" in standard_circle.name
    
    @pytest.mark.parametrize("invalid_radius", [-1, 0, -5.5])
    def test_circle_creation_invalid_radius(self, invalid_radius):
        """Ungültiger Radius wirft ValueError."""
        with pytest.raises(ValueError, match="Radius must be positive"):
            Circle(invalid_radius)
    
    def test_circle_area_calculation(self, standard_circle):
        """Flächenberechnung ist korrekt."""
        expected_area = math.pi * 25  # π * r²
        assert abs(standard_circle.get_area() - expected_area) < 1e-10
    
    def test_circle_perimeter_calculation(self, standard_circle):
        """Umfangsberechnung ist korrekt."""
        expected_perimeter = 2 * math.pi * 5  # 2πr
        assert abs(standard_circle.get_perimeter() - expected_perimeter) < 1e-10
    
    def test_circle_string_representation(self, standard_circle):
        """String-Darstellung enthält wichtige Informationen."""
        str_repr = str(standard_circle)
        assert "Circle" in str_repr
        assert "area=" in str_repr
        assert "78.54" in str_repr  # Approximierte Fläche

class TestPolymorphism:
    """Tests für polymorphes Verhalten."""
    
    @pytest.fixture
    def mixed_shapes(self):
        """Verschiedene Formen für Polymorphismus-Tests."""
        return [
            Circle(3.0),
            Rectangle(4.0, 5.0),
            Circle(2.0),
            Rectangle(3.0, 3.0)
        ]
    
    def test_polymorphic_area_calculation(self, mixed_shapes):
        """Polymorphe Flächenberechnung funktioniert."""
        areas = [shape.get_area() for shape in mixed_shapes]
        
        # Erwartete Flächen: π*9, 20, π*4, 9
        expected = [
            math.pi * 9,   # Circle(3)
            20.0,          # Rectangle(4x5)
            math.pi * 4,   # Circle(2)
            9.0            # Rectangle(3x3)
        ]
        
        for actual, exp in zip(areas, expected):
            assert abs(actual - exp) < 1e-10
    
    def test_polymorphic_drawing(self, mixed_shapes):
        """Polymorphes Zeichnen funktioniert."""
        drawings = [shape.draw() for shape in mixed_shapes]
        
        for drawing in drawings:
            assert "Drawing" in drawing
            assert "area" in drawing

class TestShapeCollection:
    """Tests für die ShapeCollection-Klasse."""
    
    @pytest.fixture
    def collection(self):
        """Leere Sammlung für Tests."""
        return ShapeCollection()
    
    @pytest.fixture
    def filled_collection(self):
        """Gefüllte Sammlung für Tests."""
        collection = ShapeCollection()
        collection.add_shape(Circle(1.0))
        collection.add_shape(Rectangle(2.0, 3.0))
        collection.add_shape(Circle(2.0))
        return collection
    
    def test_empty_collection(self, collection):
        """Leere Sammlung verhält sich korrekt."""
        assert len(collection) == 0
        assert collection.get_total_area() == 0.0
        assert list(collection) == []
    
    def test_add_valid_shapes(self, collection):
        """Gültige Formen werden hinzugefügt."""
        circle = Circle(1.0)
        rectangle = Rectangle(2.0, 3.0)
        
        collection.add_shape(circle)
        collection.add_shape(rectangle)
        
        assert len(collection) == 2
        assert circle in collection
        assert rectangle in collection
    
    def test_add_invalid_object_raises_error(self, collection):
        """Ungültige Objekte werden abgelehnt."""
        with pytest.raises(TypeError, match="Only Shape instances allowed"):
            collection.add_shape("not a shape")
    
    def test_total_area_calculation(self, filled_collection):
        """Gesamtfläche wird korrekt berechnet."""
        # Circle(1): π*1² = π
        # Rectangle(2x3): 6
        # Circle(2): π*2² = 4π
        # Total: π + 6 + 4π = 5π + 6
        expected = 5 * math.pi + 6
        actual = filled_collection.get_total_area()
        assert abs(actual - expected) < 1e-10
    
    def test_filter_shapes_by_type(self, filled_collection):
        """Filterung nach Typ funktioniert."""
        circles = filled_collection.get_shapes_by_type(Circle)
        rectangles = filled_collection.get_shapes_by_type(Rectangle)
        
        assert len(circles) == 2
        assert len(rectangles) == 1
        assert all(isinstance(s, Circle) for s in circles)
        assert all(isinstance(s, Rectangle) for s in rectangles)
    
    def test_collection_iteration(self, filled_collection):
        """Iteration über Sammlung funktioniert."""
        shape_types = [type(shape).__name__ for shape in filled_collection]
        assert shape_types == ['Circle', 'Rectangle', 'Circle']
```


### Testen von Decorator-Patterns und Mixins

```python
# src/decorators.py
from functools import wraps
from typing import Callable, Any
import time
import logging

class TimingMixin:
    """Mixin für Zeitmessungen."""
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._timings = {}
    
    def time_method(self, method_name: str):
        """Decorator für Zeitmessung von Methoden."""
        def decorator(func: Callable) -> Callable:
            @wraps(func)
            def wrapper(*args, **kwargs):
                start = time.time()
                result = func(*args, **kwargs)
                elapsed = time.time() - start
                self._timings[method_name] = elapsed
                return result
            return wrapper
        return decorator
    
    def get_timing(self, method_name: str) -> float:
        return self._timings.get(method_name, 0.0)

class CachingMixin:
    """Mixin für Ergebniscaching."""
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._cache = {}
    
    def cached_method(self, cache_key: str):
        """Decorator für Ergebnis-Caching."""
        def decorator(func: Callable) -> Callable:
            @wraps(func)
            def wrapper(*args, **kwargs):
                if cache_key not in self._cache:
                    self._cache[cache_key] = func(*args, **kwargs)
                return self._cache[cache_key]
            return wrapper
        return decorator
    
    def clear_cache(self, key: str = None):
        if key:
            self._cache.pop(key, None)
        else:
            self._cache.clear()

class AdvancedCircle(Circle, TimingMixin, CachingMixin):
    """Erweiterte Circle-Klasse mit Mixins."""
    
    def __init__(self, radius: float):
        super().__init__(radius)
        
        # Decoriere Methoden zur Laufzeit
        self.get_area = self.time_method('get_area')(
            self.cached_method('area')(self.get_area)
        )
```


### Tests für Mixin-Strukturen

```python
# tests/test_mixins.py
import pytest
import time
from src.decorators import TimingMixin, CachingMixin, AdvancedCircle

class TestTimingMixin:
    """Tests für TimingMixin."""
    
    def test_timing_functionality(self):
        """Zeitmessung funktioniert korrekt."""
        circle = AdvancedCircle(5.0)
        
        # Erste Berechnung (sollte gemessen werden)
        area1 = circle.get_area()
        timing1 = circle.get_timing('get_area')
        
        assert timing1 > 0.0
        assert area1 > 0.0
        
        # Zweite Berechnung (aus Cache, neue Messung)  
        area2 = circle.get_area()
        timing2 = circle.get_timing('get_area')
        
        assert area1 == area2
        assert timing2 >= 0.0  # Kann 0 sein wegen Cache

class TestCachingMixin:
    """Tests für CachingMixin."""
    
    def test_caching_functionality(self):
        """Caching funktioniert korrekt."""
        circle = AdvancedCircle(5.0)
        
        # Erste Berechnung
        area1 = circle.get_area()
        
        # Cache leeren und Radius ändern (simuliert Änderung)
        circle.radius = 10.0  # Änderung ohne Cache-Invalidierung
        area2 = circle.get_area()  # Sollte gecachten Wert zurückgeben
        
        assert area1 == area2  # Cache verhindert Neuberechnung
        
        # Cache leeren
        circle.clear_cache('area')
        area3 = circle.get_area()  # Jetzt neue Berechnung
        
        assert area3 != area1  # Neue Berechnung mit radius=10
```


## TDD für Refactoring anwenden

### Red-Green-Refactor Cycle im Detail

Test-Driven Development (TDD) beim Refactoring bedeutet, dass wir zuerst umfassende Tests schreiben, dann den Code verbessern, ohne die Funktionalität zu ändern.

```python
# Beispiel: Refactoring einer Legacy-Klasse
# BEFORE (Legacy Code)
class LegacyDataProcessor:
    """Schlecht strukturierte Legacy-Klasse."""
    
    def __init__(self, data):
        self.data = data
        self.processed = False
        self.results = None
    
    def process_everything(self):
        """Monolithische Methode - macht alles."""
        if self.processed:
            return self.results
            
        # Validation
        if not self.data:
            raise ValueError("No data")
        if not isinstance(self.data, list):
            raise TypeError("Data must be list")
            
        # Processing
        filtered = []
        for item in self.data:
            if isinstance(item, (int, float)) and item > 0:
                filtered.append(item)
        
        # Calculations  
        total = sum(filtered)
        avg = total / len(filtered) if filtered else 0
        maximum = max(filtered) if filtered else 0
        minimum = min(filtered) if filtered else 0
        
        # Result formatting
        self.results = {
            'count': len(filtered),
            'sum': total,
            'average': avg,
            'max': maximum,
            'min': minimum,
            'processed_data': filtered
        }
        
        self.processed = True
        return self.results
```


### Schritt 1: Umfassende Tests für Legacy Code

```python
# tests/test_legacy_processor.py
import pytest
from src.legacy import LegacyDataProcessor

class TestLegacyDataProcessor:
    """Umfassende Tests vor dem Refactoring."""
    
    @pytest.fixture
    def valid_data(self):
        return [1, 2, 3, 4, 5, -1, 0, 3.5, 2.1]
    
    @pytest.fixture  
    def processor(self, valid_data):
        return LegacyDataProcessor(valid_data)
    
    def test_valid_processing(self, processor):
        """Test für normale Verarbeitung."""
        result = processor.process_everything()
        
        # Erwartete gefilterte Daten: [1, 2, 3, 4, 5, 3.5, 2.1]
        expected_filtered = [1, 2, 3, 4, 5, 3.5, 2.1]
        
        assert result['count'] == 7
        assert result['sum'] == sum(expected_filtered)
        assert result['average'] == sum(expected_filtered) / 7
        assert result['max'] == 5
        assert result['min'] == 1
        assert result['processed_data'] == expected_filtered
    
    def test_empty_data_raises_error(self):
        """Leere Daten werfen Fehler."""
        processor = LegacyDataProcessor([])
        with pytest.raises(ValueError, match="No data"):
            processor.process_everything()
    
    def test_none_data_raises_error(self):
        """None-Daten werfen Fehler."""
        processor = LegacyDataProcessor(None)
        with pytest.raises(ValueError, match="No data"):
            processor.process_everything()
    
    def test_wrong_type_raises_error(self):
        """Falscher Datentyp wirft Fehler."""
        processor = LegacyDataProcessor("not a list")
        with pytest.raises(TypeError, match="Data must be list"):
            processor.process_everything()
    
    def test_caching_behavior(self, processor):
        """Caching-Verhalten funktioniert."""
        result1 = processor.process_everything()
        result2 = processor.process_everything()
        
        assert result1 is result2  # Sollte dasselbe Objekt sein
        assert processor.processed is True
    
    def test_only_positive_numbers_processed(self):
        """Nur positive Zahlen werden verarbeitet."""
        data = [-5, -1, 0, 1, 2, 3]
        processor = LegacyDataProcessor(data)
        result = processor.process_everything()
        
        assert result['processed_data'] == [1, 2, 3]
        assert result['count'] == 3
    
    def test_mixed_types_filtered_correctly(self):
        """Gemischte Typen werden korrekt gefiltert."""
        data = [1, "string", 2.5, None, 3, [1, 2], 4.0]
        processor = LegacyDataProcessor(data)
        result = processor.process_everything()
        
        assert result['processed_data'] == [1, 2.5, 3, 4.0]
        assert result['count'] == 4
```


### Schritt 2: Refactoring mit TDD

```python
# src/refactored_processor.py - AFTER (Refactored Code)
from typing import List, Dict, Any, Union
from dataclasses import dataclass
from abc import ABC, abstractmethod

@dataclass
class ProcessingResult:
    """Ergebnis der Datenverarbeitung."""
    count: int
    sum: float
    average: float
    max: float
    min: float
    processed_data: List[Union[int, float]]

class DataValidator:
    """Verantwortlich für Datenvalidierung."""
    
    @staticmethod
    def validate(data: Any) -> None:
        if not data:
            raise ValueError("No data")
        if not isinstance(data, list):
            raise TypeError("Data must be list")

class DataFilter:
    """Verantwortlich für Datenfilterung."""
    
    @staticmethod
    def filter_positive_numbers(data: List[Any]) -> List[Union[int, float]]:
        """Filtert positive Zahlen aus den Daten."""
        return [
            item for item in data 
            if isinstance(item, (int, float)) and item > 0
        ]

class StatisticsCalculator:
    """Verantwortlich für statistische Berechnungen."""
    
    @staticmethod
    def calculate(data: List[Union[int, float]]) -> Dict[str, float]:
        """Berechnet Statistiken für die Daten."""
        if not data:
            return {'sum': 0, 'average': 0, 'max': 0, 'min': 0}
        
        total = sum(data)
        return {
            'sum': total,
            'average': total / len(data),
            'max': max(data),
            'min': min(data)
        }

class RefactoredDataProcessor:
    """Refactored Data Processor mit klarer Trennung der Verantwortlichkeiten."""
    
    def __init__(self, data: List[Any]):
        self._data = data
        self._validator = DataValidator()
        self._filter = DataFilter()
        self._calculator = StatisticsCalculator()
        self._result: ProcessingResult = None
        self._processed = False
    
    def process(self) -> ProcessingResult:
        """Hauptmethode für die Datenverarbeitung."""
        if self._processed:
            return self._result
        
        # Validierung
        self._validator.validate(self._data)
        
        # Filterung
        filtered_data = self._filter.filter_positive_numbers(self._data)
        
        # Berechnung
        stats = self._calculator.calculate(filtered_data)
        
        # Ergebnis erstellen
        self._result = ProcessingResult(
            count=len(filtered_data),
            sum=stats['sum'],
            average=stats['average'],
            max=stats['max'],
            min=stats['min'],
            processed_data=filtered_data
        )
        
        self._processed = True
        return self._result
    
    @property
    def is_processed(self) -> bool:
        return self._processed
    
    def reset(self) -> None:
        """Setzt den Processor zurück."""
        self._result = None
        self._processed = False
```


### Schritt 3: Tests für refactored Code

```python
# tests/test_refactored_processor.py
import pytest
from src.refactored_processor import (
    RefactoredDataProcessor, DataValidator, DataFilter, 
    StatisticsCalculator, ProcessingResult
)

class TestDataValidator:
    """Tests für die DataValidator-Klasse."""
    
    def test_valid_data_passes(self):
        """Gültige Daten passieren die Validierung."""
        DataValidator.validate([1, 2, 3])  # Sollte nicht werfen
    
    def test_empty_list_raises_error(self):
        with pytest.raises(ValueError, match="No data"):
            DataValidator.validate([])
    
    def test_none_raises_error(self):
        with pytest.raises(ValueError, match="No data"):
            DataValidator.validate(None)
    
    def test_wrong_type_raises_error(self):
        with pytest.raises(TypeError, match="Data must be list"):
            DataValidator.validate("not a list")

class TestDataFilter:
    """Tests für die DataFilter-Klasse."""
    
    def test_filter_positive_numbers(self):
        """Positive Zahlen werden korrekt gefiltert."""
        data = [-1, 0, 1, 2.5, "string", 3, None]
        result = DataFilter.filter_positive_numbers(data)
        assert result == [1, 2.5, 3]
    
    def test_empty_list_returns_empty(self):
        """Leere Liste gibt leere Liste zurück."""
        result = DataFilter.filter_positive_numbers([])
        assert result == []
    
    def test_no_valid_numbers_returns_empty(self):
        """Liste ohne gültige Zahlen gibt leere Liste zurück."""
        data = [-1, 0, "string", None, [1, 2]]
        result = DataFilter.filter_positive_numbers(data)
        assert result == []

class TestStatisticsCalculator:
    """Tests für die StatisticsCalculator-Klasse."""
    
    def test_calculate_with_data(self):
        """Berechnung mit Daten funktioniert."""
        data = [1, 2, 3, 4, 5]
        result = StatisticsCalculator.calculate(data)
        
        assert result['sum'] == 15
        assert result['average'] == 3.0
        assert result['max'] == 5
        assert result['min'] == 1
    
    def test_calculate_empty_data(self):
        """Berechnung mit leeren Daten gibt Nullwerte."""
        result = StatisticsCalculator.calculate([])
        
        assert result['sum'] == 0
        assert result['average'] == 0
        assert result['max'] == 0
        assert result['min'] == 0

class TestRefactoredDataProcessor:
    """Tests für den refactored Processor."""
    
    @pytest.fixture
    def valid_data(self):
        return [1, 2, 3, 4, 5, -1, 0, 3.5, 2.1]
    
    @pytest.fixture
    def processor(self, valid_data):
        return RefactoredDataProcessor(valid_data)
    
    def test_processing_equivalence_to_legacy(self, processor):
        """Ergebnis ist äquivalent zum Legacy-System."""
        result = processor.process()
        
        # Erwartete gefilterte Daten: [1, 2, 3, 4, 5, 3.5, 2.1]
        expected_filtered = [1, 2, 3, 4, 5, 3.5, 2.1]
        
        assert result.count == 7
        assert result.sum == sum(expected_filtered)
        assert result.average == sum(expected_filtered) / 7
        assert result.max == 5
        assert result.min == 1
        assert result.processed_data == expected_filtered
    
    def test_result_is_dataclass(self, processor):
        """Ergebnis ist ein ordentlicher Dataclass."""
        result = processor.process()
        assert isinstance(result, ProcessingResult)
        assert hasattr(result, 'count')
        assert hasattr(result, 'sum')
        assert hasattr(result, 'average')
    
    def test_immutable_caching_behavior(self, processor):
        """Caching-Verhalten ist konsistent."""
        result1 = processor.process()
        result2 = processor.process()
        
        assert result1 is result2
        assert processor.is_processed is True
    
    def test_reset_functionality(self, processor):
        """Reset-Funktionalität funktioniert."""
        processor.process()
        assert processor.is_processed is True
        
        processor.reset()
        assert processor.is_processed is False

class TestRefactoringRegressionSuite:
    """Regression-Tests zum Vergleich Legacy vs. Refactored."""
    
    @pytest.mark.parametrize("test_data", [
        [1, 2, 3, 4, 5],
        [-1, 0, 1, 2, 3],
        [1.5, 2.7, -3.2, 4.1],
        [1, "string", 2, None, 3],
        list(range(-10, 10)),
        [100, 200, 300, 400, 500]
    ])
    def test_legacy_vs_refactored_equivalence(self, test_data):
        """Refactored Code erzeugt identische Ergebnisse wie Legacy Code."""
        from src.legacy import LegacyDataProcessor
        
        # Legacy-Verarbeitung
        legacy_processor = LegacyDataProcessor(test_data.copy())
        legacy_result = legacy_processor.process_everything()
        
        # Refactored-Verarbeitung  
        refactored_processor = RefactoredDataProcessor(test_data.copy())
        refactored_result = refactored_processor.process()
        
        # Vergleich aller Felder
        assert refactored_result.count == legacy_result['count']
        assert refactored_result.sum == legacy_result['sum']
        assert refactored_result.average == legacy_result['average']
        assert refactored_result.max == legacy_result['max']
        assert refactored_result.min == legacy_result['min']
        assert refactored_result.processed_data == legacy_result['processed_data']
```


## Property-Based Testing mit Hypothesis

Für wirklich robuste Tests verwenden wir Property-Based Testing:

```python
# tests/test_property_based.py
import pytest
from hypothesis import given, strategies as st, assume
from src.refactored_processor import RefactoredDataProcessor

class TestPropertyBasedProcessor:
    """Property-Based Tests für den Data Processor."""
    
    @given(st.lists(st.integers(), min_size=1))
    def test_count_never_exceeds_input_length(self, data):
        """Die Anzahl verarbeiteter Elemente überschreitet nie die Eingabelänge."""
        processor = RefactoredDataProcessor(data)
        result = processor.process()
        assert result.count <= len(data)
    
    @given(st.lists(st.integers(min_value=1), min_size=1))
    def test_with_only_positive_integers_count_equals_length(self, positive_data):
        """Bei nur positiven Zahlen entspricht Count der Eingabelänge."""
        processor = RefactoredDataProcessor(positive_data)
        result = processor.process()
        assert result.count == len(positive_data)
        assert result.processed_data == positive_data
    
    @given(st.lists(st.one_of(st.integers(max_value=0), st.text(), st.none())))
    def test_no_positive_numbers_gives_zero_result(self, non_positive_data):
        """Ohne positive Zahlen sind alle Statistiken null."""
        assume(len(non_positive_data) > 0)  # Vermeidet leere Listen
        
        processor = RefactoredDataProcessor(non_positive_data)
        result = processor.process()
        
        assert result.count == 0
        assert result.sum == 0
        assert result.average == 0
        assert result.max == 0
        assert result.min == 0
        assert result.processed_data == []
    
    @given(st.lists(st.floats(min_value=0.1, max_value=1000.0), min_size=2))
    def test_average_is_between_min_and_max(self, float_data):
        """Der Durchschnitt liegt immer zwischen Min und Max."""
        processor = RefactoredDataProcessor(float_data)
        result = processor.process()
        
        if result.count > 0:
            assert result.min <= result.average <= result.max
```


## Test Doubles: Mocks, Stubs und Fakes

```python
# src/external_services.py - Services die gemockt werden müssen
import requests
from typing import Dict, Any
import time

class DatabaseService:
    """Service für Datenbankoperationen."""
    
    def __init__(self, connection_string: str):
        self.connection_string = connection_string
        self.connected = False
    
    def connect(self) -> None:
        # Simuliert Datenbankverbindung
        time.sleep(0.1)
        self.connected = True
    
    def save_data(self, data: Dict[str, Any]) -> str:
        if not self.connected:
            raise RuntimeError("Not connected to database")
        # Simuliert Datenspeicherung
        time.sleep(0.05)
        return f"saved_id_{hash(str(data))}"
    
    def disconnect(self) -> None:
        self.connected = False

class EmailService:
    """Service für E-Mail-Versendung."""
    
    def __init__(self, smtp_host: str, port: int):
        self.smtp_host = smtp_host
        self.port = port
    
    def send_email(self, to: str, subject: str, body: str) -> bool:
        # Simuliert E-Mail-Versendung über echten SMTP
        response = requests.post(f"http://{self.smtp_host}:{self.port}/send", 
                                json={'to': to, 'subject': subject, 'body': body})
        return response.status_code == 200

class ReportGenerator:
    """Generiert Reports und sendet sie per E-Mail."""
    
    def __init__(self, db_service: DatabaseService, email_service: EmailService):
        self.db_service = db_service
        self.email_service = email_service
    
    def generate_and_send_report(self, data: Dict[str, Any], recipient: str) -> Dict[str, Any]:
        """Generiert Report, speichert in DB und sendet per E-Mail."""
        # Report-Daten verarbeiten
        report_data = {
            'timestamp': time.time(),
            'data': data,
            'summary': f"Processed {len(data)} items"
        }
        
        # In Datenbank speichern
        saved_id = self.db_service.save_data(report_data)
        
        # E-Mail-Body erstellen
        email_body = f"""
        Report generated successfully!
        Report ID: {saved_id}
        Summary: {report_data['summary']}
        """
        
        # E-Mail senden
        email_sent = self.email_service.send_email(
            to=recipient,
            subject="Daily Report",
            body=email_body
        )
        
        return {
            'report_id': saved_id,
            'email_sent': email_sent,
            'timestamp': report_data['timestamp']
        }
```


### Umfassende Mock-Tests

```python
# tests/test_mocking.py
import pytest
from unittest.mock import Mock, patch, MagicMock, call
import time
from src.external_services import DatabaseService, EmailService, ReportGenerator

class TestDatabaseServiceMocking:
    """Tests mit Mocking für DatabaseService."""
    
    def test_database_connection_with_mock(self):
        """Datenbank-Verbindung mit Mock."""
        db_service = DatabaseService("mock://connection")
        
        # Originalmethode mocken um Zeit zu sparen
        with patch.object(db_service, 'connect') as mock_connect:
            db_service.connect()
            mock_connect.assert_called_once()
    
    @patch('time.sleep')  # time.sleep mocken für schnelle Tests
    def test_save_data_timing(self, mock_sleep):
        """Test ohne echte Wartezeiten."""
        db_service = DatabaseService("test://db")
        db_service.connected = True  # Direktes Setzen für Test
        
        result = db_service.save_data({'key': 'value'})
        
        assert result.startswith('saved_id_')
        mock_sleep.assert_called_once_with(0.05)

class TestEmailServiceMocking:
    """Tests mit Mocking für EmailService."""
    
    @patch('src.external_services.requests.post')
    def test_successful_email_sending(self, mock_post):
        """Erfolgreiche E-Mail-Versendung mocken."""
        # Mock-Response konfigurieren
        mock_response = Mock()
        mock_response.status_code = 200
        mock_post.return_value = mock_response
        
        email_service = EmailService("smtp.example.com", 587)
        result = email_service.send_email("test@example.com", "Test", "Body")
        
        assert result is True
        mock_post.assert_called_once_with(
            "http://smtp.example.com:587/send",
            json={'to': "test@example.com", 'subject': "Test", 'body': "Body"}
        )
    
    @patch('src.external_services.requests.post')
    def test_failed_email_sending(self, mock_post):
        """Fehlgeschlagene E-Mail-Versendung mocken."""
        mock_response = Mock()
        mock_response.status_code = 500
        mock_post.return_value = mock_response
        
        email_service = EmailService("smtp.example.com", 587)
        result = email_service.send_email("test@example.com", "Test", "Body")
        
        assert result is False

class TestReportGeneratorWithMocks:
    """Komplexe Tests mit mehreren Mocks."""
    
    @pytest.fixture
    def mock_services(self):
        """Mock-Services für Tests."""
        mock_db = Mock(spec=DatabaseService)
        mock_email = Mock(spec=EmailService)
        return mock_db, mock_email
    
    def test_successful_report_generation(self, mock_services):
        """Erfolgreiche Report-Generierung mit Mocks."""
        mock_db, mock_email = mock_services
        
        # Mock-Verhalten konfigurieren
        mock_db.save_data.return_value = "report_12345"
        mock_email.send_email.return_value = True
        
        generator = ReportGenerator(mock_db, mock_email)
        
        with patch('time.time', return_value=1234567890.0):
            result = generator.generate_and_send_report(
                {'item1': 'data1', 'item2': 'data2'},
                'recipient@example.com'
            )
        
        # Assertions für Ergebnis
        assert result['report_id'] == "report_12345"
        assert result['email_sent'] is True
        assert result['timestamp'] == 1234567890.0
        
        # Verifikation der Mock-Aufrufe
        mock_db.save_data.assert_called_once()
        mock_email.send_email.assert_called_once_with(
            to='recipient@example.com',
            subject='Daily Report',
            body=mock_email.send_email.call_args[^1]['body']
        )
        
        # Detaillierte Argument-Prüfung
        call_args = mock_db.save_data.call_args[^0][^0]
        assert 'timestamp' in call_args
        assert call_args['data'] == {'item1': 'data1', 'item2': 'data2'}
        assert call_args['summary'] == "Processed 2 items"
    
    def test_database_failure_handling(self, mock_services):
        """Handling von Datenbankfehlern."""
        mock_db, mock_email = mock_services
        
        # Datenbank-Fehler simulieren
        mock_db.save_data.side_effect = RuntimeError("Database connection failed")
        
        generator = ReportGenerator(mock_db, mock_email)
        
        with pytest.raises(RuntimeError, match="Database connection failed"):
            generator.generate_and_send_report({'key': 'value'}, 'test@example.com')
        
        # E-Mail sollte nicht gesendet werden bei DB-Fehler
        mock_email.send_email.assert_not_called()
    
    def test_email_failure_still_returns_report_id(self, mock_services):
        """E-Mail-Fehler verhindert nicht Report-Speicherung."""
        mock_db, mock_email = mock_services
        
        mock_db.save_data.return_value = "report_67890"
        mock_email.send_email.return_value = False  # E-Mail-Fehler
        
        generator = ReportGenerator(mock_db, mock_email)
        
        with patch('time.time', return_value=1234567890.0):
            result = generator.generate_and_send_report({'key': 'value'}, 'test@example.com')
        
        # Report wurde trotzdem gespeichert
        assert result['report_id'] == "report_67890"
        assert result['email_sent'] is False
        assert result['timestamp'] == 1234567890.0

class TestAdvancedMockingTechniques:
    """Fortgeschrittene Mocking-Techniken."""
    
    def test_context_manager_mocking(self):
        """Mocking von Context Managern."""
        with patch('builtins.open', mock_open(read_data="test content")) as mock_file:
            with open('dummy_file.txt', 'r') as f:
                content = f.read()
            
            assert content == "test content"
            mock_file.assert_called_once_with('dummy_file.txt', 'r')
    
    def test_property_mocking(self):
        """Mocking von Properties."""
        db_service = DatabaseService("test://db")
        
        with patch.object(DatabaseService, 'connected', new_callable=PropertyMock) as mock_prop:
            mock_prop.return_value = True
            assert db_service.connected is True
            mock_prop.assert_called_once()
    
    def test_side_effect_sequences(self, mock_services):
        """Verschiedene Rückgabewerte bei mehreren Aufrufen."""
        mock_db, _ = mock_services
        
        # Erste Speicherung erfolgreich, zweite fehlschlägt
        mock_db.save_data.side_effect = ["success_1", RuntimeError("DB full")]
        
        generator = ReportGenerator(mock_db, Mock())
        
        # Erster Aufruf erfolgreich
        mock_db.save_data({'test1': 'data1'})
        
        # Zweiter Aufruf wirft Exception
        with pytest.raises(RuntimeError, match="DB full"):
            mock_db.save_data({'test2': 'data2'})
```


## Performance Testing und Profiling

```python
# tests/test_performance.py
import pytest
import time
import cProfile
import pstats
from memory_profiler import profile
import psutil
import os
from src.refactored_processor import RefactoredDataProcessor

class TestPerformanceMetrics:
    """Performance-Tests für den Data Processor."""
    
    @pytest.mark.slow
    def test_processing_speed_large_dataset(self):
        """Test der Verarbeitungsgeschwindigkeit bei großen Datenmengen."""
        # Große Datenmenge erstellen
        large_data = list(range(-50000, 50000))  # 100,000 Elemente
        
        processor = RefactoredDataProcessor(large_data)
        
        start_time = time.time()
        result = processor.process()
        end_time = time.time()
        
        processing_time = end_time - start_time
        
        # Performance-Assertions
        assert processing_time < 1.0, f"Processing took too long: {processing_time:.2f}s"
        assert result.count == 49999  # Positive Zahlen: 1 bis 49999
        
        print(f"Processed {len(large_data)} items in {processing_time:.3f} seconds")
        print(f"Throughput: {len(large_data)/processing_time:.0f} items/second")
    
    @pytest.mark.slow
    def test_memory_usage_profiling(self):
        """Memory-Profiling für den Processor."""
        import tracemalloc
        
        # Memory-Tracking starten
        tracemalloc.start()
        
        # Große Datenmenge verarbeiten
        data = list(range(100000))
        processor = RefactoredDataProcessor(data)
        result = processor.process()
        
        # Memory-Usage messen
        current, peak = tracemalloc.get_traced_memory()
        tracemalloc.stop()
        
        # Memory-Assertions
        assert peak < 50 * 1024 * 1024, f"Peak memory usage too high: {peak/1024/1024:.1f}MB"
        
        print(f"Current memory: {current/1024/1024:.1f} MB")
        print(f"Peak memory: {peak/1024/1024:.1f} MB")
    
    def test_cpu_profiling(self):
        """CPU-Profiling für Hotspot-Identifikation."""
        data = list(range(10000))
        processor = RefactoredDataProcessor(data)
        
        # Profiling durchführen
        profiler = cProfile.Profile()
        profiler.enable()
        
        # Mehrere Durchläufe für aussagekräftige Daten
        for _ in range(10):
            processor.reset()
            processor.process()
        
        profiler.disable()
        
        # Profiling-Ergebnisse analysieren
        stats = pstats.Stats(profiler)
        stats.sort_stats('cumulative')
        
        # Top-Funktionen anzeigen (für Debugging)
        print("\nTop 10 CPU-intensive functions:")
        stats.print_stats(10)
        
        # Sicherstellen, dass keine offensichtlich ineffizienten Funktionen da sind
        for func_name, func_stats in stats.stats.items():
            if 'filter_positive_numbers' in str(func_name):
                # Diese Funktion sollte nicht zu oft aufgerufen werden
                calls = func_stats[^0]
                assert calls <= 100, f"filter_positive_numbers called {calls} times - too many!"

class TestConcurrentPerformance:
    """Performance-Tests für parallele Verarbeitung."""
    
    @pytest.mark.slow
    def test_concurrent_processing(self):
        """Test der Performance bei paralleler Verarbeitung."""
        import concurrent.futures
        import threading
        
        def process_data_chunk(data_chunk):
            processor = RefactoredDataProcessor(data_chunk)
            return processor.process()
        
        # Daten in Chunks aufteilen
        full_data = list(range(100000))
        chunk_size = 10000
        chunks = [full_data[i:i+chunk_size] for i in range(0, len(full_data), chunk_size)]
        
        # Sequential processing
        start_sequential = time.time()
        sequential_results = [process_data_chunk(chunk) for chunk in chunks]
        sequential_time = time.time() - start_sequential
        
        # Concurrent processing
        start_concurrent = time.time()
        with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
            concurrent_results = list(executor.map(process_data_chunk, chunks))
        concurrent_time = time.time() - start_concurrent
        
        # Performance-Vergleich
        speedup = sequential_time / concurrent_time
        print(f"Sequential time: {sequential_time:.3f}s")
        print(f"Concurrent time: {concurrent_time:.3f}s")
        print(f"Speedup: {speedup:.2f}x")
        
        # Ergebnisse sollten identisch sein
        assert len(sequential_results) == len(concurrent_results)
        for seq_result, conc_result in zip(sequential_results, concurrent_results):
            assert seq_result.count == conc_result.count
            assert abs(seq_result.sum - conc_result.sum) < 1e-10

@pytest.mark.benchmark
class TestBenchmarking:
    """Benchmark-Tests mit pytest-benchmark."""
    
    def test_small_dataset_benchmark(self, benchmark):
        """Benchmark für kleine Datenmengen."""
        data = list(range(1000))
        processor = RefactoredDataProcessor(data)
        
        # Benchmark durchführen
        result = benchmark(processor.process)
        
        assert result.count == 999  # 1 bis 999
    
    def test_medium_dataset_benchmark(self, benchmark):
        """Benchmark für mittlere Datenmengen."""
        data = list(range(10000))
        
        def process_data():
            processor = RefactoredDataProcessor(data)
            return processor.process()
        
        result = benchmark(process_data)
        assert result.count == 9999
    
    @pytest.mark.parametrize("data_size", [100, 1000, 10000])
    def test_scaling_benchmark(self, benchmark, data_size):
        """Benchmark für verschiedene Datengrößen."""
        data = list(range(data_size))
        
        def process_data():
            processor = RefactoredDataProcessor(data)
            return processor.process()
        
        result = benchmark(process_data)
        assert result.count == data_size - 1  # Positive Zahlen: 1 bis data_size-1
```


## Test-Driven Documentation

```python
# tests/test_documentation.py
import pytest
import doctest
import inspect
from src.refactored_processor import (
    RefactoredDataProcessor, DataValidator, DataFilter, StatisticsCalculator
)

class TestDocstrings:
    """Tests für Code-Dokumentation."""
    
    def test_all_classes_have_docstrings(self):
        """Alle Klassen haben Docstrings."""
        classes = [RefactoredDataProcessor, DataValidator, DataFilter, StatisticsCalculator]
        
        for cls in classes:
            assert cls.__doc__ is not None, f"{cls.__name__} has no docstring"
            assert len(cls.__doc__.strip()) > 10, f"{cls.__name__} docstring too short"
    
    def test_all_public_methods_have_docstrings(self):
        """Alle öffentlichen Methoden haben Docstrings."""
        classes = [RefactoredDataProcessor, DataValidator, DataFilter, StatisticsCalculator]
        
        for cls in classes:
            for name, method in inspect.getmembers(cls, predicate=inspect.isfunction):
                if not name.startswith('_'):  # Nur öffentliche Methoden
                    assert method.__doc__ is not None, f"{cls.__name__}.{name} has no docstring"
    
    def test_docstring_examples_work(self):
        """Docstring-Beispiele funktionieren (Doctest)."""
        # Doctest für alle Module ausführen
        import src.refactored_processor
        
        doctest_results = doctest.testmod(src.refactored_processor, verbose=True)
        assert doctest_results.failed == 0, f"{doctest_results.failed} doctest failures"

class TestTypeHints:
    """Tests für Type Hints."""
    
    def test_all_methods_have_type_hints(self):
        """Alle Methoden haben Type Hints."""
        from typing import get_type_hints
        
        classes = [RefactoredDataProcessor, DataValidator, DataFilter, StatisticsCalculator]
        
        for cls in classes:
            for name, method in inspect.getmembers(cls, predicate=inspect.isfunction):
                if not name.startswith('_'):  # Nur öffentliche Methoden
                    hints = get_type_hints(method)
                    
                    # Return-Type prüfen
                    assert 'return' in hints, f"{cls.__name__}.{name} missing return type hint"
                    
                    # Parameter-Types prüfen (außer self)
                    sig = inspect.signature(method)
                    for param_name, param in sig.parameters.items():
                        if param_name != 'self':
                            assert param_name in hints, f"{cls.__name__}.{name} missing type hint for {param_name}"
```


## Abschluss und Best Practices

### Zusammenfassung der fortgeschrittenen Testing-Prinzipien

1. **CI-Integration** macht Tests zu einem automatischen Teil des Entwicklungsprozesses
2. **Komplexe OOP-Strukturen** erfordern strategisches Testing von Vererbung, Polymorphismus und Mixins
3. **TDD für Refactoring** gewährleistet, dass Verbesserungen die Funktionalität nicht beeinträchtigen
4. **Property-Based Testing** deckt Edge Cases auf, die traditionelle Tests übersehen
5. **Mocking und Test Doubles** ermöglichen isolierte Tests ohne externe Abhängigkeiten
6. **Performance Testing** stellt sicher, dass Code auch unter Last funktioniert

### Testing Pyramid für Python-Projekte

```python
# tests/test_integration_final.py
import pytest
from src.refactored_processor import RefactoredDataProcessor

class TestComprehensiveIntegration:
    """Comprehensive Integration Test Suite."""
    
    @pytest.mark.integration
    def test_full_workflow_integration(self):
        """End-to-End Test des gesamten Workflows."""
        # Verschiedene realistische Datenszenarien
        test_scenarios = [
            ([1, 2, 3, 4, 5], "normale positive Zahlen"),
            ([-5, -1, 0, 1, 2, 3], "gemischte Zahlen"),
            ([1.1, 2.2, 3.3, 4.4], "float-Zahlen"),
            ([1, "string", 2, None, 3, []], "gemischte Typen"),
            (list(range(1000)), "große Datenmenge")
        ]
        
        for data, description in test_scenarios:
            with pytest.subtest(description=description):
                processor = RefactoredDataProcessor(data)
                result = processor.process()
                
                # Grundlegende Invarianten prüfen
                assert result.count >= 0
                assert len(result.processed_data) == result.count
                
                if result.count > 0:
                    assert result.min <= result.average <= result.max
                    assert result.sum == sum(result.processed_data)
                    assert all(isinstance(x, (int, float)) and x > 0 
                             for x in result.processed_data)
                
                print(f"✓ {description}: {result.count} items processed")
```

Diese umfassende Einführung in Modul 35 zeigt, wie Unit Testing von einer einfachen Testpraxis zu einem mächtigen Werkzeug für Qualitätssicherung, Refactoring und kontinuierliche Integration wird. Die fortgeschrittenen Techniken ermöglichen es, auch komplexe Software-Architekturen zuverlässig zu testen und dabei sowohl funktionale als auch non-funktionale Anforderungen zu erfüllen.
<span style="display:none">[^10][^11][^12][^13][^2][^3][^4][^5][^6][^7][^8][^9]</span>

<div style="text-align: center">⁂</div>

[^1]: 00-Schwerpunkte-aller-Module.md

[^2]: 00-Python-to-Rust-Migration-Ein-umfassendes-Desktop-App-Projekt.md

[^3]: 01b-Py2Rust-README.md

[^4]: 03-Projekt-Christopher-PersonalPrinz.md

[^5]: 04a-Vorschlag-Klassenubersicht-KeyRecognition.md

[^6]: 01a-Vorschlag-Klassenubersicht-Py2Rust.md

[^7]: 01-Projekt-Fritz-Py2Rust.md

[^8]: 02a-Vorschlag-Klassenubersicht-WeiterWeiser.md

[^9]: 04-Projekt-Tristan-KeyRegognition.md

[^10]: 02-Projekt-Christian-WetterWeiser.md

[^11]: 03a-Vorschlag-Klassenubersicht-PersonalPrinz.md

[^12]: 04b-Key-Recognizer-README.md

[^13]: 02b-WetterWeiser-README.md


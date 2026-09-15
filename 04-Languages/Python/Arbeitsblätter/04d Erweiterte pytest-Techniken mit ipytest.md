## Inhaltsübersicht

### **1. Fixtures (Test-Setup und -Teardown)**

- **Einfache Fixtures** für Testdaten
- **Setup/Teardown** mit `yield` für Ressourcen-Management
- **Fixture Scopes** (function, class, module, session)


### **2. Mocking - Abhängigkeiten simulieren**

- **Einfache Mock-Objekte** für isoliertes Testen
- **Patch-Dekorator** für automatisches Mocking
- **Seiteneffekte** (`side_effect`) für komplexe Szenarien


### **3. Erweiterte Parametrisierung**

- **Mehrere Parameter kombinieren** (kartesisches Produkt)
- **Beschreibende IDs** für bessere Lesbarkeit
- **Fixture-Parametrisierung** für verschiedene Konfigurationen


### **4. Pytest Marks - Tests organisieren**

- **Kategorisierung** mit `@pytest.mark.slow`, `@pytest.mark.integration`
- **Selektive Ausführung** mit `-m` Optionen
- **Skip/xfail** für temporär deaktivierte Tests


### **5. Komplexe Anwendungsbeispiele**

- **UserService-Klasse** mit Abhängigkeiten (Database, EmailService)
- **Vollständiges Mocking** und Verifikation
- **Factory Fixtures** für flexible Objekterstellung


### **6. Fortgeschrittene Features**

- **Property-Based Testing** mit Hypothesis
- **Async/Await Testing** für asynchronen Code
- **Best Practices Zusammenfassung**

## Setup und Installation

```python
# Installation der benötigten Pakete
!pip install ipytest pytest-mock
```

Diese Zelle installiert ipytest für Jupyter-Integration und pytest-mock für erweiterte Mock-Funktionalität.

---

```python
import ipytest
import pytest
from unittest.mock import Mock, patch, MagicMock
import tempfile
import os
from pathlib import Path

ipytest.autoconfig()
```

Hier werden alle notwendigen Module importiert und ipytest für die Jupyter-Umgebung konfiguriert.

---

## 1. Fixtures - Test-Setup und -Teardown

### Einfache Fixtures

```python
@pytest.fixture
def sample_data():
    """Fixture liefert Beispieldaten für Tests"""
    return [1, 2, 3, 4, 5]

@pytest.fixture
def empty_list():
    """Fixture für leere Liste"""
    return []

def test_sample_data_fixture(sample_data):
    assert len(sample_data) == 5
    assert sum(sample_data) == 15

def test_empty_list_fixture(empty_list):
    assert len(empty_list) == 0
    assert not empty_list

ipytest.run()
```

Fixtures sind wiederverwendbare Test-Vorbereitungen. Sie werden als Parameter an Testfunktionen übergeben und können komplexe Objekte, Daten oder Zustände bereitstellen. pytest führt Fixtures automatisch aus, bevor der Test startet.

---

### Fixtures mit Setup/Teardown

```python
@pytest.fixture
def temp_file():
    """Fixture erstellt temporäre Datei und räumt sie auf"""
    # Setup: Temporäre Datei erstellen
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as f:
        f.write("Test content")
        temp_path = f.name
    
    yield temp_path  # Hier wird der Wert an den Test übergeben
    
    # Teardown: Datei löschen
    if os.path.exists(temp_path):
        os.unlink(temp_path)

def test_file_operations(temp_file):
    """Test arbeitet mit temporärer Datei"""
    assert os.path.exists(temp_file)
    
    with open(temp_file, 'r') as f:
        content = f.read()
    
    assert content == "Test content"

ipytest.run()
```

`yield` in Fixtures trennt Setup (vor yield) von Teardown (nach yield). Das ist perfekt für Ressourcen, die nach dem Test aufgeräumt werden müssen - wie Dateien, Datenbankverbindungen oder Netzwerk-Sockets.

---

### Fixture Scopes

```python
@pytest.fixture(scope="session")
def database_connection():
    """Session-weite Fixture - wird nur einmal erstellt"""
    return {"connection": "mock_db_connection", "status": "connected"}

@pytest.fixture(scope="function")  # Standard-Scope
def fresh_user():
    """Function-Scope: Neue Instanz für jeden Test"""
    return {"name": "TestUser", "id": 123, "active": True}

def test_database_fixture(database_connection):
    assert database_connection["status"] == "connected"

def test_user_fixture(fresh_user):
    fresh_user["active"] = False
    assert not fresh_user["active"]

def test_user_fixture_isolation(fresh_user):
    # fresh_user ist wieder neu, unabhängig vom vorherigen Test
    assert fresh_user["active"] == True

ipytest.run()
```

Fixture-Scopes bestimmen die Lebensdauer:
- function (Standard): Neue Instanz für jeden Test
- class: Eine Instanz für alle Tests einer Klasse
- module: Eine Instanz für alle Tests einer Datei
- session: Eine Instanz für die gesamte Test-Session

---

## 2. Mocking - Abhängigkeiten simulieren

### Einfache Mock-Objekte

```python
def send_email(recipient, subject, body):
    """Simuliert Email-Versand (in Realität würde hier ein API-Call stehen)"""
    # In echtem Code würde hier z.B. requests.post() aufgerufen
    print(f"Email an {recipient}: {subject}")
    return True

def register_user(username, email, email_service):
    """User registrieren und Welcome-Email senden"""
    user_id = f"user_{len(username)}"
    
    # Email über Service senden
    success = email_service.send_email(
        email, 
        "Willkommen!", 
        f"Hallo {username}, willkommen bei uns!"
    )
    
    if success:
        return user_id
    return None

def test_user_registration_with_mock():
    """Test mit Mock Email Service"""
    # Mock Email Service erstellen
    mock_email_service = Mock()
    mock_email_service.send_email.return_value = True
    
    # User registrieren
    user_id = register_user("testuser", "test@example.com", mock_email_service)
    
    # Assertions
    assert user_id == "user_8"  # len("testuser") = 8
    
    # Prüfen dass Mock aufgerufen wurde
    mock_email_service.send_email.assert_called_once_with(
        "test@example.com",
        "Willkommen!",
        "Hallo testuser, willkommen bei uns!"
    )

ipytest.run()
```

Mocks sind "Fake-Objekte" die echte Abhängigkeiten ersetzen. Sie ermöglichen es, Code isoliert zu testen ohne externe Services (APIs, Datenbanken, etc.) zu verwenden. Mit `assert_called_once_with()` können Sie prüfen, ob das Mock korrekt aufgerufen wurde.

---

### Patch-Dekorator für automatisches Mocking

```python
import datetime

def get_current_time():
    """Gibt aktuelle Zeit zurück"""
    return datetime.datetime.now()

def create_log_entry(message):
    """Erstellt Log-Eintrag mit Zeitstempel"""
    timestamp = get_current_time()
    return f"[{timestamp}] {message}"

@patch('__main__.get_current_time')
def test_log_entry_with_patch(mock_get_time):
    """Test mit gepatchter Zeit-Funktion"""
    # Mock-Zeit setzen
    fixed_time = datetime.datetime(2023, 1, 1, 12, 0, 0)
    mock_get_time.return_value = fixed_time
    
    # Funktion testen
    log_entry = create_log_entry("Test message")
    
    # Assertions
    assert log_entry == "[2023-01-01 12:00:00] Test message"
    mock_get_time.assert_called_once()

ipytest.run()
```

Der `@patch` Dekorator ersetzt automatisch Funktionen/Objekte durch Mocks. Das ist besonders nützlich für Funktionen wie `datetime.now()`, `random()` oder API-Calls, die Sie für deterministische Tests kontrollieren möchten.

---

### Mocking mit Seiteneffekten

```python
def divide_numbers(a, b):
    """Division mit Fehlerbehandlung"""
    if b == 0:
        raise ValueError("Division durch Null")
    return a / b

def safe_calculation(numbers, divisor, calculator_func):
    """Führt sichere Berechnungen durch"""
    results = []
    errors = []
    
    for num in numbers:
        try:
            result = calculator_func(num, divisor)
            results.append(result)
        except ValueError as e:
            errors.append(str(e))
    
    return results, errors

def test_safe_calculation_with_side_effects():
    """Test mit Mock der verschiedene Seiteneffekte hat"""
    mock_calculator = Mock()
    
    # Verschiedene Rückgabewerte und Exceptions
    mock_calculator.side_effect = [
        10.0,  # Erstes Call: Erfolg
        ValueError("Division durch Null"),  # Zweites Call: Exception
        5.0,   # Drittes Call: Erfolg
    ]
    
    results, errors = safe_calculation([20, 10, 15], 2, mock_calculator)
    
    assert results == [10.0, 5.0]
    assert errors == ["Division durch Null"]
    assert mock_calculator.call_count == 3

ipytest.run()
```

`side_effect` ermöglicht es, Mocks verschiedene Verhaltensweisen bei aufeinanderfolgenden Aufrufen zu geben. Das ist ideal für Tests, die verschiedene Szenarien (Erfolg, Fehler, etc.) in einer Funktion durchlaufen.

---

## 3. Parametrisierte Tests - Erweiterte Techniken

### Mehrere Parameter kombinieren

```python
@pytest.mark.parametrize("base,exponent,expected", [
    (2, 3, 8),
    (3, 2, 9),
    (5, 0, 1),
    (10, 1, 10),
    (-2, 2, 4),
])
@pytest.mark.parametrize("precision", [1, 2, 3])
def test_power_calculation_combinations(base, exponent, expected, precision):
    """Test Potenz-Berechnung mit verschiedenen Präzisionen"""
    result = round(base  exponent, precision)
    expected_rounded = round(expected, precision)
    assert result == expected_rounded

ipytest.run()
```

Mehrere `@pytest.mark.parametrize` Dekoratoren erstellen das kartesische Produkt aller Parameterkombinationen. Hier wird jede Potenz-Berechnung mit jeder Präzision getestet.

---

### Parametrisierung mit IDs für bessere Lesbarkeit

```python
def validate_email(email):
    """Einfache Email-Validierung"""
    if "@" not in email:
        return False
    if "." not in email:
        return False
    if len(email) < 5:
        return False
    return True

@pytest.mark.parametrize("email,expected", [
    ("test@example.com", True),
    ("user@domain.org", True),
    ("invalid.email", False),
    ("@domain.com", False),
    ("user@", False),
    ("ab@c", False),
], ids=[
    "valid_standard",
    "valid_org_domain", 
    "missing_at_symbol",
    "missing_username",
    "missing_domain",
    "too_short"
])
def test_email_validation(email, expected):
    """Test Email-Validierung mit beschreibenden IDs"""
    assert validate_email(email) == expected

ipytest.run()
```

Der `ids` Parameter gibt jedem Testfall einen beschreibenden Namen. Das macht Testergebnisse viel lesbarer und hilft bei der Fehlerdiagnose.

---

## 4. Fixture-Parametrisierung

```python
@pytest.fixture(params=[
    {"name": "SQLite", "connection": "sqlite:///:memory:"},
    {"name": "MySQL", "connection": "mysql://localhost/test"},
    {"name": "PostgreSQL", "connection": "postgresql://localhost/test"}
])
def database_config(request):
    """Parametrisierte Fixture für verschiedene Datenbanken"""
    return request.param

def test_database_connection(database_config):
    """Test läuft für jede Datenbank-Konfiguration"""
    assert "connection" in database_config
    assert database_config["name"] in ["SQLite", "MySQL", "PostgreSQL"]
    print(f"Testing with {database_config['name']}")

ipytest.run()
```

Parametrisierte Fixtures führen Tests mit verschiedenen Fixture-Werten aus. Jeder Test wird einmal pro Parameter-Wert ausgeführt. Das ist perfekt für Tests, die mit verschiedenen Konfigurationen laufen sollen.

---

## 5. Pytest Marks - Tests organisieren und steuern

```python
@pytest.mark.slow
def test_slow_operation():
    """Langsamer Test (simuliert durch sleep)"""
    import time
    time.sleep(0.1)  # Simuliert langsame Operation
    assert True

@pytest.mark.integration  
def test_api_integration():
    """Integration Test"""
    # Würde echten API-Call machen
    assert True

@pytest.mark.unit
def test_fast_unit_test():
    """Schneller Unit Test"""
    assert 2 + 2 == 4

@pytest.mark.skip(reason="Feature noch nicht implementiert")
def test_future_feature():
    """Test für zukünftige Implementierung"""
    assert False  # Würde fehlschlagen

@pytest.mark.xfail(reason="Bekannter Bug")
def test_known_bug():
    """Test für bekannten Bug"""
    assert 1 == 2  # Schlägt erwartungsgemäß fehl

# Nur bestimmte Tests ausführen
ipytest.run("-m", "unit")  # Nur Unit Tests
```

Marks kategorisieren Tests und ermöglichen selektive Ausführung:
- `@pytest.mark.slow` - Langsame Tests
- `@pytest.mark.skip` - Tests überspringen  
- `@pytest.mark.xfail` - Erwartetes Fehlschlagen
- Mit `-m "markname"` können Sie nur bestimmte Tests ausführen

---

## 6. Komplexes Beispiel: Testen einer Klasse mit Abhängigkeiten

```python
class Database:
    """Mock Database Interface"""
    def save(self, data):
        pass
    
    def find(self, id):
        pass

class EmailService:
    """Mock Email Service"""
    def send(self, recipient, subject, body):
        pass

class UserService:
    """Service für Benutzerverwaltung mit Abhängigkeiten"""
    
    def __init__(self, database, email_service):
        self.database = database
        self.email_service = email_service
        
    def create_user(self, username, email):
        """Benutzer erstellen und Welcome-Email senden"""
        user = {
            "id": f"user_{len(username)}",
            "username": username,
            "email": email,
            "active": True
        }
        
        # In Datenbank speichern
        self.database.save(user)
        
        # Welcome-Email senden
        self.email_service.send(
            email,
            "Willkommen!",
            f"Hallo {username}!"
        )
        
        return user
    
    def get_user(self, user_id):
        """Benutzer aus Datenbank laden"""
        return self.database.find(user_id)
```

Diese Klasse hat zwei Abhängigkeiten (Database, EmailService) die wir in Tests mocken müssen.

---

```python
@pytest.fixture
def mock_database():
    """Mock Database Fixture"""
    mock_db = Mock(spec=Database)
    return mock_db

@pytest.fixture  
def mock_email_service():
    """Mock Email Service Fixture"""
    mock_email = Mock(spec=EmailService)
    mock_email.send.return_value = True
    return mock_email

@pytest.fixture
def user_service(mock_database, mock_email_service):
    """UserService mit gemockten Abhängigkeiten"""
    return UserService(mock_database, mock_email_service)

def test_create_user_success(user_service, mock_database, mock_email_service):
    """Test erfolgreiche Benutzererstellung"""
    # Test ausführen
    user = user_service.create_user("alice", "alice@example.com")
    
    # Assertions
    assert user["username"] == "alice"
    assert user["email"] == "alice@example.com"
    assert user["active"] == True
    assert user["id"] == "user_5"  # len("alice") = 5
    
    # Prüfen dass Dependencies korrekt aufgerufen wurden
    mock_database.save.assert_called_once_with(user)
    mock_email_service.send.assert_called_once_with(
        "alice@example.com",
        "Willkommen!",
        "Hallo alice!"
    )

def test_get_user(user_service, mock_database):
    """Test Benutzer laden"""
    # Mock Return Value setzen
    expected_user = {"id": "user_123", "username": "bob"}
    mock_database.find.return_value = expected_user
    
    # Test ausführen
    result = user_service.get_user("user_123")
    
    # Assertions
    assert result == expected_user
    mock_database.find.assert_called_once_with("user_123")

ipytest.run()
```

Dieses Beispiel zeigt professionelles Testen einer Klasse mit Abhängigkeiten:
- Fixtures für Mocks und Service-Instanzen
- spec=Database stellt sicher, dass Mock die richtige Interface hat
- Vollständige Verifikation aller Mock-Aufrufe
- Isolation - jeder Test ist unabhängig

---

## 7. Property-Based Testing mit Hypothesis

```python
# Installation von hypothesis für Property-Based Testing
!pip install hypothesis
```

```python
from hypothesis import given, strategies as st

def reverse_string(s):
    """String umkehren"""
    return s[::-1]

@given(st.text())
def test_reverse_string_properties(s):
    """Property-Based Test: Umkehrung von Umkehrung ist Original"""
    reversed_twice = reverse_string(reverse_string(s))
    assert reversed_twice == s

@given(st.text())
def test_reverse_string_length(s):
    """Property: Länge bleibt gleich"""
    reversed_s = reverse_string(s)
    assert len(reversed_s) == len(s)

ipytest.run()
```

Property-Based Testing mit Hypothesis generiert automatisch viele verschiedene Eingabewerte und testet Eigenschaften (Properties) des Codes. Das findet oft Edge-Cases, an die Sie nicht gedacht hätten.

---

## 8. Fixtures mit konfigurierbaren Parametern

```python
@pytest.fixture
def user_factory():
    """Factory Fixture für User-Objekte"""
    def _create_user(name="testuser", email=None, active=True):
        if email is None:
            email = f"{name}@example.com"
        return {
            "name": name,
            "email": email,
            "active": active,
            "id": f"user_{len(name)}"
        }
    return _create_user

def test_user_factory_defaults(user_factory):
    """Test Factory mit Default-Werten"""
    user = user_factory()
    assert user["name"] == "testuser"
    assert user["email"] == "testuser@example.com"
    assert user["active"] == True

def test_user_factory_custom(user_factory):
    """Test Factory mit Custom-Werten"""
    user = user_factory(name="alice", active=False)
    assert user["name"] == "alice" 
    assert user["email"] == "alice@example.com"
    assert user["active"] == False

ipytest.run()
```

Factory Fixtures geben Funktionen zurück, die flexibel konfigurierbare Objekte erstellen. Das ist perfekt wenn Sie ähnliche aber nicht identische Testobjekte brauchen.

---

## 9. Async/Await Testing

```python
import asyncio

async def async_fetch_data(url):
    """Simuliert asynchronen API-Call"""
    await asyncio.sleep(0.1)  # Simuliert Netzwerk-Delay
    return f"Data from {url}"

@pytest.mark.asyncio
async def test_async_function():
    """Test für asynchrone Funktion"""
    result = await async_fetch_data("https://api.example.com")
    assert result == "Data from https://api.example.com"

# Für asyncio Tests brauchen wir pytest-asyncio
# !pip install pytest-asyncio

ipytest.run()
```

Asynchrone Tests brauchen `@pytest.mark.asyncio` und `async def`. pytest-asyncio Plugin ermöglicht das Testen von async/await Code.

---

## 10. Zusammenfassung: Best Practices für erweiterte Tests

```python
def test_best_practices_summary():
    """Zusammenfassung der wichtigsten Prinzipien"""
    
    # 1. AAA Pattern (Arrange, Act, Assert)
    # Arrange
    data = [1, 2, 3, 4, 5]
    
    # Act  
    result = sum(data)
    
    # Assert
    assert result == 15
    
    # 2. Ein Test - ein Aspekt
    assert len(data) == 5  # Separate Assertion für andere Eigenschaft

def test_meaningful_names_and_isolation():
    """Tests haben aussagekräftige Namen und sind isoliert"""
    # Jeder Test ist unabhängig von anderen
    local_data = {"key": "value"}
    assert local_data["key"] == "value"

ipytest.run()
```

---

## Zusammenfassung der erweiterten Techniken

Fixtures:
- ✅ Setup/Teardown automatisieren
- ✅ Wiederverwendbare Test-Ressourcen
- ✅ Verschiedene Scopes für optimale Performance

Mocking:
- ✅ Abhängigkeiten isolieren mit Mock/patch
- ✅ Seiteneffekte simulieren für verschiedene Szenarien  
- ✅ Aufrufe verifizieren mit assert_called_*

Parametrisierung:
- ✅ Mehrere Testfälle effizient abarbeiten
- ✅ Kombinationen testen mit mehreren Parametern
- ✅ Lesbare IDs für bessere Diagnostik

Organisation:
- ✅ Marks für Kategorisierung
- ✅ Factory Fixtures für flexible Objekte
- ✅ Property-Based Testing für umfassende Abdeckung

Diese Techniken ermöglichen professionelles, wartbares und umfassendes Testing für komplexe Python-Anwendungen! 🚀

---

Kommandozeilen-Optionen für erweiterte Tests:

```bash
# Nur bestimmte Marks ausführen
pytest -m "not slow"          # Alle außer langsamen Tests
pytest -m "unit or integration" # Unit ODER Integration Tests

# Mit Coverage
pytest --cov=src --cov-report=html

# Verbose Output mit Details
pytest -v --tb=short

# Tests parallel ausführen (mit pytest-xdist)
pytest -n 4  # 4 parallele Prozesse
```
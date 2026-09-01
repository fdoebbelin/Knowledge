## Was ist Unit Testing?

- **Unit Testing** bezeichnet das automatisierte Testen einzelner Code-Einheiten (Units) 
	- typischerweise Funktionen oder Methoden 
	- isoliert von anderen Teilen des Programms. 
- Jeder Test 
	- prüft eine spezifische Funktionalität und stellt sicher, 
	- dass der Code unter verschiedenen Bedingungen korrekt funktioniert.

### Vorteile von Unit Testing
- **Frühe Fehlererkennung**: 
	- Bugs werden bereits während der Entwicklung entdeckt, nicht erst beim Endnutzer
- **Refactoring-Sicherheit**: 
	- Bestehender Code kann sicher umgeschrieben werden, da Tests sofort Änderungen validieren
- **Dokumentation**: 
	- Tests dienen als lebende Dokumentation des erwarteten Verhaltens
- **Debugging-Unterstützung**: 
	- Fehlgeschlagene Tests zeigen präzise, wo Probleme auftreten

## Test-Driven Development (TDD)

**TDD** ist eine Entwicklungsmethodik, bei der Tests vor dem eigentlichen Code geschrieben werden. 
Der TDD-Zyklus folgt dem **Red-Green-Refactor** Prinzip:

1. **Red**: Schreibe einen Test, der fehlschlägt
2. **Green**: Schreibe minimalen Code, um den Test zum Laufen zu bringen
3. **Refactor**: Verbessere den Code, während alle Tests weiterhin bestehen

### Praktisches TDD-Beispiel

```python
# test_calculator.py
import pytest
from calculator import Calculator

class TestCalculator:
    def test_addition(self):
        """Test: Addition von zwei Zahlen"""
        calc = Calculator()
        result = calc.add(2, 3)
        assert result == 5
    
    def test_addition_negative_numbers(self):
        """Test: Addition mit negativen Zahlen"""
        calc = Calculator()
        result = calc.add(-2, 3)
        assert result == 1
    
    def test_division_by_zero(self):
        """Test: Division durch Null sollte Exception werfen"""
        calc = Calculator()
        with pytest.raises(ZeroDivisionError):
            calc.divide(10, 0)
```

```python
# calculator.py - Implementierung nach TDD
class Calculator:
    def add(self, a, b):
        """Addiert zwei Zahlen"""
        return a + b
    
    def subtract(self, a, b):
        """Subtrahiert zwei Zahlen"""
        return a - b
    
    def multiply(self, a, b):
        """Multipliziert zwei Zahlen"""
        return a * b
    
    def divide(self, a, b):
        """Dividiert zwei Zahlen"""
        if b == 0:
            raise ZeroDivisionError("Division durch Null ist nicht erlaubt")
        return a / b
```


## pytest Framework einrichten und verwenden

### Installation und Grundkonfiguration

```bash
# pytest installieren
pip install pytest

# Tests ausführen
pytest                    # Alle Tests
pytest test_calculator.py # Spezifische Datei
pytest -v                # Verbose Output
pytest --tb=short        # Kurze Traceback-Anzeigen
```


### Pytest Konventionen
- **Dateinamen**: 
	- Test-Dateien beginnen mit `test_` oder enden mit `_test.py`
- **Funktionsnamen**: 
	- Test-Funktionen beginnen mit `test_`
- **Klassen**: 
	- Test-Klassen beginnen mit `Test` (ohne `__init__` Methode)

### Grundlegende Assertions

```python
def test_assertions_beispiele():
    """Demonstration verschiedener Assertion-Arten"""
    
    # Gleichheit testen
    assert 2 + 2 == 4
    assert "hello".upper() == "HELLO"
    
    # Ungleichheit testen
    assert 5 != 3
    
    # Boolean Werte
    assert True
    assert not False
    
    # Listen und Collections
    assert [1, 2, 3] == [1, 2, 3]
    assert len([1, 2, 3]) == 3
    
    # In/Not in
    assert 'a' in 'banana'
    assert 'z' not in 'hello'
    
    # Typ-Checks
    assert isinstance(42, int)
    assert isinstance([], list)
```


## Unit Tests für Funktionen

### Einfache Funktionen testen

```python
# mathutils.py
def factorial(n):
    """Berechnet die Fakultät einer Zahl"""
    if n < 0:
        raise ValueError("Fakultät ist nur für nicht-negative Zahlen definiert")
    if n == 0 or n == 1:
        return 1
    return n * factorial(n - 1)

def is_prime(n):
    """Prüft, ob eine Zahl eine Primzahl ist"""
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True
```

```python
# test_mathutils.py
import pytest
from mathutils import factorial, is_prime

class TestFactorial:
    def test_factorial_positive_numbers(self):
        """Test: Fakultät positiver Zahlen"""
        assert factorial(0) == 1
        assert factorial(1) == 1
        assert factorial(5) == 120
        assert factorial(4) == 24
    
    def test_factorial_negative_number_raises_error(self):
        """Test: Fakultät negativer Zahlen wirft ValueError"""
        with pytest.raises(ValueError, match="nur für nicht-negative"):
            factorial(-1)
    
    def test_factorial_large_number(self):
        """Test: Fakultät großer Zahlen"""
        assert factorial(10) == 3628800

class TestIsPrime:
    def test_prime_numbers(self):
        """Test: Erkennung von Primzahlen"""
        assert is_prime(2) == True
        assert is_prime(3) == True
        assert is_prime(17) == True
        assert is_prime(29) == True
    
    def test_non_prime_numbers(self):
        """Test: Erkennung von Nicht-Primzahlen"""
        assert is_prime(1) == False
        assert is_prime(4) == False
        assert is_prime(15) == False
        assert is_prime(100) == False
    
    def test_edge_cases(self):
        """Test: Grenzfälle"""
        assert is_prime(0) == False
        assert is_prime(-5) == False
```


## Unit Tests für Klassen

### Objektorientierte Tests

```python
# bankaccount.py
class BankAccount:
    def __init__(self, initial_balance=0):
        if initial_balance < 0:
            raise ValueError("Anfangssaldo kann nicht negativ sein")
        self._balance = initial_balance
        self._transaction_history = []
    
    @property
    def balance(self):
        return self._balance
    
    def deposit(self, amount):
        if amount <= 0:
            raise ValueError("Einzahlungsbetrag muss positiv sein")
        self._balance += amount
        self._transaction_history.append(f"Einzahlung: +{amount}")
        return self._balance
    
    def withdraw(self, amount):
        if amount <= 0:
            raise ValueError("Auszahlungsbetrag muss positiv sein")
        if amount > self._balance:
            raise ValueError("Unzureichender Saldo")
        self._balance -= amount
        self._transaction_history.append(f"Auszahlung: -{amount}")
        return self._balance
    
    def get_transaction_history(self):
        return self._transaction_history.copy()
```

```python
# test_bankaccount.py
import pytest
from bankaccount import BankAccount

class TestBankAccount:
    def test_account_creation_default_balance(self):
        """Test: Konto-Erstellung mit Standard-Saldo"""
        account = BankAccount()
        assert account.balance == 0
    
    def test_account_creation_with_initial_balance(self):
        """Test: Konto-Erstellung mit Anfangssaldo"""
        account = BankAccount(100)
        assert account.balance == 100
    
    def test_account_creation_negative_balance_raises_error(self):
        """Test: Negativer Anfangssaldo wirft Fehler"""
        with pytest.raises(ValueError, match="Anfangssaldo kann nicht negativ"):
            BankAccount(-50)
    
    def test_deposit_positive_amount(self):
        """Test: Einzahlung positiver Beträge"""
        account = BankAccount(100)
        new_balance = account.deposit(50)
        assert new_balance == 150
        assert account.balance == 150
    
    def test_deposit_negative_amount_raises_error(self):
        """Test: Negative Einzahlung wirft Fehler"""
        account = BankAccount()
        with pytest.raises(ValueError, match="Einzahlungsbetrag muss positiv"):
            account.deposit(-10)
    
    def test_withdraw_sufficient_balance(self):
        """Test: Auszahlung bei ausreichendem Saldo"""
        account = BankAccount(100)
        new_balance = account.withdraw(30)
        assert new_balance == 70
        assert account.balance == 70
    
    def test_withdraw_insufficient_balance(self):
        """Test: Auszahlung bei unzureichendem Saldo"""
        account = BankAccount(50)
        with pytest.raises(ValueError, match="Unzureichender Saldo"):
            account.withdraw(100)
    
    def test_transaction_history_tracking(self):
        """Test: Transaktions-Historie wird korrekt geführt"""
        account = BankAccount(100)
        account.deposit(50)
        account.withdraw(25)
        
        history = account.get_transaction_history()
        assert len(history) == 2
        assert "Einzahlung: +50" in history
        assert "Auszahlung: -25" in history
```


## Fortgeschrittene pytest Features

### Parametrisierte Tests

```python
import pytest

@pytest.mark.parametrize("input_value, expected", [
    (0, 1),
    (1, 1),
    (2, 2),
    (3, 6),
    (4, 24),
    (5, 120)
])
def test_factorial_parametrized(input_value, expected):
    """Parametrisierte Tests für Fakultäts-Funktion"""
    assert factorial(input_value) == expected

@pytest.mark.parametrize("number, is_prime_expected", [
    (2, True),
    (3, True),
    (4, False),
    (17, True),
    (18, False),
    (29, True),
    (30, False)
])
def test_prime_numbers_parametrized(number, is_prime_expected):
    """Parametrisierte Tests für Primzahl-Prüfung"""
    assert is_prime(number) == is_prime_expected
```


### Test Fixtures

```python
import pytest
from bankaccount import BankAccount

@pytest.fixture
def empty_account():
    """Fixture: Leeres Bankkonto"""
    return BankAccount()

@pytest.fixture
def account_with_balance():
    """Fixture: Bankkonto mit Startguthaben"""
    return BankAccount(1000)

@pytest.fixture
def account_with_transactions():
    """Fixture: Bankkonto mit einigen Transaktionen"""
    account = BankAccount(500)
    account.deposit(200)
    account.withdraw(100)
    return account

class TestBankAccountWithFixtures:
    def test_empty_account_balance(self, empty_account):
        """Test mit Empty Account Fixture"""
        assert empty_account.balance == 0
    
    def test_deposit_to_account_with_balance(self, account_with_balance):
        """Test mit Account Balance Fixture"""
        account_with_balance.deposit(500)
        assert account_with_balance.balance == 1500
    
    def test_transaction_history_length(self, account_with_transactions):
        """Test mit Transaction History Fixture"""
        history = account_with_transactions.get_transaction_history()
        assert len(history) == 2
```


## TDD-Workflow implementieren

### Schritt-für-Schritt TDD Beispiel

```python
# Schritt 1: Test schreiben (RED)
def test_string_reverser_simple():
    """Test: String umkehren"""
    reverser = StringReverser()
    result = reverser.reverse("hello")
    assert result == "olleh"

# Schritt 2: Minimale Implementierung (GREEN)
class StringReverser:
    def reverse(self, text):
        return text[::-1]

# Schritt 3: Weitere Tests hinzufügen (RED)
def test_string_reverser_empty_string():
    """Test: Leerer String"""
    reverser = StringReverser()
    result = reverser.reverse("")
    assert result == ""

def test_string_reverser_single_character():
    """Test: Einzelnes Zeichen"""
    reverser = StringReverser()
    result = reverser.reverse("a")
    assert result == "a"

# Schritt 4: Robuste Implementierung (GREEN + REFACTOR)
class StringReverser:
    def reverse(self, text):
        if not isinstance(text, str):
            raise TypeError("Input muss ein String sein")
        return text[::-1]

def test_string_reverser_non_string_input():
    """Test: Nicht-String Input"""
    reverser = StringReverser()
    with pytest.raises(TypeError, match="Input muss ein String sein"):
        reverser.reverse(123)
```


## Praktische Testing-Strategien

### Test Organization

```python
# tests/conftest.py - Zentrale Fixtures
import pytest
from pathlib import Path
import tempfile

@pytest.fixture(scope="session")
def test_data_dir():
    """Fixture: Test-Datenverzeichnis"""
    return Path(__file__).parent / "data"

@pytest.fixture
def temp_file():
    """Fixture: Temporäre Datei"""
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as f:
        yield f.name
    Path(f.name).unlink(missing_ok=True)
```


### Mocking und Isolation

```python
from unittest.mock import Mock, patch
import pytest

class EmailService:
    def send_email(self, recipient, subject, body):
        # In Realität würde hier ein Email-Provider angesprochen
        pass

class UserRegistration:
    def __init__(self, email_service):
        self.email_service = email_service
    
    def register_user(self, username, email):
        # Benutzer registrieren
        user_id = f"user_{len(username)}"
        
        # Willkommens-Email senden
        self.email_service.send_email(
            email, 
            "Willkommen!", 
            f"Hallo {username}, willkommen bei uns!"
        )
        return user_id

class TestUserRegistration:
    def test_user_registration_sends_welcome_email(self):
        """Test: Benutzerregistrierung sendet Willkommens-Email"""
        # Mock Email Service
        mock_email_service = Mock()
        registration = UserRegistration(mock_email_service)
        
        # User registrieren
        user_id = registration.register_user("testuser", "test@example.com")
        
        # Überprüfen, dass Email gesendet wurde
        mock_email_service.send_email.assert_called_once_with(
            "test@example.com",
            "Willkommen!",
            "Hallo testuser, willkommen bei uns!"
        )
        assert user_id == "user_8"  # len("testuser") = 8
```


## Integration mit bestehenden Projekten

### Tests für das Py2Rust Projekt

```python
# test_py2rust_project.py
import pytest
from pathlib import Path
from py2rust.projectloader import ProjectLoader
from py2rust.pythonanalyzer import PythonAnalyzer

class TestProjectLoader:
    def test_project_loader_initialization(self, temp_dir):
        """Test: ProjectLoader Initialisierung"""
        loader = ProjectLoader(temp_dir)
        assert loader.pfad == temp_dir
        assert loader.files == []
    
    def test_load_python_files(self, temp_dir_with_python_files):
        """Test: Python-Dateien laden"""
        loader = ProjectLoader(temp_dir_with_python_files)
        loader.load_files()
        
        assert len(loader.files) >= 1
        assert all(file.endswith('.py') for file in loader.files)

class TestPythonAnalyzer:
    def test_analyze_simple_class(self, simple_python_class_file):
        """Test: Einfache Klassen-Analyse"""
        analyzer = PythonAnalyzer(simple_python_class_file)
        classes = analyzer.list_classes()
        
        assert 'SimpleClass' in classes
    
    def test_analyze_functions(self, simple_python_function_file):
        """Test: Funktions-Analyse"""
        analyzer = PythonAnalyzer(simple_python_function_file)
        functions = analyzer.list_functions()
        
        assert 'simple_function' in functions
```


### Tests für das KeyRecognition Projekt

```python
# test_key_recognition.py
import pytest
import numpy as np
from keyrecognition.keysignal import KeySignal, LabeledKeySignal

class TestKeySignal:
    @pytest.fixture
    def sample_iq_data(self):
        """Fixture: Sample IQ-Daten"""
        fs = 1000
        t = np.arange(0, 1, 1/fs)
        return np.exp(1j * 2 * np.pi * 100 * t)
    
    def test_key_signal_initialization(self, sample_iq_data):
        """Test: KeySignal Initialisierung"""
        signal = KeySignal(sample_iq_data, 1000, "Test Signal")
        
        assert signal.samplingrate == 1000
        assert signal.desc == "Test Signal"
        assert signal.modulation is None
        assert len(signal.iqdata) == len(sample_iq_data)
    
    def test_ask_demodulation(self, sample_iq_data):
        """Test: ASK Demodulation"""
        signal = KeySignal(sample_iq_data, 1000)
        signal.set_modulation('ASK')
        
        demod_data = signal.demodulate()
        assert len(demod_data) == len(sample_iq_data)
        assert all(isinstance(x, (int, float, np.number)) for x in demod_data)
    
    def test_feature_extraction(self, sample_iq_data):
        """Test: Feature-Extraktion"""
        signal = KeySignal(sample_iq_data, 1000)
        features = signal.extract_features()
        
        required_features = ['mean_amplitude', 'std_amplitude', 'mean_phase', 'std_phase']
        assert all(feature in features for feature in required_features)

class TestLabeledKeySignal:
    def test_labeled_signal_inheritance(self, sample_iq_data):
        """Test: LabeledKeySignal Vererbung"""
        labeled_signal = LabeledKeySignal(
            sample_iq_data, 1000, "Test", "BMW", "X5", 2021
        )
        
        assert labeled_signal.marke == "BMW"
        assert labeled_signal.modell == "X5"
        assert labeled_signal.jahr == 2021
        
        # Vererbte Funktionalität testen
        assert hasattr(labeled_signal, 'extract_features')
        features = labeled_signal.extract_features()
        assert isinstance(features, dict)
```


## Test-Coverage und Qualitätsmessung

### Coverage-Analyse

```bash
# Coverage installieren und verwenden
pip install pytest-cov

# Tests mit Coverage ausführen
pytest --cov=src tests/
pytest --cov=src --cov-report=html tests/  # HTML Report
pytest --cov=src --cov-report=term-missing tests/  # Fehlende Zeilen
```


### Testqualität bewerten

```python
# pytest.ini - Konfigurationsdatei
[tool:pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = --strict-markers --disable-warnings
markers =
    slow: marks tests as slow
    integration: marks tests as integration tests
    unit: marks tests as unit tests
```


## Best Practices für Unit Testing

### Testbenennung und Organisation

**Aussagekräftige Namen**: Test-Namen sollten das erwartete Verhalten beschreiben

```python
# Gut: Beschreibt was getestet wird
def test_deposit_positive_amount_increases_balance()
def test_withdraw_amount_exceeding_balance_raises_error()

# Schlecht: Vage Bezeichnungen
def test_deposit()
def test_error()
```

**AAA-Pattern**: Arrange (Vorbereiten), Act (Ausführen), Assert (Überprüfen)

```python
def test_calculator_addition():
    # Arrange
    calc = Calculator()
    a, b = 5, 3
    
    # Act
    result = calc.add(a, b)
    
    # Assert
    assert result == 8
```


### Testunabhängigkeit

```python
class TestBankAccount:
    def setup_method(self):
        """Wird vor jedem Test ausgeführt"""
        self.account = BankAccount(100)
    
    def test_deposit(self):
        """Test isoliert von anderen Tests"""
        self.account.deposit(50)
        assert self.account.balance == 150
    
    def test_withdraw(self):
        """Startet mit frischem Account"""
        self.account.withdraw(30)
        assert self.account.balance == 70
```


### Fehlerbehandlung testen

```python
def test_comprehensive_error_handling():
    """Test: Umfassende Fehlerbehandlung"""
    calc = Calculator()
    
    # Spezifische Exception testen
    with pytest.raises(ZeroDivisionError):
        calc.divide(10, 0)
    
    # Exception-Message testen
    with pytest.raises(ValueError, match="muss positiv sein"):
        calc.square_root(-4)
    
    # Multiple Exceptions
    with pytest.raises((TypeError, ValueError)):
        calc.add("text", 5)
```

- Unit Testing ist ein fundamentaler Baustein moderner Softwareentwicklung. 
- Durch systematisches Testen mit pytest und die Anwendung von TDD-Prinzipien schaffen Sie eine solide Basis für wartbaren, zuverlässigen Code. 
- Die Investition in gute Tests zahlt sich durch reduzierte Debugging-Zeit, erhöhte Codequalität und das Vertrauen aus, Änderungen sicher durchführen zu können.
<span style="display:none">[^10][^11][^12][^13][^2][^3][^4][^5][^6][^7][^8][^9]</span>

<div style="text-align: center">⁂</div>

[^1]: 00-Schwerpunkte-aller-Module.md

[^2]: 01a-Vorschlag-Klassenubersicht-Py2Rust.md

[^3]: 04a-Vorschlag-Klassenubersicht-KeyRecognition.md

[^4]: 00-Python-to-Rust-Migration-Ein-umfassendes-Desktop-App-Projekt.md

[^5]: 04-Projekt-Tristan-KeyRegognition.md

[^6]: 04b-Key-Recognizer-README.md

[^7]: 03a-Vorschlag-Klassenubersicht-PersonalPrinz.md

[^8]: 02a-Vorschlag-Klassenubersicht-WeiterWeiser.md

[^9]: 03-Projekt-Christopher-PersonalPrinz.md

[^10]: 01b-Py2Rust-README.md

[^11]: 03b-Personalprinz-README.md

[^12]: 01-Projekt-Fritz-Py2Rust.md

[^13]: 02b-WetterWeiser-README.md


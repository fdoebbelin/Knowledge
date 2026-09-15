# Arbeitsblatt: aNNoTest - Annotationsbasierte Testgenerierung für neuronale Netzwerke

## Was ist aNNoTest?

**aNNoTest** ist ein innovatives Tool zur automatischen Generierung von Unit-Tests für neuronale Netzwerk-Programme in Python. Es wurde entwickelt, um spezifische Herausforderungen beim Testen von ML/NN-Code zu lösen, insbesondere die präzise Beschreibung gültiger Eingabeparameter.

## Kernproblem und Lösung

### Das Problem
- **Dynamische Typisierung**: Python kann detaillierte Constraints über gültige Funktionseingaben nicht ausdrücken
- **Komplexe Datenstrukturen**: Neuronale Netzwerke verwenden Matrizen, Tensoren, Vektoren mit präzisen Dimensionsbeschränkungen
- **Ungültige Eingaben**: Automatische Testgenerierung produziert oft ungültige Inputs, die zu Fehlalarmen führen

### Die Lösung
aNNoTest verwendet eine **einfache Annotationssprache (aN)**, mit der Entwickler präzise und kompakt gültige Funktionseingaben beschreiben können.

## Die aN-Annotationssprache

### 1. Installation
```bash
pip install annotest
```

### 2. Grundlegende Syntax

#### Import der Annotationssprache:
```python
from an_language import *
```

#### Typ-Constraints (@arg):
```python
@arg(var): TypeConstr
```

Beispiele für TypeConstr:
- `ints(min_value=0, max_value=100)` - Ganze Zahlen zwischen 0 und 100
- `floats(min_value=0.0, max_value=1.0)` - Gleitkommazahlen zwischen 0.0 und 1.0
- `bools()` - Boolesche Werte
- `lists(ints(), min_size=1, max_size=10)` - Listen von Ganzzahlen

#### NumPy-spezifische Constraints:
```python
@arg(matrix): np_arrays(np.float32, shape=(10, 20))  # 10x20 Matrix
@arg(vector): int_lists(min_size=5, max_size=5)      # Vektor der Länge 5
@arg(shape): np_shapes(min_dims=2, max_dims=4)       # 2-4 dimensionale Shapes
```

#### Vordefinierte Werte:
```python
@arg(activation): froms(['relu', 'sigmoid', 'tanh'])  # Auswahl aus Liste
```

#### Benutzerdefinierte Generatoren:
```python
@arg(custom_obj): objs(custom_generator_function)
```

### 3. Preconditions (@require):
```python
@require: lambda args: constraint_expression
```

Beispiel:
```python
@require: lambda args: args.input_dim > 0 and args.output_dim > 0
```

## Praktisches Beispiel

### Originaler Code (ohne Annotationen):
```python
def create_dense_layer(input_dim, output_dim, activation='relu', reg=None):
    """Erstellt eine dichte Schicht eines neuronalen Netzwerks."""
    if input_dim <= 0 or output_dim <= 0:
        raise ValueError("Dimensionen müssen positiv sein")
    
    # Weitere Implementierung...
    pass
```

### Annotierter Code:
```python
from an_language import *

@arg(input_dim): ints(min_value=1, max_value=1000)
@arg(output_dim): ints(min_value=1, max_value=1000) 
@arg(activation): froms(['relu', 'sigmoid', 'tanh', 'softmax'])
@arg(reg): floats(min_value=0.0, max_value=1.0)
@require: lambda args: args.input_dim <= args.output_dim * 2
def create_dense_layer(input_dim, output_dim, activation='relu', reg=0.01):
    """Erstellt eine dichte Schicht eines neuronalen Netzwerks."""
    if input_dim <= 0 or output_dim <= 0:
        raise ValueError("Dimensionen müssen positiv sein")
    
    # Bug: Fehlerhafte Dimensionsprüfung
    if input_dim > output_dim * 3:  # Sollte * 2 sein
        raise ValueError("Input-Dimension zu groß")
    
    return f"Dense Layer: {input_dim} -> {output_dim}, {activation}, reg={reg}"
```

## Workflow mit aNNoTest

### Schritt 1: Funktionen annotieren
```python
# Nur kritische/fehleranfällige Funktionen annotieren
# Durchschnittlich 6 Annotationen pro Funktion
```

### Schritt 2: Tests generieren
```bash
annotest <project_root>
```

### Schritt 3: Tests ausführen
```bash
python -m unittest
```

## Übungsaufgaben

### Aufgabe 1: Basis-Annotationen
Annotieren Sie diese Funktion für Matrixmultiplikation:

```python
def matrix_multiply(A, B):
    """Multipliziert zwei Matrizen A und B."""
    if A.shape[1] != B.shape[0]:
        raise ValueError("Inkompatible Dimensionen")
    return A @ B

# TODO: Fügen Sie aN-Annotationen hinzu
```

**Lösung:**
```python
@arg(A): np_arrays(np.float32, shape=(10, 20))
@arg(B): np_arrays(np.float32, shape=(20, 15))
@require: lambda args: args.A.shape[1] == args.B.shape[0]
def matrix_multiply(A, B):
    # ... Rest bleibt unverändert
```

### Aufgabe 2: Komplexe Constraints
Annotieren Sie eine Aktivierungsfunktion:

```python
def apply_activation(x, func_name, params=None):
    """Wendet Aktivierungsfunktion auf Eingabe an."""
    if func_name == 'relu':
        return max(0, x)
    elif func_name == 'leaky_relu' and params:
        alpha = params.get('alpha', 0.01)
        return max(alpha * x, x)
    # ... weitere Implementierung

# TODO: Annotationen hinzufügen
```

### Aufgabe 3: Custom Generators
Erstellen Sie einen benutzerdefinierten Generator für Netzwerk-Konfigurationen:

```python
def create_network_config():
    """Generiert zufällige, aber gültige Netzwerk-Konfiguration."""
    # TODO: Implementierung
    pass

@arg(config): objs(create_network_config)
def build_network(config):
    """Erstellt Netzwerk basierend auf Konfiguration."""
    # TODO: Implementierung mit Annotationen
    pass
```

## Bewertung von aNNoTest

### Vorteile:
- **Hohe Präzision**: Weniger Fehlalarme durch valide Eingaben
- **Geringe Annotation-Last**: Durchschnittlich 6 Annotationen pro Funktion
- **Automatische Hypothesis-Integration**: Generiert property-based Tests
- **Praxisrelevant**: Findet echte Bugs in realen Projekten

### Nachteile:
- **Manuelle Annotation**: Erfordert Domain-Wissen
- **Python-spezifisch**: Nur für Python/NumPy-Programme
- **Nested Functions**: Kann verschachtelte Funktionen nicht testen
- **Syntaxabhängig**: Benötigt syntaktisch validen Code

## Vergleich mit anderen Tools

| Feature | aNNoTest | Pynguin | Hypothesis |
|---------|----------|---------|------------|
| Zielgruppe | ML/NN-Programme | Allgemein | Property-based |
| Annotation | Erforderlich | Keine | Optional |
| Präzision | Hoch | Mittel | Hoch |
| Automatisierung | Mittel | Hoch | Niedrig |
| Domain-Fokus | ML-spezifisch | Allgemein | Allgemein |

## Experimentelle Ergebnisse

- **19 neuronale Netzwerk-Programme** getestet
- **94 Bugs** gefunden (davon 63 bekannte Bugs aus Surveys)
- **6 Annotationen pro Funktion** im Durchschnitt
- **Hohe Testabdeckung** bei geringem manuellen Aufwand

## Praktische Anwendung

### Wann aNNoTest verwenden?
- **ML/DL-Bibliotheken** mit komplexen Tensor-Operationen
- **Kritische NN-Komponenten** in sicherheitsrelevanten Systemen
- **Funktionen mit komplexen Eingabe-Constraints**

### Integration in Entwicklungsprozess:
1. **Selektive Annotation**: Nur kritische Funktionen annotieren
2. **CI/CD-Integration**: Automatische Testgenerierung in Build-Pipeline
3. **Kombination mit anderen Tools**: Ergänzung zu Pynguin und manuellen Tests

## Zusammenfassung

aNNoTest schließt eine wichtige Lücke in der automatischen Testgenerierung für ML/NN-Programme durch:
- **Domain-spezifische Annotationssprache**
- **Property-based Testing** mit validen Eingaben
- **Hohe Fehlererkennungsrate** bei geringem manuellen Aufwand
- **Praktische Anwendbarkeit** in realen ML-Projekten

Das Tool eignet sich besonders für Entwickler von ML-Bibliotheken und safety-critical AI-Systemen, die eine gezielte und präzise Testabdeckung benötigen.
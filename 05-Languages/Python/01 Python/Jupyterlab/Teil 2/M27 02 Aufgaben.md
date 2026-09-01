## Aufgaben \& Lösungen: Py2Rust (Dozentenprojekt)

### Aufgabe 1: Implementiere ein Analysesystem mit abstrakter Basisklasse

**Aufgabenstellung:**
Implementiere eine abstrakte Basisklasse `Analyzer` mit einer `analyze()`-Methode. Erstelle zwei spezialisierte Klassen, eine für Python (`PythonAnalyzer`) und eine für Rust (`RustAnalyzer`), die jeweils die Methode überschreiben und eine spezifische Textausgabe liefern.

**Lösung:**

```python
from abc import ABC, abstractmethod

class Analyzer(ABC):
    @abstractmethod
    def analyze(self, code):
        pass

class PythonAnalyzer(Analyzer):
    def analyze(self, code):
        print("Analysiere Python-Code:", code[:30])

class RustAnalyzer(Analyzer):
    def analyze(self, code):
        print("Analysiere Rust-Code:", code[:30])

py = PythonAnalyzer()
rs = RustAnalyzer()
py.analyze("def foo(): pass")
rs.analyze("fn foo() {}")
```

**Kommentar:**
Beispiel zeigt Nutzung von abstrakter Basisklasse und Methodenüberschreibung. Die Konzeption sichert, dass jede Analyzer-Unterklasse die Schnittstelle erfüllt. Perfekt für Testbarkeit und Erweiterbarkeit.

***

### Aufgabe 2: Untersuche Method Resolution Order

**Aufgabenstellung:**
Erzeuge eine Klassenhierarchie mit Mehrfachvererbung und prüfe mittels `__mro__`, wie Python die Method Resolution Order bestimmt.

**Lösung:**

```python
class Parser:
    def process(self):
        print("Parser")

class Linter(Parser):
    def process(self):
        print("Linter")

class Formatter(Parser):
    def process(self):
        print("Formatter")

class Py2RustAnalyzer(Linter, Formatter):
    pass

pr = Py2RustAnalyzer()
pr.process()
print(Py2RustAnalyzer.__mro__)
```

**Kommentar:**
Hier ist der Aufruf „Linter“: Die Reihenfolge bestimmt das MRO-System (Linter → Formatter → Parser). So lassen sich Konflikte analysieren und gezielt beseitigen.

***

## Teilnehmerprojekte - Aufgaben mit Lösungshinweisen

### WetterWeiser (Projekt Christian)

- **Aufgabe:** Erstelle eine abstrakte Klasse `Sensor` mit der abstrakten Methode `read_data()`. Implementiere zwei Unterklassen für Temperatur- und Niederschlagssensor, die eine unterschiedliche Art von „Messdaten“ ausgeben.
    - **Hinweis:** Nutze das Modul `abc` und stelle sicher, dass keine Instanz von `Sensor` erstellt werden kann. Zeige, wie beide Sensoren gemeinsam genutzt werden können, etwa durch eine Liste von Sensorobjekten, die nacheinander abgefragt werden.


### PersonalPrinz (Projekt Christopher)

- **Aufgabe:** Füge eine abstrakte Basisklasse `MitarbeiterRollentyp` ein, die eine Methode `berechtigung()` vorschreibt. Erstelle mindestens zwei konkrete Rollenklassen (z.B. `Angestellter`, `Admin`), die unterschiedliche Rückgabewerte liefern. Teste an einem Beispiel, dass Polymorphismus funktioniert.
    - **Hinweis:** Die Methode könnte Textrechte oder Zugriffslevel zurückgeben, und im Teammeeting lässt sich leicht erläutern, wieso dieses Muster in OOP-Projekten relevant ist.


### KeyRecognition (Projekt Tristan)

- **Aufgabe:** Erweitere die bestehende Signalstruktur durch Mehrfachvererbung: Lege eine Klasse `SignalLogger` mit einer Log-Methode und eine (gerne abstrakte) Klasse `FeatureExtractor` mit einer abstrakten Methode `extract()`. Erstelle eine Klasse, die beide erbt und vollständige Implementierungen liefert.
    - **Hinweis:** Die Kollision zweier gleichnamiger Methoden in beiden Basisklassen ist gezielt zu provozieren und mit MRO sichtbar zu machen. Die Implementierung unterstützt somit das Verständnis der Mehrfachvererbung und der Aufrufkette in Python.

***

**Praxis-Tipp:**
Alle Aufgaben sind darauf ausgelegt, die **Methodenvererbung, MRO und die Gestaltung abstrakter Schnittstellen** mit realem Projektbezug zu verankern – mit viel Raum für kreative Varianten! Lösungen können direkt im Jupyter Notebook oder einer IDE ausprobiert und iterativ erweitert werden.

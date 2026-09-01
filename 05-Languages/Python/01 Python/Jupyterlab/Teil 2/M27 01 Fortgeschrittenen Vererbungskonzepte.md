- behandelt die **fortgeschrittenen Vererbungskonzepte** in Python und bildet einen entscheidenden Abschluss des OOP-Bereichs im Kurs. 
- im Fokus stehen 
	- Mehrfachvererbung, 
	- die Method Resolution Order (MRO) und 
	- die Nutzung abstrakter Basisklassen mit dem Modul `abc`. 
- diese Themen sind für größere Projekte und professionelle OOP-Architekturen unverzichtbar.

***

## Mehrfachvererbung

Die Mehrfachvererbung ermöglicht es einer Klasse, von mehreren Elternklassen Eigenschaften und Methoden zu erben. 
In Python geschieht dies schlicht durch die Kommaschreibweise in der Klassendefinition:

```python
class A:
    def hello(self):
        print("Hallo von A")

class B:
    def hello(self):
        print("Hallo von B")

class C(A, B):
    pass

c = C()
c.hello()  # Gibt "Hallo von A" aus, da A zuerst in der MRO steht
```

Die Praxis zeigt: Mehrfachvererbung bietet große Flexibilität, kann aber zu Konflikten (z. B. Diamond Problem) führen. 
Daher ist das Verständnis der Aufrufreihenfolge und -vererbung essenziell.

***

## Method Resolution Order (MRO)

Python klärt Konflikte bei mehrfacher Vererbung durch die **MRO**. 
Sie legt fest, in welcher Reihenfolge nach Methoden gesucht wird. 
Die MRO kann über die Methode `__mro__` oder die Funktion `mro()` abgefragt werden:

```python
print(C.__mro__)  # (<class '__main__.C'>, <class '__main__.A'>, <class '__main__.B'>, <class 'object'>)
```

Das sogenannte C3-Linearization-Verfahren sichert dabei eine konsistente Reihenfolge über die gesamte Hierarchie hinweg. 
Komplexe Hierarchien lassen sich so transparent und sicher gestalten.[

***

## Abstrakte Basisklassen mit `abc`

Mit dem Modul `abc` können **abstrakte Basisstrukturen** definiert werden, die bestimmte Methoden erzwingen und so Schnittstellenähnlichkeit garantieren.

```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass

class Rectangle(Shape):
    def area(self):
        return 4  # Beispiel
  
r = Rectangle()
print(r.area())  # Gibt 4 aus
```

Eine Klasse mit mindestens einer abstrakten Methode kann nicht instanziiert werden. 
Erst eine Unterklasse, die alle abstrakten Methoden implementiert, wird voll nutzbar. 
Das ermöglicht ein professionelles API-Design und Testing.

***

## Praxisnahe Beispiele

### 1. **Diamond Problem** sichtbar machen

```python
class X:
    def show(self):
        print("X")

class Y(X):
    def show(self):
        print("Y")

class Z(X):
    def show(self):
        print("Z")

class A(Y, Z):
    pass

a = A()
a.show()           # Gibt "Y" aus
print(A.__mro__)   # (<class '__main__.A'>, <class '__main__.Y'>, <class '__main__.Z'>, <class '__main__.X'>, <class 'object'>)
```

Hier ist klar an der MRO ablesbar, dass `Y` vor `Z` aufgelöst wird.

### 2. **Verwendung eines Interface mit abc**

```python
from abc import ABC, abstractmethod

class Logger(ABC):
    @abstractmethod
    def log(self, msg):
        pass

class ConsoleLogger(Logger):
    def log(self, msg):
        print("Konsole:", msg)

logger = ConsoleLogger()
logger.log("Testausgabe")
```

Das Beispiel zwingt jede Logger-Unterklasse, eine Log-Methode zu implementieren.

***

## Erweiterungen und Kursrolle

- **Best Practice**: 
	- Meist eine saubere, flache Vererbung benutzen und stattdessen Komposition erwägen, außer wenn Mehrfachvererbung explizit Vorteile bringt.
- **Refactoring**: 
	- Vor Einführung abstrakter Basisklassen hilft oft, bestehende Methoden und Schnittstellen explizit zu dokumentieren.
- **Testing \& API**: 
	- Die Nutzung von `abc` unterstützt automatisiertes Testing und fördert wartbaren Code.

***

## Mini-Projekt-Beispiel: Plugin-System

```python
from abc import ABC, abstractmethod

class Plugin(ABC):
    @abstractmethod
    def do_action(self):
        pass

class PluginA(Plugin):
    def do_action(self):
        print("Aktion A läuft")

class PluginB(Plugin):
    def do_action(self):
        print("Aktion B läuft")

def run_plugins(plugins):
    for plugin in plugins:
        plugin.do_action()

run_plugins([PluginA(), PluginB()])
```

Dieses Muster ist typisch für flexible, objektorientierte Architektur und Testbarkeit.

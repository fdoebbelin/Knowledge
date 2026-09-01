Dieses Jupyter-Arbeitsblatt zeigt, wie typische Refactorings mit Rope allein aus Python-Codezellen durchgeführt werden können – ohne externe Dateien und mit selbst enthaltenen Beispielcodes. Jeder Abschnitt enthält eine Problemstellung, eine Zelle mit dem „problematischen“ Code (dynamisch als String), eine Zelle für das Refactoring mit Rope und die Ausgabe des transformierten Codes. So kann alles direkt im Notebook getestet werden.

***

## Vorbereitung: Rope installieren und laden

```python
# Installieren, falls Rope nicht vorhanden ist (in Jupyter ausführen)
!pip install rope
```


***

## 1. Umbenennen eines Variablennamens mit Rope

**Problem:** Der Variablenname `an_attr` ist unpassend. Er soll überall in `new_attr` umbenannt werden.

**Originalcode:**

```python
code = '''
class AClass(object):
    def __init__(self):
        self.an_attr = 1
        
    def a_method(self, arg):
        print(self.an_attr, arg)

a_var = AClass()
a_var.a_method(a_var.an_attr)
'''
print(code)
```

**Refactoring mit Rope:**

```python
from rope.base.project import Project
from rope.refactor.rename import Rename
from rope.base.fscommands import FileSystemCommands
from rope.base import libutils

# Projekt in Memory anlegen und Datei als Resource erzeugen (virtuell)
project = Project('.', fscommands=FileSystemCommands())
fname = 'memory.py'
resource = project.get_file(fname)
with open(fname, 'w') as f:
    f.write(code)

# Attribut überall umbenennen
change = Rename(project, resource).get_changes('new_attr')
project.do(change)

# Transformierten Code auslesen
with open(fname) as f:
    print(f.read())

project.close()
```


***

## 2. Parameter einer Funktion umbenennen

**Problem:** Funktionsparameter `a_param` ist nicht sprechend.

**Originalcode:**

```python
code = '''
def a_func(a_param):
    print(a_param)

a_func(a_param=10)
a_func(10)
'''
print(code)
```

**Refactoring:**

```python
from rope.base.project import Project
from rope.refactor.rename import Rename

project = Project('.')
fname = 'memory2.py'
with open(fname, 'w') as f:
    f.write(code)
resource = project.get_file(fname)
change = Rename(project, resource).get_changes('new_param')
project.do(change)
with open(fname) as f:
    print(f.read())
project.close()
```


***

## 3. Extract Method (Codeauszug als eigene Funktion)

**Problem:** Zu viel Logik in einer Funktion – ein Teil davon soll ausgelagert werden.

**Originalcode:**

```python
code = '''
def a_func():
    a = 1
    b = 2 * a
    c = a * 2 + b * 3
    print(b, c)
'''
print(code)
```

**Extract-Refactoring (Offsets für den Mittelteil berechnen):**

```python
from rope.base.project import Project
from rope.refactor.extract import ExtractMethod

project = Project('.')
fname = 'memory3.py'
with open(fname, 'w') as f:
    f.write(code)
resource = project.get_file(fname)

lines = code.splitlines(True)
# Annahme: Zeile 3-4 sollen extrahiert werden (zeilen-Offsets berechnen)
start = sum(len(l) for l in lines[:2])
end = sum(len(l) for l in lines[:4])
extractor = ExtractMethod(project, resource, start, end)
change = extractor.get_changes('new_func')
project.do(change)
with open(fname) as f:
    print(f.read())
project.close()
```


***

## 4. Inline Refactoring (Funktion wird durch ihren Wert ersetzt)

**Problem:** Die Funktion `helper` ist überflüssig.

**Originalcode:**

```python
code = '''
def helper(x):
    return x ** 2

result = helper(3)
'''
print(code)
```

**Inline-Refactoring:**

```python
from rope.base.project import Project
from rope.refactor.inline import create_inline

project = Project('.')
fname = 'memory4.py'
with open(fname, 'w') as f:
    f.write(code)
resource = project.get_file(fname)

# Offset für 'helper' (erste Vorkommnis)
offset = code.find('helper')
inline = create_inline(project, resource, offset)
change = inline.get_changes()
project.do(change)
with open(fname) as f:
    print(f.read())
project.close()
```


***

**Hinweise:**

- Für produktive Notebooks empfiehlt sich die Nutzung von temporären, im Kernel gesteuerten Dateien wie in den Beispielen.
- Jede Zelle kann einzeln getestet werden – Variablennamen und Dateinamen sollten pro Beispiel unterschiedlich gewählt werden.
- Rope manipuliert Code-dateien, daher werden Mini-Dateien für die Arbeit verwendet. Ein kompletter In-Memory-Workflow ist mit Rope selbst aktuell nicht vorgesehen.

***

Dieses Arbeitsblatt bietet so eine „hands-on“ Refactoring-Einführung für den sofortigen Einsatz in der JupyterLab-Umgebung, ohne auf externe, reale Projektdaten angewiesen zu sein.


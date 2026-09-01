Die Variable `__name__` hat in Python eine besondere Bedeutung und wird häufig verwendet, um zu bestimmen, ob ein Skript direkt ausgeführt oder als Modul importiert wird. Hier ist eine Erklärung mit einem praktischen Beispiel, das in einem JupyterLab Notebook direkt ausgeführt werden kann:

```python
# Zelle 1: Erstellen und Anzeigen von example_module.py
module_code = '''
def greet():
    print("Hallo aus der greet()-Funktion!")

if __name__ == "__main__":
    print("Dieses Skript wird direkt ausgeführt.")
    print(f"Der Wert von __name__ ist: {__name__}")
    greet()
else:
    print("Dieses Skript wurde als Modul importiert.")
    print(f"Der Wert von __name__ ist: {__name__}")

print(f"__name__ am Ende des Skripts: {__name__}")
'''

# Schreiben des Codes in die Datei
with open('example_module.py', 'w') as f:
    f.write(module_code)

# Anzeigen des Inhalts der erstellten Datei
print("Inhalt von example_module.py:")
print(module_code)
```

```python
# Zelle 2: Direkte Ausführung
print("Direkte Ausführung des Skripts:")
%run example_module.py
```

```python
# Zelle 3: Import als Modul
print("\nImport als Modul:")
import example_module

print("\nAufruf der importierten Funktion:")
example_module.greet()
```

## Erklärung

1. Die erste Zelle erstellt die Datei `example_module.py` mit dem definierten Code und zeigt ihren Inhalt an.
2. Die zweite Zelle führt das Skript direkt aus, wobei `__name__` den Wert `"__main__"` hat.
3. Die dritte Zelle importiert das Skript als Modul und ruft die `greet()`-Funktion auf.

## Erwartete Ausgabe

Bei Ausführung der Zellen nacheinander sollte folgende Ausgabe erscheinen:

```
Inhalt von example_module.py:
[Inhalt des Moduls wird hier angezeigt]

Direkte Ausführung des Skripts:
Dieses Skript wird direkt ausgeführt.
Der Wert von __name__ ist: __main__
Hallo aus der greet()-Funktion!
__name__ am Ende des Skripts: __main__

Import als Modul:
Dieses Skript wurde als Modul importiert.
Der Wert von __name__ ist: example_module
__name__ am Ende des Skripts: example_module

Aufruf der importierten Funktion:
Hallo aus der greet()-Funktion!
```

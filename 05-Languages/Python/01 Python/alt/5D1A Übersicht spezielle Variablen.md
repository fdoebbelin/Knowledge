Hier ist eine Übersicht der wichtigsten speziellen Variablen (auch als "dunder"-Variablen bekannt) in Python:

## Modul-bezogene Variablen

- `__name__`: 
	- Enthält den Namen des aktuellen Moduls. 
	- Wird auf `"__main__"` gesetzt, wenn das Skript direkt ausgeführt wird[1].
- `__file__`: 
	- Gibt den Dateipfad des aktuellen Moduls an.
- `__doc__`: 
	- Enthält den Docstring des Moduls, der Klasse oder der Funktion.

## Klassen-bezogene Variablen

- `__init__(self, ...)`: 
	- Konstruktor-Methode für Klasseninstanziierung.
- `__str__(self)`: 
	- Definiert die String-Repräsentation eines Objekts für `print()`.
- `__repr__(self)`: 
	- Definiert die detaillierte String-Repräsentation eines Objekts.
- `__len__(self)`: 
	- Ermöglicht die Verwendung von `len()` auf Objekten der Klasse.

## Operator-Überladung

- `__add__(self, other)`: 
	- Überschreibt den `+`-Operator.
- `__sub__(self, other)`: 
	- Überschreibt den `-`-Operator.
- `__mul__(self, other)`: 
	- Überschreibt den `*`-Operator.
- `__truediv__(self, other)`: 
	- Überschreibt den `/`-Operator.

## Iteration und Sequenzen

- `__iter__(self)`: 
	- Macht ein Objekt iterierbar[1].
- `__next__(self)`: 
	- Definiert das Verhalten für den nächsten Iterationsschritt[1].
- `__getitem__(self, key)`: 
	- Ermöglicht den Zugriff auf Elemente wie bei Listen oder Dictionaries.

## Attribute und Methoden

- `__getattr__(self, name)`: 
	- Wird aufgerufen, wenn auf ein nicht existierendes Attribut zugegriffen wird.
- `__setattr__(self, name, value)`: 
	- Wird beim Setzen eines Attributs aufgerufen.
- `__call__(self, ...)`: 
	- Ermöglicht es, Instanzen wie Funktionen aufzurufen.

## Kontextmanager

- `__enter__(self)`: 
	- Definiert das Verhalten beim Betreten eines `with`-Blocks.
- `__exit__(self, exc_type, exc_value, traceback)`: 
	- Definiert das Verhalten beim Verlassen eines `with`-Blocks.

Diese speziellen Variablen und Methoden bieten mächtige Möglichkeiten zur Anpassung des Verhaltens von Klassen und Objekten in Python. Sie ermöglichen es, die Funktionalität von Objekten zu erweitern und an spezifische Anforderungen anzupassen.
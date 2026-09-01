---
aliases: 
tags: 
title: 5D4G1 Dataclass
---

Eine Dataclass in Python ist eine spezielle Art von Klasse, die hauptsächlich zum Speichern und Verwalten von Daten dient. Sie wurde in Python 3.7 mit dem Modul `dataclasses` eingeführt und bietet eine vereinfachte Möglichkeit, Klassen zu erstellen, die primär als Datencontainer fungieren.

Hier sind die wichtigsten Merkmale und Vorteile von Dataclasses:

1. Automatische Methodengenerierung:
	 - Der `@dataclass` Dekorator generiert automatisch spezielle Methoden wie `__init__`, `__repr__`, `__eq__` und `__hash__`.

2. Prägnante Syntax:
	 - Dataclasses reduzieren den Boilerplate-Code erheblich, indem sie eine kompakte Syntax zur Definition von Klassenattributen verwenden.

3. Typ-Annotationen:
	 - Dataclasses integrieren sich nahtlos mit Python's Typ-Hinweis-System, was die Lesbarkeit und statische Codeanalyse verbessert.

4. Standardwerte:
	 - Es können einfach Standardwerte für Attribute definiert werden.

5. Unveränderlichkeit:
	 - Mit dem Parameter `frozen=True` können unveränderliche Instanzen erstellt werden.

6. Vergleichsmethoden:
	 - Dataclasses bieten automatisch implementierte Vergleichsmethoden wie `__eq__`, `__lt__`, `__gt__` etc..

7. Vererbung:
	 - Dataclasses unterstützen Vererbung, sodass Unterklassen mit zusätzlichen Attributen oder Methoden erstellt werden können.

Beispiel einer einfachen Dataclass:

```python
from dataclasses import dataclass

@dataclass
class Person:
    name: str
    alter: int
    stadt: str = "Berlin"

person = Person("Max", 30)
print(person)  # Ausgabe: Person(name='Max', alter=30, stadt='Berlin')
```

In diesem Beispiel wird eine `Person`-Klasse mit drei Attributen definiert. Der `@dataclass` Dekorator sorgt dafür, dass die notwendigen Methoden automatisch generiert werden.

Dataclasses sind besonders nützlich, wenn Sie Klassen erstellen möchten, die hauptsächlich Daten speichern und wenig zusätzliche Funktionalität benötigen. Sie machen den Code kürzer, lesbarer und wartungsfreundlicher, insbesondere bei Klassen mit vielen Attributen.

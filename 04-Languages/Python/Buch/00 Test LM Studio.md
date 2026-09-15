 Hier ist eine Einführung in Python OOP (Object-Oriented Programming) im Format von Markdown-Dokumenten, das Sie in Jupyter Lab ausführen können und Ergebnisse sehen:

# Python Object-Oriented Programming (OOP)

## Definition eines Klasses

```python
class MyClass:
    def __init__(self, name):  # Konstruktor
        self.name = name

    def say_hello(self):  # Methode
        print("Hello, my name is " + self.name)

# Erstellen eines Objekts der Klasse MyClass
my_obj = MyClass("John Doe")
```

## Ausführen der Methode des Objekts

```python
my_obj.say_hello()  # Ergebnis: Hello, my name is John Doe
```

## Definition einer Klasse mit Attributen und Methoden

```python
class MyClass:
    def __init__(self, name):  # Konstruktor
        self.name = name
        self.age = 30

    def say_hello(self):  # Methode
        print("Hello, my name is " + self.name + ", and I'm " + str(self.age) + " years old.")
```

## Ausführen der Methode des Objekts mit Attributen

```python
my_obj = MyClass("Jane Smith")
my_obj.say_hello()  # Ergebnis: Hello, my name is Jane Smith, and I'm 30 years old.
```
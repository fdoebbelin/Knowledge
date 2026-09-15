---
aliases: 
tags: 
title: 5D5D Versionskontrolle
---

## 1. Projekt erstellen und initialen Code schreiben

Zunächst erstellen wir eine einfache Konsolenanwendung:

1. Öffnen Sie PyCharm und wählen Sie "Create New Project".
2. Wählen Sie "Pure Python" als Projekttyp.
3. Benennen Sie das Projekt (z.B. "SimpleCalculator") und wählen Sie den Speicherort.
4. Klicken Sie auf "Create".

Erstellen Sie nun eine neue Python-Datei namens `calculator.py`:

```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

if __name__ == "__main__":
    print("Willkommen zum einfachen Taschenrechner!")
    num1 = float(input("Geben Sie die erste Zahl ein: "))
    num2 = float(input("Geben Sie die zweite Zahl ein: "))
    print(f"Addition: {add(num1, num2)}")
    print(f"Subtraktion: {subtract(num1, num2)}")
```

## 2. Git-Repository initialisieren

1. Gehen Sie zu "VCS" > "Enable Version Control Integration" in der Menüleiste.
2. Wählen Sie "Git" aus dem Dropdown-Menü und klicken Sie auf "OK".
3. PyCharm erstellt nun ein lokales Git-Repository für Ihr Projekt.

## 3. Ersten Commit durchführen

1. Öffnen Sie das "Commit"-Fenster durch Klicken auf "Commit" in der linken Seitenleiste oder durch Drücken von `Ctrl+K` (Windows/Linux) oder `Cmd+K` (Mac).
2. Wählen Sie alle Dateien aus, die Sie committen möchten.
3. Geben Sie eine Commit-Nachricht ein, z.B. "Initial commit: Basic calculator functionality".
4. Klicken Sie auf "Commit".

## 4. Neue Funktion hinzufügen

Fügen wir nun eine Multiplikationsfunktion hinzu:

1. Öffnen Sie `calculator.py`.
2. Fügen Sie folgende Funktion hinzu:

```python
def multiply(a, b):
    return a * b
```

1. Aktualisieren Sie den Hauptteil der Anwendung:

```python
if __name__ == "__main__":
    print("Willkommen zum einfachen Taschenrechner!")
    num1 = float(input("Geben Sie die erste Zahl ein: "))
    num2 = float(input("Geben Sie die zweite Zahl ein: "))
    print(f"Addition: {add(num1, num2)}")
    print(f"Subtraktion: {subtract(num1, num2)}")
    print(f"Multiplikation: {multiply(num1, num2)}")
```

## 5. Änderungen committen

1. Öffnen Sie erneut das "Commit"-Fenster.
2. Sie sehen die geänderte Datei `calculator.py`.
3. Geben Sie eine aussagekräftige Commit-Nachricht ein, z.B. "Add multiplication function".
4. Klicken Sie auf "Commit".

## 6. Branch erstellen für neue Funktion

1. Klicken Sie auf den Branch-Namen in der oben rechten Ecke der IDE (standardmäßig "main" oder "master").
2. Wählen Sie "New Branch".
3. Geben Sie einen Namen für den neuen Branch ein, z.B. "division-feature".
4. Klicken Sie auf "Create".

## 7. Neue Funktion im Branch entwickeln

1. Fügen Sie eine Divisionsfunktion in `calculator.py` hinzu:

```python
def divide(a, b):
    if b != 0:
        return a / b
    else:
        return "Error: Division durch Null!"
```

1. Aktualisieren Sie den Hauptteil entsprechend:

```python
if __name__ == "__main__":
    print("Willkommen zum einfachen Taschenrechner!")
    num1 = float(input("Geben Sie die erste Zahl ein: "))
    num2 = float(input("Geben Sie die zweite Zahl ein: "))
    print(f"Addition: {add(num1, num2)}")
    print(f"Subtraktion: {subtract(num1, num2)}")
    print(f"Multiplikation: {multiply(num1, num2)}")
    print(f"Division: {divide(num1, num2)}")
```

## 8. Änderungen im Feature-Branch committen

1. Öffnen Sie das "Commit"-Fenster.
2. Wählen Sie die geänderte Datei aus.
3. Geben Sie eine Commit-Nachricht ein, z.B. "Add division function".
4. Klicken Sie auf "Commit".

## 9. Merge des Feature-Branches

1. Wechseln Sie zurück zum Hauptbranch (main/master) über das Branch-Menü.
2. Gehen Sie zu "VCS" > "Git" > "Merge".
3. Wählen Sie den "division-feature"-Branch aus.
4. Klicken Sie auf "Merge".

## 10. Push der Änderungen zu einem Remote-Repository

Wenn Sie ein Remote-Repository (z.B. auf GitHub) eingerichtet haben:

1. Gehen Sie zu "VCS" > "Git" > "Push".
2. Wählen Sie den Branch aus, den Sie pushen möchten.
3. Klicken Sie auf "Push".

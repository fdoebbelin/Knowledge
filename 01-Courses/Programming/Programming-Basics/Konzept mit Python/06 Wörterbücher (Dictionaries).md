## Einführung

Ein **Dictionary** (Wörterbuch) in Python ist eine Datenstruktur, die es ermöglicht, Daten in **Schlüssel-Wert-Paaren** zu speichern. Im Gegensatz zu Listen, bei denen der Zugriff über Indizes erfolgt, verwenden Dictionaries eindeutige Schlüssel, um auf die zugehörigen Werte zuzugreifen.
## 1. Anlegen eines Dictionaries

### Erklärung

Ein Dictionary wird mit geschweiften Klammern `{}` angelegt. Schlüssel und Werte werden durch einen Doppelpunkt `:` getrennt, und Paare werden durch Kommas `,` getrennt.

### Codebeispiel: Erstellen eines Dictionaries

```python
# Ein einfaches Dictionary erstellen
mein_dictionary = {
    "Name": "Max",
    "Alter": 25,
    "Beruf": "Entwickler"
}
print("Mein Dictionary:", mein_dictionary)
```
## 2. Zugriff auf Werte

### Erklärung

Auf Werte in einem Dictionary greift man über den zugehörigen Schlüssel zu. Wenn ein Schlüssel nicht existiert, wird ein `KeyError` ausgelöst, es sei denn, man verwendet die Methode `get()`.

### Codebeispiel: Zugriff auf Werte

```python
# Zugriff auf einen Wert über den Schlüssel
print("Name:", mein_dictionary["Name"])  # Max

# Zugriff mit der get-Methode (empfohlen)
alter = mein_dictionary.get("Alter")
print("Alter:", alter)  # 25

# Zugriff auf einen nicht vorhandenen Schlüssel mit Standardwert
geschlecht = mein_dictionary.get("Geschlecht", "Nicht angegeben")
print("Geschlecht:", geschlecht)  # Nicht angegeben
```
## 3. Hinzufügen, Ändern und Entfernen von Einträgen

### Erklärung

- **Hinzufügen:** Einträge werden durch Zuweisung eines Werts zu einem neuen Schlüssel hinzugefügt.
- **Ändern:** Werte können durch erneutes Zuweisen des Schlüssels verändert werden.
- **Entfernen:** Einträge werden mit der Methode `pop()` oder dem Schlüsselwort `del` entfernt.

### Codebeispiel: Einträge hinzufügen und ändern

```python
# Einen neuen Eintrag hinzufügen
mein_dictionary["Geschlecht"] = "Männlich"
print("Nach Hinzufügen:", mein_dictionary)

# Einen bestehenden Eintrag ändern
mein_dictionary["Alter"] = 26
print("Nach Änderung:", mein_dictionary)
```

### Codebeispiel: Einträge entfernen

```python
# Einen Eintrag mit pop entfernen
beruf = mein_dictionary.pop("Beruf")
print("Entfernter Eintrag:", beruf)
print("Nach dem Entfernen:", mein_dictionary)

# Einen Eintrag mit del entfernen
del mein_dictionary["Name"]
print("Nach dem Löschen des Namens:", mein_dictionary)
```
## 4. Iteration über ein Dictionary

### Erklärung

Man kann über die Schlüssel, Werte oder Schlüssel-Wert-Paare eines Dictionaries iterieren. Die Methoden `keys()`, `values()` und `items()` sind dafür nützlich.

### Codebeispiel: Iteration über Schlüssel und Werte

```python
# Iteration über die Schlüssel
for schluessel in mein_dictionary.keys():
    print("Schlüssel:", schluessel)

# Iteration über die Werte
for wert in mein_dictionary.values():
    print("Wert:", wert)

# Iteration über Schlüssel-Wert-Paare
for schluessel, wert in mein_dictionary.items():
    print(f"{schluessel}: {wert}")
```
## 5. Einsatzmöglichkeiten von Dictionaries

### Erklärung

Dictionaries sind nützlich, um Daten zu strukturieren und logisch zu verknüpfen, z. B. bei der Speicherung von Benutzerdaten, Konfigurationswerten oder Datenbankeinträgen.

### Codebeispiel: Benutzerprofil speichern

```python
# Benutzerprofil in einem Dictionary speichern
benutzer = {
    "Benutzername": "max123",
    "E-Mail": "max@example.com",
    "Interessen": ["Programmieren", "Lesen", "Reisen"]
}

# Zugriff auf verschachtelte Daten
print("Interessen:", benutzer["Interessen"])
```
## 6. Übungen

### Übung 1: Grundlegende Arbeit mit Dictionaries

1. Erstellen Sie ein Dictionary mit den Schlüsseln `Vorname`, `Nachname` und `Alter` und füllen Sie es mit Werten.
2. Greifen Sie auf den Wert des Schlüssels `Alter` zu.
3. Fügen Sie einen neuen Schlüssel `Beruf` hinzu und weisen Sie ihm einen Wert zu.
4. Entfernen Sie den Schlüssel `Nachname`.

### Übung 2: Iteration und Zugriff

1. Erstellen Sie ein Dictionary mit den Namen und Geburtsjahren von drei Personen.
2. Iterieren Sie über das Dictionary und geben Sie für jede Person den Namen und das Geburtsjahr aus.
3. Fügen Sie einen neuen Eintrag für eine vierte Person hinzu.
## 7. Fazit

Dictionaries sind eine der flexibelsten und nützlichsten Datenstrukturen in Python. Sie ermöglichen die Speicherung von Daten in einer klar strukturierten Form. Nutzen Sie sie, um Ihre Programme effizienter und übersichtlicher zu gestalten.
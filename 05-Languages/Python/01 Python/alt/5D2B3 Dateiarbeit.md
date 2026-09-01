---
aliases: 
tags: 
title: 5D2B4 Dateiarbeit
---

## 1. Datei öffnen und schließen

In Python verwenden wir die `open()`-Funktion, um Dateien zu öffnen. Es ist wichtig, Dateien nach der Verwendung wieder zu schließen.

```python
# Datei öffnen
file = open('beispiel.txt', 'r')

# Datei schließen
file.close()

print("Datei wurde geöffnet und geschlossen.")
```

Besser ist es, den `with`-Kontext-Manager zu verwenden, der die Datei automatisch schließt:

```python
with open('beispiel.txt', 'r') as file:
    # Hier mit der Datei arbeiten
    print("Datei ist geöffnet und wird automatisch geschlossen.")
```

## 2. Dateien lesen

### Gesamten Inhalt lesen

```python
with open('beispiel.txt', 'r') as file:
    inhalt = file.read()
    print("Inhalt der Datei:")
    print(inhalt)
```

### Zeilenweise lesen

```python
print("Zeilenweiser Inhalt der Datei:")
with open('beispiel.txt', 'r') as file:
    for zeile in file:
        print(zeile.strip())
```

## 3. In Dateien schreiben

### 3.1. Neue Datei erstellen und schreiben

```python
with open('neue_datei.txt', 'w') as file:
    file.write('Hallo, Welt!\n')
    file.write('Dies ist eine neue Zeile.')

print("Neue Datei wurde erstellt und beschrieben.")
```

### 3.2. An bestehende Datei anhängen

```python
with open('beispiel.txt', 'a') as file:
    file.write('\nDiese Zeile wird angehängt.')

print("Neue Zeile wurde an die Datei angehängt.")
```

## 4. Dateimodi

- `'r'`: Lesen (Standard)
- `'w'`: Schreiben (überschreibt existierende Datei)
- `'a'`: Anhängen
- `'r+'`: Lesen und Schreiben
- `'b'`: Binärmodus (z.B. 'rb' für binäres Lesen)

```python
print("Verfügbare Dateimodi:")
modi = ['r', 'w', 'a', 'r+', 'b']
for modus in modi:
    print(f"- '{modus}'")
```

## 5. Übung

1. Erstellen Sie eine Textdatei namens "`einkaufsliste.txt`" und schreiben Sie einige Artikel hinein.
2. Lesen Sie den Inhalt der Datei und geben Sie ihn aus.
3. Fügen Sie der Liste einen neuen Artikel hinzu.
4. Lesen Sie die aktualisierte Liste und geben Sie sie aus.

```python
# Hier können Sie Ihren Code für die Übung schreiben
# Beispiel:
with open('einkaufsliste.txt', 'w') as file:
    file.write("Äpfel\nBrot\nMilch")

print("Ursprüngliche Einkaufsliste:")
with open('einkaufsliste.txt', 'r') as file:
    print(file.read())

with open('einkaufsliste.txt', 'a') as file:
    file.write("\nKäse")

print("\nAktualisierte Einkaufsliste:")
with open('einkaufsliste.txt', 'r') as file:
    print(file.read())
```

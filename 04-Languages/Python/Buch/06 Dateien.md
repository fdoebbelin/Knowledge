In diesem Notebook werden verschiedene Methoden zum Lesen und Schreiben von Dateien in Python demonstriert, basierend auf dem Kapitel 6 "Dateien" aus dem Kursmaterial.

## 1. Grundlagen zu Datenströmen

- Datenströme sind kontinuierliche Folgen von Daten
- Zwei Typen: eingehende Datenströme (downstreams) und ausgehende Datenströme (upstreams)
- Standardströme: stdin (Eingabe) und stdout (Ausgabe)
- Datenströme können im Text- oder Binärmodus geöffnet werden

## 2. Dateien lesen

### 2.1 Eine Datei öffnen und schließen

```python
def datei_oeffnen_schliessen(dateipfad):
    """Öffnet eine Datei zum Lesen und schließt sie wieder."""
    fobj = open(dateipfad, "r")
    # Hier würden Operationen auf der Datei ausgeführt
    fobj.close()
    return f"Datei {dateipfad} wurde geöffnet und geschlossen"
```

```python
# Beispielaufruf
datei_oeffnen_schliessen("woerterbuch.txt")
```

### 2.2 Die with-Anweisung

- Die with-Anweisung stellt sicher, dass das Dateiobjekt immer korrekt geschlossen wird
- Auch bei Fehlern wird die Datei ordnungsgemäß geschlossen
- Empfohlene Methode zum Umgang mit Dateien

```python
def datei_with_anweisung(dateipfad):
    """Öffnet eine Datei mit der with-Anweisung, die automatisch für korrektes Schließen sorgt."""
    with open(dateipfad, "r") as fobj:
        # Hier würden Operationen auf der Datei ausgeführt
        pass
    return f"Datei {dateipfad} wurde mit with-Anweisung geöffnet und automatisch geschlossen"
```

```python
# Beispielaufruf
datei_with_anweisung("woerterbuch.txt")
```

### 2.3 Den Dateiinhalt auslesen

- Dateiobjekte sind zeilenweise iterierbar
- Mit einer for-Schleife kann über die Zeilen einer Datei iteriert werden

```python
def zeilen_ausgeben(dateipfad):
    """Liest eine Datei zeilenweise ein und gibt die Zeilen zurück."""
    zeilen = []
    with open(dateipfad, "r") as fobj:
        for line in fobj:
            zeilen.append(line)
    return zeilen
```

```python
# Beispielaufruf
zeilen_ausgeben("woerterbuch.txt")
```

### 2.4 Ein Wörterbuch aus einer Datei erstellen

- Beispiel: Wörterbuch mit englischen Begriffen und deutschen Übersetzungen
- Daten werden aus einer Datei gelesen und in ein Dictionary gespeichert

```python
def woerterbuch_erstellen(dateipfad):
    """Erstellt ein Wörterbuch aus einer Datei mit englisch-deutschen Begriffspaaren."""
    woerter = {}
    with open(dateipfad, "r") as fobj:
        for line in fobj:
            line = line.strip()  # Entfernt Whitespace am Anfang und Ende
            zuordnung = line.split(" ")
            if len(zuordnung) == 2:  # Betrachte nur gültige Zeilen
                woerter[zuordnung[0]] = zuordnung[1]
    return woerter
```

```python
# Beispielaufruf
woerterbuch = woerterbuch_erstellen("woerterbuch.txt")
woerterbuch
```

### 2.5 Übersetzungsprogramm

- Interaktives Programm, das ein Wörterbuch verwendet, um Begriffe zu übersetzen
- Hier als Funktion implementiert, die eine Simulation der Benutzerabfrage durchführt

```python
def uebersetzungsprogramm(dateipfad, anfragen):
    """Simuliert ein Übersetzungsprogramm, das Anfragen beantwortet."""
    woerter = {}
    with open(dateipfad, "r") as fobj:
        for line in fobj:
            line = line.strip()
            zuordnung = line.split(" ")
            if len(zuordnung) == 2:
                woerter[zuordnung[0]] = zuordnung[1]
    
    ergebnisse = []
    for wort in anfragen:
        if wort in woerter:
            ergebnisse.append(f"Das deutsche Wort für {wort} lautet: {woerter[wort]}")
        else:
            ergebnisse.append(f"Das Wort {wort} ist unbekannt")
    
    return ergebnisse
```

```python
# Beispielaufruf: Übersetze einige englische Wörter
uebersetzungsprogramm("woerterbuch.txt", ["Germany", "Italy", "Greece"])
```

## 3. Dateien schreiben

### 3.1 In eine Datei schreiben

```python
def in_datei_schreiben(dateipfad, inhalt):
    """Schreibt einen String in eine Datei."""
    with open(dateipfad, "w") as fobj:
        fobj.write(inhalt)
    return f"Inhalt wurde in {dateipfad} geschrieben"
```

```python
# Beispielaufruf
in_datei_schreiben("ausgabe.txt", "Dies ist ein Testtext.")
```

### 3.2 Wörterbuch in eine Datei schreiben

```python
def woerterbuch_in_datei_schreiben(dateipfad, woerter):
    """Schreibt ein Wörterbuch in eine Datei."""
    with open(dateipfad, "w") as fobj:
        for engl in woerter:
            fobj.write(f"{engl} {woerter[engl]}\n")
    return f"Wörterbuch wurde in {dateipfad} geschrieben"
```

```python
# Beispielaufruf
test_woerterbuch = {
    "Germany": "Deutschland",
    "Spain": "Spanien",
    "Greece": "Griechenland"
}
woerterbuch_in_datei_schreiben("ausgabe.txt", test_woerterbuch)
```

## 4. Fortgeschrittene Dateioperationen

### 4.1 Die Schreib-/Leseposition verändern

- Mit seek() und tell() kann die Position in der Datei verändert und abgefragt werden
- Besonders nützlich bei Binärdateien

```python
def bitmap_info_auslesen(dateipfad):
    """Liest Breite, Höhe und Farbtiefe aus einer Bitmap-Datei aus."""
    from struct import unpack
    
    with open(dateipfad, "rb") as f:
        f.seek(18)
        breite, hoehe = unpack("ii", f.read(8))
        f.seek(2, 1)  # 2 Bytes von aktueller Position weitergehen
        bpp = unpack("H", f.read(2))[0]
    
    return {
        "Breite": breite,
        "Höhe": hoehe,
        "Farbtiefe": bpp
    }
```

```python
# Beispielaufruf
bitmap_info_auslesen("kaffee.bmp")
```

### 4.2 Verschiedene Dateimodi


| Modus                                              | Beschreibung                                                                                                                                                                                   |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| "r"                                                | Die Datei wird ausschließlich zum Lesen geöffnet.                                                                                                                                              |
| "w"                                                | Die Datei wird ausschließlich zum Schreiben geöffnet. Eine eventuell bestehende Datei gleichen Namens wird überschrieben.                                                                      |
| "a"                                                | Die Datei wird ausschließlich zum Schreiben geöffnet. Eine eventuell bestehende Datei gleichen Namens wird nicht überschrieben, sondern erweitert.                                             |
| "x"                                                | Die Datei wird ausschließlich zum Schreiben geöffnet, sofern sie nicht bereits existiert. Wenn bereits eine Datei gleichen Namens vorhanden ist, wird eine FileExistsError-Exception geworfen. |
| "r+", "w+", "a+", "x+"                             | Die Datei wird zum Lesen und Schreiben geöffnet. Beachten Sie, dass "w+" eine eventuell bestehende Datei gleichen Namens leert.                                                                |
| "rb", "wb", "ab", "xb", "r+b", "w+b", "a+b", "x+b" | Die Datei wird im Binärmodus geöffnet. Beachten Sie, dass in diesem Fall bytes-Instanzen anstelle von Strings verwendet werden müssen.                                                         |

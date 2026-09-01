## Zielsetzung
In diesem Arbeitsblatt lernen Sie, wie Sie mit draw.io professionelle UML-Klassendiagramme für Python-Klassen erstellen. Sie werden praktische Übungen zu allen vier Kursprojekten durchführen und dabei die wichtigsten OOP-Konzepte visualisieren.

---

## 1. Grundlagen: Was sind UML-Klassendiagramme?

### Was ist UML?
**UML (Unified Modeling Language)** ist eine standardisierte grafische Modellierungssprache zur Visualisierung, Spezifikation und Dokumentation von Software-Systemen. Klassendiagramme sind dabei die wichtigste Diagrammart für die objektorientierte Programmierung.

### Aufbau einer Klasse im UML-Diagramm
Jede Klasse wird als rechteckiges Kästchen mit drei Bereichen dargestellt:

```
┌─────────────────┐
│   Klassenname   │  ← Klassennamen (fett, zentriert)
├─────────────────┤
│   - attribut1   │  ← Attribute (Eigenschaften)
│   + attribut2   │
├─────────────────┤
│   + methode1()  │  ← Methoden (Verhalten)
│   - methode2()  │
└─────────────────┘
```

### Sichtbarkeitsmodifikatoren
- **+ (public)**: Von außen zugreifbar
- **- (private)**: Nur innerhalb der Klasse zugreifbar  
- **# (protected)**: Nur in der Klasse und Unterklassen zugreifbar

---

## 2. draw.io Grundlagen

### 2.1 draw.io starten
1. Öffnen Sie https://app.diagrams.net (oder diagrams.net)
2. Wählen Sie einen Speicherort (z.B. "Device" für lokale Speicherung)
3. Klicken Sie auf "Create New Diagram"
4. Wählen Sie "Blank Diagram" und geben Sie einen Dateinamen ein

### 2.2 UML-Bibliotheken aktivieren
1. Klicken Sie links unten auf **"More Shapes..."**
2. Scrollen Sie zum Bereich **"Software"**
3. Aktivieren Sie **"UML"** und **"UML 2.5"**
4. Klicken Sie **"Apply"**

### 2.3 Erste Klasse erstellen
1. Suchen Sie in der linken Seitenleiste nach **"Class"**
2. Ziehen Sie eine **"Class"**-Form auf die Zeichenfläche
3. Doppelklicken Sie zum Bearbeiten des Texts
4. Fügen Sie Klassenname, Attribute und Methoden hinzu

---

## 3. Python-spezifische Besonderheiten in UML

### 3.1 Python-Konstruktor
In Python heißt der Konstruktor `__init__()`. Im UML-Diagramm wird er normal dargestellt:

**Python-Code:**
```python
Anthropic```

**UML-Darstellung:**
```
┌─────────────────┐
│     Person      │
├─────────────────┤
│   - name: str   │
│   - alter: int  │
├─────────────────┤
│ + __init__(name,│
│   alter)        │
└─────────────────┘
```

### 3.2 Python-Datentypen
- `str` für Strings
- `int` für ganze Zahlen  
- `float` für Dezimalzahlen
- `bool` für Boolean-Werte
- `list` für Listen
- `dict` für Dictionaries

---

## 4. Praktische Übungen

### Übung 1: PersonalPrinz - Einfache Klasse

**Python-Code:**
```python
class Mitarbeiter:
    def __init__(self, personalnummer, vorname, nachname):
        self.personalnummer = personalnummer
        self.vorname = vorname
        self.nachname = nachname
        self.urlaubstage = 30
        self.stundenkonto = 0.0
        
    def urlaub_beantragen(self, tage):
        if self.urlaubstage >= tage:
            self.urlaubstage -= tage
            return True
        return False
    
    def stunden_buchen(self, stunden):
        self.stundenkonto += stunden
    
    def __str__(self):
        return f"{self.vorname} {self.nachname} ({self.personalnummer})"
```

**Ihre Aufgabe:**
1. Erstellen Sie in draw.io ein UML-Klassendiagramm für die `Mitarbeiter`-Klasse
2. Achten Sie auf korrekte Sichtbarkeitsmodifikatoren
3. Fügen Sie Datentypen hinzu
4. Berücksichtigen Sie Parameter und Rückgabetypen

**Erwartetes Ergebnis:**
```
┌─────────────────────────────────┐
│           Mitarbeiter           │
├─────────────────────────────────┤
│ - personalnummer: str           │
│ - vorname: str                  │
│ - nachname: str                 │
│ - urlaubstage: int              │
│ - stundenkonto: float           │
├─────────────────────────────────┤
│ + __init__(personalnummer: str,│
│   vorname: str, nachname: str)  │
│ + urlaub_beantragen(tage: int): │
│   bool                          │
│ + stunden_buchen(stunden: float)│
│ + __str__(): str                │
└─────────────────────────────────┘
```

### Übung 2: WetterWeiser - Vererbung

**Python-Code:**
```python
class WetterDaten:
    def __init__(self, datum, temperatur):
        self.datum = datum
        self.temperatur = temperatur
    
    def anzeigen(self):
        return f"Datum: {self.datum}, Temperatur: {self.temperatur}°C"

class ErweiterteWetterDaten(WetterDaten):
    def __init__(self, datum, temperatur, niederschlag, luftfeuchtigkeit):
        super().__init__(datum, temperatur)
        self.niederschlag = niederschlag
        self.luftfeuchtigkeit = luftfeuchtigkeit
    
    def ist_regenTag(self):
        return self.niederschlag > 0
    
    def anzeigen(self):
        basis_info = super().anzeigen()
        return f"{basis_info}, Niederschlag: {self.niederschlag}mm"
```

**Ihre Aufgabe:**
1. Erstellen Sie zwei Klassen: `WetterDaten` und `ErweiterteWetterDaten`
2. Verbinden Sie sie mit einem **Vererbungspfeil** (durchgezogene Linie mit geschlossenem Dreieck)
3. Die abgeleitete Klasse überschreibt die `anzeigen()`-Methode

**Tipp:** Vererbungspfeil finden Sie in der UML-Bibliothek unter "Inheritance"

### Übung 3: KeyRecognition - Komposition

**Python-Code:**
```python
class FunkSignal:
    def __init__(self, frequenz, staerke):
        self.frequenz = frequenz
        self.staerke = staerke
        self.modulation = None
    
    def set_modulation(self, mod_typ):
        self.modulation = mod_typ

class AutoSchluessel:
    def __init__(self, marke, modell, frequenz):
        self.marke = marke
        self.modell = modell
        self.signal = FunkSignal(frequenz, 100)  # Komposition!
    
    def senden(self):
        return f"{self.marke} {self.modell} sendet auf {self.signal.frequenz} MHz"
```

**Ihre Aufgabe:**
1. Erstellen Sie beide Klassen als UML-Diagramm
2. Verbinden Sie sie mit einem **Kompositionspfeil** (durchgezogene Linie mit gefülltem Diamant)
3. Der Diamant zeigt zur "Container"-Klasse (`AutoSchluessel`)
4. Fügen Sie die Multiplizität "1" hinzu

**Tipp:** Komposition bedeutet "hat ein" - wenn der Autoschlüssel gelöscht wird, wird auch das FunkSignal gelöscht.

### Übung 4: Py2Rust - Assoziation

**Python-Code:**
```python
class PythonKlasse:
    def __init__(self, name):
        self.name = name
        self.methoden = []
        self.attribute = []
    
    def add_methode(self, methode_name):
        self.methoden.append(methode_name)
    
    def add_attribut(self, attribut_name):
        self.attribute.append(attribut_name)

class CodeTranspiler:
    def __init__(self):
        self.python_klassen = []
    
    def analysiere_klasse(self, python_klasse):
        self.python_klassen.append(python_klasse)
        return f"Klasse {python_klasse.name} analysiert"
    
    def generiere_rust_code(self):
        # Generiert Rust-Code basierend auf Python-Klassen
        pass
```

**Ihre Aufgabe:**
1. Erstellen Sie beide Klassen
2. Verbinden Sie sie mit einem **Assoziationspfeil** (durchgezogene Linie mit Pfeil)
3. Fügen Sie Multiplizitäten hinzu: `CodeTranspiler` → `0..*` `PythonKlasse`
4. Fügen Sie einen Rollennamen hinzu: "analysiert"

---

## 5. Erweiterte draw.io Funktionen

### 5.1 Formatierung
- **Text formatieren**: Wählen Sie Text aus und nutzen Sie die Formatierungsoptionen rechts
- **Farben ändern**: Rechtsklick → "Format" → Füll- und Linienfarbe anpassen
- **Schriftgröße**: Format → Text → Schriftgröße

### 5.2 Ausrichtung und Verteilung
- **Objekte ausrichten**: Mehrere Objekte auswählen → Arrange → Align
- **Gleichmäßig verteilen**: Arrange → Distribute

### 5.3 Export und Speicherung
- **PNG exportieren**: File → Export as → PNG
- **PDF exportieren**: File → Export as → PDF
- **Automatisches Speichern**: File → Auto-Save aktivieren

---

## 6. Projektspezifische Aufgaben

### Aufgabe Fritz (Py2Rust): AST-Analyse-Klassen
Erweitern Sie Ihr Py2Rust-Diagramm um folgende Klassen:
1. `ASTAnalyzer` - analysiert Python AST-Knoten
2. `RustCodeGenerator` - generiert Rust-Code
3. `FileHandler` - verwaltet Datei-Ein-/Ausgabe

**Beziehungen:**
- `CodeTranspiler` verwendet `ASTAnalyzer` und `RustCodeGenerator`
- `FileHandler` ist eine Utility-Klasse (Abhängigkeit zu allen anderen)

### Aufgabe Christian (WetterWeiser): Datenanalyse-Hierarchie
Erstellen Sie ein Klassendiagramm mit:
1. `WetterDaten` (Basisklasse)
2. `WetterAnalyse` (verarbeitet WetterDaten)
3. `WetterVisualisierung` (erstellt Grafiken)
4. `CSV_Import` (lädt Daten aus CSV-Dateien)

**Spezielle Anforderungen:**
- Verwenden Sie Aggregation zwischen `WetterAnalyse` und `WetterDaten`
- `WetterVisualisierung` hat eine Assoziation zu `WetterAnalyse`

### Aufgabe Christopher (PersonalPrinz): Verwaltungssystem
Erweitern Sie das Mitarbeiter-Diagramm:
1. `Mitarbeiter` (bereits erstellt)
2. `Personalverwaltung` - Container für alle Mitarbeiter
3. `LoginSystem` - verwaltet Benutzeranmeldungen
4. `CSVExport` - exportiert Daten

**Beziehungen:**
- `Personalverwaltung` aggregiert `Mitarbeiter` (0..*)
- `LoginSystem` assoziiert mit `Mitarbeiter` (1..1)

### Aufgabe Tristan (KeyRecognition): Signalverarbeitung
Komplexes Diagramm mit:
1. `FunkSignal` (bereits erstellt)
2. `AutoSchluessel` (bereits erstellt)
3. `SignalAnalyzer` - analysiert empfangene Signale
4. `MLClassifier` - klassifiziert Signalmuster
5. `DatabaseStorage` - speichert Ergebnisse

**Besonderheiten:**
- `SignalAnalyzer` verwendet Strategy-Pattern (verschiedene Analyse-Algorithmen)
- `MLClassifier` erbt von einer abstrakten Klasse `BaseClassifier`

---

## 7. Häufige Fehler und Lösungen

### Problem: Verbindungslinien überlagern sich
**Lösung:** Nutzen Sie Waypoints (Zwischenpunkte) durch Klicken auf die Linie und Ziehen der Eckpunkte

### Problem: Text zu klein/zu groß
**Lösung:** Format → Text → Schriftgröße anpassen oder Auto-Resize aktivieren

### Problem: Diagramm zu groß für Export
**Lösung:** File → Page Setup → Fit auf A4 oder gewünschte Größe anpassen

### Problem: UML-Formen nicht verfügbar
**Lösung:** More Shapes → Software → UML aktivieren und Apply klicken

---

## 8. Checkliste für vollständige Klassendiagramme

- [ ] Alle Klassen haben sprechende Namen (PascalCase)
- [ ] Attribute haben Datentypen
- [ ] Methoden haben Parameter und Rückgabetypen
- [ ] Sichtbarkeitsmodifikatoren sind korrekt gesetzt
- [ ] Beziehungen zwischen Klassen sind eindeutig
- [ ] Multiplizitäten sind angegeben
- [ ] Diagramm ist ordentlich formatiert und ausgerichtet
- [ ] Konstruktoren (`__init__`) sind enthalten

---

## 9. Weiterführende Ressourcen

- **draw.io Dokumentation**: https://www.drawio.com/doc/
- **UML-Klassendiagramm Guide**: https://www.drawio.com/blog/uml-class-diagrams
- **Python UML Tools**: https://pypi.org/project/uml-class-diagram-generator/

---

## 10. Zusatzaufgaben für Fortgeschrittene

### Template-Übung: Generische Klassen
Erstellen Sie ein Diagramm für eine generische `Container`-Klasse, die verschiedene Datentypen aufnehmen kann.

### Design-Pattern-Übung: Observer-Pattern
Modellieren Sie das Observer-Pattern für das WetterWeiser-Projekt, bei dem sich verschiedene Displays automatisch aktualisieren, wenn sich Wetterdaten ändern.

### Datenbank-Integration: 
Erweitern Sie ein Projekt Ihrer Wahl um Datenbankklassen und zeigen Sie die Verbindungen zwischen Domain-Objekten und Persistierung.
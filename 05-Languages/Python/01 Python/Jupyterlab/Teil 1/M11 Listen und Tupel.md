## Lernziele

- Listen erstellen, manipulieren und mit verschiedenen Methoden arbeiten
- Tupel verstehen und ihre Unveränderlichkeit nutzen
- Entscheiden, wann Listen oder Tupel verwendet werden sollten
- Listen und Tupel als Funktionsparameter und Rückgabewerte einsetzen
- List Comprehensions für elegante Datenverarbeitung verwenden
- Grundlegende Datenstrukturen für praktische Programmierprobleme anwenden

## 1. Listen erstellen und manipulieren

### 1.1 Grundlagen der Listenerstellung

- **Leere und gefüllte Listen erstellen**
    - Verschiedene Initialisierungsmethoden
    - Listen mit unterschiedlichen Datentypen
    - Listen aus anderen Sequenzen erstellen
- **Listen mit range() und Wiederholung**
    - Zahlenfolgen generieren
    - Wiederholungsmuster verwenden
    - Performance-Aspekte verstehen
- **Verschachtelte Listen (2D-Listen)**
    - Matrix-ähnliche Strukturen
    - Praktische Anwendungsfälle
    - Zugriff auf verschachtelte Elemente
- **Indizierung und Slicing verstehen**
    - Positive und negative Indizes
    - Slice-Notation beherrschen
    - Grenzen und Fehlerbehandlung

### 1.2 Grundlegende Listenoperationen

- **Elemente hinzufügen und entfernen**
    - Unterschied zwischen append, insert, extend
    - Remove vs. pop vs. del
    - Effizienz verschiedener Methoden
- **Elemente ändern und ersetzen**
    - Direkte Indexzuweisung
    - Slice-Assignments
    - Teilbereiche ersetzen
- **Listen verketten und vervielfachen**
    - Plus-Operator vs. extend
    - Multiplikation mit Zahlen
    - Fallstricke bei Referenzen
- **Membership-Tests**
    - in und not in Operatoren
    - Performance bei großen Listen
    - Alternative Suchmethoden

### 1.3 Listen-Slicing und erweiterte Zugriffe

- **Slice-Notation: [start:end:step]**
    - Alle Parameter verstehen
    - Negative Schritte für Umkehrung
    - Slicing-Shortcuts
- **Negative Indizes nutzen**
    - Vom Ende her zählen
    - Kombinationen mit positivem Slicing
    - Praktische Anwendungsmuster
- **Slicing für Kopien und Teilbereiche**
    - Oberflächliche vs. tiefe Kopien
    - Speicher-effiziente Operationen
    - Views vs. neue Listen
- **Slice-Assignments für Ersetzungen**
    - Bereiche ersetzen
    - Listen vergrößern/verkleinern
    - Einfügen ohne Ersetzen

## 2. Wichtige Listenmethoden

### 2.1 Methoden zum Hinzufügen und Entfernen

- **append(), insert(), extend()**
    - Einzelne vs. mehrere Elemente
    - Performance-Unterschiede verstehen
    - Wann welche Methode verwenden
- **remove(), pop(), clear()**
    - Unterschiedliche Entfernungsstrategien
    - Rückgabewerte nutzen
    - Exception-Handling
- **del-Statement**
    - Elemente und Slices löschen
    - Memory-Management verstehen
    - Unterschied zu anderen Methoden

### 2.2 Sortierung und Anordnung

- **sort() vs. sorted()**
    - In-place vs. neue Liste
    - Wann welche Variante wählen
    - Memory-Implications
- **Sortierung mit key-Parameter**
    - Custom Sortierkriterien
    - Lambda-Funktionen als Keys
    - Komplexe Datenstrukturen sortieren
- **reverse() für Umkehrung**
    - In-place Umkehrung
    - Alternativen mit Slicing
    - Performance-Vergleich
- **Stabile Sortierung verstehen**
    - Bedeutung für gleiche Elemente
    - Mehrfache Sortierkriterien
    - Praktische Anwendungen

### 2.3 Such- und Analysemethoden

- **index(), count() für Suche**
    - Erstes Vorkommen finden
    - Häufigkeiten ermitteln
    - Exception-Handling bei Suche
- **min(), max(), sum() für Analyse**
    - Statistische Grundfunktionen
    - Key-Parameter für komplexe Objekte
    - Performance bei großen Listen
- **len() für Längenbestimmung**
    - O(1) Komplexität verstehen
    - Unterschied zu anderen Sprachen
    - Leere Listen erkennen
- **List Comprehensions - Grundlagen**
    - Syntax und Aufbau verstehen
    - Filterung mit Bedingungen
    - Performance-Vorteile
    - Lesbarkeit vs. Effizienz
## 3. Tupel: Unveränderliche Sequenzen

### 3.1 Tupel-Grundlagen

- **Tupel erstellen und verstehen**
    - Verschiedene Erstellungsarten
    - Klammern vs. Kommata als Definitionsmerkmal
    - Leere Tupel und Ein-Element-Tupel
- **Unveränderlichkeit (Immutability)**
    - Was bedeutet unveränderlich
    - Unterschied zu Listen verstehen
    - Vorteile der Unveränderlichkeit
- **Spezialfälle**
    - Ein-Element-Tupel: Komma-Syntax
    - Tupel ohne Klammern (Tuple Packing)
    - Verschachtelte Tupel

### 3.2 Tupel-Operationen

- **Indizierung und Slicing**
    - Gleiche Syntax wie bei Listen
    - Nur Lesezugriff möglich
    - Performance-Vorteile
- **Tupel-Methoden**
    - count() und index() verfügbar
    - Warum so wenige Methoden
    - Alternative Operationen
- **Konvertierung zwischen Listen und Tupeln**
    - tuple() und list() Funktionen
    - Wann Konvertierung sinnvoll
    - Performance-Aspekte

### 3.3 Tuple Unpacking

- **Multiple Assignment verstehen**
    - Parallele Zuweisungen
    - Elegant und pythonisch
    - Swap-Operationen ohne temp-Variable
- **Erweiterte Unpacking-Patterns**
    - Starred expressions mit *
    - Teilweises Unpacking
    - Nested Unpacking
- **Funktions-Rückgabewerte entpacken**
    - Multiple Returns elegant handhaben
    - API-Design-Implications
    - Lesbarkeit verbessern
## 4. Liste vs. Tupel: Anwendungsfälle

### 4.1 Eigenschaften-Vergleich

- **Veränderbarkeit vs. Unveränderlichkeit**
    - Mutable vs. Immutable im Detail
    - Auswirkungen auf Programmlogik
    - Debugging-Vorteile
- **Performance-Unterschiede**
    - Speicherverbrauch vergleichen
    - Zugriffszeiten messen
    - Erstellungsperformance
- **Hashbarkeit für Dictionary-Keys**
    - Warum Tupel hashbar sind
    - Listen als Keys nicht möglich
    - Set-Membership implications
- **Thread-Safety**
    - Unveränderlichkeit und Concurrency
    - Shared State Probleme vermeiden
    - Defensive Programming

### 4.2 Anwendungsszenarien

- **Listen für: Veränderliche Sammlungen**
    - Dynamisch wachsende Datenmengen
    - User-Input Sammlung
    - Temporäre Arbeitsstrukturen
    - Caches und Puffer
- **Tupel für: Feste Strukturen**
    - Koordinaten und Positionen
    - Datenbankzeilen (Records)
    - Konfigurationswerte
    - Return-Values von Funktionen
- **Entscheidungsmatrix entwickeln**
    - Kriterien für die Wahl
    - Performance vs. Semantik
    - Team-Konventionen
- **API-Design Überlegungen**
    - Konsistenz in Schnittstellen
    - Erwartungen der Nutzer
    - Backwards Compatibility

### 4.3 Best Practices

- **Semantische Klarheit**
    - Code-Intent durch Datentyp ausdrücken
    - Selbstdokumentierender Code
    - Type Hints Vorbereitung
- **Performance vs. Maintainability**
    - Premature Optimization vermeiden
    - Profiling vor Optimierung
    - Readable Code bevorzugen
- **Team-Konventionen**
    - Coding Standards etablieren
    - Code Reviews durchführen
    - Dokumentation schreiben

## 5. Funktionen mit Listen und Tupeln

### 5.1 Listen als Funktionsparameter

- **Listen an Funktionen übergeben**
    - Pass-by-Reference verstehen
    - Unerwartete Seiteneffekte vermeiden
    - Debugging von Referenz-Problemen
- **Mutable Parameter - Risiken und Chancen**
    - In-place Modifikationen
    - Ungewollte Änderungen am Original
    - Dokumentation von Seiteneffekten
- **Defensive Kopien**
    - copy() vs. deepcopy()
    - Wann Kopien erstellen
    - Performance-Impact
- **Rückgabe-Strategien**
    - Neue Listen vs. Modifikation
    - API-Konsistenz wahren
    - Functional Programming Ansätze

### 5.2 Tupel als Rückgabewerte

- **Multiple Rückgabewerte elegant verpacken**
    - Alternative zu Klassen für einfache Fälle
    - Named Tuples als Weiterentwicklung
    - API-Erweiterbarkeit
- **Structured Returns für bessere APIs**
    - Selbstdokumentierende Rückgaben
    - Type Hints Integration
    - IDE-Support verbessern
- **Error Handling mit Tupeln**
    - Status-Code Pattern
    - Optional Return Values
    - Exception vs. Return Code

### 5.3 Erweiterte Patterns

- *_Listen/Tupel mit _args verarbeiten__
    - Variable Argumentlisten
    - Flexible Function Signatures
    - Decorator-Vorbereitung
- **Generator Functions**
    - Memory-effiziente Verarbeitung
    - Lazy Evaluation Konzepte
    - Iterator Protocol verstehen
- **Nested Structures bearbeiten**
    - Recursive Processing
    - Flattening Algorithmen
    - Tree-like Data Structures
- **Functional Programming Patterns**
    - map, filter, reduce mit Listen
    - Pure Functions bevorzugen
    - Immutable Data Structures
## Zusammenfassung und Ausblick

### Was haben wir gelernt?

- **Listen:** Flexible, veränderbare Sammlungen für dynamische Daten
- **Tupel:** Strukturierte, unveränderliche Daten für feste Beziehungen
- **Anwendungsgebiete:** Bewusste Entscheidung zwischen beiden Typen
- **Funktionale Integration:** Effektive Nutzung als Parameter und Rückgabewerte
- **Best Practices:** Performance und Lesbarkeit in Balance

### Verbindung zu anderen Konzepten

- **Iteration:** Schleifen mit Listen und Tupeln
- **String Processing:** Listen von Zeichen und Wörtern
- **File I/O:** Daten aus Dateien in Listen strukturieren
- **Error Handling:** Defensive Programmierung mit Collections

### Nächste Schritte

- **Dictionaries:** Key-Value-Datenstrukturen für assoziative Arrays
- **Sets:** Mengen-Operationen für mathematische Konzepte
- **Iteratoren und Generatoren:** Memory-effiziente Datenverarbeitung
- **Datenstrukturen kombinieren:** Komplexe Datenmodelle entwickeln
- **Algorithm Design:** Sortierung, Suche, Optimierung

## Zusätzliche Ressourcen

### Weiterführende Links

- **Offizielle Python-Dokumentation**
    - Tutorial zu Datenstrukturen
    - Built-in Types Reference
    - Performance Tips
- **Community Resources**
    - Real Python Tutorials
    - Stack Overflow Best Practices
    - Python Enhancement Proposals (PEPs)
- **Bücher und Kurse**
    - "Effective Python" für fortgeschrittene Patterns
    - "Python Tricks" für Idioms
    - Online-Kurse zu Datenstrukturen

### Assessment und Erfolgskontrolle

- **Praktische Coding-Aufgaben:** Hands-on Probleme lösen
- **Code Review Sessions:** Peer-Learning fördern
- **Mini-Projekte:** Anwendung in realistischen Szenarien
- **Reflexion:** Was war schwierig, was hat gut funktioniert?

### Vorbereitung für Folgemodule

- **Dictionary Foundations:** Key-Konzepte vorbereiten
- **Object-Oriented Thinking:** Datenstrukturen als Objekteigenschaften
- **Algorithm Complexity:** Big-O Notation verstehen
- **Testing Mindset:** Systematisches Testen von Datenoperationen
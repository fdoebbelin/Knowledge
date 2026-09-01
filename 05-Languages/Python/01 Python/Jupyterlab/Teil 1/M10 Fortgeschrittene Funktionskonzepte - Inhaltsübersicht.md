## Lernziele

- Funktionen mit flexiblen Parametern definieren und verwenden
- Lambda-Funktionen für einfache Operationen einsetzen
- Rekursive Probleme lösen und verstehen
- Scope-Regeln anwenden und Closures nutzen
- Einfache Dekoratoren erstellen und verwenden
- Funktionen als Parameter und Rückgabewerte nutzen

## 1. Default- und benannte Parameter

### 1.1 Grundlagen der Default-Parameter

- Funktionen mit Standardwerten definieren
- Optionale Parameter verwenden
- Flexibilität beim Funktionsaufruf

### 1.2 Benannte Parameter und Reihenfolge

- Parameter explizit benennen
- Reihenfolge von Parametern flexibel gestalten
- Kombination von Positions- und Schlüsselwortparametern

### 1.3 Häufige Fallstricke

- Probleme mit mutablen Default-Parametern
- Sichere Implementierung mit None als Default
- Best Practices für Default-Parameter

**Übung 1:** Konfigurationsfunktion für eine App erstellen

## 2. Variable Argumentlisten (`*args`, `**kwargs`)

### 2.1 *args - Variable Positionsargumente

- Beliebige Anzahl von Argumenten akzeptieren
- Verwendung von `*args` in Funktionsdefinitionen
- Praktische Anwendungsfälle

### 2.2 `**kwargs` - Variable Schlüsselwortargumente

- Beliebige benannte Parameter verarbeiten
- Dynamische Funktionsschnittstellen erstellen
- Dictionary-ähnliche Parameterverarbeitung

### 2.3 Kombination von `*args` und `**kwargs`

- Maximale Flexibilität bei Funktionsparametern
- Weiterleitung von Argumenten an andere Funktionen
- API-Design mit flexiblen Schnittstellen

**Übung 2:** Flexible Rechenfunktion implementieren

## 3. Funktionen als Objekte (Higher-order functions)

### 3.1 Funktionen als Parameter

- Funktionen an andere Funktionen übergeben
- Callback-Mechanismen implementieren
- Strategiemuster mit Funktionen

### 3.2 Funktionen als Rückgabewerte

- Factory-Funktionen erstellen
- Konfigurierbare Funktionen generieren
- Closures verstehen und nutzen

### 3.3 Praktische Anwendung mit built-in Funktionen

- Verwendung von filter(), map() und sorted()
- Funktionale Programmierungskonzepte
- Elegante Datenverarbeitung

**Übung 3:** Sortierungsfunktion mit verschiedenen Kriterien

## 4. Lambda-Funktionen

### 4.1 Lambda-Syntax und Grundlagen

- Anonyme Funktionen definieren
- Kompakte Syntax für einfache Operationen
- Vergleich mit normalen Funktionsdefinitionen

### 4.2 Lambda mit Built-in-Funktionen

- Lambda-Funktionen als Parameter für filter(), map(), sorted()
- Inline-Funktionsdefinitionen
- Readable Code mit Lambda-Ausdrücken

### 4.3 Grenzen von Lambda-Funktionen

- Einschränkungen bei komplexen Operationen
- Wann normale Funktionen bevorzugt werden sollten
- Lesbarkeit vs. Kompaktheit abwägen

**Übung 4:** Datenanalyse mit Lambda-Funktionen

## 5. Rekursion

### 5.1 Grundprinzip der Rekursion

- Selbstaufrufende Funktionen verstehen
- Basisfall und rekursiver Fall
- Klassische Beispiele wie Fakultät

### 5.2 Rekursion mit komplexeren Datenstrukturen

- Fibonacci-Zahlen berechnen
- Rekursive Listenverarbeitung
- Verschachtelte Datenstrukturen durchlaufen

### 5.3 Rekursion vs. Iteration

- Vor- und Nachteile rekursiver Lösungen
- Performance-Überlegungen
- Wann Rekursion die bessere Wahl ist

**Übung 5:** Rekursive Verzeichnis-Durchsuchung

## 6. Scope und Namensräume

### 6.1 LEGB-Regel verstehen

- Local, Enclosing, Global, Built-in Scopes
- Variablenauflösung in Python
- Sichtbarkeit von Variablen

### 6.2 global und nonlocal Schlüsselwörter

- Globale Variablen in Funktionen modifizieren
- Zugriff auf umschließende Scopes
- Best Practices für Scope-Verwaltung

### 6.3 Closures

- Funktionen mit "eingeschlossenen" Variablen
- Zustand zwischen Funktionsaufrufen bewahren
- Praktische Anwendungen von Closures

**Übung 6:** State-Machine mit Closures

## 7. Dekoratoren: Grundlagen und Anwendungen

### 7.1 Einfache Dekoratoren

- Wrapper-Funktionen erstellen
- @-Syntax verstehen und verwenden
- Funktionalität transparent erweitern

### 7.2 Dekoratoren mit Parametern

- Konfigurierbare Dekoratoren implementieren
- Verschachtelte Funktionsstrukturen
- Flexible Dekorator-Parameter

### 7.3 Praktische Dekorator-Anwendungen

- Zeitmessung und Performance-Monitoring
- Eingabevalidierung automatisieren
- Logging und Debugging unterstützen

**Übung 7:** Cache-Dekorator für Performance-Optimierung



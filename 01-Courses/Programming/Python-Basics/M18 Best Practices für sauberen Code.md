## Modul-Übersicht
- **Dauer:** 2 Unterrichtseinheiten (UE)
- **Zielgruppe:** Absolute Programmieranfänger
- **Voraussetzungen:** Funktionen, Module, PEP 8, Grundlagen OOP, Fehlerbehandlung
- **Lernziele:** Wartbaren, lesbaren und testbaren Code schreiben, professionelle Entwicklungsprinzipien anwenden

## UE 1: DRY-Prinzip und aussagekräftige Namen (45 min)

### M18.1 - Code-Struktur und Namenswahl optimieren

**Lernziele:**
- DRY-Prinzip (Don't Repeat Yourself) verstehen und anwenden
- Aussagekräftige Namen für Variablen, Funktionen und Klassen wählen
- Magic Numbers durch benannte Konstanten ersetzen
- Code-Duplikation erkennen und eliminieren
- Funktionen sinnvoll aufteilen für bessere Lesbarkeit

**Inhalte:**
1. **DRY-Prinzip praktisch anwenden**
   - Code-Duplikation als Problem erkennen
   - Wiederholende Logik in Funktionen auslagern
   - Gemeinsame Datenstrukturen zentralisieren
   - Konfiguration und Konstanten auslagern

2. **Aussagekräftige Namen wählen**
   - Selbsterklärende Variablennamen: `student_count` statt `n`
   - Beschreibende Funktionsnamen: `calculate_grade_average()` statt `calc()`
   - Intention-revealing Namen: `is_valid_email()` statt `check()`
   - Konsistente Namensgebung im gesamten Projekt

3. **Magic Numbers eliminieren**
   - Zahlen durch benannte Konstanten ersetzen
   - Konfigurationswerte zentral verwalten
   - Bedeutung von Zahlen im Code dokumentieren
   - Wartbarkeit durch Konstanten verbessern

4. **Funktionen richtig aufteilen**
   - Single Responsibility Principle für Anfänger
   - Funktionen mit einer klaren Aufgabe
   - Optimale Funktionslänge (10-20 Zeilen)
   - Input/Output klar definieren

**Praktisches Beispiel:**
- Unstrukturierten Notenverwaltungs-Code refaktorieren
- Taschenrechner mit wiederholtem Code optimieren
- Studentenverwaltung mit Magic Numbers bereinigen

---

## UE 2: Funktionaler Entwurf und testbarer Code (45 min)

### M18.2 - Kohäsion, Kopplung und Testbarkeit

**Lernziele:**
- Kohäsion (Zusammengehörigkeit) in Funktionen und Modulen verstehen
- Kopplung (Abhängigkeiten) zwischen Code-Teilen minimieren
- Code so strukturieren, dass er leicht testbar ist
- Seiteneffekte reduzieren für vorhersagbares Verhalten
- Clean Code Prinzipien praktisch anwenden

**Inhalte:**
1. **Kohäsion verstehen und verbessern**
   - Funktionen mit zusammengehörigen Aufgaben
   - Module mit thematisch verwandten Funktionen
   - Klassen mit kohärenten Verantwortlichkeiten
   - Beispiele für hohe vs. niedrige Kohäsion

2. **Kopplung reduzieren**
   - Lose Kopplung durch klare Schnittstellen
   - Abhängigkeiten zwischen Modulen minimieren
   - Parameter statt globale Variablen verwenden
   - Interfaces und Abstraktion für Anfänger

3. **Testbaren Code schreiben**
   - Funktionen mit klaren Ein- und Ausgaben
   - Seiteneffekte (print, Dateizugriff) isolieren
   - Abhängigkeiten von außen injizieren
   - Pure Functions vs. Funktionen mit Seiteneffekten

4. **Clean Code Prinzipien für Anfänger**
   - Code für Menschen schreiben, nicht nur für Computer
   - Selbstdokumentierender Code
   - Fehlerbehandlung als First-Class Citizen
   - Defensive Programmierung

**Praktisches Beispiel:**
- Bibliotheksverwaltung mit hoher Kohäsion strukturieren
- Datenbank-Code von Business-Logik entkoppeln
- Testbare Funktionen für Berechnungslogik erstellen

---

## Unterthemen-Struktur

### M18.1: Code-Struktur und Namenswahl optimieren
- **M18.1.1** - Demonstration: DRY-Prinzip und aussagekräftige Namen
- **M18.1.2** - Aufgaben: Legacy-Code refaktorieren nach Best Practices
- **M18.1.3** - Musterlösung: Professionell strukturierter Code

### M18.2: Kohäsion, Kopplung und Testbarkeit
- **M18.2.1** - Demonstration: Funktionaler Entwurf und Clean Code
- **M18.2.2** - Aufgaben: E-Commerce-System sauber strukturieren
- **M18.2.3** - Musterlösung: Wartbarer und testbarer Code

---

## Methodische Hinweise

### Für Programmieranfänger angepasst:
- **Konkrete Probleme lösen:** Echte Code-Smells aus typischen Anfänger-Programmen
- **Schrittweise Verbesserung:** Code iterativ refaktorieren statt neu schreiben
- **Praktische Regeln:** Einfache Faustregeln statt komplexe Theorie
- **Sofortige Verbesserung:** Direkt anwendbare Techniken für besseren Code

### Technische Umsetzung:
- **Before/After Beispiele:** Schlechter Code wird zu gutem Code transformiert
- **Code-Reviews:** Gemeinsame Analyse von Code-Qualität
- **Refactoring-Patterns:** Wiederkehrende Verbesserungsmuster zeigen
- **Praktische Checklisten:** Einfache Prüflisten für Code-Qualität

### Schwierigkeitsgrad:
- **Konkrete statt abstrakte Beispiele:** Studentenverwaltung statt allgemeine Patterns
- **Ein Prinzip nach dem anderen:** Nicht alle Best Practices gleichzeitig
- **Sofort anwendbar:** Techniken die in aktuellen Projekten helfen
- **Messbare Verbesserung:** Vorher/nachher Vergleiche zeigen Fortschritt

---

## Praktische Code-Transformationen

### Schlechter Code (typische Anfänger-Probleme):
```python
def process_data():
    data = [85, 92, 78, 96, 88]
    sum = 0
    for i in data:
        sum = sum + i
    avg = sum / 5
    
    if avg >= 90:
        print("Excellent")
    elif avg >= 80:
        print("Good")
    elif avg >= 70:
        print("Average")
    else:
        print("Poor")
    
    # Same logic repeated elsewhere...
    data2 = [75, 82, 79, 88, 91]
    sum2 = 0
    for i in data2:
        sum2 = sum2 + i
    avg2 = sum2 / 5
    
    if avg2 >= 90:
        print("Excellent")
    # ... repeated grading logic
```

### Guter Code (nach Best Practices):
```python
# Konstanten für Magic Numbers
EXCELLENT_THRESHOLD = 90
GOOD_THRESHOLD = 80
AVERAGE_THRESHOLD = 70

def calculate_average(grades):
    """Berechnet den Durchschnitt einer Notenliste."""
    if not grades:
        return 0
    return sum(grades) / len(grades)

def determine_grade_category(average_score):
    """Bestimmt die Notenkategorie basierend auf dem Durchschnitt."""
    if average_score >= EXCELLENT_THRESHOLD:
        return "Excellent"
    elif average_score >= GOOD_THRESHOLD:
        return "Good"
    elif average_score >= AVERAGE_THRESHOLD:
        return "Average"
    else:
        return "Poor"

def evaluate_student_performance(student_grades):
    """Evaluiert die Leistung eines Studenten."""
    average_score = calculate_average(student_grades)
    grade_category = determine_grade_category(average_score)
    return {
        'average': average_score,
        'category': grade_category
    }

# Verwendung
student1_grades = [85, 92, 78, 96, 88]
student2_grades = [75, 82, 79, 88, 91]

result1 = evaluate_student_performance(student1_grades)
result2 = evaluate_student_performance(student2_grades)

print(f"Student 1: {result1['category']} ({result1['average']:.1f})")
print(f"Student 2: {result2['category']} ({result2['average']:.1f})")
```

---

## Erwartete Lernergebnisse

Nach Abschluss des Moduls können die Teilnehmer:
- ✅ Code-Duplikation erkennen und durch Funktionen eliminieren
- ✅ Aussagekräftige Namen für bessere Code-Lesbarkeit wählen
- ✅ Magic Numbers durch benannte Konstanten ersetzen
- ✅ Funktionen nach Single Responsibility aufteilen
- ✅ Kohäsion in Modulen und Klassen verbessern
- ✅ Kopplung zwischen Code-Komponenten reduzieren
- ✅ Code testbarer strukturieren durch klare Schnittstellen
- ✅ Clean Code Prinzipien in eigenen Projekten anwenden

## Integration in den Gesamtkurs

Das Modul baut auf auf:
- **M09-10:** Funktionen (die jetzt besser strukturiert werden)
- **M16:** Module (die jetzt kohärenter organisiert werden)
- **M17:** PEP 8 und Dokumentation (erweiterte Code-Qualität)
- **M08:** Fehlerbehandlung (defensive Programmierung)

Das Modul bereitet vor auf:
- **M19-20:** Versionskontrolle (sauberer Code in Git)
- **M33-35:** Unit Testing (testbarer Code ist besser testbar)
- **M21-29:** OOP (Clean Code Prinzipien in Klassen)
- **M37-38:** Funktionale Programmierung (Pure Functions)

## Qualitätskriterien für sauberen Code

### DRY-Prinzip Checkliste:
- [ ] Keine identische Logik in mehreren Funktionen
- [ ] Konfigurationswerte zentral definiert
- [ ] Wiederverwendbare Funktionen erstellt
- [ ] Code-Duplikation eliminiert

### Clean Code Checkliste:
- [ ] Funktionen haben eine klare Verantwortlichkeit
- [ ] Namen erklären Intention ohne Kommentare
- [ ] Magic Numbers durch Konstanten ersetzt
- [ ] Funktionen sind maximal 20 Zeilen lang
- [ ] Module sind thematisch kohärent
- [ ] Abhängigkeiten sind minimiert

### Testbarkeit Checkliste:
- [ ] Funktionen haben klare Ein- und Ausgaben
- [ ] Seiteneffekte sind isoliert
- [ ] Business-Logik ist von I/O getrennt
- [ ] Funktionen sind deterministisch (gleiche Eingabe → gleiche Ausgabe)
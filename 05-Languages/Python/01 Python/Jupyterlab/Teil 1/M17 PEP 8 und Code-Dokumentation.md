## Modul-Übersicht
- **Dauer:** 2 Unterrichtseinheiten (UE)
- **Zielgruppe:** Absolute Programmieranfänger
- **Voraussetzungen:** Grundlagen Python-Syntax, Funktionen, Module, einfache Klassen
- **Lernziele:** Sauberen, lesbaren Code schreiben, professionelle Dokumentation erstellen

## UE 1: PEP 8 Stilrichtlinien praktisch anwenden (45 min)

### M17.1 - PEP 8 Grundlagen und praktische Anwendung

**Lernziele:**
- PEP 8 als Python-Stilrichtlinie verstehen
- Wichtigste Namenskonventionen praktisch anwenden
- Code-Formatierung für bessere Lesbarkeit verwenden
- Häufige Stil-Fehler erkennen und korrigieren
- Eigenen Code nach PEP 8 Standards überarbeiten

**Inhalte:**
1. **Was ist PEP 8?**
   - PEP 8 als offizielle Python-Stilrichtlinie
   - Warum einheitlicher Stil wichtig ist
   - "Readability counts" - Lesbarkeit im Fokus

2. **Namenskonventionen praktisch anwenden**
   - Variablen: `mein_name`, `anzahl_studenten` (snake_case)
   - Funktionen: `berechne_durchschnitt()`, `formatiere_text()`
   - Konstanten: `MAX_VERSUCHE`, `PI` (UPPER_CASE)
   - Klassen: `Student`, `BankKonto` (PascalCase)

3. **Code-Formatierung und Struktur**
   - Einrückung: 4 Leerzeichen statt Tabs
   - Zeilenlänge: maximal 79 Zeichen
   - Leerzeilen zwischen Funktionen und Klassen
   - Leerzeichen um Operatoren: `a = b + c`

4. **Praktische Stil-Verbesserungen**
   - Schlechten Code nach PEP 8 umschreiben
   - Vor/Nach-Vergleiche zeigen
   - Häufige Anfänger-Fehler korrigieren

**Praktisches Beispiel:**
- Unordentlichen Taschenrechner-Code nach PEP 8 umgestalten
- Studentenverwaltung mit korrekten Namenskonventionen
- Datei-Verarbeitungsskript professionell formatieren

---

## UE 2: Dokumentation mit Docstrings und Kommentaren (45 min)

### M17.2 - Code-Dokumentation für Anfänger

**Lernziele:**
- Unterschied zwischen Kommentaren und Docstrings verstehen
- Docstrings für Funktionen und Klassen schreiben
- Inline-Kommentare sinnvoll einsetzen
- Dokumentation als Teil des Entwicklungsprozesses verstehen
- Eigene Module und Funktionen dokumentieren

**Inhalte:**
1. **Kommentare vs. Docstrings**
   - `# Kommentare` für Code-Erklärungen
   - `"""Docstrings"""` für Funktions- und Klassenbeschreibungen
   - Wann welche Art der Dokumentation verwenden

2. **Docstrings für Funktionen schreiben**
   - Einzeilige Docstrings für einfache Funktionen
   - Mehrzeilige Docstrings mit Parameter-Beschreibung
   - Rückgabewerte dokumentieren
   - Beispiele in Docstrings einfügen

3. **Modul- und Klassen-Dokumentation**
   - Modul-Docstrings am Dateianfang
   - Klassen-Docstrings für Zweck und Verwendung
   - Konsistente Dokumentations-Struktur

4. **Praktische Dokumentations-Standards**
   - Was dokumentiert werden sollte
   - Was NICHT dokumentiert werden muss
   - Dokumentation aktuell halten
   - Einfache Tools zur Dokumentations-Generierung

**Praktisches Beispiel:**
- Mathematik-Modul vollständig dokumentieren
- Klassen-Hierarchie mit professionellen Docstrings
- Datei-Manager mit ausführlicher Modul-Dokumentation

---

## Unterthemen-Struktur

### M17.1: PEP 8 Grundlagen und praktische Anwendung
- **M17.1.1** - Demonstration: PEP 8 Stilrichtlinien in der Praxis
- **M17.1.2** - Aufgaben: Code-Refactoring nach PEP 8 Standards
- **M17.1.3** - Musterlösung: Professionell formatierter Code

### M17.2: Code-Dokumentation für Anfänger
- **M17.2.1** - Demonstration: Docstrings und Kommentare richtig verwenden
- **M17.2.2** - Aufgaben: Bibliotheksverwaltung vollständig dokumentieren
- **M17.2.3** - Musterlösung: Beispielhafte Dokumentation

---

## Methodische Hinweise

### Für Programmieranfänger angepasst:
- **Vorher/Nachher-Vergleiche:** Schlechter vs. guter Code-Stil
- **Konkrete Beispiele:** Echte Code-Fragmente aus vorherigen Modulen
- **Häufige Fehler:** Typische Anfänger-Probleme und deren Lösung
- **Praktische Tools:** Einfache Linting-Tools kurz vorstellen

### Technische Umsetzung:
- **Live-Refactoring:** Bestehenden Code gemeinsam verbessern
- **Template-Docstrings:** Wiederverwendbare Dokumentations-Vorlagen
- **Checklisten:** Einfache Prüflisten für Code-Qualität
- **Realitätsnahe Beispiele:** Code aus vorherigen Modulen verwenden

### Schwierigkeitsgrad:
- **Wichtigste Regeln zuerst:** Fokus auf die 20% die 80% ausmachen
- **Nicht überfordern:** Nur die essentiellen PEP 8 Regeln
- **Praxis vor Theorie:** Mehr Code-Beispiele als Regelwerk
- **Iterative Verbesserung:** Code schrittweise verbessern

---

## Praktische Code-Beispiele

### Schlechter Stil (typische Anfänger-Fehler):
```python
def calc(a,b,c):
    #berechnet irgendwas
    if a>b:
        return a+c
    else:
        return b-c

class student:
    def __init__(self,N,A):
        self.N=N
        self.A=A
```

### Guter Stil (nach PEP 8):
```python
def berechne_ergebnis(wert_a, wert_b, wert_c):
    """
    Berechnet ein Ergebnis basierend auf drei Eingabewerten.
    
    Args:
        wert_a (float): Erster Vergleichswert
        wert_b (float): Zweiter Vergleichswert  
        wert_c (float): Zusätzlicher Berechnungswert
        
    Returns:
        float: Berechnetes Ergebnis
    """
    if wert_a > wert_b:
        return wert_a + wert_c
    else:
        return wert_b - wert_c


class Student:
    """Repräsentiert einen Studenten mit Name und Alter."""
    
    def __init__(self, name, alter):
        """
        Initialisiert einen neuen Studenten.
        
        Args:
            name (str): Name des Studenten
            alter (int): Alter des Studenten
        """
        self.name = name
        self.alter = alter
```

---

## Erwartete Lernergebnisse

Nach Abschluss des Moduls können die Teilnehmer:
- ✅ PEP 8 Namenskonventionen korrekt anwenden
- ✅ Code sauber formatieren (Einrückung, Leerzeichen, Zeilenlänge)
- ✅ Aussagekräftige Variablen- und Funktionsnamen wählen
- ✅ Docstrings für Funktionen und Klassen schreiben
- ✅ Sinnvolle Inline-Kommentare verfassen
- ✅ Module professionell dokumentieren
- ✅ Eigenen Code nach professionellen Standards überarbeiten
- ✅ Code-Qualität bewerten und verbessern

## Integration in den Gesamtkurs

Das Modul baut auf auf:
- **M09-10:** Funktionen (die jetzt dokumentiert werden)
- **M16:** Module (die jetzt dokumentiert werden)
- **M21-22:** Erste Klassen (die nach PEP 8 benannt werden)

Das Modul bereitet vor auf:
- **M18:** Best Practices für sauberen Code (erweiterte Konzepte)
- **M33-35:** Unit Testing (gut dokumentierter Code ist testbarer)
- **Alle späteren Module:** Professionelle Code-Standards von Anfang an

## Qualitätssicherung

### Checkliste für PEP 8 Compliance:
- [ ] Variablen in snake_case: `mein_name`
- [ ] Funktionen in snake_case: `berechne_summe()`
- [ ] Klassen in PascalCase: `MeineKlasse`
- [ ] Konstanten in UPPER_CASE: `MAX_WERT`
- [ ] 4 Leerzeichen Einrückung
- [ ] Leerzeichen um Operatoren: `a = b + c`
- [ ] Maximal 79 Zeichen pro Zeile

### Checkliste für Dokumentation:
- [ ] Jede Funktion hat einen Docstring
- [ ] Parameter sind beschrieben
- [ ] Rückgabewerte sind dokumentiert
- [ ] Klassen haben beschreibende Docstrings
- [ ] Module haben einleitende Dokumentation
- [ ] Komplexe Code-Stellen haben Kommentare
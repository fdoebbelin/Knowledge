Dieses Dokument enthält Beispiele aus Kapitel 4 "Der Weg zum ersten Programm". Jedes Konzept ist als eigenständige Funktion implementiert, die praktische Anwendungsbeispiele zeigt.

## 1. Grundlagen eines Python-Programms

- Python-Programme werden als Textdateien mit der Endung `.py` gespeichert
- Programme werden als Ganzes vom Interpreter ausgeführt
- Unterschied zum interaktiven Modus, in dem zeileweise gearbeitet wird

```python
def erstes_programm_erklaerung():
    """
    Erklärt die Grundstruktur eines Python-Programms:
    - Python-Programme werden in .py-Dateien gespeichert
    - Sie können mit dem Python-Interpreter ausgeführt werden
    - Die Ausführung kann über die Kommandozeile oder eine IDE erfolgen
    """
    return {
        "dateiendung": ".py",
        "ausfuehrung_windows": "python dateiname.py",
        "ausfuehrung_linux": "python dateiname.py",
        "ausfuehrung_ide": "Run-Menü oder Run-Button in der IDE"
    }

# Aufruf der Funktion erstes_programm_erklaerung()
erstes_programm_erklaerung()
```

## 2. Shebang-Zeile für Unix-Systeme

- Unter Unix-ähnlichen Systemen kann ein Programm direkt ausführbar gemacht werden
- Die erste Zeile muss dann eine Shebang-Zeile sein
- Dazu muss das Executable-Flag gesetzt werden

```python
def shebang_beispiel():
    """
    Zeigt die Verwendung einer Shebang-Zeile in einem Python-Programm
    für Unix-ähnliche Systeme.
    """
    shebang_zeile_1 = "#!/usr/bin/python"
    shebang_zeile_2 = "#!/usr/bin/env python"
    executable_flag_setzen = "$ chmod +x dateiname.py"
    
    return {
        "shebang_fest": shebang_zeile_1,
        "shebang_flexibel": shebang_zeile_2,
        "executable_flag_setzen": executable_flag_setzen,
        "hinweis": "Die zweite Variante ist besser, da sie vom tatsächlichen Installationsort unabhängig ist."
    }

# Aufruf der Funktion shebang_beispiel()
shebang_beispiel()
```

## 3. Kompilieren und Interpretieren

- Python-Programme durchlaufen einen zweistufigen Ausführungsprozess
- Zuerst wird der Quellcode in Byte-Code kompiliert
- Dann wird der Byte-Code vom Interpreter ausgeführt

```python
def kompilieren_interpretieren():
    """
    Erklärt den zweistufigen Ausführungsprozess von Python-Programmen.
    """
    return {
        "phase_1": "Compiler übersetzt Python-Code in Byte-Code (programm.pyc)",
        "phase_2": "Interpreter führt den Byte-Code aus",
        "vorteil": "Derselbe Python-Code kann auf allen Plattformen ausgeführt werden, für die ein Interpreter existiert",
        "nachteil": "Programme laufen in der Regel langsamer als kompilierte Programme (z.B. in C)",
        "optimierung": "Moderne Python-Interpreter führen Optimierungen wie Just-in-time-Kompilierung durch"
    }

# Aufruf der Funktion kompilieren_interpretieren()
kompilieren_interpretieren()
```

## 4. Grundstruktur eines Python-Programms

- Ein Python-Programm besteht aus Anweisungen
- Anweisungen können einen Anweisungskopf und Anweisungskörper haben
- Die Zugehörigkeit wird durch Einrückung gekennzeichnet

```python
def grundstruktur_beispiel():
    """
    Zeigt die Grundstruktur eines Python-Programms mit Einrückungen.
    """
    beispiel = """
    # Einfache Anweisung
    print("Hallo Welt")
    
    # Anweisung mit Kopf und Körper
    if x > 10:
        print("x ist größer als 10")
        print("Zweite Zeile!")
    """
    
    return {
        "struktur": "Anweisungen, die einen Block bilden, werden durch Doppelpunkt und Einrückung gekennzeichnet",
        "einrueckung": "Üblicherweise 4 Leerzeichen pro Einrückungsebene",
        "hinweis": "Nicht Leerzeichen und Tabulatoren mischen!"
    }

# Aufruf der Funktion grundstruktur_beispiel()
grundstruktur_beispiel()
```

## 5. Interaktiver Modus mit Einrückungen

- Auch im interaktiven Modus können Blöcke mit Einrückungen verwendet werden
- Der Prompt ändert sich von `>>>` zu `...` bei einer fortgesetzten Anweisung

```python
def interaktiver_modus_mit_bloecken():
    """
    Demonstriert, wie Codeblöcke im interaktiven Modus eingegeben werden.
    """
    interaktive_eingabe = """
    >>> x = 123
    >>> if x > 10:
    ...     print("Der Interpreter leistet gute Arbeit")
    ...     print("Zweite Zeile!")
    ...
    Der Interpreter leistet gute Arbeit
    Zweite Zeile!
    >>>
    """
    
    return {
        "besonderheiten": [
            "Prompt ändert sich von >>> zu ... bei fortgesetzten Anweisungen",
            "Einrückungen müssen konsistent sein",
            "Leere Zeile beendet einen Block"
        ],
        "hinweis": "Im interaktiven Modus muss ein Block durch Drücken der Enter-Taste beendet werden"
    }

# Aufruf der Funktion interaktiver_modus_mit_bloecken()
interaktiver_modus_mit_bloecken()
```

## 6. Lange Zeilen umbrechen

- Python erlaubt das Umbrechen langer Zeilen
- Innerhalb von Klammern werden Umbrüche automatisch erkannt
- An anderen Stellen kann der Backslash (`\`) verwendet werden

```python
def zeilen_umbrechen_klammern():
    """
    Zeigt, wie man lange Zeilen innerhalb von Klammern umbrechen kann.
    """
    # In Klammern können Umbrüche ohne Backslash erfolgen
    ergebnis = (
        10
        +
        10
    )
    
    return {
        "ergebnis": ergebnis,
        "hinweis": "Innerhalb von Klammern werden Zeilenumbrüche automatisch erkannt"
    }

# Aufruf der Funktion zeilen_umbrechen_klammern()
zeilen_umbrechen_klammern()
```

```python
def zeilen_umbrechen_backslash():
    """
    Zeigt, wie man lange Zeilen mit dem Backslash umbrechen kann.
    """
    # Mit Backslash können Umbrüche an beliebigen Stellen erfolgen
    var = 10  # Zum Vergleich: ohne Umbruch
    
    # Mit Backslash über mehrere Zeilen
    var_umgebrochen = \
        10
    
    return {
        "var": var,
        "var_umgebrochen": var_umgebrochen,
        "hinweis": "Der Backslash kann überall eingesetzt werden, wo auch ein Leerzeichen stehen könnte"
    }

# Aufruf der Funktion zeilen_umbrechen_backslash()
zeilen_umbrechen_backslash()
```

```python
def string_umbrechen():
    """
    Zeigt verschiedene Möglichkeiten, Strings über mehrere Zeilen zu schreiben.
    """
    # Backslash im String
    string1 = "Hallo \
Welt"
    
    # Besser: Strings verketten
    string2 = "Hallo " \
              "Welt"
    
    return {
        "string_mit_backslash": string1,
        "strings_verkettet": string2,
        "hinweis": "Die Verkettung von Strings ist oft die bessere Option, da keine ungewollten Leerzeichen entstehen"
    }

# Aufruf der Funktion string_umbrechen()
string_umbrechen()
```

## 7. Mehrere Anweisungen in einer Zeile

- Mit dem Semikolon (`;`) können mehrere Anweisungen in einer Zeile zusammengefasst werden
- Bei Anweisungen mit Block kann der Block in derselben Zeile stehen

```python
def mehrere_anweisungen_in_zeile():
    """
    Zeigt, wie mehrere Anweisungen in einer Zeile zusammengefasst werden können.
    """
    # Semikolon trennt Anweisungen
    ergebnis1 = 5
    ergebnis2 = 10
    
    # Dasselbe in einer Zeile
    ergebnis3 = 5; ergebnis4 = 10
    
    return {
        "getrennt": [ergebnis1, ergebnis2],
        "zusammen": [ergebnis3, ergebnis4],
        "hinweis": "Das Zusammenfassen von Anweisungen kann die Lesbarkeit verschlechtern"
    }

# Aufruf der Funktion mehrere_anweisungen_in_zeile()
mehrere_anweisungen_in_zeile()
```

```python
def einzeilige_bloecke():
    """
    Zeigt, wie Anweisungen mit Blöcken in einer Zeile geschrieben werden können.
    """
    x = True
    
    # Normal mit Einrückung
    if x:
        ergebnis1 = "x ist wahr"
    
    # In einer Zeile
    if x: ergebnis2 = "x ist wahr"
    
    # Mehrere Anweisungen im Block
    if x: ergebnis3 = "Erster Teil"; ergebnis4 = "Zweiter Teil"
    
    return {
        "normal": ergebnis1,
        "einzeilig": ergebnis2,
        "mehrere_anweisungen": [ergebnis3, ergebnis4],
        "hinweis": "Einzeilige Blöcke sollten nur bei sehr einfachen Anweisungen verwendet werden"
    }

# Aufruf der Funktion einzeilige_bloecke()
einzeilige_bloecke()
```

## 8. Das Zahlenraten-Spiel (modularisiert)

Ein einfaches erstes Python-Programm, das in funktionale Komponenten aufgeteilt wurde. Diese Modularisierung hilft, den Code übersichtlicher und leichter verständlich zu machen.

### Die Basis-Funktionen des Spiels

```python
import random
def initialisierung():
    """
    Initialisiert die Variablen für das Zahlenraten-Spiel.
    
    Returns:
        Ein Dictionary mit den initialisierten Werten
    """
    geheimnis = 1337  # Die zu erratende Zahl
    versuch = -1      # Anfangswert für die Benutzereingabe, verschieden von geheimnis
    zaehler = 0       # Zähler für die Anzahl der Versuche
    
    return {
        "geheimnis": geheimnis,
        "versuch": versuch,
        "zaehler": zaehler
    }

# Aufruf der Funktion initialisierung()
initialisierung()
```

Diese Funktion setzt die Anfangswerte für das Spiel. Durch die Trennung der Initialisierung vom Rest des Codes wird deutlich, welche Variablen das Spiel benötigt und mit welchen Werten sie starten.

```python
def rate_zahl(geheimnis, versuch, zaehler):
    """
    Verarbeitet einen Rateversuch und gibt Feedback.
    
    Args:
        geheimnis: Die zu erratende Zahl
        versuch: Die aktuelle Ratezahl des Benutzers
        zaehler: Die bisherige Anzahl der Versuche
    
    Returns:
        Ein Dictionary mit Informationen zum Rateversuch
    """
    # Feedback generieren
    feedback = ""
    if versuch < geheimnis:
        feedback = "Zu klein"
    elif versuch > geheimnis:
        feedback = "Zu groß"
    else:
        feedback = "Richtig!"
    
    # Zähler erhöhen
    zaehler = zaehler + 1
    
    return {
        "versuch": versuch,
        "feedback": feedback,
        "zaehler": zaehler,
        "richtig_geraten": versuch == geheimnis
    }

# Beispielaufruf der Funktion rate_zahl() mit einem Rateversuch
rate_zahl(1337, 500, 1)
```

Diese Funktion verarbeitet einen einzelnen Rateversuch. Sie prüft, ob der Versuch richtig, zu groß oder zu klein ist, und gibt entsprechendes Feedback zurück. Der Versuchszähler wird erhöht und alle Informationen werden im Rückgabewert gebündelt.

```python
def ergebnis_ausgabe(zaehler):
    """
    Generiert die Erfolgsmeldung nach dem Erraten der Zahl.
    
    Args:
        zaehler: Die Anzahl der benötigten Versuche
    
    Returns:
        Die Erfolgsmeldung als String
    """
    return f"Super, Sie haben es in {zaehler} Versuchen geschafft!"

# Aufruf der Funktion ergebnis_ausgabe() mit einem Beispielwert
ergebnis_ausgabe(4)
```

Diese Funktion erstellt die Erfolgsmeldung, die angezeigt wird, wenn der Spieler die Zahl erraten hat.

### Hauptfunktion zum Starten des Spiels

```python
def start_zahlen_raten():
    """
    Startet das komplette Zahlenraten-Spiel und koordiniert die einzelnen Funktionen.
    Das Spiel läuft interaktiv in der Konsole.
    
    Returns:
        Ein Dictionary mit dem Spielverlauf und dem Ergebnis
    """
    # Spiel initialisieren
    spiel_status = initialisierung()
    geheimnis = spiel_status["geheimnis"]
    versuch = spiel_status["versuch"]
    zaehler = spiel_status["zaehler"]
    
    # Spielverlauf protokollieren
    verlauf = []
    
    # Spielschleife
    while versuch != geheimnis:
        # Benutzereingabe
        try:
            eingabe = int(input("Raten Sie: "))
        except ValueError:
            print("Bitte geben Sie eine ganze Zahl ein!")
            continue
        
        # Rateversuch verarbeiten
        ergebnis = rate_zahl(geheimnis, eingabe, zaehler)
        
        # Spielstatus aktualisieren
        versuch = eingabe
        zaehler = ergebnis["zaehler"]
        
        # Feedback ausgeben
        print(ergebnis["feedback"])
        
        # Versuch protokollieren
        verlauf.append({
            "versuch": versuch,
            "feedback": ergebnis["feedback"],
            "zaehler": zaehler
        })
    
    # Erfolgsmeldung ausgeben
    erfolg = ergebnis_ausgabe(zaehler)
    print(erfolg)
    
    # Gesamtergebnis zurückgeben
    return {
        "geheimnis": geheimnis,
        "verlauf": verlauf,
        "zaehler": zaehler,
        "erfolg": erfolg
    }

# Um das Spiel zu starten, kommentieren Sie die folgende Zeile ein:
start_zahlen_raten()
```

Diese Hauptfunktion verbindet alle vorherigen Funktionen zu einem vollständigen Spiel. Sie initialisiert das Spiel, führt die Rateschleife durch und gibt am Ende das Ergebnis aus.

### Testfunktion mit simulierten Eingaben

```python
def test_zahlen_raten(test_eingaben):
    """
    Testet das Zahlenraten-Spiel mit vordefinierten Eingaben.
    
    Args:
        test_eingaben: Eine Liste von simulierten Benutzereingaben
    
    Returns:
        Ein Dictionary mit dem Spielverlauf und dem Ergebnis
    """
    # Spiel initialisieren
    spiel_status = initialisierung()
    geheimnis = spiel_status["geheimnis"]
    zaehler = spiel_status["zaehler"]
    
    # Spielverlauf protokollieren
    verlauf = []
    
    # Testmodus mit simulierten Eingaben
    for eingabe in test_eingaben:
        print(f"Raten Sie: {eingabe}")
        
        ergebnis = rate_zahl(geheimnis, eingabe, zaehler)
        zaehler = ergebnis["zaehler"]
        
        print(ergebnis["feedback"])
        
        verlauf.append({
            "versuch": eingabe,
            "feedback": ergebnis["feedback"],
            "zaehler": zaehler
        })
        
        if ergebnis["richtig_geraten"]:
            break
    
    # Erfolgsmeldung ausgeben
    erfolg = ergebnis_ausgabe(zaehler)
    print(erfolg)
    
    # Gesamtergebnis zurückgeben
    return {
        "geheimnis": geheimnis,
        "verlauf": verlauf,
        "zaehler": zaehler,
        "erfolg": erfolg
    }

# Beispieltestdurchlauf mit simulierten Rateversuchen
test_zahlen_raten([42, 10000, 999, 1337])
```

Diese zusätzliche Funktion ermöglicht es, das Spiel mit vordefinierten Eingaben zu testen, ohne jedes Mal manuell Zahlen eingeben zu müssen. Dies ist besonders nützlich zum Testen und Debuggen.

## Vorteile der Modularisierung

Die Aufteilung des Zahlenraten-Spiels in separate Funktionen bietet zahlreiche Vorteile:

1. **Bessere Lesbarkeit**: 
	- Jede Funktion hat eine klare, abgegrenzte Aufgabe, was den Code leichter verständlich macht.
2. **Verbesserte Testbarkeit**: 
	- Die einzelnen Komponenten können unabhängig voneinander getestet werden.
3. **Wiederverwendbarkeit**: 
	- Funktionen wie `rate_zahl()` könnten auch in anderen Spielen verwendet werden.
4. **Einfachere Wartung**: 
	- Fehler können gezielt in der zuständigen Funktion behoben werden, ohne den restlichen Code zu beeinträchtigen.
5. **Erweiterbarkeit**: 
	- Das Spiel kann leicht um neue Funktionen erweitert werden, z.B. um einen Schwierigkeitsgrad oder eine Highscore-Liste.
6. **Didaktischer Wert**: 
	- Die Zerlegung komplexer Abläufe in einfache Schritte fördert das Verständnis der Programmlogik.
7. **Teamarbeit**: 
	- In größeren Projekten können verschiedene Entwickler an unterschiedlichen Funktionen arbeiten.

Diese Art der Modularisierung ist ein fundamentales Prinzip in der Softwareentwicklung und hilft dabei, selbst komplexe Programme überschaubar zu gestalten. Obwohl das Zahlenraten-Spiel ein einfaches Beispiel ist, demonstriert es bereits die Grundlagen der strukturierten Programmierung, die in professionellen Softwareprojekten unerlässlich sind.

## 9. Kommentare in Python

- Kommentare helfen, den Code zu dokumentieren
- Sie werden vom Interpreter ignoriert

```python
def kommentare_beispiele():
    """
    Zeigt verschiedene Arten von Kommentaren in Python.
    """
    # Zeilenkommentar mit dem #-Zeichen
    ergebnis1 = 42  # Kommentar am Ende einer Zeile
    
    """
    Dies ist ein mehrzeiliger Kommentar (Docstring).
    Er kann sich über mehrere Zeilen erstrecken.
    """
    
    '''
    Auch mit einfachen Anführungszeichen möglich.
    '''
    
    return {
        "zeilenkommentar": "Beginnt mit # und geht bis zum Zeilenende",
        "blockkommentar": "Beginnt und endet mit drei Anführungszeichen (''' oder \"\"\")",
        "hinweis": "Docstrings (mehrzeilige Kommentare) werden eigentlich als Strings interpretiert, können aber auch als Kommentare verwendet werden"
    }

# Aufruf der Funktion kommentare_beispiele()
kommentare_beispiele()
```

## 10. Fehler und Fehlermeldungen

- Python gibt hilfreiche Fehlermeldungen aus
- Es gibt verschiedene Arten von Fehlern

```python
def syntax_fehler_beispiel():
    """
    Zeigt ein Beispiel für einen Syntaxfehler und wie Python ihn meldet.
    """
    # Dies würde einen Syntaxfehler verursachen, wenn es ausgeführt würde:
    # if versuch < geheimnis
    #     print("Zu klein")
    
    fehlermeldung = """
    File "spiel.py", line 10
      if versuch < geheimnis
                           ^
    SyntaxError: expected ':'
    """
    
    return {
        "fehlertyp": "SyntaxError",
        "fehlerbeschreibung": "Es fehlt ein Doppelpunkt am Ende der if-Anweisung",
        "fehleranalyse": [
            "Die erste Zeile gibt an, in welcher Datei und Zeile der Fehler aufgetreten ist",
            "Der Pfeil zeigt auf die Stelle, an der der Interpreter den Fehler entdeckt hat",
            "Die letzte Zeile gibt den Fehlertyp und eine kurze Beschreibung an"
        ]
    }

# Aufruf der Funktion syntax_fehler_beispiel()
syntax_fehler_beispiel()
```

```python
def einrueckungs_fehler_beispiel():
    """
    Zeigt ein Beispiel für einen Einrückungsfehler und wie Python ihn meldet.
    """
    # Dies würde einen Einrückungsfehler verursachen, wenn es ausgeführt würde:
    # i = 10
    # if i == 10:
    # print("Falsch eingerückt")
    
    fehlermeldung = """
    File "indent.py", line 3
      print("Falsch eingerückt")
      ^
    IndentationError: expected an indented block after 'if' statement on line 2
    """
    
    return {
        "fehlertyp": "IndentationError",
        "fehlerbeschreibung": "Der Anweisungskörper nach einer if-Anweisung muss eingerückt sein",
        "korrektur": "Die print-Anweisung muss um mindestens ein Leerzeichen (üblicherweise 4) eingerückt werden"
    }

# Aufruf der Funktion einrueckungs_fehler_beispiel()
einrueckungs_fehler_beispiel()
```

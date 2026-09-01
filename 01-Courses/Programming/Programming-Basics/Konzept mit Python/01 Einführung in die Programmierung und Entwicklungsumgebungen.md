> Grundlagen der Programmierung und Entwicklungsumgebungen

## 1. Block: Was ist Programmierung?

> Verständnis der grundlegenden Konzepte der Programmierung

### 1. Einführung 
- Vorstellen des Kursziels: „Am Ende der Woche können Sie ein kleines Programm schreiben, debuggen und verbessern.“
- Erwartungsabfrage: „Was erwarten Sie von der Woche? Haben Sie schon Vorkenntnisse?“

### 2. Theorie: Was ist Programmierung?
- **Folgende Punkte erklären:**
	- Programm: 
		- Ein Set von Anweisungen, die der Computer ausführt.
	- Übersetzer: 
		- Compiler (z. B. in C++) und Interpreter (z. B. in Python).
	- Basisbegriffe: 
		- Quellcode, Syntax, Semantik.
	- Beispiel: Warum kann ein falsch gesetztes Semikolon ein Programm unbrauchbar machen?
- **Visualisierung nutzen:**
	- Flussdiagramm: 
		- Eingabe → Verarbeitung → Ausgabe.
### 3. Praxis: „Hello World“-Programm
- **Vorgehen:**
	1. Kurz zeigen, wie man ein „Hello World“-Programm schreibt und ausführt.
	2. Teilnehmer erstellen selbst ein „Hello World“-Programm in Python:
		
	```python
	print("Hello World")
	```
		
	3. **Fehlersuche simulieren:** Teilnehmer machen absichtlich kleine Fehler (z. B. vergessen der Anführungszeichen).
## 2. Block: Entwicklungsumgebungen und Tools

> Einrichtung einer IDE und Verstehen ihrer Bestandteile.
### 1. Theorie: Was ist eine IDE?
- Definition: IDE = Integrated Development Environment.
- Bestandteile: Editor, Debugger, Compiler/Interpreter.
- Beispiele: Visual Studio Code, PyCharm, IDLE.
### 2. Praxis: Einrichten einer Entwicklungsumgebung
- **Schritt 1: Installation von Visual Studio Code**:
	- Gemeinsam den Download und die Installation durchführen.
- **Schritt 2: Vorstellung der wichtigsten Features:**
	- Code-Editor.
	- Debugging-Tools.
	- Erweiterungen (z. B. Linter für Python).
- **Schritt 3: Schreiben und Ausführen eines Programms:**
	
	- Programm mit Eingabe und Ausgabe schreiben, z. B.:
		
		```python
		name = input("Wie heißt du? ")
		print(f"Hallo, {name}!")
		```
		
- **Schritt 4: Gemeinsames Debugging:**
	
	- Beispielhafte Fehler einbauen:
		- Falscher Datentyp (z. B. `int` statt `string`).
		- Rechtschreibfehler bei `print`.
	- Teilnehmer suchen die Fehler und beheben sie.
## 3. Block: Daten und Variablen

> Verständnis von Variablen und Datentypen.
### 1. Theorie: Einführung in Daten und Variablen
    
- Was ist eine Variable? (Speicherplatz für Werte).
- Datentypen in Python:
	- `int` (Ganzzahlen)
	- `float` (Gleitkommazahlen)
	- `string` (Zeichenketten)
	- `bool` (Wahr/Falsch)
### 2. Praxis: Variablen deklarieren und verwenden
    
- Beispiele:
	
	```python
	alter = 20
	name = "Anna"
	ist_volljaehrig = alter >= 18
	print(f"{name} ist volljährig: {ist_volljaehrig}")
	```
	
- Übungen:
	- Teilnehmer erstellen ein Programm mit eigenen Variablen.
	- Berechnung des Flächeninhalts eines Rechtecks (`länge * breite`).
### 3. Gruppenaufgabe: Fehler finden und beheben
    
- Falsche Datentypen oder falsche Syntax.
- Diskussion der Lösungen.
## 4. Block: Abschlussaufgabe – Einfacher Taschenrechner

> Anwendung der erlernten Konzepte in einer kleinen Abschlussaufgabe.

### Aufgabe:
- Schreibe ein Programm, das zwei Zahlen einliest und eine der Grundrechenarten (Addition, Subtraktion, Multiplikation, Division) ausführt.
- Beispielcode:
	
	```python
	zahl1 = float(input("Gib die erste Zahl ein: "))
	zahl2 = float(input("Gib die zweite Zahl ein: "))
	ergebnis = zahl1 + zahl2
	print(f"Das Ergebnis ist: {ergebnis}")
	```
  
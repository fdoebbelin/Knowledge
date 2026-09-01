> **Thema des Tages:** Kontrollstrukturen (Bedingungen und Verzweigungen)

## 1. Block: Theorie – Bedingungen und Verzweigungen

> Verständnis von Kontrollstrukturen (`if`, `else`, `elif`) und deren Anwendung.

### 1. Rückblick auf Modul 1
    
- Kurze Wiederholung:
	- „Was ist eine Variable?“
	- „Welche Datentypen haben wir kennengelernt?“
	- „Wer hatte Schwierigkeiten mit der Taschenrechner-Aufgabe?“
- Teilnehmer können offene Fragen stellen.
### 2. Einführung: Was sind Kontrollstrukturen?
    
- Definition: Kontrollstrukturen sind Anweisungen, mit denen der Programmfluss gesteuert wird.
- Wichtigste Kontrollstruktur: Bedingte Anweisungen (`if`, `else`, `elif`).
- **Syntax in Python:**
	
	```python
	if bedingung:
		# Anweisungen
	elif andere_bedingung:
		# Anweisungen
	else:
		# Anweisungen
	```
	
- **Beispiel:**
	
	```python
	alter = int(input("Wie alt bist du? "))
	if alter >= 18:
		print("Du bist volljährig.")
	else:
		print("Du bist minderjährig.")
	```
	
### 3. Praxis: Einfache Bedingung schreiben
    
- Teilnehmer schreiben ein Programm, das das Alter abfragt und ausgibt, ob jemand volljährig ist.
- Erweiterung: Verschachtelte Bedingungen (z. B. „ab 16 Führerschein mit Begleitung möglich“).

## 2. Block: Logische Operatoren und verschachtelte Bedingungen

> Verständnis der logischen Operatoren (`AND`, `OR`, `NOT`) und komplexeren Bedingungen.

### 1. Theorie: Logische Operatoren
    
- **AND**: Alle Bedingungen müssen wahr sein.
- **OR**: Eine der Bedingungen muss wahr sein.
- **NOT**: Kehrt die Bedingung um.
- **Beispiele:**
	
```python
alter = 20
student = True

if alter >= 18 and student:
	print("Volljähriger Student")
if alter < 18 or student:
	print("Minderjähriger oder Student")
if not student:
	print("Kein Student")
```
        
### 2. Praxis: Bedingte Programme schreiben
    
- Aufgabe: Schreibe ein Programm, das eine Ampelschaltung simuliert:
	- Eingabe der Ampelfarbe (`rot`, `gelb`, `grün`).
	- Ausgabe: „Halt“, „Vorsicht“, „Los“.
- Erweiterung: Eingabe einer zweiten Ampelfarbe (Fußgängerampel) und logische Verknüpfungen verwenden.
### 3. Gruppenarbeit: Verschachtelte Bedingungen
    
- Aufgabe: Schreibe ein Programm, das ein Alter und eine Nationalität abfragt und entscheidet, ob jemand wählen darf. Beispiel:
	- Ab 18 Jahren darf gewählt werden.
	- Ausnahme: In bestimmten Ländern ab 16 Jahren.
### 4. Präsentation und Besprechung der Ergebnisse
    
- Teilnehmer präsentieren ihre Programme.
- Gemeinsame Diskussion: Was lief gut? Welche Herausforderungen gab es?
## 3. Block: Theorie und Praxis – Switch-Case und Ternäre Operatoren

> Kennenlernen alternativer Kontrollstrukturen und deren Anwendungen.
### 1. Theorie: Einführung in Switch-Case

- Hinweis: In Python wird `switch-case` erst seit Version 3.10 mit `match-case` unterstützt.
- **Syntax für Python (ab Version 3.10):**
	
```python
def wochenplan(tag):
	match tag:
		case "Montag":
			return "Arbeitsbeginn"
		case "Freitag":
			return "Fast Wochenende"
		case _:
			return "Standard-Tag"

print(wochenplan("Montag"))
```
### 2. Praxis: Programm mit `match-case` schreiben
    
- Aufgabe: Schreibe ein Programm, das den Wochentag abfragt und ausgibt, ob es ein Arbeits- oder ein Ruhetag ist.
	- Erweiterung: Feiertage berücksichtigen.
- Teilnehmer probieren die neue Kontrollstruktur aus.
### 3. Theorie: Ternärer Operator
    
- Einführung in den verkürzten `if-else`-Operator:
	
```python
alter = 20
status = "Volljährig" if alter >= 18 else "Minderjährig"
print(status)
```
	
- Diskussion: Wann ist der ternäre Operator sinnvoll?
### 4. Praxis: Kurzaufgaben
    
- Aufgabe 1: 
	- Schreibe ein Programm, das entscheidet, ob eine Zahl gerade oder ungerade ist.
- Aufgabe 2: 
	- Schreibe ein Programm, das prüft, ob eine Zahl positiv oder negativ ist.
## 4. Block: Abschlussaufgabe – Komplexere Entscheidungsstrukturen

> Anwendung der erlernten Kontrollstrukturen in einer umfangreicheren Aufgabe.

### Aufgabe:
    
- Schreiben  Sie ein Programm, das folgende Anforderungen erfüllt:
	- Frage Name, Alter und Wohnort des Nutzers ab.
	- Entscheide anhand des Alters, ob der Nutzer volljährig ist.
	- Abfrage: Möchte der Nutzer Autofahren?
		- Wenn ja, prüfe das Alter (ab 18 erlaubt).
	- Ausgabe: Eine personalisierte Nachricht basierend auf den Eingaben.

**Beispielausgabe:**

```
Hallo Max! Du bist 20 Jahre alt und wohnst in Berlin. Du darfst Auto fahren.
```

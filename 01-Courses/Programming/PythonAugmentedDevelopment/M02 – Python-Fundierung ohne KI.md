*Standardkurs ~80 UE · M2-Anteil: 10 UE · Phase 1 (KI-freie Fundierung)*
*Aufbauend auf Modulstruktur (Stufe 2) und didaktischem Konzept (Stufe 1)*

---

## 0. Vorbemerkung

Diese Feinplanung operationalisiert M2 für einen Standardkurs von ca. 80 UE. Der M2-Anteil beträgt 10 UE in fünf Blöcken à 2 UE. Die UE-Länge (45 oder 60 Minuten) ist trägerabhängig; die Blockstruktur funktioniert in beiden Fällen, weil sie nach Lernsequenzen gegliedert ist, nicht nach festen Minuten.

**Was in dieser Feinplanung enthalten ist:**

1. Operationalisierte Lernziele mit Indikatoren
2. Inhaltliche Detailspezifikation (was wird vermittelt, was nicht)
3. Stundenraster für alle fünf Blöcke (Mikro-Struktur)
4. Übungspool mit konkretem Aufgabenmaterial (Tracing, Parsons, Worked Examples, Mini-Programmierung)
5. Materialvorlagen (Tabellenblätter, Selbstcheck, Lernjournal)
6. Diagnostik- und Beobachtungsbogen für die DoLe
7. Bewertungsraster (hilfsmittelfreies Kurzformat am Modulende)
8. Differenzierungspakete (für Vorerfahrene und für Anfänger:innen)
9. Übergang zu M3 (KI-Vertrag aktivieren)
10. Stolpersteine und DoLe-Hinweise

**Was ausdrücklich nicht in M2 gehört** (Abgrenzung):

- Listen, Tupel, Dictionaries, Sets → M4
- Tieferer Funktionsbegriff (Default-Args, *args/**kwargs, Closures) → M6
- Module, Imports → M6
- Datei-I/O → M6/M9
- OOP, Klassen → außerhalb des Anfänger-Curriculums
- KI-Tools → ab M3

Diese Abgrenzung ist wichtig: M2 darf nicht zur Themenrutsche werden. Die Erfahrung zeigt, dass die Versuchung groß ist, „nebenbei" Listen einzuführen, sobald `for`-Schleifen behandelt werden. Hier gilt: lieber `for` über Strings und über `range()` üben, Listen kommen später.

---

## 1. Operationalisierte Lernziele mit Indikatoren

| Lernziel | Indikator (was die TN am Modulende konkret können) | Ebene |
|---|---|---|
| L1 | TN können einer Variable einen Wert zuweisen, sie verändern und den aktuellen Wert ausgeben | A |
| L2 | TN unterscheiden int, float, str, bool, None und nennen je ein Beispiel | A |
| L3 | TN konvertieren mit `int()`, `float()`, `str()` zwischen Typen und erkennen typische Fehlerquellen | A |
| L4 | TN lesen `input()`-Werte ein und konvertieren sie korrekt für Berechnungen | A |
| L5 | TN schreiben if/elif/else-Konstrukte mit korrekter Einrückung und sinnvollen Bedingungen | A |
| L6 | TN kombinieren Vergleichsoperatoren mit `and`, `or`, `not` zu zusammengesetzten Bedingungen | A |
| L7 | TN schreiben `while`-Schleifen mit korrekter Abbruchbedingung (kein Endlos-Loop) | A |
| L8 | TN schreiben `for`-Schleifen mit `range()` und über Strings | A |
| L9 | TN nutzen `break` und `continue` korrekt | A |
| L10 | TN definieren Funktionen mit Parametern und `return` und rufen sie auf | A |
| L11 | TN tracen ein 15–25-zeiliges Skript per Hand korrekt und vollständig | A |
| L12 | TN unterscheiden Syntaxfehler, Laufzeitfehler und logischen Fehler an je einem Beispiel | A |
| L13 | TN beschreiben in eigenen Worten, was beim Ausführen einer Codezeile geschieht (notional machine) | C |
| L14 | TN benennen drei sicher beherrschte und drei unsichere Konzepte aus M2 | C |

**Mindeststandard für Modulabschluss:** L1, L2, L4, L5, L7, L8, L10, L11 (Indikatoren 7 von 10 in der Selbsteinschätzung sicher).

---

## 2. Inhaltliche Detailspezifikation

### Block A – Variablen, Datentypen, Ein-/Ausgabe (2 UE)

**Sprachelemente:**
- `print()` mit einem und mehreren Argumenten, mit `sep=` und `end=` (kurz, nicht vertieft)
- f-Strings für die einfache Ausgabe (`f"{name} ist {alter} Jahre alt"`)
- Variablenzuweisung, Mehrfachzuweisung (`a = b = 0` – nur zeigen, nicht prüfen)
- Datentypen: `int`, `float`, `str`, `bool`, `None`
- `type()` als Diagnose-Werkzeug
- Typkonvertierung: `int()`, `float()`, `str()`, `bool()`
- `input()` mit Prompt-String

**Bewusst nicht behandelt:**
- String-Methoden im Detail (kommt in M4)
- Formatierung mit `format()` oder `%` (nur f-Strings, sonst überfrachtend)
- Komplexe Zahlen, Bytes

**Stolperstein:** `input()` gibt **immer** einen String zurück. Das ist der Klassiker-Fehler („warum klappt `input("Alter: ") + 1` nicht?"). Wird im Block A explizit demonstriert.

### Block B – Bedingungen (2 UE)

**Sprachelemente:**
- Vergleichsoperatoren: `==`, `!=`, `<`, `<=`, `>`, `>=`
- Logische Operatoren: `and`, `or`, `not`
- `if`, `elif`, `else`
- Verkettete Vergleiche (`0 < x < 100`)
- Truthy/Falsy nur am Rand erwähnen (vertieft in M4)

**Bewusst nicht behandelt:**
- Ternärer Ausdruck (`x if cond else y`) – kann optional am Ende des Blocks gezeigt werden
- Match-Case (Python 3.10+) – zu fortgeschritten

**Stolperstein:** `=` vs. `==`. Klassischer Anfängerfehler, wird in Tracing-Aufgaben gezielt eingebaut.

### Block C – Schleifen (2 UE)

**Sprachelemente:**
- `while` mit Zähler und mit Abbruchbedingung
- `for i in range(n)`, `range(start, stop)`, `range(start, stop, step)`
- `for char in string` (über Zeichen iterieren)
- `break`, `continue`

**Bewusst nicht behandelt:**
- Iteration über Listen (kommt in M4)
- `enumerate`, `zip` (M4)
- `else`-Klausel bei Schleifen (verwirrend für Anfänger:innen)

**Stolperstein:** Endlos-Schleifen bei `while`. Wird im Block C demonstriert (mit Tastenkombination zum Abbruch). Außerdem: `range(1, 10)` enthält 10 nicht – wird mit Tracing nachgewiesen.

### Block D – Funktionen (2 UE)

**Sprachelemente:**
- `def`, Parameter, `return`
- Aufruf, Übergabe von Argumenten
- Funktionen ohne Rückgabewert (impliziter `return None`)
- Lokal vs. global – nur konzeptionell, ohne `global`-Keyword

**Bewusst nicht behandelt:**
- Default-Argumente (M6)
- Keyword-Argumente, *args, **kwargs (M6)
- Lambda (M6)
- Rekursion (außerhalb des Curriculums)
- Type Hints (sinnvoll, aber in M2 ablenkend; können in der Differenzierung gezeigt werden)

**Stolperstein:** Verwechslung von „Funktion definieren" und „Funktion aufrufen". Wird per Tracing nachgewiesen, indem ein Skript zuerst eine Funktion definiert (ohne sichtbare Wirkung) und dann mehrfach aufruft.

### Block E – Fehler & Konsolidierung (2 UE)

**Inhalte:**
- Tracebacks lesen: `File`, Zeilennummer, Fehlertyp, Fehlermeldung
- Drei Fehlerkategorien: Syntaxfehler (vor Ausführung), Laufzeitfehler (während Ausführung), logischer Fehler (Programm läuft, falsches Ergebnis)
- Häufige Fehlertypen: `SyntaxError`, `IndentationError`, `NameError`, `TypeError`, `ValueError`, `ZeroDivisionError`
- Selbstcheck (siehe Abschnitt 6)
- Lernjournal-Eintrag, Reflexion
- Vorbereitung des Übergangs zu M3

**Bewusst nicht behandelt:**
- `try`/`except` (kommt in M7)
- Eigene Exceptions

---

## 3. Stundenraster (Block-Mikrostruktur)

Jeder der fünf Blöcke folgt einer einheitlichen Mikro-Struktur. Die Zeitanteile sind als Anteile angegeben, damit sie auf 45-Min- oder 60-Min-UE übertragbar sind.

### Generische Block-Mikrostruktur (90 Min bzw. 120 Min für 2 UE)

| Phase | Anteil | Zweck | Methode |
|---|---|---|---|
| Anker | 10 % | Anschluss an Vorblock, heutiges Lernziel | Plenum, kurzes Recap |
| Konzept-Input | 20 % | Neue Sprachelemente einführen | Live-Coding mit Tracing-Pausen |
| Worked Example | 15 % | Anwendung an vorgelöstem Beispiel | DoLe demonstriert + Plenum-Diskussion |
| Übungsphase | 40 % | Eigenaktivität | Tracing, Parsons, Mini-Programmierung |
| Konsolidierung | 10 % | Reflexion, Sicherung | Plenum, Lernjournal-Notiz |
| Brücke | 5 % | Übergang zum nächsten Block | Ausblick, Hausaufgabe |

### Kursverlauf M2 im Überblick

| Block | UE | Inhalt | Zentrale Übungsformate |
|---|---|---|---|
| A | 2 | Variablen, Datentypen, I/O | Tracing einfacher Zuweisungen, Typkonvertierungs-Puzzle |
| B | 2 | Bedingungen | Tracing mit if/elif, Parsons-Puzzles für Bedingungsketten |
| C | 2 | Schleifen | Tracing-Tabelle mit Schleifenzähler, Schleifen-Parsons |
| D | 2 | Funktionen | Tracing mit Funktionsaufrufen, Funktions-Parsons |
| E | 2 | Fehler & Konsolidierung | Fehleranalyse-Übung, Selbstcheck |

---

## 4. Übungspool mit konkretem Aufgabenmaterial

### 4.1 Tracing-Aufgaben (zentrales Übungsformat)

Tracing-Aufgaben werden in einer Tabelle bearbeitet. Pro Codezeile eine Zeile in der Tabelle, Spalten: „Zeile", „aktuelle Variablenwerte", „Ausgabe (falls)".

**Beispiel Tracing A1 – Stufe leicht (Block A)**

```python
1  name = "Anna"
2  alter = 30
3  print(name, "ist", alter)
4  alter = alter + 5
5  print(name, "ist jetzt", alter)
```

Erwartete Trace-Tabelle:

| Zeile | name | alter | Ausgabe |
|---|---|---|---|
| 1 | "Anna" | – | – |
| 2 | "Anna" | 30 | – |
| 3 | "Anna" | 30 | `Anna ist 30` |
| 4 | "Anna" | 35 | – |
| 5 | "Anna" | 35 | `Anna ist jetzt 35` |

**Beispiel Tracing B2 – Stufe mittel (Block B)**

```python
1  x = 7
2  y = 12
3  if x > 5 and y < 10:
4      print("A")
5  elif x > 5 or y < 10:
6      print("B")
7  else:
8      print("C")
9  print("Ende")
```

Erwartete Trace: x=7, y=12 unverändert; Zeile 3 false, Zeile 5 true → Ausgabe `B` und `Ende`.

**Beispiel Tracing C3 – Stufe mittel (Block C)**

```python
1  summe = 0
2  for i in range(1, 6):
3      if i % 2 == 0:
4          summe = summe + i
5  print(summe)
```

Erwartete Trace: summe wird bei i=2 auf 2, bei i=4 auf 6 gesetzt; Ausgabe `6`.

**Beispiel Tracing D4 – Stufe schwer (Block D)**

```python
1  def verdoppele(x):
2      return x * 2
3
4  def verarbeite(a, b):
5      c = verdoppele(a)
6      d = verdoppele(b)
7      return c + d
8
9  ergebnis = verarbeite(3, 5)
10 print(ergebnis)
```

Erwartete Trace mit Funktions-Stack: bei Aufruf `verarbeite(3, 5)` werden a=3, b=5 lokal, dann `verdoppele(3)` mit lokalem x=3, return 6, c=6; analog d=10; Ausgabe `16`.

**Beispiel Tracing E5 – Fehleranalyse (Block E)**

```python
1  alter = input("Alter: ")
2  if alter > 18:
3      print("erwachsen")
4  else:
5      print("minderjährig")
```

TN sollen erkennen: Zeile 2 wirft `TypeError`, weil `alter` ein String ist und nicht mit `int` verglichen werden kann. Lösung: `int(input(...))`.

### 4.2 Parsons-Puzzles (zweites zentrales Übungsformat)

Parsons-Puzzles geben Codezeilen vor, die in die richtige Reihenfolge gebracht werden müssen. Sie reduzieren Cognitive Load (TN müssen Syntax nicht aus dem Kopf produzieren) und sind LLM-resilient.

**Empfehlung:** Parsons-Puzzles als Karten oder als drag-and-drop-Übung auf Papier (mit Schere). Für Online-Kurse eignet sich ein einfaches HTML-Tool (z. B. js-parsons) oder ein simples Editor-basiertes Verfahren mit nummerierten Zeilen.

**Parsons B1 (Block B, leicht)**

Aufgabe: „Frage das Alter ab. Ist es ≥ 18, gib 'volljährig' aus, sonst 'minderjährig'."

Vorgegebene Zeilen (in falscher Reihenfolge, plus zwei Distraktoren):

```
print("minderjährig")
alter = int(input("Alter: "))
else:
print("volljährig")
if alter >= 18:
alter = input("Alter: ")           ← Distraktor
if alter > 18                       ← Distraktor (fehlender Doppelpunkt)
```

**Parsons C2 (Block C, mittel)**

Aufgabe: „Berechne die Summe aller Zahlen von 1 bis 10."

Vorgegebene Zeilen:

```
summe = 0
for i in range(1, 11):
    summe = summe + i
print(summe)
```

Plus drei Distraktoren:

```
for i in range(10):                 ← geht auch, aber falsche Range
summe = summe + 1                   ← falscher Operand
print(i)                            ← falsche Variable
```

**Parsons D3 (Block D, schwer)**

Aufgabe: „Definiere eine Funktion `groesster(a, b, c)`, die das Maximum von drei Zahlen zurückgibt."

Vorgegebene Zeilen werden bewusst so gestreut, dass Einrückung und Funktionsstruktur geübt werden. Distraktoren testen das Verständnis von `return` vs. `print`.

### 4.3 Worked Examples

Worked Examples sind vollständig durchgearbeitete Beispiele mit Erklärung jeder Zeile. Sie reduzieren Cognitive Load nach Sweller/Atkinson.

**Worked Example A1 (Block A) – „Temperaturkonvertierung"**

```python
# Aufgabe: Konvertiere Celsius nach Fahrenheit
celsius_str = input("Temperatur in °C: ")  # input liefert String
celsius = float(celsius_str)               # in Zahl umwandeln
fahrenheit = celsius * 9/5 + 32            # Formel anwenden
print(f"{celsius} °C entsprechen {fahrenheit} °F")
```

Erklärung Zeile für Zeile (DoLe oder schriftlich):

1. `input("Temperatur in °C: ")` zeigt den Prompt-Text an und wartet auf eine Eingabe; das Ergebnis ist immer ein String (auch wenn die Person „25" tippt).
2. `float(...)` wandelt den String in eine Fließkommazahl um. Wenn der String keine gültige Zahl ist, wirft Python einen `ValueError`.
3. Operatorpräzedenz: `*` und `/` binden stärker als `+`. Die Reihenfolge ist also `(celsius * 9 / 5) + 32`.
4. f-String fügt die Werte direkt in den Ausgabe-String ein.

**Worked Example C1 (Block C) – „Mittelwert von n Zahlen"**

```python
n = int(input("Wie viele Zahlen? "))
summe = 0
for i in range(n):
    zahl = float(input(f"Zahl {i+1}: "))
    summe = summe + zahl
mittelwert = summe / n
print(f"Mittelwert: {mittelwert}")
```

Erklärung mit Trace bei n=3 und Eingaben 4, 6, 8: summe schrittweise 0 → 4 → 10 → 18; Mittelwert 6.0.

### 4.4 Mini-Programmieraufgaben

Mini-Programmieraufgaben sind die einzigen Aufgaben, in denen TN selbst Code schreiben (ohne KI). Sie sind klein, klar spezifiziert, und bauen aufeinander auf.

| ID | Block | Aufgabe | Schwierigkeit |
|---|---|---|---|
| MP-A1 | A | Frage Vor- und Nachname ab und gib eine Begrüßung aus | leicht |
| MP-A2 | A | Frage zwei Zahlen ab und gib Summe, Differenz, Produkt aus | leicht |
| MP-A3 | A | Wandle Sekunden in Minuten und Sekunden um (z. B. 125 → 2 Min 5 Sek) | mittel |
| MP-B1 | B | Gib zu einer Note (1–6) den Notentext aus („sehr gut" usw.) | leicht |
| MP-B2 | B | Prüfe, ob ein Jahr ein Schaltjahr ist (durch 4, nicht durch 100, oder durch 400) | mittel |
| MP-B3 | B | BMI-Rechner mit Klassifikation (untergewichtig/normal/übergewichtig) | mittel |
| MP-C1 | C | Gib die Zahlen 1 bis 100 aus, ersetze Vielfache von 3 durch „Fizz", von 5 durch „Buzz", von 15 durch „FizzBuzz" | mittel |
| MP-C2 | C | Berechne die Fakultät einer Zahl (mit Schleife, ohne Rekursion) | mittel |
| MP-C3 | C | Zähle die Vokale in einem String | mittel |
| MP-D1 | D | Schreibe eine Funktion `quadrat(x)`, die x² zurückgibt | leicht |
| MP-D2 | D | Schreibe eine Funktion `ist_primzahl(n)`, die `True` oder `False` zurückgibt | mittel |
| MP-D3 | D | Schreibe eine Funktion `passwort_check(p)`, die prüft: mind. 8 Zeichen, eine Ziffer, ein Großbuchstabe | schwer |
| MP-E1 | E | Gegeben ist Code mit drei Bugs (siehe Material 4.4-bugs.py). Finde sie ohne Ausführung | schwer |

Pro Block werden 2–3 Mini-Aufgaben in der Übungsphase bearbeitet, der Rest steht als Differenzierung oder Selbstlernzeit bereit.

---

## 5. Materialvorlagen

### 5.1 Tracing-Tabellenblatt

Empfehlung: A4 quer, sechs Spalten. Über dem Blatt: Aufgabentitel, Codeschnipsel mit Zeilennummern. Darunter Tabelle:

```
| Zeile | <Var1> | <Var2> | <Var3> | Bedingung wahr? | Ausgabe |
|-------|--------|--------|--------|-----------------|---------|
|       |        |        |        |                 |         |
```

Die Variablenspalten werden je Aufgabe angepasst. Pro Variable eine Spalte, dazu eine Spalte für Bedingungs-Ergebnisse (bei if/while) und eine für Ausgaben.

**Hinweis für die DoLe:** Tracing-Tabelle ist physisches Material (Papier, Stift). Bewusst nicht digital, weil das Mit-Schreiben den Lerneffekt verstärkt (Cognitive Apprenticeship). Online-Kurse: PDF zum Ausdrucken oder einfaches digitales Tabellenformat, kein interaktives Tool.

### 5.2 Parsons-Puzzle-Vorlage

Empfehlung: Codezeilen werden auf einzelne Streifen gedruckt (oder ausgeschnitten); TN sortieren sie auf dem Tisch. Distraktoren in einer separaten Farbe (z. B. grau hinterlegt) – nach erfolgter Lösung wird gemeinsam besprochen, **warum** ein Distraktor falsch ist.

Online: js-parsons ist die etablierte Open-Source-Lösung; Alternative ist eine simple Liste mit Drag-and-Drop oder ein Texteditor mit nummerierten Zeilen.

### 5.3 Selbstcheck am Modulende (Block E)

Ein zweiseitiges Dokument. Die TN bearbeiten ihn allein, ohne KI, in ca. 20–30 Min. Er ist **nicht** prüfungsrelevant; er dient der Selbstdiagnose und der Verständigung mit der DoLe.

**Teil 1 – Verständnis-Selbsteinschätzung (5er-Skala je Indikator)**

Pro Indikator (L1–L14): „Ich kann das…" mit fünf Stufen: 1 = nein, 2 = unsicher, 3 = mit Hilfe, 4 = sicher, 5 = sicher und kann es erklären.

**Teil 2 – Praktischer Mini-Check (5–10 Min)**

Drei kurze Aufgaben:

a) Tracing eines 8-zeiligen Skripts (Bedingung + Schleife)
b) Parsons-Puzzle (Funktion mit Schleife)
c) Fehlersuche: Drei Code-Snippets mit je einem Bug; TN sollen den Fehlertyp benennen, nicht zwingend reparieren.

**Teil 3 – Lernjournal-Eintrag**

Drei Sätze:
- „Drei Konzepte, die ich sicher beherrsche: …"
- „Drei Konzepte, bei denen ich noch unsicher bin: …"
- „Was war der wichtigste Aha-Moment in M2 für mich?"

### 5.4 Lernjournal-Vorlage (durchgängig durch den Kurs)

Die Lernjournal-Vorlage ist im Kurs durchgängig. Pro Modul ein Abschnitt mit drei Feldern:

```
Modul: ___
Datum: ___

Was habe ich heute gelernt?
(2–3 Sätze, in eigenen Worten)

Was war neu/überraschend?
(1–2 Sätze)

Was ist mir noch unklar?
(konkrete Frage)
```

In M2 wird das Lernjournal in Block E ausgewertet, in M11 noch einmal vollständig.

---

## 6. Diagnostik- und Beobachtungsbogen für die DoLe

Während der Übungsphasen geht die DoLe im Raum (oder im Online-Breakout) herum und beobachtet anhand des folgenden Bogens. Ziel: Frühindikatoren erkennen, bevor sie sich als hartnäckige Lernprobleme manifestieren.

### 6.1 Beobachtungsindikatoren

| Indikator | Beobachtung deutet auf |
|---|---|
| TN tracen, ohne Variablenwerte aufzuschreiben | mentales Modell unklar; bittet um „Trace bitte schriftlich" |
| TN korrigieren Tracing-Fehler erst, wenn DoLe darauf zeigt | fehlende Selbstüberprüfung; Reflexionsroutine schwach |
| TN raten bei Parsons-Puzzles, statt zu argumentieren | Syntax-/Strukturverständnis fehlt; mehr Worked Examples |
| TN lassen Codeschnipsel sofort laufen, statt zu denken | „Run-and-See"-Strategie; in M2 noch nicht ideal |
| TN benennen Fehlermeldungen nicht, sondern „es geht nicht" | Lese-Routine für Tracebacks fehlt; in Block E vertiefen |
| TN vermischen `=` und `==` mehrfach | klassisch; Plenums-Klärung sinnvoll |
| TN klagen über Einrückung | IDE-Einstellungen prüfen, Tabs vs. Spaces |
| TN sind nach 30 Min noch beim Setup | Tooling-Problem aus M1; Pair mit Vorerfahrenem |

### 6.2 Frühwarnindikatoren

Wenn **drei oder mehr** der folgenden Beobachtungen für eine:n TN zutreffen, empfiehlt sich ein kurzes Einzelgespräch:

- TN zeigt im Plenum keine Aktivität, antwortet auch nicht auf direkte Ansprache
- TN bricht Tracing-Aufgaben nach wenigen Zeilen ab
- TN verwendet immer wieder dieselben Codestellen aus den Worked Examples ohne Anpassung
- TN behauptet „ich verstehe das alles", liefert aber keine korrekte Lösung
- TN drückt Frust körperlich/verbal aus
- TN versucht trotz KI-Vertrag aus M1, KI zu nutzen

Im Einzelgespräch nicht kontrollieren, sondern verstehen: „Was macht dir gerade Mühe?" – das öffnet mehr als „Wo hängst du?".

### 6.3 Klassendiagnose-Sammelbogen

Am Ende jedes Blocks notiert die DoLe:

- Welche Indikatoren waren breit aufgetreten?
- Welche Konzepte wurden im Plenum nochmals erklärt?
- Welche TN brauchen im nächsten Block besondere Aufmerksamkeit?
- Pacing: war zu schnell/zu langsam – ggf. Anpassung im nächsten Block?

---

## 7. Bewertungsraster (hilfsmittelfreies Kurzformat am Modulende)

Konzeptionelle Position aus M2-Stufe-2: Hilfsmittelfreie Kurzformate sichern die Ebene-A-Lernziele. Das nachfolgende Raster operationalisiert ein 30-Min-Kurzformat am Ende von Block E.

### 7.1 Format des Kurzformats

Drei Aufgabentypen, je 10 Min:

**Teil A: Tracing (10 Min)**

Ein Skript von 12–18 Zeilen mit `if`, `while` oder `for`, **einer** einfachen Funktion. TN füllen die Trace-Tabelle aus.

**Teil B: Parsons-Puzzle (10 Min)**

Aufgabenstellung in Worten + 8–12 Codezeilen (3 Distraktoren). TN sortieren und markieren Distraktoren.

**Teil C: Fehleranalyse (10 Min)**

Drei kurze Snippets (je 4–8 Zeilen) mit jeweils einem Bug. TN nennen Fehlertyp und – wo möglich – die Reparatur.

### 7.2 Bewertungsraster

Pro Teil 0–10 Punkte, gesamt 30 Punkte. Die TN erfahren das Raster vor dem Test.

**Teil A – Tracing (10 Punkte)**
- 10 P: alle Variablenwerte korrekt, alle Ausgaben korrekt
- 8 P: maximal eine kleine Abweichung (z. B. Reihenfolge der Spalten)
- 6 P: ein logischer Fehler in einer Schleifeniteration, sonst korrekt
- 4 P: korrekt bis zu einem Bruchpunkt, ab dort folgerichtig falsch
- 2 P: Trace begonnen, aber überwiegend falsch
- 0 P: keine sinnvolle Trace

**Teil B – Parsons (10 Punkte)**
- 10 P: korrekte Reihenfolge, Distraktoren korrekt erkannt, Einrückung stimmt
- 8 P: korrekte Reihenfolge, ein Distraktor übersehen oder Einrückung leicht abweichend
- 6 P: Reihenfolge funktional korrekt, aber zwei Probleme
- 4 P: Reihenfolge teilweise korrekt
- 2 P: erkennbarer Lösungsversuch, aber nicht funktional
- 0 P: keine sinnvolle Sortierung

**Teil C – Fehleranalyse (10 Punkte, je Snippet 0–3,33 P)**
Pro Snippet:
- 3 P: Fehlertyp korrekt benannt + sinnvolle Reparatur
- 2 P: Fehlertyp korrekt benannt, Reparatur fehlt oder leicht falsch
- 1 P: Fehler an richtiger Stelle erkannt, Typ falsch benannt
- 0 P: nicht erkannt

### 7.3 Bestanden-Kriterien

- Bestanden: ≥ 18 von 30 Punkten **und** mindestens 4 Punkte in jedem Teil
- Gut bestanden: ≥ 24 von 30 Punkten
- Nicht bestanden: < 18 oder weniger als 4 Punkte in einem Teil

**Wichtig:** Das Kurzformat ist konzeptionell nicht „Prüfung im Sinne eines Zertifikats". Es ist ein hilfsmittelfreies Lernstandsfeststellungsformat. Das ändert sich erst in M10 (Open-AI-Assessment) und – falls trägerseitig vorgesehen – am Kursende.

### 7.4 Umgang mit „nicht bestanden"

Kein TN wird aussortiert. Die DoLe vereinbart mit nicht bestandenen TN ein Wiederholungsformat (z. B. Zusatzaufgaben aus dem Pool, betreutes Üben in einer Selbstlernphase, Peer-Tutoring). In M3 wird dann mit allen TN gestartet, aber die DoLe weiß, wo Aufmerksamkeit nötig ist.

---

## 8. Differenzierungspakete

### 8.1 Für Vorerfahrene

TN mit Python-Vorerfahrung (in M1 diagnostiziert) erhalten in der Übungsphase Zusatzaufgaben:

- **Komplexere Tracing-Aufgaben** mit verschachtelten Schleifen und mehreren Funktionsaufrufen
- **Parsons mit höherer Distraktorquote** (4–6 Distraktoren statt 2–3)
- **Mini-Aufgaben aus der oberen Schwierigkeit** (MP-D3, MP-E1)
- **Optional: Type Hints** in den eigenen Funktionen
- **Optional: Refactoring-Aufgaben** – ein bewusst umständlich geschriebenes Skript wird klarer formuliert
- **Peer-Tutor-Rolle**, klar abgegrenzt: erklären, aber nicht vorsagen

Wichtig: Vorerfahrene werden nicht „durchgewunken". Auch sie machen das Kurzformat (7.1) mit. Erfahrungsgemäß zeigen sich auch hier Lücken (vor allem bei Tracing).

### 8.2 Für Anfänger:innen

TN ohne Vorerfahrung erhalten bei Bedarf:

- **Mehr Worked Examples** vor der eigenen Übungsphase
- **Parsons-Puzzles mit weniger Distraktoren** (1–2 statt 3)
- **Tracing-Tabellen mit vorgedruckten Variablen-Spaltenüberschriften**
- **Pair-Working** mit anderen Anfänger:innen (nicht zwingend mit Vorerfahrenen, weil das oft asymmetrisch wird)
- **Kürzere Mini-Aufgaben** mit klarem Beispiel-Output

In Online-Kursen ist die Differenzierung schwieriger, weil die DoLe die Bildschirme nicht alle sieht. Empfehlung: kurze 1:1-Breakouts während der Übungsphase, bei Bedarf Bildschirmfreigabe.

---

## 9. Übergang zu M3 – Aktivierung des KI-Vertrags

Am Ende von Block E (letzte 15 Min):

- Rückblick auf M2: was war anstrengend, was war hilfreich, was war neu?
- Ankündigung M3: ab M3 wird KI als Lernpartner eingeführt.
- **Aktivierung des KI-Vertrags aus M1:** TN lesen ihn nochmal durch, unterzeichnen ggf. eine zweite Version, in der die ersten praktischen Erfahrungen aus M2 berücksichtigt sind.
- Eine zentrale Frage als Hausaufgabe für M3: „Welche Frage zu Python würdest du jetzt einer KI stellen, und warum?" – wird in M3 als Gesprächseinstieg genutzt.

**Wichtige Botschaft:** Die KI-freie Phase endet, aber das in M2 aufgebaute mentale Modell bleibt das Fundament. Auch wenn ab M3 KI-Werkzeuge zur Verfügung stehen, müssen die Verifikationsroutinen auf diesem Fundament aufbauen.

---

## 10. Stolpersteine und DoLe-Hinweise

### 10.1 Typische TN-Probleme in M2

| Problem | Symptom | Antwort |
|---|---|---|
| `input()`-String nicht konvertiert | TypeError beim ersten arithmetischen Vergleich | im Block A explizit demonstrieren, in Block B als Tracing-Aufgabe wiederholen |
| `=` vs. `==` | Bedingung ist immer wahr/falsch ohne Logik | in Block B als Plenums-Klärung; Tracing-Aufgabe mit beiden Varianten nebeneinander |
| Endlos-Schleife | Programm hängt | in Block C demonstrieren, Tastenkombination zum Abbruch zeigen, danach gemeinsam debuggen |
| Einrückung falsch | IndentationError oder logischer Fehler | IDE-Einstellungen in M1 prüfen, in M2 jede Zeile mit DoLe-Augen mitlesen |
| `range(1, 10)` enthält 10 nicht | Fizzbuzz endet bei 99 | per Tracing nachweisen, nicht erklären lassen – sehen lassen |
| `return` vs. `print` in Funktionen | Funktion gibt nichts zurück, druckt aber etwas | in Block D explizit demonstrieren, Parsons-Puzzle mit beiden Varianten |
| TN „verstehen alles", aber lösen nichts | Selbstüberschätzung | Selbstcheck zeigt Realität; wichtig ist, dies nicht beschämend zu inszenieren |

### 10.2 Hinweise für die DoLe

**Live-Coding-Disziplin.** In M2 ist Live-Coding der zentrale Demonstrationsmodus. Tipp: bewusst Tippfehler einbauen, sie gemeinsam mit der Lerngruppe finden – das modelliert Fehlerbehandlung als normalen Vorgang.

**„Trace it!" als Standardantwort.** Wenn ein:e TN eine Frage stellt wie „warum macht der Code das?" – möglichst nicht erklären, sondern gemeinsam tracen. Das ist anstrengender, aber nachhaltiger.

**Die KI-freie Phase verteidigen.** Erfahrungsgemäß versuchen einzelne TN, „heimlich" KI zu nutzen. Die DoLe sollte dies nicht polizieren, sondern wiederholt die Begründung in Erinnerung rufen: in M2 geht es darum, ein mentales Modell aufzubauen, das ab M3 mit KI **zusammenarbeiten** kann. Wer in M2 mit KI arbeitet, baut dieses Fundament nicht auf und wird ab M3 (ohne es zu merken) in die „illusion of competence" geraten.

**Pacing-Diagnose.** Nach Block B (also Halbzeit M2) hat die DoLe ein gutes Bild von der Klassendynamik. Spätestens hier ggf. Pacing anpassen: bei zu schnellem Tempo Block C/D etwas vertiefen; bei zu langsamem Tempo die Differenzierung nutzen, um Vorerfahrene zu binden, ohne die Anfänger:innen zu verlieren.

**Eigene Fehler zeigen.** Die DoLe demonstriert in M2 idealerweise auch eigene Fehler beim Live-Coding. Das normalisiert Fehler als professionellen Vorgang und entlastet TN.

### 10.3 Trigger zur Anpassung im laufenden M2

| Trigger | Anpassung |
|---|---|
| Diagnostik in M1 zeigt: > 50 % der TN haben Programmiererfahrung | Block A auf 1 UE kürzen, gewonnene UE in Block D investieren |
| Diagnostik zeigt: < 20 % haben je Programm geschrieben | Block A auf 2,5 UE verlängern (aus dem Puffer), Block E auf 1,5 UE verkürzen |
| Nach Block B: Selbsteinschätzung niedrig, Beobachtung niedrig | im Block C mehr Worked Examples, weniger eigene Mini-Aufgaben |
| Nach Block D: TN können Funktionen nicht definieren | Block E mit Funktions-Tracing beginnen, Selbstcheck verschieben |
| Kursabschluss-Selbstcheck: > 30 % unter Bestanden-Kriterium | Wiederholungsphase einplanen, M3-Start verzögern |

---

## 11. Anhang: Abdeckungsmatrix Lernziele × Übungen

| Lernziel | Tracing | Parsons | Worked Ex. | Mini-Prog. | Selbstcheck |
|---|---|---|---|---|---|
| L1 Variable | A1 | – | A1 | MP-A1 | T2.a |
| L2 Datentypen | A2 | – | A1 | – | T1 |
| L3 Konvertierung | E5 | – | A1 | MP-A2, MP-A3 | T2.c |
| L4 input() | – | B1 | A1, C1 | MP-A1, MP-A2 | T1 |
| L5 if/elif/else | B2 | B1 | – | MP-B1, MP-B2, MP-B3 | T1 |
| L6 and/or/not | B2 | – | – | MP-B2 | T1 |
| L7 while | – | – | – | MP-C2 | T2.a |
| L8 for/range | C3 | C2 | C1 | MP-C1, MP-C2 | T2.a |
| L9 break/continue | – | – | – | MP-C1 (optional) | – |
| L10 Funktionen | D4 | D3 | – | MP-D1, MP-D2, MP-D3 | T2.b |
| L11 Tracing | A1, B2, C3, D4, E5 | – | – | – | T2.a |
| L12 Fehlertypen | E5 | – | – | MP-E1 | T2.c |
| L13 notional machine | indirekt | indirekt | indirekt | – | T3 (Reflexion) |
| L14 Selbsteinschätzung | – | – | – | – | T1 + T3 |

Diese Matrix zeigt, dass jedes Lernziel durch mindestens zwei Übungsformate abgedeckt ist. Bei der Aufgabenauswahl in den einzelnen Blöcken sollte die DoLe darauf achten, dass die Spalten breit gestreut werden – ein Block, in dem nur Tracing dominiert, ist methodisch zu eng.

---

## 12. Was die DoLe vor dem Kursstart konkret vorbereitet

Eine Checkliste für die operative Vorbereitung von M2:

- [ ] Tracing-Tabellenblatt-Vorlage als druckbares PDF
- [ ] Parsons-Puzzle-Karten (oder js-parsons-Setup für online)
- [ ] Worked Examples ausgearbeitet, mindestens je einer pro Block
- [ ] Mini-Programmieraufgaben (alle 13 Aufgaben aus 4.4) als Aufgabenblatt
- [ ] Selbstcheck-PDF (Vorlage in 5.3)
- [ ] Lernjournal-Vorlage (5.4)
- [ ] Beobachtungsbogen für die DoLe (6.1, 6.2, 6.3)
- [ ] Bewertungsraster (7.2) für die DoLe und – ohne Lösungen – für die TN als Vorab-Information
- [ ] Differenzierungs-Aufgabenpaket (8.1, 8.2)
- [ ] Live-Coding-Skripte: 5 Skripte (eines pro Block) mit bewusst eingebauten Stolpersteinen für die Demonstration
- [ ] Kommunikationsdokument für die TN: „Warum dieser Block ohne KI?" – in einem Absatz, schriftlich, im Kursportal

Dieses Material bildet die operative Substanz von M2. Mit der vorliegenden Feinplanung ist die didaktische Architektur abgedeckt; was bleibt, ist das Erstellen der konkreten Materialien gemäß den hier spezifizierten Vorgaben.

---

*Stand: April 2026. Diese Feinplanung ist die dritte Konzeptstufe (Stufe 1: didaktisches Konzept; Stufe 2: Modulstruktur; Stufe 3: Feinplanung). Sie sollte nach jedem Kursdurchlauf entlang der Beobachtungsbögen aus Abschnitt 6.3 kalibriert und – wo nötig – angepasst werden.*

## Erben von eingebauten Datentypen (am Beispiel `list`)

### 1. Motivation und Grundlagen

Python erlaubt es, von eingebauten Datentypen wie `list`, `dict` oder `str` mit der eigenen Klasse zu erben. Dadurch können bestehende Funktionalitäten gezielt erweitert oder angepasst werden – mit allen Vorteilen der OOP wie Wiederverwendbarkeit und Erweiterbarkeit.

***

### 2. Eigene abgeleitete Klasse: SortedList

**Aufgabe:**
Leite eine eigene Klasse `SortedList` von `list` ab, sodass das Einfügen (`append`) automatisch die Liste sortiert hält.

```python
class SortedList(list):
    def append(self, item):
        super().append(item)
        self.sort()  # Nach jedem Hinzufügen wird die Liste sortiert

# Beispiel und Test
s = SortedList([3, 1, 2])
s.append(5)
s.append(0)
print(s)  # Ausgabe: [0, 1, 2, 3, 5]
```

Damit wird beim Einfügen neuer Elemente stets das gewünschte, automatisch sortierte Verhalten erzielt.

***

### 3. Die Methode direkt im Basistyp verändern: Monkey Patching

Direkte Änderung bedeutet, Methoden eines eingebauten Typs **global** zur Laufzeit umzudefinieren (“Monkey Patching”).
Beispiel:

```python
def neuer_append(self, item):
    print("Achtung: list.append wird überschrieben!")
    self.extend([item])

list.append = neuer_append

a = [1, 2]
a.append(3)           
# => TypeError: cannot set 'append' attribute of immutable type 'list'
```

### 4. Vergleich: Ableiten vs. direktes Verändern

|  | Vererbung/Ableitung (z. B. SortedList) | Direktes Verändern (Monkey Patching) |
| :-- | :-- | :-- |
| **Wirkungsbereich** | Nur eigene Klasse und deren Instanzen | Im ganzen Programm, für alle `list` |
| **Wartbarkeit** | Sehr gut, klar abgegrenzt | Schlecht, schwer nachvollziehbar |
| **Fehleranfälligkeit** | Gering, Änderungen lokalisiert | Hoch, da Seiteneffekte überall möglich |
| **Standardverhalten noch da** | Ja, in anderen Listen keine Störung | Nein, Standardverhalten ist überschrieben |
| **Best Practices/OOP** | Idealer Weg für Erweiterungen | Wird ausdrücklich abgeraten (!) |


***

### 5. Vorteile der Ableitung

- **Klar abgrenzbare Funktionalität**: Das Verhalten ist auf die eigene Klasse beschränkt.
- **Kompatibilität**: Die Klasse ist weiter wie eine Liste verwendbar (z. B. in Funktionen).
- **Erweiterbarkeit**: Kann flexibel weitere Methoden oder eigene Eigenschaften erhalten.
- **Wartbarkeit**: Änderungen sind nachvollziehbar und leicht testbar.


### 6. Nachteile \& Gefahren des direkten Überschreibens

- **Unübersichtlichkeit**: Die Änderung wirkt ohne Warnung auf das gesamte Programm.
- **Fehlersuche**: Schwerwiegende Probleme („Warum verhält sich meine Liste plötzlich anders?“).
- **Kompatibilitätsbrüche**: Dritte Bibliotheken oder Standardfunktionen verlassen sich auf das Standardverhalten.
- **Best-Practice**: Wird in Python-Projekten nur als Notlösung (z. B. für Mocking im Test) genutzt.

***

## Zusammenfassung/Bewertung

**Empfehlung:**
Das Erben von eingebauten Typen wie `list` ist in Python gut realisierbar und ein sauberer Überweg, gewünschte Funktionalität gezielt und sicher zu erweitern. Das direkte Verändern von Methoden eingebauter Typen ist nicht mehr technisch möglich, sollte aber in Produktivcode dringend vermieden werden. OOP-Strategien wie die Ableitung bieten die nötige Flexibilität bei voller Kontrolle und Sicherheit.

Diskussionen zu Monkey Patching und Typunveränderlichkeit (PEP 3129, PEP 399)

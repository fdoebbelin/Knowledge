Das **C3-Linearization-Verfahren** ist der Algorithmus, mit dem Python die sogenannte Method Resolution Order (MRO) für Klassenhierarchien (vor allem mit Mehrfachvererbung) eindeutig bestimmt. Das Verfahren sorgt dafür, dass es immer eine konsistente, vorhersehbare Suchreihenfolge für Methoden- und Attributaufrufe gibt. Die MRO entscheidet also, in welcher Reihenfolge Python nach einer Methode sucht, wenn diese in Elternklassen mehrfach definiert ist.[^1][^2][^3]

***

## Grundprinzipien des C3-Algorithmus

- **Konsistenz**: Kindklassen werden immer vor Elternklassen geprüft („Kinder vor Eltern“).
- **Reihenfolge bleibt erhalten**: Bei Mehrfachvererbung bleibt die Reihenfolge der Basisklassen erhalten (wie sie im Klassendefinitionskopf angegeben wurden).
- **Monotonie**: Die Vererbungsbeziehungen bleiben logisch, sodass keine Elternklasse "übersprungen" oder mehrfach aufgelistet wird.[^2][^4]

***

## Wie funktioniert das Verfahren?

1. **Starte bei der abgeleiteten Klasse** und erstelle deren MRO-Liste.
2. **Führe die MRO-Listen der direkten Elternklassen** sowie die Elternklassen selbst (in Reihenfolge) zusammen („merge“).
3. Wähle jeweils immer das erste Element der Listen, das *nicht* beliebig später in einer der anderen Listen erscheint (also keine Vorfahrabfolge verletzt).
4. Entferne das gewählte Element aus allen Listen und trage es in die MRO ein.
5. Wiederhole die Schritte, bis alle Klassen einsortiert sind.

Dadurch entsteht eine eindeutige Linearisation aller beteiligten Klassen – auch bei komplexen Hierarchien mit Diamant-Struktur.

***

## Konkretes Beispiel

```python
class A: pass
class B(A): pass
class C(A): pass
class D(B, C): pass

print(D.__mro__)
# (<class '__main__.D'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.A'>, <class 'object'>)
```

- Hier ist sichergestellt: D → B → C → A → object.
- „B geht vor C“, weil die Definition von D so ist (`class D(B, C): ...`)
- „A“ erscheint genau einmal und nach ihren Kindern, auch wenn B und C beide von A erben.

***

## Bedeutung und Nutzen

C3-Linearization macht Vererbung vorhersehbar. 
Sie verhindert Schleifen und doppelte Einträge. 
Für Entwickler bedeutet das: Mit Blick auf die Ausgaben von `.__mro__` oder `.mro()` kann genau nachvollzogen werden, wie Python Methoden in komplexen Hierarchien sucht – und warum bestimmte Aufrufe zu bestimmten Ergebnissen führen.

***

**Zusammenfassung:**
Das C3-Linearization-Verfahren regelt die Reihenfolge der Methodensuche bei Mehrfachvererbung logisch, konsistent und fehlerfrei. 
Es ist der Kern jedes modernen OOP-Konzepts in Python – und wird bei einer objektorientierten Designsprache ab Python 2.3 und in Python 3.x stets verwendet.

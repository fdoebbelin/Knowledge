# Geschichte der Informatik - Interaktiv

Dieses Jupyter-Notebook enthält interaktive Aufgaben und Lösungen zur Geschichte der Informatik.
Jede Sektion besteht aus einer Frage, einer interaktiven Aufgabe und einer Lösung.


## 1. Die ersten Rechenmaschinen

### Frage:
Was war die erste mechanische Rechenmaschine und wer hat sie erfunden?


```python
# Interaktive Aufgabe: Simuliere eine einfache Addition wie bei der Pascaline
def addiere(a, b):
    return a + b

# Teste die Funktion
print(addiere(5, 7))
```

    12
    

### Lösung:
<details>
<summary>Lösung anzeigen</summary>

Die erste mechanische Rechenmaschine war die **Pascaline**, erfunden von **Blaise Pascal** im Jahr 1642.

</details>

## 2. Alan Turing und die Turing-Maschine

### Frage:
Was ist das Prinzip der Turing-Maschine?


```python
# Interaktive Aufgabe: Simuliere eine einfache Turing-Maschine
# Hier könnte ein einfaches Beispiel für eine Turing-Maschine stehen
def turing_machine_simulation(band):
    # Einfache Simulation: Ersetze alle '0' durch '1'
    return band.replace('0', '1')

# Teste die Funktion
print(turing_machine_simulation('001010'))
```

    111111
    

### Lösung:
<details>
<summary>Lösung anzeigen</summary>

Die Turing-Maschine ist ein mathematisches Modell einer Rechenmaschine, das von Alan Turing entwickelt wurde.
Sie besteht aus einem unendlichen Band, einem Lese-/Schreibkopf und einer Tabelle von Regeln.

</details>

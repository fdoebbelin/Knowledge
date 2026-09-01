Erweitern Sie das gegebene Zahlenratspiel um die folgenden Funktionen:

1. **Zufallszahl:** Verwenden Sie das Modul `random`, um eine Zufallszahl zwischen 1 und 1000 zu generieren, die geraten werden muss.
2. **Abbruch über leere Eingabe:** Ermöglichen Sie dem Benutzer, das Spiel durch Eingabe einer leeren Zeile abzubrechen.
3. **Speichern des Ergebnisses:** Speichern Sie das Ergebnis (Anzahl der Versuche) in einer Datei, wenn das Spiel erfolgreich beendet wird.

**Gegebener Code:**
```python
geheimnis = 1337
zaehler = 0

while (versuch := int(input("Raten Sie: "))) != geheimnis:
    if versuch < geheimnis:
        print("Zu klein")
    elif versuch > geheimnis:
        print("Zu groß")
    zaehler += 1

print(f"Super, Sie haben es in {zaehler} Versuchen geschafft!")
```

**Anforderungen:**
1. **Zufallszahl:** Verwenden Sie `random.randint(1, 1000)`, um eine Zufallszahl zu generieren.
2. **Abbruch über leere Eingabe:** Überprüfen Sie, ob die Eingabe leer ist, und brechen Sie das Spiel in diesem Fall ab.
3. **Speichern des Ergebnisses:** Speichern Sie die Anzahl der Versuche in einer Datei namens `ergebnis.txt`.

**Beispiel-Lösung:**
```python
import random  
  
# Generiere eine Zufallszahl zwischen 1 und 1000  
geheimnis = random.randint(1, 1000)  
print(geheimnis)  
zaehler = 0  
  
while True:  
    eingabe = input("Raten Sie (oder drücken Sie Enter zum Abbrechen): ")  
		    if eingabe == "":  
		        print("Spiel abgebrochen.")  
		        break  
    versuch = int(eingabe)  
    zaehler += 1  
    if versuch < geheimnis:  
        print("Zu klein")  
    elif versuch > geheimnis:  
        print("Zu groß")  
    else:  
        print(f"Super, Sie haben es in {zaehler} Versuchen geschafft!")  
        # Speichere das Ergebnis in einer Datei  
        with open("ergebnis.txt", "w") as datei:  
            datei.write(f"Anzahl der Versuche: {zaehler}")  
        break
```

**Erklärung der Lösung:**
1. **Zufallszahl:** Die Zufallszahl wird mit `random.randint(1, 1000)` generiert.
2. **Abbruch über leere Eingabe:** Die Schleife wird abgebrochen, wenn die Eingabe leer ist.
3. **Speichern des Ergebnisses:** Die Anzahl der Versuche wird in der Datei `ergebnis.txt` gespeichert.

**Hinweise:**
- Stellen Sie sicher, dass Sie das Modul `random` importieren.
- Verwenden Sie eine `try-except`-Anweisung, um ungültige Eingaben abzufangen.
- Die Datei `ergebnis.txt` wird im selben Verzeichnis wie das Skript erstellt.

---

Diese Aufgabe sollte den Schülern helfen, ihre Kenntnisse in Python zu vertiefen und die Verwendung von Zufallszahlen, Benutzereingaben und Dateioperationen zu üben.
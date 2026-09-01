Es handelt sich um ein kleines **Text-Quiz**, das über eine Python-Funktion gesteuert wird und in einer Markdown-Datei integriert sein kann – ideal als Demonstration für Markdown + eingebettetes Skript.

---

## 🧩 Beispielprojekt: **Zahlenraten – Das Schleifen-Quiz**

### 📄 Markdown-Datei (`zahlenraten.md`)

````markdown
# 🧠 Zahlenraten mit Python

In dieser Mini-App kannst du dein Wissen über Schleifen und Bedingungen testen. Rate eine Zahl zwischen 1 und 10!

```python
import random

def zahlenraten():
    geheime_zahl = random.randint(1, 10)
    versuche = 0
    print("Ich denke mir eine Zahl zwischen 1 und 10.")
    
    while True:
        tipp = input("Dein Tipp: ")
        versuche += 1

        if not tipp.isdigit():
            print("Bitte gib eine Zahl ein.")
            continue

        tipp = int(tipp)

        if tipp < geheime_zahl:
            print("Zu klein!")
        elif tipp > geheime_zahl:
            print("Zu groß!")
        else:
            print(f"Richtig! Die Zahl war {geheime_zahl}. Du hast {versuche} Versuche gebraucht.")
            break

zahlenraten()
````
### Hinweise

- Das Beispiel verwendet:
    - `while`-Schleife
    - `if` / `elif` / `else`
    - Benutzer-Eingabe über `input()`
    - Zufallszahl mit `random.randint()`
- Es kann im MetaRow-Player direkt ausgeführt oder verändert werden (z. B. größerer Zahlenbereich, Versuchslimit, Highscore…).
### Variantenideen
- Begrenze die Anzahl der Versuche (Kontrollstruktur mit `break`)
- Mache ein Spiel mit Schwierigkeitswahl (Einbindung von Funktionen)
- Baue ein „Quiz-Brettspiel“ mit Arcade-Grafik
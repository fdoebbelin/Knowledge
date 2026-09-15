## Aufgabe 1: Code-Analyse

**Ausgangscode:**

```python
class GameState:
    def __init__(self):
        self.players = []
        self.score = {}
    
    def add_player(self, name):
        self.players.append(name)
        self.score[name] = 0

def update_scores(game_state, new_scores):
    for player, score in new_scores.items():
        game_state.score[player] += score
    return game_state

def get_leaderboard(game_state):
    return sorted(game_state.score.items(), key=lambda x: x[^1], reverse=True)
```

**Analyse und Probleme:**

- Die Klasse `GameState` kapselt den Zustand des Spiels, aber das Instanzobjekt wird an Funktionen übergeben, die diesen Zustand direkt verändern.
- **Verletzung von Ownership:** Es ist nicht eindeutig, welche Komponente wirklich „Besitzer“ der Spieldaten ist, denn jede Funktion könnte das Objekt beliebig verändern.
- **Borrowing-Verletzung:** Die Borrowing-Idee wird ignoriert, da mehrere Teile des Programms gleichzeitig veränderbare Zugriffe haben – das widerspricht dem Prinzip, dass es immer klare, exklusive Zuständigkeiten geben sollte.
- **Seiteneffekte:** Jede Funktion, die ein Referenz auf `GameState` erhält, kann dessen Zustand beeinflussen oder gar zerstören.

***

## Aufgabe 2: Code-Verbesserung

**Ziel:** Überarbeite den Code so, dass Besitz und Veränderung klar geregelt, Seiteneffekte minimiert und Veränderung explizit gemacht werden.

**Lösung:**

```python
from copy import deepcopy
from dataclasses import dataclass, field
from typing import Tuple

@dataclass(frozen=True)
class GameState:
    players: Tuple[str, ...]
    score: Tuple[Tuple[str, int], ...]

    @staticmethod
    def from_scores(players, score_dict):
        # Wandelt ein Dictionary in ein Tuple um, damit die Struktur immutable bleibt
        score_tuple = tuple((player, score_dict[player]) for player in players)
        return GameState(tuple(players), score_tuple)

    def update_scores(self, new_scores):
        # Erstellt ein neues Objekt mit den aktualisierten Punktständen (statt in-place Änderung!)
        new_score_dict = dict(self.score)
        for player, score in new_scores.items():
            new_score_dict[player] = new_score_dict.get(player, 0) + score
        return GameState.from_scores(self.players, new_score_dict)

    def leaderboard(self):
        # Gibt eine sortierte Ansicht des Scores
        return sorted(self.score, key=lambda x: x[^1], reverse=True)


# --- Nutzung ---
# Immer immutable, keine geteilten veränderbaren Referenzen!
initial = GameState.from_scores(["Alice"], {"Alice": 5})

# Neue Instanz statt Änderung:
with_bob = GameState.from_scores(initial.players + ("Bob",), dict(initial.score + (("Bob", 0),)))

updated = with_bob.update_scores({"Alice": 3, "Bob": 2})

print(updated.leaderboard())  # [('Alice', 8), ('Bob', 2)]
```

**Erklärung:**

- Der gesamte Zustand ist nun **immutable** (unveränderlich).
- Jede Veränderung erzeugt eine neue Instanz von `GameState`, statt den alten Zustand zu überschreiben.
- Der Besitz ist immer klar: Wer eine Instanz hat, kann sie nicht verändern, sondern nur für sich neue instanzen daraus erzeugen („neuer Besitzer“).

***

## Aufgabe 3: Defensive Programmierung bei einer BankAccount-Klasse

**Vorgabe:** Eine „BankAccount“-Klasse soll eine unveränderliche Transaktionshistorie bieten, defensive Kopien für externe Zugriffe nutzen und deutlich machen, dass nur die Klasse selbst zuständig für ihren Zustand ist.

**Lösung:**

```python
from typing import Tuple

class BankAccount:
    def __init__(self, start_balance=0):
        self._balance = start_balance
        self._transactions = []

    def deposit(self, amount):
        if amount <= 0:
            raise ValueError("Deposit must be positive")
        self._balance += amount
        self._transactions.append(("deposit", amount))

    def withdraw(self, amount):
        if amount <= 0:
            raise ValueError("Withdraw must be positive")
        if amount > self._balance:
            raise ValueError("Overdraft not allowed")
        self._balance -= amount
        self._transactions.append(("withdraw", amount))

    @property
    def balance(self):
        # Rückgabe einer Kopie für defensive Programmierung (obwohl ints immutable sind):
        return self._balance

    def get_transaction_history(self):
        # Defensive Kopie, so dass niemand die Liste von außen verändern kann:
        return tuple(self._transactions)

# --- Nutzung ---
account = BankAccount(100)
account.deposit(50)
account.withdraw(30)

# Zugriff nur über Kopien
print("Transaktionen:", account.get_transaction_history())
print("Kontostand:", account.balance)

# externer Code kann internen Zustand nicht verändern!
history = account.get_transaction_history()
# history.append(...)  # führt zu Exception, weil Tuple!
```

**Erklärung:**

- Die Klasse gibt **niemals** Referenzen auf interne Daten heraus, sondern nur unveränderliche Kopien (Tuple statt List).
- Alle Änderungen erfolgen nur über Methoden der Klasse, der Besitz des Zustands bleibt beim Objekt.
- Der Kontostand (`balance`) kann gelesen, aber außerhalb nicht verändert werden.
- Keine Chance auf „leaks“ durch geteilte, mutable Referenzen.

***

**Zusammenfassung:**
Die Lösungen demonstrieren, wie du Ownership und Borrowing selbst in Python durch kluge API-Gestaltung, defensive Kopien und bevorzugte immutable Strukturen nachbilden kannst – alle Teilbereiche des Codes sind sauber getrennt und gemeinsam genutzte mutable Daten werden strikt vermieden.

## Quellen
[^1]: https://www.adesso.de/de/news/blog/einfuehrung-in-die-programmiersprache-rust.jsp
[^2]: https://www.youtube.com/watch?v=apornmRask8
[^3]: https://entwickler.de/rust/eine-einfuhrung-in-rust
[^4]: https://www.heise.de/hintergrund/Programmiersprache-Rust-fuer-Neugierige-9345899.html
[^5]: https://www.heise.de/hintergrund/Auf-Nummer-sicher-Sicheres-Programmieren-mit-Rust-6302125.html?seite=2
[^6]: https://opus.fhv.at/files/4532/MSc_thesis_Hopfgartner_final.pdf
[^7]: https://www.reddit.com/r/rust/comments/1g7g67m/how_does_rusts_ownership_model_apply_to/?tl=de
[^8]: https://techjourney.it-jobs.de/de/it-skills/die-rost-programmiersprache/

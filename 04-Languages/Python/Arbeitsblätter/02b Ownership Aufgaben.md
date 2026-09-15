## Aufgabe 1: Code-Analyse

Analysiere den folgenden Code und identifiziere Ownership/Borrowing-Verletzungen:

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

**Denkanstöße:**

- Überlege, wie und durch wen die Daten in `game_state` verändert werden können.
- Gibt es geteilten zustand? Werden Objekte außerhalb der Klasse modifiziert?
- Findest du Stellen, an denen Seiteneffekte entstehen könnten?

***

## Aufgabe 2: Code-Verbesserung

Verbessere den Code aus Aufgabe 1 unter Anwendung der Ownership/Borrowing-Prinzipien.

**Denkanstöße:**

- Überlege dir, wie du die Besitzverhältnisse an den Daten klar machen kannst.
- Ist es möglich, unveränderliche Datenstrukturen zu verwenden?
- Wie könntest du Funktionen so gestalten, dass sie keinen internen Zustand verändern, sondern neue (unabhängige) Ergebnisse erzeugen?

***

## Aufgabe 3: Defensive Programmierung

Implementiere eine `BankAccount`-Klasse, die:

- Eine unveränderliche Transaktionshistorie bietet,
- Defensive Kopierung für alle externen Zugriffe verwendet,
- Klare Ownership für den Account-Zustand hat.

**Denkanstöße:**

- Welche Methoden solltest du bereitstellen und wie schützt du interne Daten nach außen?
- Wie lässt sich verhindern, dass externe Code-Stellen deine interne Transaktionsliste aus Versehen verändern?
- Denke an Property-Methoden oder Rückgabe von Kopien/unveränderlichen Views.

***

Nutze bei allen Aufgaben dein Wissen über Ownership und Borrowing, um gezielt Risiken durch gemeinsamen, veränderlichen Zustand zu minimieren und unveränderliche Schnittstellen zu bevorzugen.

## Quellen
[^1]: https://www.heise.de/hintergrund/Programmiersprache-Rust-2024-ist-die-bisher-umfangreichste-Edition-10393340.html
[^2]: https://www.youtube.com/watch?v=VIKS-wJ60Ik
[^3]: https://www.w3schools.com/rust/rust_ownership.php
[^4]: https://www.youtube.com/watch?v=apornmRask8
[^5]: https://www.heise.de/hintergrund/Auf-Nummer-sicher-Sicheres-Programmieren-mit-Rust-6302125.html?seite=2
[^6]: https://www.reddit.com/r/rust/comments/15rqbm0/the_intuition_behind_rusts_borrowing_rules_and/
[^7]: https://www.hslu.ch/-/media/campus/common/files/dokumente/w/ifz/seminare-konferenzen/carf/carf-2021-konferenzband-klein.pdf/


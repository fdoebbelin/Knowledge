Hier ist die **fertige Markdown-Datei** für den MetaRow-Player mit Erklärung, eingebettetem Code und Erweiterungshinweisen – perfekt als Mini-App-Beispiel im Kursmodul.

---

### 📄 Datei: `fang_das_quadrat.md`

````markdown
# 🎮 Fang das Quadrat!

Willkommen bei deinem ersten kleinen Spiel mit **Python Arcade**!  
Hier lernst du, wie man mit Klassen, Mausereignissen und einfachem Grafik-Rendering ein Mini-Spiel entwickelt.

## 🎯 Ziel

Klicke mit der Maus auf das rote Quadrat, bevor es verschwindet! Für jeden Treffer bekommst du einen Punkt – das Quadrat springt danach an eine neue Position.

---

## 🧠 Was du hier lernst

- **Objektorientierung** mit `class QuadratSpiel(...)`
- **Vererbung** von `arcade.Window`
- **Kollisionslogik** (wo wurde geklickt?)
- **Verwendung externer Bibliotheken** (`arcade`)
- **Spiel-Loop und Benutzerinteraktion**

---

## 🛠️ Der Code

```python
import arcade
import random

# Fenstergröße
SCREEN_WIDTH = 600
SCREEN_HEIGHT = 400
SCREEN_TITLE = "Fang das Quadrat!"

# Quadrat-Größe
SQUARE_SIZE = 40

class QuadratSpiel(arcade.Window):
    def __init__(self):
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)
        arcade.set_background_color(arcade.color.LIGHT_BLUE)
        self.quadrat_x = random.randint(0, SCREEN_WIDTH - SQUARE_SIZE)
        self.quadrat_y = random.randint(0, SCREEN_HEIGHT - SQUARE_SIZE)
        self.punkte = 0

    def on_draw(self):
        arcade.start_render()
        arcade.draw_rectangle_filled(self.quadrat_x + SQUARE_SIZE // 2,
                                     self.quadrat_y + SQUARE_SIZE // 2,
                                     SQUARE_SIZE, SQUARE_SIZE,
                                     arcade.color.RED)
        arcade.draw_text(f"Punkte: {self.punkte}", 10, SCREEN_HEIGHT - 30,
                         arcade.color.BLACK, 16)

    def on_mouse_press(self, x, y, button, modifiers):
        if (self.quadrat_x < x < self.quadrat_x + SQUARE_SIZE and
            self.quadrat_y < y < self.quadrat_y + SQUARE_SIZE):
            self.punkte += 1
            self.quadrat_x = random.randint(0, SCREEN_WIDTH - SQUARE_SIZE)
            self.quadrat_y = random.randint(0, SCREEN_HEIGHT - SQUARE_SIZE)

def main():
    spiel = QuadratSpiel()
    arcade.run()

if __name__ == "__main__":
    main()
````

---

## 🔧 Erweiterungsideen

- 🕒 Baue einen **Countdown-Timer** ein (Spiel endet nach 30 Sekunden)
    
- 🚀 Erhöhe die Schwierigkeit bei jedem Treffer (Quadrat wird kleiner oder schneller)
    
- 🧮 Speichere den **Highscore** (z. B. in Datei)
    
- 🧱 Erstelle weitere Formen oder Hindernisse (z. B. Liste von Objekten)
    

---

## 📦 Voraussetzung

Installiere Arcade, bevor du das Spiel startest:

```
pip install arcade
```

---

Viel Spaß beim Erweitern, Anpassen und Spielen!

```

---

Du kannst diese Datei direkt in dein System einbinden und im MetaRow-Player ausführen oder zur Inspiration für andere Lernende bereitstellen.

Wenn du möchtest, erstelle ich dir auch ein Template, mit dem Teilnehmer:innen ihre eigenen Markdown-Mini-Apps einreichen können. Interesse?
```
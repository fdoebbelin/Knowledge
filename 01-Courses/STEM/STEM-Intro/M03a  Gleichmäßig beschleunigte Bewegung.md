Perfekt 👍  
Dann folgt jetzt das **MINT-Modul Physik**, im gleichen Stil aufgebaut wie zuvor (Mathematik → Informatik → jetzt Physik), wieder mit einer **kompletten interaktiven Unterrichtseinheit**, **Visualisierung in p5.js**, **Quizfragen** und **weiterführenden Quellen**.  
Thema diesmal: **„Gleichmäßig beschleunigte Bewegung“ (s–v–t–a-Zusammenhänge)**

---

## ⚛️ Unterrichtseinheit Physik

### Thema: _Gleichmäßig beschleunigte Bewegung (Bewegungsgesetze, Diagramme, Simulation)_

---

## 🎯 Lernziele

Die Schülerinnen und Schüler sollen …

1. die Größen **Weg s**, **Geschwindigkeit v** und **Beschleunigung a** physikalisch beschreiben können.
    
2. den Zusammenhang zwischen diesen Größen verstehen:  
    ( v = a \cdot t ), ( s = \frac{1}{2} a t^2 + v_0 t + s_0 )
    
3. anhand einer interaktiven **p5.js-Simulation** die Bewegung eines Körpers untersuchen.
    
4. einfache **Experimente und Quizfragen** durchführen, um Verständnis zu überprüfen.
    
5. reale Bewegungen (z. B. Autoanfahrt, Fallbewegung) qualitativ interpretieren.
    

---

## 🧭 Ablaufübersicht

|Phase|Inhalt|Methode / Material|
|:--|:--|:--|
|Einstieg (10 min)|Beispiel: Auto fährt an, Beschleunigung wird sichtbar|Gespräch + Video|
|Erarbeitung I (20 min)|Theoretische Grundlagen (s–v–t–a)|Lehrerinput + Formelherleitung|
|Erarbeitung II (25 min)|**Interaktive p5.js-Simulation**: Bewegung mit variabler a, v₀, s₀|Browser, Experimentieren|
|Sicherung (10 min)|Quiz mit Verständnisfragen|integriert im Sketch|
|Hausaufgabe / Vertiefung|reale Messdaten analysieren (z. B. Sensor-App, Videoanalyse)|externe Quelle|

---

## ⚙️ Physikalische Grundlagen

### Definitionen

|Größe|Symbol|Einheit|Bedeutung|
|---|---|---|---|
|Weg|s|m|zurückgelegte Strecke|
|Geschwindigkeit|v|m/s|Änderung des Weges pro Zeit|
|Beschleunigung|a|m/s²|Änderung der Geschwindigkeit pro Zeit|

### Formeln

- ( v = v_0 + a t )
    
- ( s = s_0 + v_0 t + \frac{1}{2} a t^2 )
    

### Beispiel

Ein Auto startet aus dem Stand und beschleunigt mit ( a = 2 , \text{m/s}^2 ).  
Nach 5 s beträgt:

- ( v = 2 \cdot 5 = 10 , \text{m/s} )
    
- ( s = 0.5 \cdot 2 \cdot 5^2 = 25 , \text{m} )
    

---

## 💻 Interaktive p5.js-Simulation

**Simulation: Gleichmäßig beschleunigte Bewegung mit grafischer Anzeige von s(t) und v(t)**  
Lernende können:

- Beschleunigung `a`
    
- Startgeschwindigkeit `v₀`
    
- Startposition `s₀`  
    verändern und beobachten, wie sich Bewegung und Diagramme ändern.
    

---

### 📜 Vollständiger p5.js-Code (kopierfertig)

```javascript
// --- Physik-MINT-Modul: Gleichmäßig beschleunigte Bewegung ---
// Simulation & Quiz mit p5.js
// Autor: Unterrichtsbeispiel für Physikunterricht (Sek I / II)

let s = 0;          // Weg
let v = 0;          // Geschwindigkeit
let a = 1.0;        // Beschleunigung
let t = 0;          // Zeit
let running = false;
let startButton, resetButton;
let sliderA, sliderV0, sliderS0;
let quizActive = false;
let quizIndex = 0;
let showFeedback = false;
let quizResult = "";

let quiz = [
  {
    q: "Was bedeutet eine Beschleunigung von 2 m/s²?",
    options: [
      "a) Die Geschwindigkeit steigt jede Sekunde um 2 m/s.",
      "b) Das Objekt legt jede Sekunde 2 m zurück.",
      "c) Die Geschwindigkeit nimmt um 2 m zu, wenn die Zeit verdoppelt wird."
    ],
    answer: 0
  },
  {
    q: "Wie lautet die Formel für die gleichmäßig beschleunigte Bewegung?",
    options: [
      "a) s = a * t + v₀",
      "b) s = ½ a t² + v₀ t + s₀",
      "c) s = v * t"
    ],
    answer: 1
  },
  {
    q: "Was passiert bei negativer Beschleunigung?",
    options: [
      "a) Das Objekt bewegt sich rückwärts.",
      "b) Die Geschwindigkeit nimmt ab (Bremsung).",
      "c) Die Geschwindigkeit bleibt konstant."
    ],
    answer: 1
  },
  {
    q: "Welche Größe ist die Steigung des v-t-Diagramms?",
    options: [
      "a) Geschwindigkeit",
      "b) Weg",
      "c) Beschleunigung"
    ],
    answer: 2
  },
  {
    q: "Welche Einheit hat die Beschleunigung?",
    options: [
      "a) m/s",
      "b) m/s²",
      "c) m²/s"
    ],
    answer: 1
  }
];

function setup() {
  createCanvas(900, 600);
  textFont("Courier New");

  startButton = createButton("▶️ Start");
  startButton.position(20, 20);
  startButton.mousePressed(() => (running = !running));

  resetButton = createButton("🔄 Reset");
  resetButton.position(100, 20);
  resetButton.mousePressed(resetSim);

  quizButton = createButton("🧠 Quiz starten");
  quizButton.position(180, 20);
  quizButton.mousePressed(() => (quizActive = true));

  sliderA = createSlider(-3, 3, 1, 0.1);
  sliderA.position(20, 70);
  sliderV0 = createSlider(0, 10, 0, 0.5);
  sliderV0.position(20, 100);
  sliderS0 = createSlider(0, 50, 0, 1);
  sliderS0.position(20, 130);
}

function draw() {
  background(250);
  if (!quizActive) drawSimulation();
  else drawQuiz();
}

function drawSimulation() {
  fill(0);
  textSize(16);
  text("Physik-Simulation: Gleichmäßig beschleunigte Bewegung", 20, 160);
  text("a = " + sliderA.value() + " m/s²", 20, 190);
  text("v₀ = " + sliderV0.value() + " m/s", 20, 210);
  text("s₀ = " + sliderS0.value() + " m", 20, 230);

  if (running) {
    t += deltaTime / 1000.0;
    a = sliderA.value();
    v = sliderV0.value() + a * t;
    s = sliderS0.value() + sliderV0.value() * t + 0.5 * a * t * t;
  }

  // Darstellung
  fill(100, 150, 255);
  ellipse(100 + s * 5, 400, 30, 30); // Objektposition
  fill(0);
  text("t = " + t.toFixed(2) + " s", 20, 280);
  text("v = " + v.toFixed(2) + " m/s", 20, 300);
  text("s = " + s.toFixed(2) + " m", 20, 320);

  // Diagramm v-t
  drawGraph(450, 100, "v-t Diagramm", (time) => sliderV0.value() + sliderA.value() * time, "v (m/s)");
  // Diagramm s-t
  drawGraph(450, 350, "s-t Diagramm", (time) => sliderS0.value() + sliderV0.value() * time + 0.5 * sliderA.value() * time * time, "s (m)");
}

function drawGraph(x, y, title, func, label) {
  noFill();
  stroke(0);
  rect(x, y, 400, 200);
  fill(0);
  text(title, x + 10, y - 10);
  beginShape();
  for (let i = 0; i <= 100; i++) {
    let time = (i / 100) * 10;
    let val = func(time);
    vertex(x + i * 4, y + 180 - val * 10);
  }
  endShape();
  text(label, x + 350, y + 190);
}

function resetSim() {
  t = 0;
  s = 0;
  v = 0;
  running = false;
}

// --- Quizteil ---
function drawQuiz() {
  background(245);
  fill(0);
  textAlign(CENTER);
  textSize(22);
  text("🧠 Physik-Quiz: Gleichmäßig beschleunigte Bewegung", width / 2, 50);
  textAlign(LEFT);
  textSize(16);

  if (quizIndex < quiz.length) {
    let q = quiz[quizIndex];
    text(q.q, 60, 120);
    for (let i = 0; i < q.options.length; i++) {
      text(q.options[i], 80, 160 + i * 40);
    }
    if (showFeedback) {
      textSize(16);
      fill(quizResult.includes("✅") ? "green" : "red");
      text(quizResult, 60, 340);
      fill(0);
      text("Drücke ENTER für die nächste Frage.", 60, 370);
    }
  } else {
    textSize(20);
    textAlign(CENTER);
    text("🎉 Quiz abgeschlossen!", width / 2, height / 2 - 20);
    textSize(16);
    text("Drücke R, um zur Simulation zurückzukehren.", width / 2, height / 2 + 20);
  }
}

function keyPressed() {
  if (quizActive && !showFeedback) {
    if (key === "a" || key === "b" || key === "c") checkAnswer(key);
  } else if (quizActive && showFeedback && keyCode === ENTER) nextQuestion();
  else if (quizActive && quizIndex >= quiz.length && key === "r") {
    quizActive = false;
    quizIndex = 0;
  }
}

function checkAnswer(k) {
  let idx = { a: 0, b: 1, c: 2 }[k];
  let correct = quiz[quizIndex].answer;
  if (idx === correct) quizResult = "✅ Richtig!";
  else quizResult = "❌ Falsch. Richtige Antwort: " + quiz[quizIndex].options[correct];
  showFeedback = true;
}

function nextQuestion() {
  showFeedback = false;
  quizIndex++;
}
```

---

## 🧩 Beschreibung der Simulation

**Interaktiv einstellbar:**

- Beschleunigung ( a ) (positiv / negativ)
    
- Startgeschwindigkeit ( v_0 )
    
- Startposition ( s_0 )
    

**Darstellung:**

- Bewegendes Objekt auf der Strecke
    
- Echtzeitwerte von ( t, v, s )
    
- Diagramme für ( v(t) ) und ( s(t) )
    

**Ziele:**

- Zusammenhang der Formeln visuell verstehen
    
- Einfluss von a und v₀ intuitiv erfassen
    
- Vergleich von positiver und negativer Beschleunigung
    

---

## 🧠 Quizfragen (integriert)

Fragen behandeln:

- Bedeutung physikalischer Größen
    
- Formeln
    
- Diagramm-Interpretation
    
- Einheitenverständnis
    

---

## 🔗 Weiterführende Ressourcen

- **LEIFIphysik: Gleichmäßig beschleunigte Bewegung**  
    [https://www.leifiphysik.de/mechanik/gleichmaessig-beschleunigte-bewegung](https://www.leifiphysik.de/mechanik/gleichmaessig-beschleunigte-bewegung)
    
- **Khan Academy: Gleichmäßig beschleunigte Bewegung (Videos + Übungen)**  
    [https://de.khanacademy.org/science/physics/one-dimensional-motion](https://de.khanacademy.org/science/physics/one-dimensional-motion)
    
- **p5.js Reference (Animation & Slider-Elemente)**  
    [https://p5js.org/reference/](https://p5js.org/reference/)
    
- **PhET Interactive Simulations: Motion and Acceleration**  
    [https://phet.colorado.edu/en/simulation/moving-man](https://phet.colorado.edu/en/simulation/moving-man)
    

---

Möchtest du, dass ich als nächstes das **CAD-Modul** im gleichen Format aufbereite – z. B. mit einem **p5.js-basierten 2D-CAD-Lernwerkzeug** (Zeichenbefehle, Koordinatensystem, Transformationen, Quiz zu Konstruktionsprinzipien)?
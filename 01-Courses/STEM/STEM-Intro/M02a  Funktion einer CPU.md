## 🎯 Lernziele

Die Schülerinnen und Schüler sollen …

1. den **grundlegenden Aufbau einer CPU** verstehen (Register, Steuerwerk, ALU, Speicher).
    
2. wissen, was ein **Maschinenbefehl** ist und wie er vom Prozessor ausgeführt wird.
    
3. die Bedeutung von **Assemblerbefehlen** kennen und einfache Instruktionen deuten können.
    
4. den Zusammenhang zwischen **Maschinencode ↔ Assembler ↔ Hochsprache** nachvollziehen.
    
5. anhand einer **interaktiven Simulation** selbst Befehle „ausführen“ und deren Wirkung auf Register und Speicher beobachten.
    

---

## 🧭 Ablaufübersicht

|Phase|Inhalt|Methode / Material|
|:--|:--|:--|
|Einstieg (10 min)|Was macht die CPU eigentlich?|Diskussion, Schaubild|
|Erarbeitung I (15 min)|Aufbau CPU: ALU, Register, Steuerwerk|Lehrkraft + Skizze|
|Erarbeitung II (25 min)|**Interaktive Simulation: p5.js CPU-Modell**|Browser + p5.js|
|Sicherung (10 min)|Quizfragen zur CPU-Funktion|integriert im Sketch|
|Vertiefung (Hausaufgabe)|Vergleich zu echten Intel-Befehlen und Assembler|externe Quellen|

---

## ⚙️ Erklärungsrahmen: Funktion einer CPU

Eine CPU (Central Processing Unit) besteht aus:

|Komponente|Funktion|
|---|---|
|**ALU (Arithmetic Logic Unit)**|führt Rechen- und logische Operationen aus|
|**Register**|kleine, schnelle Speicher für Zwischenwerte|
|**Steuerwerk**|liest Befehle, dekodiert sie, steuert Ausführung|
|**Busse**|übertragen Daten, Adressen und Steuersignale|
|**Taktgeber (Clock)**|synchronisiert alle Vorgänge|

**Befehlszyklus (Fetch–Decode–Execute):**

1. **Fetch:** Befehl aus Speicher lesen
    
2. **Decode:** Befehl analysieren (z. B. „ADD R1, R2“)
    
3. **Execute:** Operation ausführen, Ergebnis speichern
    

---

## 💻 p5.js-Simulation: Mini-CPU mit Registerdarstellung & Assemblerbefehlen

> Diese Visualisierung zeigt eine vereinfachte CPU mit Registern, Speicher und einer Assembler-ähnlichen Befehlsausführung.  
> Lernende können Befehle eingeben und sehen, wie sie sich auf Registerwerte auswirken.

---

### 📜 Vollständiger p5.js-Code (kopierfertig)

```javascript
// --- Interaktive Lerneinheit: Funktion einer CPU ---
// Thema: Basisbefehlssatz, Register, Assemblernotation
// Autor: Unterrichtsbeispiel für Informatik-MINT-Kurs
// Läuft im p5.js Web Editor oder JupyterLite mit p5.js

let registers = { AX: 0, BX: 0, CX: 0, DX: 0 };
let memory = Array(8).fill(0);
let pc = 0; // Programmzähler
let instructionInput;
let output = "";
let quizActive = false;
let currentQuestion = 0;
let quizResult = "";
let showFeedback = false;

let quiz = [
  {
    q: "Was bedeutet der Befehl 'MOV AX, 5'?",
    options: [
      "a) Addiert 5 zu AX",
      "b) Lädt den Wert 5 in Register AX",
      "c) Vergleicht AX mit 5"
    ],
    answer: 1
  },
  {
    q: "Was macht 'ADD AX, BX'?",
    options: [
      "a) Addiert BX zu AX und speichert das Ergebnis in AX",
      "b) Multipliziert AX mit BX",
      "c) Subtrahiert BX von AX"
    ],
    answer: 0
  },
  {
    q: "Was tut 'MOV [2], AX'?",
    options: [
      "a) Liest Speicherzelle 2 in AX",
      "b) Schreibt Wert von AX in Speicherzelle 2",
      "c) Tauscht AX mit Speicherstelle 2"
    ],
    answer: 1
  },
  {
    q: "Welche Einheit führt Rechenoperationen aus?",
    options: [
      "a) Steuerwerk",
      "b) ALU (Arithmetic Logic Unit)",
      "c) Bussteuerung"
    ],
    answer: 1
  },
  {
    q: "Wozu dient ein Assembler?",
    options: [
      "a) Zum Übersetzen von Maschinencode in Hochsprachen",
      "b) Zum Übersetzen von Assemblercode in Maschinencode",
      "c) Zum Testen von Programmen im Browser"
    ],
    answer: 1
  }
];

function setup() {
  createCanvas(900, 600);
  textFont("Courier New");
  textAlign(LEFT, CENTER);

  instructionInput = createInput("MOV AX, 5");
  instructionInput.position(20, 20);
  instructionInput.size(200);

  runButton = createButton("▶️ Befehl ausführen");
  runButton.position(240, 20);
  runButton.mousePressed(executeInstruction);

  quizButton = createButton("🧠 Quiz starten");
  quizButton.position(400, 20);
  quizButton.mousePressed(startQuiz);
}

function draw() {
  background(250);

  if (!quizActive) {
    drawCPUView();
  } else {
    drawQuiz();
  }
}

// --- CPU Visualisierung ---
function drawCPUView() {
  textSize(20);
  fill(0);
  text("🧩 Simulation: CPU-Basisbefehle & Register", 20, 70);

  drawRegisters(20, 120);
  drawMemory(350, 120);
  drawExplanation(20, 400);

  fill(50);
  textSize(14);
  text("Aktueller Befehl: " + instructionInput.value(), 20, 360);
  text(output, 20, 380);
}

function drawRegisters(x, y) {
  textSize(16);
  fill(0);
  text("Register:", x, y - 20);
  let i = 0;
  for (let r in registers) {
    fill(230);
    rect(x, y + i * 40, 120, 30);
    fill(0);
    text(r + " = " + registers[r], x + 10, y + 15 + i * 40);
    i++;
  }
}

function drawMemory(x, y) {
  textSize(16);
  fill(0);
  text("Speicher (8 Zellen):", x, y - 20);
  for (let i = 0; i < memory.length; i++) {
    fill(230);
    rect(x + i * 60, y, 50, 30);
    fill(0);
    text(i + ":" + memory[i], x + i * 60 + 5, y + 15);
  }
}

function drawExplanation(x, y) {
  textSize(14);
  fill(0);
  text("Beispielhafte Intel-ähnliche Basisbefehle:", x, y);
  text("- MOV Ziel, Quelle : Wert übertragen", x, y + 20);
  text("- ADD Ziel, Quelle : Werte addieren", x, y + 40);
  text("- SUB Ziel, Quelle : Werte subtrahieren", x, y + 60);
  text("- MOV [n], AX : Schreibe AX in Speicherstelle n", x, y + 80);
  text("- MOV AX, [n] : Lade Speicherstelle n in AX", x, y + 100);
  text("- Jeder Befehl wird von der CPU im Zyklus Fetch–Decode–Execute verarbeitet.", x, y + 130);
}

function executeInstruction() {
  let instr = instructionInput.value().trim().toUpperCase();
  output = "";
  try {
    interpretInstruction(instr);
  } catch (e) {
    output = "❌ Fehler: " + e.message;
  }
}

function interpretInstruction(instr) {
  let parts = instr.replace(",", "").split(" ");
  let op = parts[0];
  let dst = parts[1];
  let src = parts[2];

  switch (op) {
    case "MOV":
      if (dst in registers) {
        if (src in registers) registers[dst] = registers[src];
        else if (src?.startsWith("[")) {
          let addr = parseInt(src.replace(/\[|\]/g, ""));
          registers[dst] = memory[addr];
        } else registers[dst] = parseInt(src);
      } else if (dst?.startsWith("[")) {
        let addr = parseInt(dst.replace(/\[|\]/g, ""));
        if (src in registers) memory[addr] = registers[src];
        else memory[addr] = parseInt(src);
      } else throw new Error("Unbekannter Operand");
      output = "✅ MOV ausgeführt.";
      break;

    case "ADD":
      if (dst in registers) {
        if (src in registers) registers[dst] += registers[src];
        else registers[dst] += parseInt(src);
        output = "✅ ADD ausgeführt.";
      } else throw new Error("Ungültiger Operand bei ADD");
      break;

    case "SUB":
      if (dst in registers) {
        if (src in registers) registers[dst] -= registers[src];
        else registers[dst] -= parseInt(src);
        output = "✅ SUB ausgeführt.";
      } else throw new Error("Ungültiger Operand bei SUB");
      break;

    default:
      throw new Error("Unbekannter Befehl: " + op);
  }
}

// --- Quizlogik ---
function startQuiz() {
  quizActive = true;
  currentQuestion = 0;
  showFeedback = false;
  quizResult = "";
}

function drawQuiz() {
  background(240);
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("🧠 CPU-Quiz", width / 2, 50);
  textAlign(LEFT);
  let q = quiz[currentQuestion];
  textSize(16);
  text(q.q, 60, 120);
  for (let i = 0; i < q.options.length; i++) {
    let y = 160 + i * 40;
    text(q.options[i], 80, y);
  }
  textSize(14);
  text("Gib a, b oder c ein und drücke ENTER", 60, 330);

  if (showFeedback) {
    textAlign(CENTER);
    textSize(16);
    fill(quizResult.includes("✅") ? "green" : "red");
    text(quizResult, width / 2, 380);
  }
}

function keyPressed() {
  if (quizActive && !showFeedback) {
    if (key === "a" || key === "b" || key === "c") checkAnswer(key);
  } else if (quizActive && showFeedback) {
    if (keyCode === ENTER) nextQuestion();
  }
}

function checkAnswer(k) {
  let idx = { a: 0, b: 1, c: 2 }[k];
  let correct = quiz[currentQuestion].answer;
  if (idx === correct) quizResult = "✅ Richtig!";
  else quizResult = "❌ Falsch. Richtige Antwort: " + quiz[currentQuestion].options[correct];
  showFeedback = true;
}

function nextQuestion() {
  currentQuestion++;
  showFeedback = false;
  quizResult = "";
  if (currentQuestion >= quiz.length) endQuiz();
}

function endQuiz() {
  background(245);
  textSize(22);
  fill(0);
  textAlign(CENTER);
  text("🎉 Quiz beendet!", width / 2, height / 2 - 40);
  textSize(16);
  text("Drücke R, um zurück zur CPU-Simulation zu gelangen.", width / 2, height / 2 + 10);
}

function keyTyped() {
  if (quizActive && currentQuestion >= quiz.length && key === "r") {
    quizActive = false;
  }
}
```

---

## 🧩 Beschreibung der Simulation

🧠 **Ziele:**  
Schüler*innen lernen, wie eine CPU elementare Befehle ausführt:

- **Register AX, BX, CX, DX** speichern Werte
    
- **Speicher (8 Zellen)** enthält einfache Integer-Werte
    
- **Instruktionen (MOV, ADD, SUB)** können eingegeben und ausgeführt werden
    

💡 **Beispielbefehle:**

```
MOV AX, 5
MOV BX, 3
ADD AX, BX
MOV [2], AX
MOV AX, [2]
```

💬 **Anzeige erklärt:**

- Was passiert in der CPU (Übertragung, Addition, Speicherung)
    
- Welche Komponenten beteiligt sind (ALU, Register, Speicher)
    

---

## 🧠 Quizfragen (integriert im Code)

Die Fragen decken zentrale Inhalte ab:

- Bedeutung von MOV, ADD
    
- Speicheroperationen
    
- Funktionsweise der ALU
    
- Rolle des Assemblers
    

---

## 📚 Weiterführende Quellen

- **Intel Developer Manual (Einsteigerfreundlich)**  
    [https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
    
- **Assembler-Einführung (Online-Tutorial)**  
    [https://www.tutorialspoint.com/assembly_programming/index.htm](https://www.tutorialspoint.com/assembly_programming/index.htm)
    
- **Visual 6502 – CPU Simulation im Browser**  
    [http://visual6502.org/](http://visual6502.org/)
    
- **p5.js Reference – Text & Input Handling**  
    [https://p5js.org/reference/](https://p5js.org/reference/)
    
- **Computerphile – How CPUs Work (YouTube)**  
    [https://www.youtube.com/watch?v=cNN_tTXABUA](https://www.youtube.com/watch?v=cNN_tTXABUA)
    

---

Möchtest du, dass ich das **nächste Modul (Physik)** im gleichen Stil aufbaue – z. B. mit einer interaktiven p5.js-Simulation zur **gleichmäßig beschleunigten Bewegung (s, v, a)** und einem begleitenden Quiz?
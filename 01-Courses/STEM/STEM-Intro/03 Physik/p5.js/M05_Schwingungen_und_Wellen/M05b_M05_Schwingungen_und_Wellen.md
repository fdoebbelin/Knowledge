# M05b – Übungen

**Thema:** Schwingungen und Wellen

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Aufgaben
1. Starte vom folgenden **Template** und vervollständige die TODOs.
2. Variiere Parameter und dokumentiere Beobachtungen in Markdown.

```javascript
// M05a: Schwingungen & Wellen – Überlagerung zweier Sinuswellen
let A1=60,f1=0.5,A2=40,f2=1.0, phase=0;
// TODO: Passe Anfangsparameter sinnvoll an
function setup(){
  // TODO: Canvas-Größe anpassen
 createCanvas(900,300); textFont('monospace'); }
function draw(){
  // TODO: Visualisierung erweitern (Beschriftungen, Hilfslinien)

  background(245);
  translate(0,height/2);
  stroke(0); line(0,0,width,0);
  noFill();
  // Einzelwellen
  stroke(150);
  beginShape();
  for(let x=0;x<width;x++){
    let y=A1*sin(TWO_PI*f1*(x/100)+phase);
    vertex(x,y);
  } endShape();
  beginShape();
  for(let x=0;x<width;x++){
    let y=A2*sin(TWO_PI*f2*(x/100)-phase*0.7);
    vertex(x,y);
  } endShape();
  // Überlagerung
  stroke(20,120,200);
  beginShape();
  for(let x=0;x<width;x++){
    let y=A1*sin(TWO_PI*f1*(x/100)+phase) + A2*sin(TWO_PI*f2*(x/100)-phase*0.7);
    vertex(x,y);
  } endShape();
  phase += 0.05;
  resetMatrix();
  noStroke(); fill(0);
  text(`A1=${A1} f1=${f1}  |  A2=${A2} f2=${f2}  (Tasten: Q/W, A/S, E/R, D/F)`,10,20);
}
function keyPressed(){
  if(key==='Q') A1=max(0,A1-5);
  if(key==='W') A1=min(120,A1+5);
  if(key==='A') f1=max(0.1,f1-0.1);
  if(key==='S') f1=min(2,f1+0.1);
  if(key==='E') A2=max(0,A2-5);
  if(key==='R') A2=min(120,A2+5);
  if(key==='D') f2=max(0.1,f2-0.1);
  if(key==='F') f2=min(2,f2+0.1);
}
```

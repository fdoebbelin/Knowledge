# M09b – Übungen

**Thema:** Physik-Projekt

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Aufgaben
1. Starte vom folgenden **Template** und vervollständige die TODOs.
2. Variiere Parameter und dokumentiere Beobachtungen in Markdown.

```javascript
// M09a: Physik-Projekt – Projektschablone
// Vorlage mit UI: Wähle Themenmodus und bearbeite Parameter.
let mode=0;
// TODO: Passe Anfangsparameter sinnvoll an // 0 Kinematik, 1 Wellen, 2 Optik
function setup(){
  // TODO: Canvas-Größe anpassen
 createCanvas(800,450); textFont('monospace'); }
function draw(){
  // TODO: Visualisierung erweitern (Beschriftungen, Hilfslinien)

  background(252);
  fill(0); text("Projekt-Schablone: Tasten 1=Kinematik, 2=Wellen, 3=Optik (R reset)",10,20);
  if(mode===0) demoKinematik();
  if(mode===1) demoWellen();
  if(mode===2) demoOptik();
}
function keyPressed(){
  if(key==='1') mode=0;
  if(key==='2') mode=1;
  if(key==='3') mode=2;
  if(key==='R') setup();
}
function demoKinematik(){
  // Einfache Parabelbahn
  let g=200; let v0=180; let angle=PI/4; stroke(0); noFill();
  beginShape(); for(let t=0;t<2;t+=0.01){ 
    let x=v0*cos(angle)*t; let y=v0*sin(angle)*t - 0.5*g*t*t; 
    vertex(50+x, height-50 - y); } endShape();
}
function demoWellen(){
  translate(0,height/2); stroke(20,120,200); noFill();
  beginShape(); for(let x=0;x<width;x++){ vertex(x, 60*sin(0.02*x + frameCount*0.03)); } endShape();
  resetMatrix();
}
function demoOptik(){
  stroke(0); line(0,height/2,width,height/2);
  stroke(0,120,200); line(400,60,400,height-60);
  stroke(220,80,60); line(120,height/2-80, 400, height/2-80);
  line(400,height/2-80, 650, height/2-30);
}
```

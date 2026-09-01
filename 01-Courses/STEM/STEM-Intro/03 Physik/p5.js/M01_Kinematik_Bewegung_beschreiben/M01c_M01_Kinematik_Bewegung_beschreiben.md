# M01c – Lösungen

**Thema:** Kinematik – Bewegung beschreiben

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Lösungssketch (vollständig)

```javascript
// M01a: Kinematik – gleichmäßig beschleunigte Bewegung (1D)
// Steuerung: A/D = Anfangsgeschwindigkeit ±, W/S = Beschleunigung ±, R = Reset
let x=50, v=50, a=0, t=0, last;
function setup(){
  createCanvas(800, 300);
  textFont('monospace'); last=millis();
}
function draw(){
  const now=millis(); const dt=(now-last)/1000.0; last=now; t+=dt;
  v += a*dt; x += v*dt;
  if(x>width-20){ x=width-20; v*=-0.8; } if(x<20){ x=20; v*=-0.8; }
  background(245);
  // Axis
  stroke(200); line(20,height-40,width-20,height-40);
  // Object
  noStroke(); fill(30,144,255); circle(x,height-60,20);
  // HUD
  fill(0); textSize(14);
  text(`t=${t.toFixed(2)}s  v=${v.toFixed(2)}px/s  a=${a.toFixed(2)}px/s²`,20,20);
  text("Tasten: A/D v± | W/S a± | R Reset", 20, 40);
}
function keyPressed(){
  if(key==='A') v-=10;
  if(key==='D') v+=10;
  if(key==='W') a+=10;
  if(key==='S') a-=10;
  if(key==='R'){ x=50; v=50; a=0; t=0; }
}
```

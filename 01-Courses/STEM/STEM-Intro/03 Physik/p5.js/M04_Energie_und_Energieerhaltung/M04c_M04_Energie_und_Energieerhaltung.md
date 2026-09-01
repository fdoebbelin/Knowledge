# M04c – Lösungen

**Thema:** Energie und Energieerhaltung

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Lösungssketch (vollständig)

```javascript
// M04a: Energieerhaltung am (vereinfachten) Pendel (kleine Winkel)
// Pfeiltasten links/rechts ändern den Startwinkel.
let theta=0.6, L=200, g=9.81, omega=0, origin, bob;
function setup(){ createCanvas(600,400); textFont('monospace'); origin=createVector(width/2,60); }
function draw(){
  background(250);
  // Bewegungsgleichungen (kleiner Winkel): theta'' = -(g/L)*theta
  let dt=1/60;
  let alpha = -(g/L)*theta;
  omega += alpha*dt;
  theta += omega*dt;
  // Position
  bob = createVector(origin.x + L*sin(theta), origin.y + L*cos(theta));
  // Energie
  let h = L*(1 - cos(theta));
  let Ep = g*h;
  let Ek = 0.5*(L*L)*omega*omega; // massenlos skaliert
  // Zeichnen
  stroke(0); line(origin.x, origin.y, bob.x, bob.y);
  fill(30,144,255); circle(bob.x,bob.y,28);
  noStroke(); fill(0);
  text(`θ=${theta.toFixed(2)}  Ek=${Ek.toFixed(2)}  Ep=${Ep.toFixed(2)}  E≈${(Ek+Ep).toFixed(2)}`, 10,20);
  text("←/→ Startwinkel ± | R Reset",10,40);
  // Energie-Balken
  let sx=10; let sy=360; let scale=120;
  noStroke(); fill(220,80,60); rect(sx,sy, Ek*scale, 10);
  fill(70,130,180); rect(sx,sy+14, Ep*scale, 10);
}
function keyPressed(){
  if(keyCode===LEFT_ARROW) theta-=0.1;
  if(keyCode===RIGHT_ARROW) theta+=0.1;
  if(key==='R'){ theta=0.6; omega=0; }
}
```

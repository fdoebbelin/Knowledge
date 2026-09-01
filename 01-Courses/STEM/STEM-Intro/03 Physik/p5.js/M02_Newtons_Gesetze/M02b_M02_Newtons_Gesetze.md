# M02b – Übungen

**Thema:** Newtons Gesetze

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Aufgaben
1. Starte vom folgenden **Template** und vervollständige die TODOs.
2. Variiere Parameter und dokumentiere Beobachtungen in Markdown.

```javascript
// M02a: Newtons Gesetze – F = m·a (2D mit Reibung)
// Ziehe mit der Maus, um Kraft zu applizieren.
let pos, vel, acc, mass=2, mu=0.05;
// TODO: Passe Anfangsparameter sinnvoll an
function setup(){
  // TODO: Canvas-Größe anpassen

  createCanvas(800,400);
  textFont('monospace');
  pos=createVector(width/2, height/2); vel=createVector(0,0); acc=createVector(0,0);
}
function draw(){
  // TODO: Visualisierung erweitern (Beschriftungen, Hilfslinien)

  background(250);
  // Maus-Kraft
  let F=createVector(0,0);
  if(mouseIsPressed){
    const dir=createVector(mouseX-pos.x, mouseY-pos.y);
    dir.limit(200);
    F.add(dir.mult(0.05)); // Skaliere Maus-Kraft
  }
  // Reibung ~ -mu * v
  let Ff = vel.copy().mult(-mu);
  F.add(Ff);
  // a = F/m
  acc = p5.Vector.div(F, mass);
  vel.add(acc);
  pos.add(vel);
  // Randeffekte elastisch
  if(pos.x<20||pos.x>width-20){ vel.x*=-0.9; pos.x=constrain(pos.x,20,width-20); }
  if(pos.y<20||pos.y>height-20){ vel.y*=-0.9; pos.y=constrain(pos.y,20,height-20); }
  // Zeichnen
  fill(50,180,80); noStroke(); circle(pos.x,pos.y,30);
  // Kraftvektor
  stroke(200,0,0); strokeWeight(2); 
  line(pos.x,pos.y, pos.x+F.x*3, pos.y+F.y*3);
  noStroke(); fill(0); textSize(14);
  text(`m=${mass.toFixed(1)}kg  |  |v|=${vel.mag().toFixed(2)}  |  mu=${mu}`, 20,20);
  text("Maus ziehen = Kraft | Tasten: +/- Masse, [/] Reibung",20,40);
}
function keyPressed(){
  if(key==='+') mass=min(10,mass+0.5);
  if(key==='-') mass=max(0.5,mass-0.5);
  if(key==='[') mu=max(0,mu-0.01);
  if(key===']') mu=min(0.2,mu+0.01);
}
```

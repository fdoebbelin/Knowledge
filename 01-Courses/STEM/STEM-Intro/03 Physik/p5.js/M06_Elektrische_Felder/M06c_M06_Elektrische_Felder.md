# M06c – Lösungen

**Thema:** Elektrische Felder

Ziel: Interaktive Simulation mit **p5.js** (kompletten Sketch unten kopieren und in den p5.js Webeditor einfügen).

Hinweis: `setup()` und `draw()` sind vollständig enthalten.

---

## Lösungssketch (vollständig)

```javascript
// M06a: Elektrische Felder – Feldlinien-Vektorplot zweier Punktladungen
// Tasten: Z/X ändern q1, C/V ändern q2
let charges=[{pos:null,q:+1},{pos:null,q:-1}];
function setup(){ createCanvas(800,500); textFont('monospace');
  charges[0].pos=createVector(width*0.35,height*0.5);
  charges[1].pos=createVector(width*0.65,height*0.5);
}
function draw(){
  background(250);
  // Feldvektoren Gitter
  stroke(180);
  for(let y=40;y<height;y+=40){
    for(let x=40;x<width;x+=40){
      let p=createVector(x,y);
      let E=createVector(0,0);
      for(const c of charges){
        let r = p5.Vector.sub(p,c.pos);
        let d = r.mag();
        r.normalize();
        let k = 2000; // Skalenfaktor
        let e = r.mult(c.q/(d*d+50));
        E.add(e);
      }
      let len = E.mag()*2000;
      push();
      translate(x,y);
      stroke(50,120,220);
      line(0,0,E.x*len,E.y*len);
      pop();
    }
  }
  // Ladungen
  noStroke();
  for(const c of charges){
    fill(c.q>0?color(220,60,60):color(60,60,220));
    circle(c.pos.x,c.pos.y,28);
  }
  fill(0); noStroke();
  text(`q1=${charges[0].q.toFixed(1)}  q2=${charges[1].q.toFixed(1)}  (Z/X, C/V)`,10,20);
}
function keyPressed(){
  if(key==='Z') charges[0].q = max(-3, charges[0].q-0.5);
  if(key==='X') charges[0].q = min( +3, charges[0].q+0.5);
  if(key==='C') charges[1].q = max(-3, charges[1].q-0.5);
  if(key==='V') charges[1].q = min( +3, charges[1].q+0.5);
}
```

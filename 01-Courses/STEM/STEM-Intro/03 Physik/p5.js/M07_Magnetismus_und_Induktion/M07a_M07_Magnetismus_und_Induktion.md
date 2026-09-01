## M07 – Magnetismus: Lorentzkraft
Ein geladenes Teilchen bewegt sich in einem homogenen Magnetfeld senkrecht zur Bewegungsebene. Es erfährt eine Lorentzkraft, die es auf eine Kreisbahn zwingt. Die Nutzer:innen können die Ladung und die Stärke des Magnetfelds anpassen. Dies simuliert den Versuchsaufbau eines Elektronenstrahls im Magnetfeld (z. B. Fadenstrahlrohr).
## Demo-Sketch (komplett)

```javascript
// M07a: Magnetismus – Lorentzkraft q v × B (B nach +z)
// Teilchen bewegt sich in x-y Ebene unter homog. B-Feld -> Kreisbahn
let pos, vel, q=1, B=0.8, m=1, path=[];
function setup(){ createCanvas(600,400); textFont('monospace');
  pos=createVector(100,200); vel=createVector(140,0);
}
function draw(){
  background(246);
  let dt=1/60;
  // F = q v × Bz -> a = F/m
  let ax = (q/m)*vel.y*B;
  let ay = -(q/m)*vel.x*B;
  vel.x += ax*dt; vel.y += ay*dt;
  pos.x += vel.x*dt; pos.y += vel.y*dt;
  path.push(pos.copy()); if(path.length>500) path.shift();
  // Zeichnen
  noFill(); stroke(180); beginShape(); for(const p of path) vertex(p.x,p.y); endShape();
  noStroke(); fill(20,120,220); circle(pos.x,pos.y,14);
  fill(0); text(`|v|=${vel.mag().toFixed(1)}  B=${B.toFixed(2)}  q=${q}  (Tasten: [/] B±, +/- q±, R)`,10,20);
  // Wrap
  if(pos.x<0) pos.x=width; if(pos.x>width) pos.x=0;
  if(pos.y<0) pos.y=height; if(pos.y>height) pos.y=0;
}
function keyPressed(){
  if(key==='[') B=max(0,B-0.1);
  if(key===']') B=min(2,B+0.1);
  if(key==='+') q=min(3,q+1);
  if(key==='-') q=max(-3,q-1);
  if(key==='R'){ pos=createVector(100,200); vel=createVector(140,0); path=[]; }
}
```

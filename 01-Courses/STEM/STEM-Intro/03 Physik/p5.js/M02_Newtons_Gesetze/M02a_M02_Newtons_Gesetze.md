## M02 – Newtonsche Gesetze: Kraft und Beschleunigung
Hier wird ein Objekt in der Ebene gezeigt, auf das über die Maus eine Kraft ausgeübt wird. Die Kraft beeinflusst die Beschleunigung gemäß Newtons 2. Gesetz ($F = m \cdot a$). Zusätzlich wirkt eine Reibungskraft entgegen der Bewegung. Die Nutzerin kann die Masse und die Reibung verändern. Das Szenario entspricht einem Versuchsaufbau, bei dem ein Objekt auf einer Fläche geschoben wird, z. B. ein Holzklotz auf einem Tisch mit Federkraftmesser.
## Demo-Sketch (komplett)

```javascript
// M02a: Newtons Gesetze – F = m·a (2D mit Reibung)
// Ziehe mit der Maus, um Kraft zu applizieren.
let pos, vel, acc, mass=2, mu=0.05;
function setup(){
  createCanvas(800,400);
  textFont('monospace');
  pos=createVector(width/2, height/2); vel=createVector(0,0); acc=createVector(0,0);
}
function draw(){
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

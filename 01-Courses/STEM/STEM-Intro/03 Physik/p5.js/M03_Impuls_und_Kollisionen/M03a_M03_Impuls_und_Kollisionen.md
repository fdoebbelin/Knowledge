## M03 – Impuls & Kollisionen: Zwei Körper im Stoß
Zwei Kugeln bewegen sich auf einer Linie und stoßen elastisch zusammen. Die Massen und Anfangsgeschwindigkeiten lassen sich variieren. Der Sketch zeigt die Bewegung vor und nach dem Stoß, sodass die Impulserhaltung beobachtet werden kann. Dies entspricht einem klassischen Stoßversuch mit zwei Gleitkörpern auf einer Luftkissenbahn oder Billardkugeln auf einer geraden Bahn.
## Demo-Sketch (komplett)

```javascript
// M03a: Impuls & Kollisionen – 1D elastischer Stoß zweier Massen
let x1=200,v1=120,m1=2, x2=600,v2=-60,m2=1, r=20, last;
function setup(){ createCanvas(800,200); textFont('monospace'); last=millis(); }
function draw(){
  background(245);
  const now=millis(); const dt=(now-last)/1000; last=now;
  x1+=v1*dt; x2+=v2*dt;
  // Wände
  if(x1-r<0){ x1=r; v1*=-1; } if(x1+r>width){ x1=width-r; v1*=-1; }
  if(x2-r<0){ x2=r; v2*=-1; } if(x2+r>width){ x2=width-r; v2*=-1; }
  // Kollision
  if(abs(x1-x2) < 2*r){
    // elastischer Stoß in 1D
    let u1=v1, u2=v2;
    v1 = ((m1-m2)/(m1+m2))*u1 + (2*m2/(m1+m2))*u2;
    v2 = (2*m1/(m1+m2))*u1 + ((m2-m1)/(m1+m2))*u2;
    // separiere
    if(x1<x2){ x1=x2-2*r; } else { x2=x1-2*r; }
  }
  noStroke(); fill(70,130,180); circle(x1,100,2*r);
  fill(220,80,60); circle(x2,100,2*r);
  fill(0); text(`v1=${v1.toFixed(1)}  v2=${v2.toFixed(1)}  p=${(m1*v1+m2*v2).toFixed(1)}`,10,20);
  text("Tasten: 1/2 Masse1±, 3/4 Masse2±, R Reset",10,40);
}
function keyPressed(){
  if(key==='1') m1=max(0.5,m1-0.5);
  if(key==='2') m1=min(5,m1+0.5);
  if(key==='3') m2=max(0.5,m2-0.5);
  if(key==='4') m2=min(5,m2+0.5);
  if(key==='R'){ x1=200;v1=120;m1=2;x2=600;v2=-60;m2=1; }
}
```

## M08 – Optik: Lichtstrahlen an einer Linse
Ein Objekt (z. B. Pfeil) steht vor einer Sammellinse. Der Lichtstrahlverlauf (Hauptstrahlen) wird dargestellt, und das entstehende Bild auf der anderen Seite der Linse wird berechnet. Die Brennweite der Linse kann verändert werden. Das entspricht einem klassischen Linsenversuch mit optischer Bank und Lichtquelle.
## Demo-Sketch (komplett)

```javascript
// M08a: Optik – Dünne Linse (Strahlenverlauf)
// Drag die Maus vertikal, um die Objekt-Höhe zu ändern.
let f=120, objX=100, imgX, h=80, lensX=400;
function setup(){ createCanvas(900,400); textFont('monospace'); }
function draw(){
  background(250);
  // Hauptachsen
  stroke(0); line(0,height/2,width,height/2);
  // Objekt & Linse
  stroke(0); line(objX,height/2, objX, height/2 - h); // Objekt
  drawLens(lensX);
  // Abbildungsgleichung: 1/f = 1/g + 1/b  (g>0 links von Linse)
  let g = lensX - objX;
  let b = 1 / (1/f - 1/g);
  imgX = lensX + b;
  // Bildhöhe ähnlich triangles: h_b = h * b/g
  let hb = h * (b/g);
  // Strahlen: Parallelstrahl, Mittelpunktstrahl, Brennpunktstrahl
  stroke(220,80,60);
  // Parallelstrahl: vom Objekt zur Linse auf Achse, danach durch Brennpunkt
  line(objX, height/2 - h, lensX, height/2 - h);
  line(lensX, height/2 - h, imgX, height/2 - hb);
  // Mittelpunktstrahl (durch Linsenmitte gerade)
  line(objX, height/2 - h, imgX, height/2 - hb);
  // Darstellung Bild
  stroke(0,120,200);
  line(imgX,height/2, imgX, height/2 - hb);
  noStroke(); fill(0);
  text(`f=${f}px, g=${g.toFixed(1)}px, b=${b.toFixed(1)}px, Abbildung: V=${(b/g).toFixed(2)}`,10,20);
  text("Maus hoch/runter = Objekt-Höhe | Pfeile links/rechts ändern f",10,40);
}
function mouseDragged(){ h = constrain(height/2 - mouseY, -150, 150); }
function keyPressed(){
  if(keyCode===LEFT_ARROW) f=max(40,f-5);
  if(keyCode===RIGHT_ARROW) f=min(200,f+5);
}
function drawLens(x){
  stroke(0); line(x,40,x,height-40);
  stroke(0,120,200); // Brennpunkte
  line(x-120,height/2-6,x-120,height/2+6);
  line(x+120,height/2-6,x+120,height/2+6);
}
```

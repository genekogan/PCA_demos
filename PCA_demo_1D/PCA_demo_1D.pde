ArrayList<PVector> points;

float w = 800;
float h = 800;
int n = 64;
float margin = 60;
float maxMargin = 1.0;
float pad = 100;
float zoomout = 300;
boolean drawLine = false;
boolean projected = false;
boolean flat = false;
float alph = 0;
float alph2 = 255;
float ang = 0;


void setup() {
  size(800, 800, P3D);
  points = new ArrayList<PVector>();
  for (int i=0; i<n; i++) {
    float x = random(w);
    float y = 2*h/3 - 0.53 * x;
    points.add(new PVector(x, y, random(-margin, margin)));
  }
}

void draw() {
  background(255);
  
  if (projected) {
    maxMargin = lerp(maxMargin, 0, 0.03);
  } else {
    maxMargin = lerp(maxMargin, 1, 0.03);
  }
  
  if (drawLine){
    alph = lerp(alph, 255, 0.1);
  } else {
    alph = lerp(alph, 0, 0.1);
  }

  if (flat) {
    ang = lerp(ang, atan2(0.53,1), 0.05);
    alph2 = lerp(alph2, 0, 0.1);
  } else {
    ang = lerp(ang, 0, 0.05);
    alph2 = lerp(alph2, 255, 0.1);
  } 
  
  translate(width/2, height/2, -zoomout);
  rotateZ(ang); 

  noFill();
  stroke(0, alph2);
  rect(-w/2-pad, -h/2-pad, w+2*pad, h+2*pad);
  for (int i=0; i<=10; i++) {
    float x = map(i, 0, 10, -w/2-pad, w/2+pad);
    line(x, -h/2-pad, x, h/2+pad);
  }
  for (int j=0; j<=10; j++) {
    float y = map(j, 0, 10, -h/2-pad, h/2+pad);
    line(-w/2-pad, y, w/2+pad, y);
  }

  float y1 = 2*h/3 + 0.53 * 2*w;// - height/2 - h/4;
  float y2 = 2*h/3 - 0.53 * 2*w;// - height/2 - h/4;
  stroke(0, alph);
  line(-2*w-w/2, y1 - h/2, 2*w-w/2, y2 - h/2);

  fill(0);
  stroke(0);
  for (int i=0; i<n; i++) {
    PVector p = points.get(i); 
    pushMatrix();
    translate(p.x-w/2, p.y - h/2 + p.z * maxMargin);
    sphere(6);
    popMatrix();
  }
  
}
    
void keyPressed() {
  if (key == '1') {
    drawLine = !drawLine;
  }
  if (key == '2') {
    projected = !projected;
  }
  if (key == '3') {
    flat = !flat;
  }
}

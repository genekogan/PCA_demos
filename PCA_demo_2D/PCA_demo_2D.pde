ArrayList<PVector> points;

float w = 800;
float h = 800;
int n = 32;
float margin = 100;
float maxMargin = 1.0;
float pad = 100;
float zoomout = 300;
boolean drawPad = false;
boolean projected = false;
boolean flat = false;
float mx = 0.98999995;
float my = 0.71;
float mx0 = mx;
float my0 = my;

void setup() {
  size(800, 800, P3D);
  points = new ArrayList<PVector>();
  for (int i=0; i<n; i++) {
    points.add(new PVector(random(w), random(h), random(-margin, margin)));
  }
}

void draw() {
  background(255);
  
  if (projected) {
    maxMargin = lerp(maxMargin, 0, 0.03);
  } else {
    maxMargin = lerp(maxMargin, 1, 0.03);
  }
  
  if (flat) {
    mx0 = lerp(mx0, 0, 0.03);
    my0 = lerp(my0, 0, 0.03);
  } else {
    mx0 = lerp(mx0, mx, 0.03);
    my0 = lerp(my0, my, 0.03);
  }
  
  translate(width/2, height/2, -zoomout);
  mx = mouseX*0.01; 
  my = mouseY*0.01;
  
  rotateY(mx0);
  rotateX(my0);
  
  if (drawPad){
    noFill();
    stroke(0, 150);
    //rect(-w/2-pad, -h/2-pad, w+2*pad, h+2*pad);
    for (int i=0; i<=10; i++) {
      float x = map(i, 0, 10, -w/2-pad, w/2+pad);
      line(x, -h/2-pad, x, h/2+pad);
    }
    for (int j=0; j<=10; j++) {
      float y = map(j, 0, 10, -h/2-pad, h/2+pad);
      line(-w/2-pad, y, w/2+pad, y);
    }
  }
  
  fill(0);
  stroke(0);
  for (int i=0; i<n; i++) {
    PVector p = points.get(i); 
    pushMatrix();
    translate(p.x-w/2, p.y-h/2, p.z * maxMargin);
    sphere(10);
    popMatrix();
  }

  
}

void keyPressed() {
  if (key == '1') {
    drawPad = !drawPad;
  }
  if (key == '2') {
    projected = !projected;
  }
  if (key == '3') {
    flat = !flat;
  }
}

void setup() {
  size(640, 640, P3D);
  noStroke();
}
 
void draw() {
  background(20);
  translate(width/2, height/2, 0);
  rotateX(-PI/6);
 
  for (int i = 0; i < 360; i+=10) {
    float x = cos(radians(i+frameCount*2))*150;
    float z = sin(radians(i+frameCount*2))*150;
    ellipseMode(CENTER);
    for (int q = 0; q < 360; q+=12) {
      float x2 = sin(radians(q))*cos(radians(i+frameCount*2))*75;
      float y2 = cos(radians(q))*75;
      float z2 = sin(radians(q))*sin(radians(i+frameCount*2))*75;
      float m = sin(radians(q+frameCount*6))*5;
      if (m > 1) {
        pushMatrix();
        translate(x+x2,y2,z+z2);
        sphere(m);
        popMatrix();
      } else {
        pushMatrix();
        translate(x+x2,y2,z+z2);
        sphere(1);
        popMatrix();
      }
    }
  }
}
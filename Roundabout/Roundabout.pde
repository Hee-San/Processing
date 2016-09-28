void setup() {
  size(640, 640);
  noStroke();
}
 
void draw() {
  background(20);
  translate(width/2, height/2);
 
 
  for (int i = 0; i < 360; i+=60) {
    float x = sin(radians(i-frameCount))*50;
    float y = cos(radians(i-frameCount))*50;
    for (int q = 0; q < 360; q+=10) {
      float x2 = sin(radians(q))*75;
      float y2 = cos(radians(q))*75;
      float m = sin(radians(q-i-frameCount*3))*5;
      if (m > 0) {
        ellipse(x+x2, y+y2, m, m);
      } else {
        ellipse(x+x2, y+y2, 1, 1);
      }
    }
  }
}
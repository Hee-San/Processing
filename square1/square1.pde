float angle = 0;
void setup(){
  size(640, 640);
  rectMode(CENTER);
}

void draw(){
  background(246, 249, 235);  //118-d
  smooth();
  stroke(61, 49, 31);  //118-b
  noFill();
  
  for(int n = 0; n < 12; n += 1){
    square(n*PI/12, 100+50*sin(angle + n*PI/6));
  }
  
  angle += PI/2/24;
  //saveFrame("frames/######.tif");
}

void square(float ang, float r){
  beginShape();
  vertex(width/2+r*cos(ang), height/2+r*sin(ang));
  vertex(width/2+r*cos(ang+PI/2), height/2+r*sin(ang+PI/2));
  vertex(width/2+r*cos(ang+PI), height/2+r*sin(ang+PI));
  vertex(width/2+r*cos(ang-PI/2), height/2+r*sin(ang-PI/2));
  endShape(CLOSE);
}
float r1 = 160;
float r2 = 80;
float r3 = 40;
float ratio1 = 2;
float ratio2 = 2;
float speed = 100;
float x1, y1, x2, y2, x3, y3, tx1, ty1;
float angle1;

void setup(){
  size(640, 640);
  noStroke();
  rectMode(CENTER);
}

void draw(){
  background(#202639);
  smooth();
  
  float ang1 = angle1;
  float ang2 = angle1*ratio1;
  float ang3 = ang2*ratio2;

  x1 = width/2 + (r1 * cos(ang1));
  y1 = height/2 + (r1 * sin(ang1));
  x2 = x1 + (r2 * cos(ang2));
  y2 = y1 + (r2 * sin(ang2));
  x3 = x2 + (r3 * cos(ang3));
  y3 = y2 + (r3 * sin(ang3));
  
  strokeWeight(3);  
  
  noFill(); 
  stroke(#9298AB);
  ellipse(width/2, height/2, r1*(2-2/ratio1), r1*(2-2/ratio1));
  ellipse(x1, y1, r1*2/ratio1, r1*2/ratio1);
  stroke(#9298AB, 90);
  ellipse(x1, y1, r2*(2-2/ratio2), r2*(2-2/ratio2));
  ellipse(x2, y2, r2*2/ratio2, r2*2/ratio2);
  
  strokeJoin(ROUND);
  strokeWeight(3); 
  stroke(#455173);
  beginShape();
  curveVertex(width/2+r1+r2+r3,height/2);
  for(float t = 0; t < PI*2 ; t += PI/200){
    tx1 = width/2 + (r1 * cos(t)) + (r2 * cos(t*ratio1)) + (r3 * cos(t*ratio1*ratio2));
    ty1 = height/2 + (r1 * sin(t)) + (r2 * sin(t*ratio1)) + (r3 * sin(t*ratio1*ratio2));
    curveVertex(tx1,ty1);
  }
  endShape(CLOSE);
  
  stroke(#FFFFFF);
  line(width/2, height/2,  x1, y1);
  line(x1, y1, x2, y2);
  line(x2, y2, x3, y3);
  
  ellipse(width/2, height/2, r1/4, r1/4);
  ellipse(x1, y1, r2/3, r2/3);
  ellipse(x2, y2, r3/3, r3/3);
  ellipse(x3, y3, r3/4, r3/4);

  
  fill(#FFFFFF);  
  ellipse(width/2, height/2, r1/4 - 12, r1/4 - 12);
  ellipse(x1, y1, r2/3 - 12, r2/3 - 12);
  ellipse(x2, y2, r3/3 - 12, r3/3 - 12);
  ellipse(x3, y3, r3/4 - 12, r3/4 - 12);
  
  angle1 += -PI / speed;
}
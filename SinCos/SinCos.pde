float x1, y1;
float angle1;
float scalar = 70; //tannien r
float r = 10; // r
float r2 = 20; // tyusinkaku r
float a1 ,a2;

void setup() {
  size(1000, 500);
  noStroke();
  rectMode(CENTER);
}

void draw() {
  background(250);

  float ang1 =angle1 % (2*PI);
  //float ang2 = radians(angle2);

  x1 = width/2 + (scalar * cos(ang1));
  //x2 = width/2 + (scalar * cos(ang2));
  
  y1 = height/2 + (scalar * sin(ang1));
  //y2 = height/2 + (scalar * sin(ang2));
  
  strokeWeight(1);  
  noFill();
  
  stroke(200);
  line(width/2, 0,  width/2, height);
  line(0, height/2, width, height/2);

  stroke(0);
  ellipse(width/2, height/2, 140, 140);
  
  line(width/2, height/2, x1, y1);
  
  stroke(100);  
  line(x1, y1, x1, height);
  line(x1, y1, width, y1);
  line(width/2-scalar, height/2 + 120, width/2+scalar, height/2 + 120);
  line(width/2 + 120, height/2-scalar, width/2 + 120, height/2+scalar);
  
  for (float a = 0.1; a <10; a += PI/30) {
    a1 = a*(width/2-120)/10;
    line(width/2 + (scalar * cos(ang1 + a -PI/30)), height/2 + 120 + a1 - (width/2-120)/100, 
          width/2 + (scalar * cos(ang1 + a)), height/2 + 120 + a1);
    line(width/2 + 120 + a1 - (width/2-120)/100, height/2 + (scalar * sin(ang1 + a -PI/30)), 
          width/2 + 120 + a1, height/2 + (scalar * sin(ang1 + a)));
  }
  
  for (float a = 0.1; a2 <(height/2-120); a += 0.1) {
    a2 = a*(width/2-120)/10;
    line(width/2 + (scalar * cos(ang1 + a -0.1)), height/2 + 120 + a2 - (width/2-120)/100, 
          width/2 + (scalar * cos(ang1 + a)), height/2 + 120 + a2);
    line(width/2 + 120 + a2 - (width/2-120)/100, height/2 + (scalar * sin(ang1 + a -0.1)), 
          width/2 + 120 + a2, height/2 + (scalar * sin(ang1 + a)));
  }
  
  noStroke();
  
  fill(0, 102, 153);
  ellipse(x1, height/2 + 120, r, r);
  
  fill(255, 204, 0);
  ellipse(width/2 + 120, y1, r, r);
    
  fill(0);
  ellipse(x1, y1, r, r);
  
  arc(width/2, height/2, r2, r2, ang1, 0);

  angle1 += -PI/100; //spead
  //saveFrame("frames/######.tif");
}
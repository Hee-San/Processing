int NCircle = 1;
float[] y;
float NewY, NewX;
circle c;
ArrayList<circle> cl1 = new ArrayList<circle>();
ArrayList<circle> cl2 = new ArrayList<circle>();
PVector basePos, NewPoint;
String Fomula;

void setup() {
  size(1300, 700);
  background(250);
  y = new float[int(width/2)+1];
  c = new circle(width/2, height/2, 0, 150, 1);
  for(int i = 0; i < 4; i++){
    cl1.add(new circle(width/12, i*height/4+height/8, 0, 150/(2*i+3), (2*i+3)));
  }
  for(int i = 0; i < int(width/2); i++){
    y[i]  = height/2+150*sin(i*PI/100);
  }
  Fomula = "f(x) = sin(x)";
  smooth();
}
 
void draw() {
  background(250);
  fill(200);
  noStroke();
  rect(0, 0, width/4, height);
  NewY = height/2;
  for(int i = 1; i <= NCircle; i++){
    NewY -= 150/(2*i-1)*sin(frameCount*PI/100*(2*i-1));
    NewX += 150/(2*i-1)*cos(frameCount*PI/100*(2*i-1));
    ellipse(NewX, NewY, c.r/10, c.r/10);
  }
  wave();
  c.draw();
  PVector p = c.getPoint();
  c.update();
  fill(180);
  textSize(26);
  text(Fomula, width/4+10, 10, width*3/4-20, height);
  for(circle c1: cl1){
    pushMatrix();
      translate(c1.x, c1.y);
      fill(255);
      textSize(26);
      text("f(x) = 1/" + int(c1.speed) + "*sin(" + int(c1.speed) + "x)", -80, 80);
      noFill();
      stroke(0);
      c1.drawWave(width/12, width/6);
      ellipse(0,0,c1.r*2,c1.r*2);
      line(0, 0, c1.r*cos(c1.angle), -c1.r*sin(c1.angle));
      fill(255, 204, 0);
      noStroke();
      ellipse(0, 0, c1.r/10, c1.r/10);
      ellipse(c1.r*cos(c1.angle), -c1.r*sin(c1.angle), c1.r/10, c1.r/10);
    popMatrix();
    c1.update();
  }
  NewPoint = c.getPoint();
  for(circle c1:cl2){
    c1.x = p.x;
    c1.y = p.y;
    c1.draw();
    c1.update();
    p.add(c1.getPoint());
    p.add(-c1.x, -c1.y);
    NewPoint = c1.getPoint();
  }
    stroke(0);
    line(NewPoint.x, NewPoint.y, 150*3/2+width/2, NewPoint.y);
    fill(255, 204, 0);
    noStroke();
    ellipse(NewPoint.x, NewPoint.y, c.r/10, c.r/10);
    ellipse(150*3/2+width/2, NewPoint.y, c.r/10, c.r/10);
}

void wave(){
  noFill();
  stroke(0);
  beginShape();
  for(int i = int(width/2)-1; i >= 0 ; i--){
    vertex(150*3/2+width/2+i, y[i]);
    y[i+1] = y[i];
  }
  y[0] = NewY;
  endShape();
}

class circle{
  float x, y;
  float angle;
  float r;
  float speed;
  
  circle(float x, float y, float ang, float r, float sp){
    this.x = x;
    this.y = y;
    this.angle = ang;
    this.r = r;
    this.speed = sp;
  }
  
  void draw(){
    ellipseMode(CENTER);
    pushMatrix();
      translate(x, y);
      noFill();
      stroke(0);
      ellipse(0,0,r*2,r*2);
      line(0, 0, r*cos(angle), -r*sin(angle));
      fill(255, 204, 0);
      noStroke();
      ellipse(0, 0, r/10, r/10);
    popMatrix();
  }
  
  void drawWave(float x1, float len){
    noFill();
    stroke(0);
    beginShape();
    for(int i = 0; x1+i < len; i++){
      vertex(x1+i, -r*sin(angle-speed*i*PI/100));
    }
    endShape();
    line(r*cos(angle), -r*sin(angle), x1, -r*sin(angle));
    fill(255, 204, 0);
    noStroke();
    ellipse(x1, -r*sin(angle), r/10, r/10);
    noFill();
    stroke(0);
  }
  
  void update(){
    this.angle += speed*PI/100;
  }
  
  PVector getPoint(){
    return new PVector(x+r*cos(angle), y-r*sin(angle));
  }
}


void mouseClicked(){
  cl2.add(cl1.get(0));
  cl1.remove(0);
  for(circle c1: cl1){
    c1.y = c1.y-height/4;
  }
  cl1.add(new circle(width/12, 3*height/4+height/8, 0, 150/(2*(NCircle+4)+3), (2*(NCircle+4)+3)));
  NCircle ++;
  Fomula = Fomula + "+1/" + (2*(NCircle)-1) + "*sin(" + (2*(NCircle)-1) + "x)";
}
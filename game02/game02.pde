ArrayList<item> items = new ArrayList<item>();
ArrayList<star> stars = new ArrayList<star>();
float MX;
void setup(){
  size(500,700,P3D);
  for(float i = -height*1.5; i < height*1.5; i += 3){
    if(int(random(10)) < 1){
      stars.add(new star(i, random(2*PI), random(1,1.5)));
    }
  }
}

void draw(){
  background(20, 30, 91);
  stroke(60);
  line(width/2, -height/2, -width/2, width/2, height*3/2, -width/2);

  for(int i = items.size()-1; i >= 0; i--){
    item a = items.get(i);
    a.draw();
    a.update();
    if(a.h > height*3/2){
      items.remove(i);
    }
  }
  for(int i = stars.size()-1; i >= 0; i--){
    star a = stars.get(i);
    a.draw();
    a.update();
    if(a.h > height*3){
      stars.remove(a);
    }
  }
  if(frameCount % 100 == 0){
    itemAdd();
  }
  if(int(random(10)) < 1){
    starAdd();
  }
}



void mousePressed(){
  MX = mouseX;
}

void mouseDragged(){
  for(item i: items){
    i.angle -= (mouseX-MX)*PI/180;
  }
  for(star s: stars){
    s.angle -= (mouseX-MX)*PI/180;
  }
  MX = mouseX;
}
void itemAdd(){
  items.add(new item(-height/3, random(2*PI)));
}

void starAdd(){
  stars.add(new star(-height*1.5, random(2*PI), random(1,1.5)));
}
  
class item{
  float h;
  float angle;
  
  item(float h, float angle){
    this.h = h;
    this.angle = angle;
  }

  
  void update(){
    h += 3;
  }
  
  void draw(){
    pushMatrix();
      translate(width/2+width*cos(angle)/3, height-h, -width/2+width*sin(angle)/3); 
      rotateY(-angle);
      fill(255);
      noStroke();
      box(30);
    popMatrix();
    stroke(100);
    line(width/2, height-h, -width/2, width/2+width*cos(angle)/3, height-h, -width/2+width*sin(angle)/3);

  }
}

class star{
  float h;
  float angle;
  float r;
  
  void update(){
    h += 3;
  }
  
  star(float h, float angle, float r){
    this.h = h;
    this.r = r;
    this.angle = angle;
  }
  
  void draw(){
    pushMatrix();
      translate(width/2+width*r*cos(angle)*3, height-h, -width/2+width*r*sin(angle)*3); 
      fill(255);
      noStroke();
      sphere(5);
    popMatrix();
  }
}
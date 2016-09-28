color[] CArray = new color[7];
ArrayList<Drop> Drops = new ArrayList<Drop>(30);
int lastX, lastY;
public Player player;
int score=0;

void setup(){
  size(600, 500);
  background(255);
  CArray[0] = color(#FF0000); 
  CArray[1] = color(#0000FF); 
  CArray[2] = color(#00FF00); 
  CArray[3] = color(#FFFF00); 
  CArray[4] = color(#FF00FF); 
  CArray[5] = color(#00FFFF);
  CArray[6] = color(#FFFFFF);
  //0=Red, 1=Blue, 2=Green, 3=Yellow, 4=Pink, 5=SkyBlue, 6=White
   int id = 0;
  for(int j = 0; j < 5; j++){
    for(int i = 0; i < 6; i++){
      Drops.add(new Drop(id, i, j, int(random(6))));
      id ++;
    }
  }
  while(LineCheck()){
    fall();
  }
  score = 0;
}

void draw(){
  background(255);
  noStroke();
  for(Drop d: Drops){
    d.draw();
  }
  textSize(64);
  fill(0, 140);
  text(score, 10, height-10);
}

void mousePressed(){
  int x = round(mouseX/100);
  int y = round(mouseY/100);
  int id = x+6*y;
  Drop P = Drops.get(id);
  player = new Player(P.Zokusei);
  Drops.set(id, new Drop(id, (int)(P.pos.x), (int)(P.pos.y), 6));
  pushMatrix();
    translate(mouseX, mouseY);
    fill(player.col);
    ellipse(0, 0, 100, 100);
  popMatrix();
  
  lastX = x;
  lastY = y;
}

void mouseDragged(){
  player.draw();
  
  int x = round(mouseX/100);
  int y = round(mouseY/100);
  if(lastX != x || lastY != y){
    int id = lastX+6*lastY;
    Drop d = Drops.get(x+6*y);
    Drops.set(id, new Drop(id, lastX, lastY, d.Zokusei));
    Drops.set(d.id, new Drop(d.id, x, y, 6));
    lastX = x;
    lastY = y;
    //println(x,y);
  }
}

void mouseReleased(){
  int x = round(mouseX/100);
  int y = round(mouseY/100);
  int id = x+6*y;

  Drops.set(id, new Drop(id, x, y, player.Zokusei));
      
  while(LineCheck()){
    fall();
  }
}

class Drop{
  color col;
  PVector pos = new PVector();
  int Zokusei;
  int id;
  Drop(int i, int x, int y, int z){
    this.id = i;
    this.Zokusei = z;
    this.pos.set(x,y);
    this.col = CArray[Zokusei];
  }
  
  void draw(){
    pushMatrix();
      translate(pos.x*100+50, pos.y*100+50);
      fill(col);
      ellipse(0, 0, 90, 90);
    popMatrix();
  }
  void draw2(float t){
    pushMatrix();
      translate(pos.x*100+50, pos.y*100+50-t);
      fill(col);
      ellipse(0, 0, 90, 90);
    popMatrix();
  }
}

class Player{
  color col;
  int Zokusei;
  Player(int z){
    this.Zokusei = z;
    this.col = CArray[Zokusei];
  }
  
  void draw(){
    pushMatrix();
      translate(mouseX, mouseY);
      fill(this.col);
      ellipse(0, 0, 100, 100);
    popMatrix();
  }
}


boolean LineCheck(){
  boolean flag = false;
  int[] Delete = {};
  
  for(Drop d: Drops){
    if(d.pos.y != 0 && d.pos.y != 4){
      Drop UDrop = Drops.get(d.id-6);
      Drop DDrop = Drops.get(d.id+6);
      if(d.Zokusei == UDrop.Zokusei && d.Zokusei == DDrop.Zokusei){
        int[] R = {d.id,UDrop.id,DDrop.id};
        Delete = concat(Delete, R);
      }
    }
    if(d.pos.x != 0 && d.pos.x != 5){
      Drop LDrop = Drops.get(d.id-1);
      Drop RDrop = Drops.get(d.id+1);
      if(d.Zokusei == LDrop.Zokusei && d.Zokusei == RDrop.Zokusei){
        int[] C = {d.id,LDrop.id,RDrop.id};
        Delete = concat(Delete, C);
      }
    }
  }
  for(int i = 0;i < Delete.length; i++){
    Drop d = Drops.get(Delete[i]);
    Drops.set(Delete[i], new Drop(Delete[i], (int)(d.pos.x), (int)(d.pos.y), 6));
    flag = true;
  }
  return(flag);
}

void fall(){
  int flag = 1;
  while(flag != 0){
    flag = 0;
    for(Drop d: Drops){
      d.draw();
      if(d.Zokusei == 6){
        flag ++;
        if(d.pos.y == 0){
          Drops.set(d.id, new Drop(d.id, (int)(d.pos.x), (int)(d.pos.y), int(random(6))));
          score ++;
        } else {
          Drop e = Drops.get(d.id-6);
          Drops.set(d.id, new Drop(d.id, (int)(d.pos.x), (int)(d.pos.y), e.Zokusei));
          Drops.set(e.id, new Drop(e.id, (int)(e.pos.x), (int)(e.pos.y), 6));
        }
      }
    }
  }
}
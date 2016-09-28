int NZokusei = 6;
int DropRow = 10;
int DropCol = 12;
float CellSize = 50;

color[] CArray;
ArrayList<Drop> Drops;
int lastX, lastY;
public Player player;
int score=0;
float DropSize;

void setup(){
  size(600, 600);
  background(255);
  
  DropSize = CellSize*0.9;
  CArray = new color[NZokusei+1];
  CArray[0] = color(#FFFFFF); 
  CArray[1] = color(#FF0000); 
  CArray[2] = color(#0000FF); 
  CArray[3] = color(#00FF00); 
  CArray[4] = color(#FFFF00); 
  CArray[5] = color(#FF00FF);
  CArray[6] = color(#00FFFF);
  //0=White, 1=Red, 2=Blue, 3=Green, 4=Yellow, 5=Pink, 6=SkyBlue, 
  
  Drops = new ArrayList<Drop>(NZokusei * DropRow);
  int id = 0;
  for(int j = 0; j < DropRow; j++){
    for(int i = 0; i < DropCol; i++){
      Drops.add(new Drop(id, i, j, int(random(NZokusei))+1));
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

float mouseX2(){
  if(CellSize*DropCol-CellSize/2<mouseX){
    return(CellSize*DropCol-CellSize/2);
  }else if(mouseX < CellSize/2){
    return(CellSize/2);
  }else return(mouseX);
}

float mouseY2(){
  if(CellSize*DropRow-CellSize/2<mouseY){
    return(CellSize*DropRow-CellSize/2);
  }else if(mouseY < CellSize/2){
    return(CellSize/2);
  }else return(mouseY);
}


void mousePressed(){
  int x = round((mouseX2() - CellSize/2)/CellSize);
  int y = round((mouseY2() - CellSize/2)/CellSize);
  //println(x,y);
  int id = x+DropCol*y;
  Drop P = Drops.get(id);
  player = new Player(P.Zokusei);
  Drops.set(id, new Drop(id, (int)(P.pos.x), (int)(P.pos.y), 0));
  pushMatrix();
    translate(mouseX2(), mouseY2());
    fill(player.col);
    ellipse(0, 0, CellSize, CellSize);
  popMatrix();
  
  lastX = x;
  lastY = y;
}

void mouseDragged(){
  player.draw();
  
  int x = round((mouseX2() - CellSize/2)/CellSize);
  int y = round((mouseY2() - CellSize/2)/CellSize);
  if(lastX != x || lastY != y){
    int id = lastX+DropCol*lastY;
    Drop d = Drops.get(x+DropCol*y);
    Drops.set(id, new Drop(id, lastX, lastY, d.Zokusei));
    Drops.set(d.id, new Drop(d.id, x, y, 0));
    lastX = x;
    lastY = y;
    //println(x,y);
  }
}

void mouseReleased(){
  int x = round((mouseX2() - CellSize/2)/CellSize);
  int y = round((mouseY2() - CellSize/2)/CellSize);
  int id = x+DropCol*y;

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
      translate(pos.x*CellSize+CellSize/2, pos.y*CellSize+CellSize/2);
      fill(col);
      ellipse(0, 0, DropSize, DropSize);
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
      translate(mouseX2(), mouseY2());
      fill(this.col);
      ellipse(0, 0, CellSize, CellSize);
    popMatrix();
  }
}


boolean LineCheck(){
  boolean flag = false;
  int[] Delete = {};
  
  for(Drop d: Drops){
    if(d.pos.y != 0 && d.pos.y != DropRow-1){
      Drop UDrop = Drops.get(d.id-DropCol);
      Drop DDrop = Drops.get(d.id+DropCol);
      if(d.Zokusei == UDrop.Zokusei && d.Zokusei == DDrop.Zokusei){
        int[] R = {d.id,UDrop.id,DDrop.id};
        Delete = concat(Delete, R);
      }
    }
    if(d.pos.x != 0 && d.pos.x != DropCol-1){
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
    Drops.set(Delete[i], new Drop(Delete[i], (int)(d.pos.x), (int)(d.pos.y), 0));
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
      if(d.Zokusei == 0){
        flag ++;
        if(d.pos.y == 0){
          Drops.set(d.id, new Drop(d.id, (int)(d.pos.x), (int)(d.pos.y), int(random(NZokusei))+1));
          score ++;
        } else {
          Drop e = Drops.get(d.id-DropCol);
          Drops.set(d.id, new Drop(d.id, (int)(d.pos.x), (int)(d.pos.y), e.Zokusei));
          Drops.set(e.id, new Drop(e.id, (int)(e.pos.x), (int)(e.pos.y), 0));
        }
      }
    }
  }
}
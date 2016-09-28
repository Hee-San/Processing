ArrayList<Block> blocks = new ArrayList<Block>();
Player player;
PVector basePos = new PVector();
PVector spawnPos = new PVector();
int Ncolored = 0;
boolean menew = false;
int seed = int(random(100000));
void setup(){
  size(1200, 600, P3D);
  randomSeed(seed);
  println("Seed:"+seed);
  for(int i=1; i<100; i++) {
    blocks.add(new Block(random(width), height - i * 110, random(60, 360), 10, color(0)));
  }
  
  blocks.add(new Block(width/2, height, 500, 10, color(0)));
  blocks.add(player = new Player(width/2, height-60));
  spawnPos.set(width/2, height-60);
}

void draw(){
  if(! menew){
    background(255);
    noStroke();
    textSize(64);
    fill(0, 140);
    text(Ncolored, 40, height-40);
    if(keyPressed && key == ' '){
        basePos.lerp(new PVector(-player.pos.x + width/2, -player.pos.y + height/2, -2000), 0.02);
    }else basePos.lerp(new PVector(-player.pos.x + width/2, -player.pos.y + height/2, -1), 0.02);
    translate(basePos.x, basePos.y, basePos.z);
    for(Block b: blocks) {
      b.update();
      b.draw();
    }
  }
}

class Block {
  PVector pos = new PVector();
  PVector size = new PVector();
  PVector vel = new PVector();
  PVector prevPos = new PVector();
  color col;
  
  Block(float x, float y, float w, float h, color col){
    pos.set(x,y, -100);
    size.set(w/2, h/2, 100);
    this.col = col;
  }
  
  void update(){
    prevPos.set(pos);
    pos.add(vel);
  }
  
  void draw(){
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(col);
      box(size.x*2, size.y*2, size.z*2);
    popMatrix();
  }
  
  boolean isHit(Block b){
    return abs(pos.x - b.pos.x) < abs(size.x + b.size.x) &&
           abs(pos.y - b.pos.y) < abs(size.y + b.size.y);
  }
}

class Player extends Block{
  boolean isLanding, isHitHead;
  int jumpingFrames;
  Player(float x, float y){
    super(x, y, 50, 50, color(255, 0, 0));
    size.z = 20;
  }
  
  void update(){
    super.update();
    
    float x = mouseX - pos.x - basePos.x;
    if(abs(x) > size.x) vel.x += x < 0 ? -0.2f : 0.2f;
    if(isLanding){
      vel.x = vel.x*0.94;
    }
    vel.y += 0.2f;
    if(mousePressed && mouseButton == LEFT) {
      if(isHitHead){
        vel.y = 0;
      } else if(isLanding) {
        vel.y -= 2.0f;
        jumpingFrames = 15;
      } if(jumpingFrames-->0) {
        vel.y -= 1.0f;
      }
    }  else jumpingFrames = 0;
    
    vel.mult(0.98f);
    vel.limit(10.0f);
    if(pos.y>height * 1.2) pos.set(spawnPos);
    
    isLanding = false;
    isHitHead = false;
    for(Block b: blocks) {
      if(b==this) continue;
      if(isHit(b)) {
        if(b.col==color(0)){
          b.col = color(random(254)+1, random(254)+1, random(254)+1);
          spawnPos.set(b.pos.x,b.pos.y-51);
          Ncolored ++;
        }
        if(prevPos.y> b.pos.y && pos.y - size.y <= b.pos.y + b.size.y) {
          pos.y = size.y + b.pos.y + b.size.y;
          isHitHead = true;
        } else if(pos.y + size.y >= b.pos.y - b.size.y){
          pos.y = -size.y + b.pos.y - b.size.y;
          isLanding = true;
        }
      }
    }
  }
}

void mousePressed(){
  if(mouseButton == RIGHT){
    if(menew == false){
      menew = true;
      pushMatrix();
        translate(-basePos.x+width/2, -basePos.y+height/2, -basePos.z);
        fill(0, 100);
        box(width, height, 100);
      popMatrix();
      textSize(64);
      fill(0, 140);
      text(seed, width/2, height-40);
    }else{
      menew = false;
    }
  }else if(mouseButton == LEFT){
    
  }
}
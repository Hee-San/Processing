int[][][] WorldData = new int[22][12][22];
ArrayList<Block> BlockList = new ArrayList<Block>();


void setup(){
  size(1800, 900, P3D);
  background(255);
  BlockRegister();
  for(int x = 0; x < 22; x++){
    for(int y = 0; y < 12; y++){
      for(int z = 0; z < 22; z++){
        WorldData[x][y][z]=0;
      }
    }
  }
  for(int x = 1; x < 21; x++){
    for(int z = 1; z < 21; z++){
      WorldData[x][5][z] = 4;
      WorldData[x][4][z] = 3;
      WorldData[x][3][z] = 3;
      WorldData[x][2][z] = 1;
      WorldData[x][1][z] = 2;
    }
  }
}

void draw(){
  if(frameCount%100==0){
   background(255);
   for(int x = 1; x < 22; x++){
     for(int y = 1; y < 12; y++){
       for(int z = 1; z < 22; z++){
         if(WorldData[x][y][z]!=0){
           drawBlock(x,y,z,WorldData[x][y][z]);
           println(WorldData[x][y][z]);
         }
       }
     }
   }
  println("d");
  }
}

class Block{
  String Name;
  int blockID;
  boolean Brokenable,  DifTexture;
  PImage texT, texS, texB;
  Block(int ID, String Name){
   this.blockID = ID;
   this.Name = Name;
   this.Brokenable = false;
   this.DifTexture = false;
   this.texT = makeTexture(Name);
   this.texS = this.texT;
   this.texB = this.texT;
  }
  Block(int ID, String Name, boolean BA){
   this.blockID = ID;
   this.Name = Name;
   this.Brokenable = BA;
   this.DifTexture = false;
   this.texT = makeTexture(Name);
   this.texS = this.texT;
   this.texB = this.texT;
  }
  Block(int ID, String Name, boolean BA, String texT, String texS, String texB){
   this.blockID = ID;
   this.Name = Name;
   this.Brokenable = BA;
   this.DifTexture = true;
   this.texT = makeTexture(texT);
   this.texS = makeTexture(texS);
   this.texB = makeTexture(texB);
  }
}

class Item{
  
}

class Player{
  
}

void BlockRegister(){
  BlockList.add(0,new Block(0, "air"));
  BlockList.add(1,new Block(1, "dirt"));
  BlockList.add(2,new Block(2, "grass", false, "grass_top", "grass_side", "dirt"));
  BlockList.add(3,new Block(3, "stone"));
  BlockList.add(4,new Block(4, "bedrock", true));
  BlockList.add(5,new Block(5, "wool_colored_black"));
  BlockList.add(6,new Block(6, "wool_colored_blue"));
  BlockList.add(7,new Block(7, "wool_colored_brown"));
  BlockList.add(8,new Block(8, "wool_colored_cyan"));
  BlockList.add(9,new Block(9, "wool_colored_gray"));
  BlockList.add(10,new Block(10, "wool_colored_green"));
  BlockList.add(11,new Block(11, "wool_colored_light_blue"));
  BlockList.add(12,new Block(12, "wool_colored_lime"));
  BlockList.add(13,new Block(13, "wool_colored_magenta"));
  BlockList.add(14,new Block(14, "wool_colored_orange"));
  BlockList.add(15,new Block(15, "wool_colored_pink"));
  BlockList.add(16,new Block(16, "wool_colored_purple"));
  BlockList.add(17,new Block(17, "wool_colored_red"));
  BlockList.add(18,new Block(18, "wool_colored_silver"));
  BlockList.add(19,new Block(19, "wool_colored_white"));
  BlockList.add(20,new Block(20, "wool_colored_yellow"));
  
}




void drawBlock(int x, int y, int z, int ID){
  noStroke();
  if(WorldData[x][y][z] != 0 && 
      WorldData[x-1][y][z]*WorldData[x+1][y][z]*WorldData[x][y-1][z]*WorldData[x][y+1][z]*WorldData[x][y+1][z]*WorldData[x][y][z-1]*WorldData[x][y][z+1]==0){
    //println("a");
    pushMatrix();
    translate(width/2+x*64,height/2+y*64,z*64);
    Block b = BlockList.get(ID);
    if(WorldData[x][y][z-1] == 0){
      beginShape();
        texture(b.texS);
        vertex(-32,-32,-32,  0,  0);
        vertex(-32, 32,-32,100,  0);
        vertex( 32, 32,-32,100,100);
        vertex( 32,-32,-32,  0,100);
      endShape(CLOSE);
    }
    if(WorldData[x][y][z+1] == 0){
      beginShape();
        texture(b.texS);
        vertex(-32,-32, 32,  0,  0);
        vertex(-32, 32, 32,100,  0);
        vertex( 32, 32, 32,100,100);
        vertex( 32,-32, 32,  0,100);
      endShape(CLOSE);
      //println("c");
    }
    if(WorldData[x-1][y][z] == 0){
      beginShape();
        texture(b.texS);
        vertex(-32,-32,-32,  0,  0);
        vertex(-32, 32,-32,100,  0);
        vertex(-32, 32, 32,100,100);
        vertex(-32,-32, 32,  0,100);
      endShape(CLOSE);
    }
    if(WorldData[x+1][y][z] == 0){
      beginShape();
        texture(b.texS);
        vertex( 32,-32,-32,  0,  0);
        vertex( 32, 32,-32,100,  0);
        vertex( 32, 32, 32,100,100);
        vertex( 32,-32, 32,  0,100);
      endShape(CLOSE);
    }
    if(WorldData[x][y-1][z] == 0){
      beginShape();
        texture(b.texT);
        vertex(-32,-32,-32,  0,  0);
        vertex( 32,-32,-32,100,  0);
        vertex( 32,-32, 32,100,100);
        vertex(-32,-32, 32,  0,100);
      endShape(CLOSE);
    }
    if(WorldData[x][y+1][z] == 0){
      beginShape();
        texture(b.texB);
        vertex(-32, 32,-32,  0,  0);
        vertex( 32, 32,-32,100,  0);
        vertex( 32, 32, 32,100,100);
        vertex(-32, 32, 32,  0,100);
      endShape(CLOSE);
    }
    popMatrix();
  }
}

PImage makeTexture(String picN){
  PImage pic = loadImage(picN + ".png");
  PImage img = createImage(128, 128, RGB);
  for(int x = 0; x < 16; x++){
    for(int y = 0; y < 16; y++){
      color c = pic.get(x*pic.width/16+pic.width/32, y*pic.height/16+pic.height/32);
      for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
          img.pixels[(x*8+i)*128+(y*8+j)] = c;
        }
      }
    }
  }
  return img;
}
  
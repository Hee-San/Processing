import gifAnimation.*;

GifMaker gifExport;

int pointCount;
int freq = 2;
float phi = 0;
float modFreq = 12;

boolean drawFrequency = true;
boolean drawModulation = true;
boolean drawCombination = true;

float angle;
float y;

void setup() {
  size(1200, 600);
  smooth();
  
  pointCount = width;
  
  frameRate(50);
  
  gifExport = new GifMaker(this, "AM1.gif");
  gifExport.setRepeat(0);
  gifExport.setDelay(20);
}

void draw() {
  background(255);
  strokeWeight(1);
  noFill();
  
  translate(0, height/2);
  
  // draw oscillator with freq and phi
  if(drawFrequency){
    stroke(0, 130, 164);
    beginShape();
    for (int i=0; i<=pointCount; i++) {
      angle = map(i, 0, pointCount, 0, TWO_PI);
      y = sin(angle * freq + radians(phi) + radians(frameCount));
      y = y * (height/4);
      vertex(i, y);
    }
    endShape();
  }
  
  // draw oscillator with modFreq
  if(drawModulation){
    stroke(0, 130, 164, 128);
    beginShape();
    for (int i=0; i<=pointCount; i++) {
      angle = map(i, 0, pointCount, 0, TWO_PI);
      y = cos(angle * modFreq);
      y = y * (height/4);
      vertex(i, y);
    }
    endShape();
  }
  
  // draw both combined
  stroke(0);
  strokeWeight(2);
  beginShape();
  for (int i=0; i<=pointCount; i++) {
    angle = map(i, 0, pointCount, 0, TWO_PI);
    
    float info = sin(angle * freq + radians(phi) + radians(frameCount));
    float carrier = cos(angle * modFreq);
    y = info * carrier;
    y = y * (height/4);
    vertex(i, y);
  }
  endShape();
  /*
  if(radians(frameCount) <= TWO_PI){
    gifExport.addFrame();
  }else{
    gifExport.finish();
  }
  */
}

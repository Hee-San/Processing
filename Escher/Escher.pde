float[][] dot;
int[] dot1, dot2;
color c1 = color(208, 207, 205); //117-c
color c2 = color(181, 180, 176); //117-d
color c3 = color(130, 134, 131); //117-e
color c4 = color(189, 211, 120); //055-b
color c5 = color(169, 182, 120); //084-d
color c6 = color(126, 164,  94); //055-c
color c7 = color(217,  62,  72); //122-c
color c8 = color(208,  32,  74); //116-a
color c9 = color(174,  57,  58); //120-h
color c10 = color(155, 214, 230); //109-d
color c11 = color(105, 197, 214); //109-g
color c12 = color(115, 187, 198); //096-h
color ca, cb, cc;
float r = 40;
float dis = 300;
float len = 150;
float t = 0;
  
void setup(){
  size(640, 640);
  noStroke();
  frameRate(600);
}



void draw(){
  background(252, 253, 252, 20);
  float[] x = new float[] {  width/2 + (dis+r)*sqrt(3)/6,   width/2 + (dis+r)*sqrt(3)/6,   width/2 - (dis+r)*sqrt(3)/3  };
  float[] y = new float[] {         height/2 + (dis+r)/2,          height/2 - (dis+r)/2,                      height/2  };
  float t2 = t+dis;
  float t3 = t2+dis;

  if(t <= len){
    cube2(x[0]-r*sqrt(3)/2, y[0]-r/2, r, len-t, c4, c5, c6, 1);  //01
    cube(1,x,y);  //01
    cube2(x[0], y[0]-t, r, t, c4, c5, c6, 2);  //01
    
    cube2(x[1], y[1]+r, r, dis+len-t2, c7, c8, c9, 2);  //02
    cube(2,x,y);  //02
    cube2(x[1]-(t2-dis)*sqrt(3)/2, y[1]+(t2-dis)/2, r, t2-dis, c7, c8, c9, 3);  //02
    
    cube2(x[2]+r*sqrt(3)/2, y[2]-r/2, r, dis*2+len-t3, c10, c11, c12, 3);  //03
    cube(3,x,y);  //03
    cube2(x[2]+(t3-dis*2)*sqrt(3)/2, y[2]+(t3-dis*2)/2, r, t3-dis*2, c10, c11, c12, 1);  //03
  }else if(t<= dis-r){
    cube(1,x,y);  //01
    cube2(x[0], y[0]-t, r, len, c4, c5, c6, 2);  //01
    
    cube(2,x,y);  //02
    cube2(x[1]-(t2-dis)*sqrt(3)/2, y[1]+(t2-dis)/2, r, len, c7, c8, c9, 3);  //02
    
    cube(3,x,y);  //03
    cube2(x[2]+(t3-dis*2)*sqrt(3)/2, y[2]+(t3-dis*2)/2, r, len, c10, c11, c12, 1);  //03
  }else if(t<= dis){
    cube2(x[2]+(t3-dis*2)*sqrt(3)/2, y[2]+(t3-dis*2)/2, r, len, c10, c11, c12, 1);  //03
    cube(1,x,y);  //03
    
    cube2(x[0], y[0]-t, r, len, c4, c5, c6, 2);  //01
    cube(2,x,y);  //01
    
    cube2(x[1]-(t2-dis)*sqrt(3)/2, y[1]+(t2-dis)/2, r, len, c7, c8, c9, 3);  //02
    cube(3,x,y);  //02
  }
  t += 0.5;
  
  if(t >= dis) {
    t=0;
    ca = c7;
    cb = c8;
    cc = c9;
    c7 = c4;
    c8 = c5;
    c9 = c6;
    c4 = c10;
    c5 = c11;
    c6 = c12;
    c10 = ca;
    c11 = cb;
    c12 = cc;
  }
}


void cube(int n, float[] x, float[] y){
  cube(x[n-1], y[n-1], r, c1, c2, c3);
}


void cube(float x1, float y1, float r1, color a, color b, color c){
  dot = new float[][] { {            0+x1,    0+y1},
                        {            0+x1,   -r1+y1},
                        {-r1*sqrt(3)/2+x1, -r1/2+y1},
                        {-r1*sqrt(3)/2+x1,  r1/2+y1},
                        {            0+x1,   +r1+y1},
                        { r1*sqrt(3)/2+x1,  r1/2+y1},
                        { r1*sqrt(3)/2+x1, -r1/2+y1} };
  vertexArra(dot, new int[] {0, 6, 1, 2}, a);
  vertexArra(dot, new int[] {0, 2, 3, 4}, b);
  vertexArra(dot, new int[] {0, 4, 5, 6}, c);
}

void cube2 (float x1, float y1,float r1, float r2,
            color a, color b, color c, int type){
  r2 = r2 - r1;
  int f1, f2, f3;
  f1 = f2 = f3 = 0;
  
  if(type == 1){
   f1 = 1;
  }else if(type == 2){
   f2 = 1;
  }else{
   f3 = 1;
  }
  
  
  
  dot = new float[][] { {            0+x1                                     ,     0+y1                      },
                        {            0+x1-f1*r2*sqrt(3)/2     +f3*r2*sqrt(3)/2,   -r1+y1-f1*r2/2      -f3*r2/2},
                        {-r1*sqrt(3)/2+x1-f1*r2*sqrt(3)/2                     , -r1/2+y1-f1*r2/2              },
                        {-r1*sqrt(3)/2+x1-f1*r2*sqrt(3)/2+f2*0                ,  r1/2+y1-f1*r2/2+f2*r2        },
                        {            0+x1                +f2*0                ,    r1+y1        +f2*r2        },
                        { r1*sqrt(3)/2+x1                +f2*0+f3*r2*sqrt(3)/2,  r1/2+y1        +f2*r2-f3*r2/2},
                        { r1*sqrt(3)/2+x1                     +f3*r2*sqrt(3)/2, -r1/2+y1              -f3*r2/2} };
  
   
  vertexArra(dot, new int[] {0, 6, 1, 2}, a);
  vertexArra(dot, new int[] {0, 2, 3, 4}, b);
  vertexArra(dot, new int[] {0, 4, 5, 6}, c);
}



void vertexArra(float[][] array, int[] dotN, color c){
  fill(c);
  beginShape();
  for(int n = 0; n < dotN.length; n += 1){
    vertex(array[dotN[n]]);
    //println(n);
  }
  endShape(CLOSE);
}

void cube3 (float x1, float y1, float r1,float r2, color a, int type){
  int f1, f2, f3;
  f1 = f2 = f3 = 0;
  if(type == 1){
   f1 = 1;
  }else if(type == 2){
   f2 = 1;
  }else{
    f3 = 1;
  }
  
  dot = new float[][] { {            0+x1                                     ,     0+y1                      },
                        {            0+x1-f1*r2*sqrt(3)/2     +f3*r2*sqrt(3)/2,   -r1+y1-f1*r2/2      -f3*r2/2},
                        {-r1*sqrt(3)/2+x1-f1*r2*sqrt(3)/2                     , -r1/2+y1-f1*r2/2              },
                        {-r1*sqrt(3)/2+x1-f1*r2*sqrt(3)/2+f2*0                ,  r1/2+y1-f1*r2/2+f2*r2        },
                        {            0+x1                +f2*0                ,    r1+y1        +f2*r2        },
                        { r1*sqrt(3)/2+x1                +f2*0+f3*r2*sqrt(3)/2,  r1/2+y1        +f2*r2-f3*r2/2},
                        { r1*sqrt(3)/2+x1                     +f3*r2*sqrt(3)/2, -r1/2+y1              -f3*r2/2} };
  
   
  if(type == 1){
    vertexArra(dot, new int[] {0, 6, 1, 2}, a);
  }else if(type == 2){
    vertexArra(dot, new int[] {0, 2, 3, 4}, a);
  }else{
    vertexArra(dot, new int[] {0, 4, 5, 6}, a);
  }
}
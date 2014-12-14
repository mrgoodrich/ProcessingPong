ball b;
paddle p1, p2;
boolean aDown,zDown,kDown,mDown;
int startSpeedXForBall;
int timer;

void setup(){
  timer = 0;
  frameRate(1000);
  size(1080,720);
  if(random(10)>5){
    startSpeedXForBall = 3;
  } else {
    startSpeedXForBall = -3;
  }
  b = new ball((float)width/2,(float)height/2,startSpeedXForBall,(float)random(-3,3),(float)30);
  p1 = new paddle(10,height/2);
  p2 = new paddle(width-20,height/2);
  aDown=zDown=kDown=mDown=false;
}

void draw(){
  timer++;
  if(timer%300==0){
    b.increaseSpeed();
  }
  background(255);
  b.process();
  b.render();
  if(aDown){
    p1.move("up");
  }
  if(zDown){
    p1.move("down");
  }
  if(kDown){
    p2.move("up");
  }
  if(mDown){
    p2.move("down");
  }
  if(b.getCx()>width-20-b.getRad()/2&&b.getCx()<width-b.getRad()/2){
    if((b.getCy()>p2.getCy())&&(b.getCy()<p2.getCy()+p2.getPadHeight())){
      b.changeXDir();
      b.setCx(width-21-b.getRad()/2);
    }
  }
  if(b.getCx()<20+b.getRad()/2&&b.getCx()>b.getRad()/2){
    if((b.getCy()>p1.getCy())&&(b.getCy()<p1.getCy()+p1.getPadHeight())){
      b.changeXDir();
      b.setCx(21+b.getRad()/2);
    }
  }
  p1.render();
  p2.render();
}

class ball{
  float cx, cy, dx, dy, rad;
  ball(float cx1, float cy1, float dx1, float dy1, float rad1){
    cx = cx1;
    cy = cy1;
    dx = dx1;
    dy = dy1;
    rad = rad1;
  }
  void process(){
    cx += dx;
    cy += dy;
    if (cy<rad/2||cy>height-rad/2){
      dy*=-1;
    }
  }
  void render(){
    fill(color(255,175,0));
    ellipse(cx,cy,rad,rad);
  }
  void setCx(float x){
    cx = x;
  }
  int getCx(){
    return (int)cx;
  }
  int getCy(){
    return (int)cy;
  }
  void changeXDir(){
    dx*=-1;
  }
  int getRad(){
    return (int)rad;
  }
  void increaseSpeed(){
    dx*=1.2;
    dy*=1.2;
  }
  float getDx(){
    return (int)dx;  //add round up with regard to absolute value!!!
  }
}

class paddle{
  float cx, cy, padHeight, padWidth;
  paddle(float cx1, float cy1){
     cx = cx1;
     cy = cy1;
     padWidth = 10;
     padHeight = 100;
  }
  void move(String dir){
    if (dir.equals("up")){
      if (cy <= 5){
        cy = 0;
      }
      else{
        cy-=5;
      }
    } 
    if (dir.equals("down")){
      if (cy > height-padHeight-5){
        cy = height-padHeight;
      }
      else{
        cy+=5;  
      }
    }
  }
  int getCy(){
    return (int)cy;
  }
  int getCx(){
    return (int)cx;
  }
  int getPadHeight(){
    return (int)padHeight;
  }
  void render(){
    rect(cx,cy,padWidth,padHeight);
  }
}

void keyPressed(){
  if(key == 'a'){
    aDown = true;
  }
  if(key == 'z'){
    zDown = true;
  }
  if(key == 'k'){
    kDown = true;
  }
  if(key == 'm'){
    mDown = true;
  }
}

void keyReleased(){
  if(key == 'a'){
    aDown = false;
  }
  if(key == 'z'){
    zDown = false;
  }
  if(key == 'k'){
    kDown = false;
  }
  if(key == 'm'){
    mDown = false;
  }
}


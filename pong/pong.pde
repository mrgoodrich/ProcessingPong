PSys fireW1, fireW2;
ball b;
paddle p1, p2;
boolean aDown,zDown,kDown,mDown;
int startSpeedXForBall;
int timer;
int[] score;
boolean instFire;
//abcdefghijk

void setup(){
  instFire = false;
  noStroke();
  score = new int[2];
  score[0] = 0;
  score[1] = 0;
  textSize(60);
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
  if (score[0]==5){
   background(255);
   if(instFire == false){
     fireW1 = new PSys(100, new PVector(random(20,width-20), random(height/2)));
     instFire = true;
   }
   fireW1.run();
   if(fireW1.dead()){
     fireW1 = new PSys(100, new PVector(random(20,width-20), random(height/2)));
   }
   text("Player 1 wins!",width/2-200,height/2);
  }
  else if(score[1]==5){
   background(255);
   if(instFire == false){
     fireW1 = new PSys(100, new PVector(random(20,width-20), random(height/2)));
     instFire = true;
   }
   fireW1.run();
   if(fireW1.dead()){
     fireW1 = new PSys(100, new PVector(random(20,width-20), random(height/2)));
   }
   text("Player 2 wins!",width/2-200,height/2);
  }
  else{
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
      b.setDy((b.getCy()-p2.getCy())/(80/6)-3);
    }
  }
  if(b.getCx()<20+b.getRad()/2&&b.getCx()>b.getRad()/2){
    if((b.getCy()>p1.getCy())&&(b.getCy()<p1.getCy()+p1.getPadHeight())){
      b.changeXDir();
      b.setCx(21+b.getRad()/2);
      b.setDy((b.getCy()-p1.getCy())/(80/6)-3);
    }
  }
  fill(color(255,170,0));
  p1.render();
  fill(color(0,0,255));
  p2.render();
  fill(0);
  text(score[0],width/4,height/4);
  text(score[1],3*width/4,height/4);
  }
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
    if (cx<-10){
      score[1]++;
      cx = width/2;
      cy = height/2;
      dx = 3;
      dy = random(-3,3);
    }
    if (cx > width+10){
      score[0]++;
      cx = width/2;
      cy = height/2;
      dx = -3;
      dy = random(-3,3);
    }
  }
  void render(){
    fill(color(random(255),random(255),random(255)));
    ellipse(cx,cy,rad,rad);
  }
  void setCx(float x){
    cx = x;
  }
  void setDy(float y){
    dy = y;
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


/**********************
  Firework stuff below
**********************/
class Particle 
{
   PVector loc;
   PVector vel;
   PVector accel;
   float r;
   float life;
   color pcolor;
  
   // constructor
   Particle(PVector start, color c) 
   {
      accel = new PVector(0, 0.05); //gravity
      vel = new PVector(random(-2, 2), random(-5, 0), 0);
      pcolor = c;
      loc = start.get();  // make a COPY of the start location vector
      r = 8.0;
      life = random(200,250);
   }
    
   // what to do each frame
   void run() 
   {
      updateP();
      renderP(); // render is a fancy word for draw.  :)
   }
    
   // a function to update the particle each frame
   void updateP() 
   {
      vel.add(accel); 
      loc.add(vel);
      pcolor = color(255,0,0);
      if(random(10)>5){
        pcolor = color(0,255,0);
      }
      if(random(10)>5){
        pcolor = color(0,0,255);
      }
      life -= 1.0;
   }
   // how to draw a particle
   void renderP() 
   {
      pushMatrix();
       stroke(pcolor);
       fill(pcolor, 70);
       translate(loc.x, loc.y);
       ellipse(0, 0, r, r);
      popMatrix();
   }
    
    // a function to test if a particle is alive
   boolean alive() 
   {
      if (life <= 0.0) 
      {
         return false;
      } 
      else 
      {
         return true;
      }
   }
} //end of particle object definition

// now define a group of particles as a particleSys
class PSys
{
  
   ArrayList particles; // all the particles
   PVector source; // where all the particles emit from
   color shade; // their main color
  
   // constructor
   PSys(int num, PVector init_loc) 
   {
      particles = new ArrayList();
      source = init_loc.get();  // you have to do this to set a vector equal to another vector
      shade = color(random(255), random(255), random(255));  // TODO_2 use this!
      for (int i=0; i < num; i++) 
      {
         particles.add(new Particle(source, color(random(255),random(255),random(255))));
      }
   }
    
   // what to do each frame
   void run() 
   {
      // go through backwards for deletes
      for (int i=particles.size()-1; i >=0; i--) 
      {
         Particle p = (Particle)particles.get(i);
          
         // update each particle per frame
         p.run();
         if (!p.alive()) // what is that '!' thingy??
         {
            particles.remove(i);
         }
      }
   }
    
   boolean dead() 
   {
      if (particles.isEmpty()) 
      {
         return true;
      } 
      else 
      {
         return false;
      }
   }
}


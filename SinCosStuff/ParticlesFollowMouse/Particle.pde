class Particle{
  PVector pos;
  PVector oldPos;
  PVector acc;
  PVector vel;
  float maxSpeed;
  color c;
  
  Particle() {
    pos = new PVector(random(width), random(height));
    oldPos = pos.copy();
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    maxSpeed = (int)random(4, 10);
    c = color(255);
  }
  
  void update() {    
    pos.add(vel);
    
    vel.add(acc);
    vel.limit(maxSpeed);
    
    acc.mult(0);
  }
  
  void edges() {
    if(pos.x > width) {
      pos.x = 0;
      updatePos();
    }
    
    if(pos.x < 0) {
      pos.x = width;
      updatePos();
    }
    
    if(pos.y > height) {
      pos.y = 0;
      updatePos();
    }
    
    if(pos.y < 0) {
      pos.y = height;
      updatePos();
    }
  }
  
  void updateColor(color c1, color c2) {
    float fraction = pos.x / width;
    c = lerpColor(c1, c2, fraction);
  }
  
  void show() {
    stroke(c, 75);
    //println(pos.x + "\t" + oldPos.x);
    line(pos.x, pos.y, oldPos.x, oldPos.y);
    updatePos();
  }
  
  void follow(Flowfield field) {
    int x = floor(pos.x / field.spacing);
    int y = floor(pos.y / field.spacing);
    
    int index = x + y * field.cols;
    PVector v = field.vectors[index];
    acc.add(v);
  }
  
  void updatePos() {
    oldPos.x = pos.x;
    oldPos.y = pos.y;
  }
}

class Gradient{
  int x, y, z; 
  float w, h;
  color c1, c2;
  Gradient(int x, int y, int z, float w, float h, color c1, color c2){
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.c1 = c1;
    this.c2 = c2;
  }

void setGradient() {
  pushMatrix();
  translate(-3000, -3000, 000);
  noFill();
  for (int i = y; i <= y+h*10; i++) {
    float inter = map(i, y, y+h*10, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, z, x+w*10, i, z);
  }
  popMatrix();
}
}

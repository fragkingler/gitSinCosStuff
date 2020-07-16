class Gradient{
  int x, y, z; 
  float w, h;
  color c1, c2;
  
  // Constructor
  Gradient(int x, int y, int z, float w, float h, color c1, color c2){ //
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
  translate(-w/2,-h/2);
  noFill();
  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter); // Interpolate color  between upper and lower color
    stroke(c); // Set the color of the stroke to the recalculated interpolation
    line(x, i, z, x+w, i, z); // Draw the gradient stroke
  }
  popMatrix();
}
}

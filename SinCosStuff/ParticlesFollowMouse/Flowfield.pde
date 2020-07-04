class Flowfield {
  int rows;
  int cols;
  PVector[] vectors;
  float spacing;
  float stepSize;
  float zoff = 0;
  
  Flowfield(int res) {
    spacing = res;
    cols = floor(width / spacing) + 1;
    rows = floor(height / spacing) + 1;
    vectors = new PVector[rows * cols];
    stepSize = 0.1;
  }
  
  void update() {
    float yoff = 0;
    for(int y = 0; y < cols; y++) {
      float xoff = 0;
      for(int x = 0; x < rows; x++) {
        float angle = noise(xoff, yoff, zoff) * TWO_PI;
        
        PVector v = PVector.fromAngle(angle);
        v.setMag(1);
        
        int index = x + y * rows;
        vectors[index] = v;
        
        xoff += stepSize;
      }
      yoff += stepSize;
    }
    zoff += stepSize;
  }
  
  void show() {
    for(int y = 0; y < cols; y++) {
      for(int x = 0; x < rows; x++) {
        int index = x + y * rows;
        PVector v = vectors[index];
        pushMatrix();
        translate(x * spacing, y * spacing);
        println(v.heading());
        fill(map(v.heading(), -TWO_PI, TWO_PI, 0, 255));
        rect(0, 0, spacing, spacing);
        rotate(v.heading());
        stroke(255, 0, 0);
        line(0, 0, spacing, 0);
        popMatrix();
      }
    }
  }
  
}

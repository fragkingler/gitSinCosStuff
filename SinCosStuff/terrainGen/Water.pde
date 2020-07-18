class Water {
  int cols, rows, blockSize, waterHeight;
  float alpha;
  color waterColor;
  boolean plainWater;
  float[][] terrain;

  // Constructor
  Water(int cols, int rows, int blockSize, int waterHeight, color waterColor, boolean plainWater, float[][] terrain) {
    this.cols = cols;
    this.rows = rows;
    this.terrain = terrain;
    this.blockSize = blockSize;
    this.waterHeight = waterHeight;
    this.waterColor = waterColor;
    this.plainWater = plainWater;
  }

  // Get Terrain and draw water according to terrain
  void calcWater(float[][] terrain) {
    for (int y = 0; y<rows-1; y++) {
      pushMatrix();
      rotateX(PI/2.5); // Rotate the Terrain that will be drawn
      translate(-w/2, -h/2, -height); // Undo rotation in order to start drawing at the upper left corner and not in the mid of canvas
      beginShape(TRIANGLES); // Water is filled with triangles, could also be simple rects, but I wanted a more fluid simulation so I used triangles
      for (int x = 0; x<cols-1; x++) {
        if (terrain[x][y] < waterHeight) {
          // Set a bit of Alpha depending on the Y-position
          alpha = map(rows-y, 0, rows, 20, 150);
          fill(waterColor, alpha);
          
          // Choose water-style
          if (plainWater) {
            // Water is at z=0 and doesn't adjust in height/z-coordinate
            vertex(x*blockSize, y*blockSize, waterHeight);
            vertex(x*blockSize, (y+1)*blockSize, waterHeight);
            vertex((x+1)*blockSize, y*blockSize, waterHeight);
            vertex((x+1)*blockSize, (y+1)*blockSize, waterHeight);
            vertex(x*blockSize, (y+1)*blockSize, waterHeight);
            vertex((x+1)*blockSize, y*blockSize, waterHeight);
          } else {
            // Water that adjusts to terrain and isn't a "plane"; comment the other stuff out then
            vertex(x*blockSize, y*blockSize, map(terrain[x][y], -100, waterHeight, waterHeight-15, waterHeight+5));
            vertex(x*blockSize, (y+1)*blockSize, map(terrain[x][y+1], -100, waterHeight, waterHeight-15, waterHeight+5));
            vertex((x+1)*blockSize, y*blockSize, map(terrain[x+1][y], -100, waterHeight, waterHeight-15, waterHeight+5));
            vertex((x+1)*blockSize, (y+1)*blockSize, map(terrain[x+1][y+1], -100, waterHeight, waterHeight-15, waterHeight+5));
            vertex(x*blockSize, (y+1)*blockSize, map(terrain[x][y+1], -100, waterHeight, waterHeight-15, waterHeight+5));
            vertex((x+1)*blockSize, y*blockSize, map(terrain[x+1][y], -100, waterHeight, waterHeight-15, waterHeight+5));
          }
        }
      }
      endShape();
      popMatrix();
    }
  }
}

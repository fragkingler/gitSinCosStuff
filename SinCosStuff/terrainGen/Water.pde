class Water {
  int cols, rows, blockSize, waterHeight;
  color waterColor;
  float[][] terrain;
  
  // Constructor
  Water(int cols, int rows, int blockSize, int waterHeight, color waterColor, float[][] terrain){
    this.cols = cols;
    this.rows = rows;
    this.terrain = terrain;
    this.blockSize = blockSize;
    this.waterHeight = waterHeight;
    this.waterColor = waterColor;
  }
  
  // Get Terrain and draw water according to terrain
  void calcWater(float[][] terrain) {
    for (int y = 0; y<rows-1; y++) {
      beginShape(TRIANGLES); // Water is filled with triangles, could also be simple rects, but I wanted a more fluid simulation so I used triangles
      for (int x = 0; x<cols-1; x++) {
        fill(waterColor, map(rows*(y), 0, 1000, 0, 100));
        if (terrain[x][y] < waterHeight) {
          // Water adjusts to terrain and isn't a "plane"
          //vertex(x*scl, y*scl, map(terrain[x][y],-100,-20,-25,-15));
          //vertex(x*scl, (y+1)*scl, map(terrain[x][y+1],-100,-20,-25,-15));
          //vertex((x+1)*scl, y*scl, map(terrain[x+1][y],-100,-20,-25,-15));
          //vertex((x+1)*scl, (y+1)*scl, map(terrain[x+1][y+1],-100,-20,-25,-15));
          //vertex(x*scl, (y+1)*scl, map(terrain[x][y+1],-100,-20,-25,-15));
          //vertex((x+1)*scl, y*scl, map(terrain[x+1][y],-100,-20,-25,-15));
          
          // Water is at z=0 and doesn't adjust in height/z-coordinate
          vertex(x*blockSize, y*blockSize, map(terrain[x][y], -100, -20, -20, -20));
          vertex(x*blockSize, (y+1)*blockSize, map(terrain[x][y+1], -100, -20, -20, -20));
          vertex((x+1)*blockSize, y*blockSize, map(terrain[x+1][y], -100, -20, -20, -20));
          vertex((x+1)*blockSize, (y+1)*blockSize, map(terrain[x+1][y+1], -100, -20, -20, -20));
          vertex(x*blockSize, (y+1)*blockSize, map(terrain[x][y+1], -100, -20, -20, -20));
          vertex((x+1)*blockSize, y*blockSize, map(terrain[x+1][y], -100, -20, -20, -20));
        }
      }
      endShape();
    }
  }
}

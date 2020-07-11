class Water {
  int cols, rows, scl;
  float[][] terrain;
  Water(int cols, int rows, float[][] terrain, int scl){
    this.cols = cols;
    this.rows = rows;
    this.terrain = terrain;
    this.scl = scl;
  }

  void calcWater(float[][] terrain) {
    for (int y = 0; y<rows-1; y++) {
      beginShape(TRIANGLES);
      for (int x = 0; x<cols-1; x++) {
        fill(19, 31, 149, 100);
        if (terrain[x][y] < -20) {
          //water adjusts to terrain
          //vertex(x*scl, y*scl, map(terrain[x][y],-100,-20,-25,-15));
          //vertex(x*scl, (y+1)*scl, map(terrain[x][y+1],-100,-20,-25,-15));
          //vertex((x+1)*scl, y*scl, map(terrain[x+1][y],-100,-20,-25,-15));
          //vertex((x+1)*scl, (y+1)*scl, map(terrain[x+1][y+1],-100,-20,-25,-15));
          //vertex(x*scl, (y+1)*scl, map(terrain[x][y+1],-100,-20,-25,-15));
          //vertex((x+1)*scl, y*scl, map(terrain[x+1][y],-100,-20,-25,-15));
          //water is at z=0
          vertex(x*scl, y*scl, map(terrain[x][y], -100, -20, -20, -20));
          vertex(x*scl, (y+1)*scl, map(terrain[x][y+1], -100, -20, -20, -20));
          vertex((x+1)*scl, y*scl, map(terrain[x+1][y], -100, -20, -20, -20));
          vertex((x+1)*scl, (y+1)*scl, map(terrain[x+1][y+1], -100, -20, -20, -20));
          vertex(x*scl, (y+1)*scl, map(terrain[x][y+1], -100, -20, -20, -20));
          vertex((x+1)*scl, y*scl, map(terrain[x+1][y], -100, -20, -20, -20));
        }
      }
      endShape();
    }
  }
}

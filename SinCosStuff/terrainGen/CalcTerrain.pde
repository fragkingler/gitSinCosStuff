class CalcTerrain {
  int cols, rows;
  float[][] terrain;
  CalcTerrain(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    terrain = new float[cols][rows];
  }

  float[][] calcTerrain(float flying) {
    float yoff = flying;
    for (int y = 0; y<rows; y++) {
      float xoff = 0;
      for (int x = 0; x<cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
        xoff += 0.1;
      }
      yoff += 0.1;
    }
    return terrain;
  }
}

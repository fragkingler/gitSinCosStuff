class CalcTerrain {
  int cols, rows;
  float terrainMin, terrainMax;
  float[][] terrain;
  CalcTerrain(int cols, int rows, float terrainMin, float terrainMax) {
    this.cols = cols;
    this.rows = rows;
    this.terrainMin = terrainMin;
    this.terrainMax = terrainMax;
    terrain = new float[cols][rows];
  }

  float[][] calcTerrain(float flying) {
    float yoff = flying;
    for (int y = 0; y<rows; y++) {
      float xoff = 0;
      for (int x = 0; x<cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, terrainMin, terrainMax);
        xoff += 0.1;
      }
      yoff += 0.1;
    }
    return terrain;
  }
}

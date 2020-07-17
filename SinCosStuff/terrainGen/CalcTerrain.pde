class CalcTerrain {
  int cols, rows;
  float terrainMin, terrainMax;
  float[][] terrain;

  // Constructor
  CalcTerrain(int cols, int rows, float terrainMin, float terrainMax) {
    this.cols = cols;
    this.rows = rows;
    this.terrainMin = terrainMin;
    this.terrainMax = terrainMax;
    terrain = new float[cols][rows];
  }

  // Calculate the new terrain based on the "wanted movement"
  float[][] calcTerrain(float flying) {
    float yoff = flying; // Calculate yoff and xoff for neighboor-sensitive terrain-calculation and yoff also handles the "cam-movement"
    for (int y = 0; y<rows; y++) {
      float xoff = 0;
      for (int x = 0; x<cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, terrainMin, terrainMax); // Calculate and save the z value of the current block
        xoff += 0.1;
      }
      yoff += 0.1;
    }
    return terrain; // Return re-calculated array
  }
}

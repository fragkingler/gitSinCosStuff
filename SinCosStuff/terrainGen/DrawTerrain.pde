class DrawTerrain {
  Gradient gradient;

  int cols, rows, scl;
  float stoneEnd, dirtEnd, grassEnd, w, h;
  float[][] terrain;

  DrawTerrain(int cols, int rows, int scl, float stoneEnd, float dirtEnd, float grassEnd, float w, float h, float[][] terrain) {
    this.cols = cols;
    this.rows = rows;
    this.scl = scl;
    this.stoneEnd = stoneEnd;
    this.dirtEnd = dirtEnd;
    this.grassEnd = grassEnd;
    this.w = w;
    this.h = h;
    this.terrain = terrain;
    gradient = new Gradient(0, 0, -4000, width, height, b1, b2);
  }

  void drawTerrain() {
    gradient.setGradient();
    translate(width/2, height/2-50);
    rotateX(PI/3);
    translate(-w/2, -h/2);
    for (int y = 0; y<rows-1; y++) {
      for (int x = 0; x<cols; x++) {
        pushMatrix();
        noStroke();
        if (terrain[x][y] < stoneEnd) {
          activeColor = stone;
        } else if (terrain[x][y] < dirtEnd) {
          activeColor = lerpColor(stone, dirt, map(terrain[x][y], stoneEnd, dirtEnd, 0, 1));
        } else {
          activeColor = lerpColor(dirt, grass, map(terrain[x][y], dirtEnd, grassEnd, 0, 1));
        }
        fill(activeColor);
        translate(x*scl, y*scl, terrain[x][y]);
        box(scl);
        translate(0, 0, 0-scl);
        box(scl);
        popMatrix();
      }
    }
  }
}

class DrawTerrain {
  Gradient gradient; // This class provides the gradient background

  int cols, rows, blockSize;
  float stoneEnd, dirtEnd, grassEnd, w, h;
  float[][] terrain;

  // Constructor
  DrawTerrain(int cols, int rows, int blockSize, float stoneEnd, float dirtEnd, float grassEnd, float w, float h) {
    this.cols = cols;
    this.rows = rows;
    this.blockSize = blockSize;
    this.stoneEnd = stoneEnd;
    this.dirtEnd = dirtEnd;
    this.grassEnd = grassEnd;
    this.w = w;
    this.h = h;

    // Create new background-object which can be drawn together with the draw-Terrain
    gradient = new Gradient(0, 0, -4000, width, height, gradient1, gradient2); // Params: x, y, z, width, height, gradientStartColor, gradientEndColor
  }
  
  // Draw the blocks/terrain with the calculated terrain as input
  void drawTerrain(float[][] terrain) {
    this.terrain = terrain;
    
    // Draw the Gradient-Background
    gradient.setGradient();
    
    // Get mid-point of the canvas in order to rotate the terrain in the middle
    translate(width/2, height/2-50); // The number after "height/2" is used to adjust the viewing angle of the terrain
    rotateX(PI/3); // Rotate the Terrain that will be drawn
    translate(-w/2, -h/2); // Undo rotation in order to start drawing at the upper left corner and not in the mid of canvas
    for (int y = 0; y<rows-1; y++) {
      for (int x = 0; x<cols; x++) {
        
        // Actual Terrain drawing
        pushMatrix();
        noStroke();
        
        // Calculate the color of the Block
        if (terrain[x][y] < stoneEnd) {
          activeColor = stone;
        } else if (terrain[x][y] < dirtEnd) {
          activeColor = lerpColor(stone, dirt, map(terrain[x][y], stoneEnd, dirtEnd, 0, 1)); // Fade color between stoneEnd and dirtEnd in order to prevent "color-jumps"
        } else {
          activeColor = lerpColor(dirt, grass, map(terrain[x][y], dirtEnd, grassEnd, 0, 1)); // Fade color between dirtEnd and grassEnd in order to prevent "color-jumps"
        }
        
        // Set the actual Color of the block, as well as a bit of Alpha depending on the Y-position
        fill(activeColor, map(rows*(y+1), 1, rows+1, 0, 255));
        
        // Get the position of this exakt block before drawing it, since the "box" doesn't accept x,y,z values
        translate(x*blockSize, y*blockSize, terrain[x][y]);
        box(blockSize); // Draw box
        translate(0, 0, 0-blockSize); // Change the z value by the blockSize in order to draw a block under each block. This prevents "holes" in the terrain as it's moving
        box(blockSize);
        popMatrix();
      }
    }
  }
}

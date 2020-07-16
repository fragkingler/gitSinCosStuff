int cols, rows, blockSize, w, h, waterHeight;
color gradient1, gradient2; // Color for background-fade
color stone, dirt, grass, waterColor, activeColor;
float flying, flyingInc, lightX, lightY, lightZ;
float terrainMax, terrainMin, stoneEnd, dirtEnd, grassEnd;
float[][] terrain; // Array which stores calculated terrain

CalcTerrain cTerrain; // This class is providing terrain calculation
DrawTerrain dTerrain; // This class draws the calculated terrain
Water water; // This class handles water

void setup() {
  //hint(ENABLE_KEY_REPEAT); // This activates registering long key press as multiple key-press
  size(562, 794, P3D); // Fully adjustable scaling based on size; don't set height below 300
  frameRate(30);

  w = int(width*3); // Width of 2d-Terrain
  h = int(height*3); // Height of 2d-Terrain
  blockSize = 20; // Size of each block

  waterHeight = -0; // Level at which water is drawn
  stoneEnd = 00; // Stone-color if block is at or below this Z value
  dirtEnd = 60; // Dirt-color if block is at exactly this Z value
  grassEnd = 100; // Grass color if block is at or higher than this Z value

  terrainMin = -100; // Maximum negative terrain distortion
  terrainMax = 150; // Maximum positive terrain distortion

  // Make ground appear like it's flying; flyingInc = speed, has to be negative to fly "forward"
  flying = 0;
  flyingInc = -0.01;

  // Position lightning source
  lightX = 500;
  lightY = 1250;
  lightZ = 1300;

  gradient1 = color(30, 151, 235);
  gradient2 = color(125, 214, 251);

  stone = color(100, 90, 110); // Base-color of stone
  dirt = color(120, 70, 20); // Base-color of dirt
  grass = color(60, 180, 40); // Base-color of grass
  waterColor = color(19, 31, 149); // Water-Color

  // Calculate the amount of blocks 
  cols = w / blockSize; 
  rows = h / blockSize;

  // Enable lights and draw basic 3d-lightning
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ);

  // Constructor for each class
  cTerrain = new CalcTerrain(cols, rows, terrainMin, terrainMax); // Params: as var-names
  terrain = cTerrain.calcTerrain(flying); // Params: speed at which terrain should move
  water = new Water(cols, rows, blockSize, waterHeight, waterColor, terrain); // Params: as var-names
  dTerrain = new DrawTerrain(cols, rows, blockSize, stoneEnd, dirtEnd, grassEnd, w, h); // Params: as var-names
}

void draw() {

  // Enable lights and draw basic 3d-lightning
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ); // Variables: red, green, blue, X, Y, Z

  // Increment flying by flyingInc in order to have a continuous "flying" effect on the terrain
  flying+=flyingInc;

  // Pass increased flying value to calcTerrain to recalculate the "moved" terrain and save the resulted new terrain in the terrain-variable
  terrain = cTerrain.calcTerrain(flying); 

  // Draw terrain after it has been calculated + background is being drawn here
  dTerrain.drawTerrain(terrain);

  // Draw water in according spots after terrain has been calculated
  water.calcWater(terrain);

  // Export png's for animation
  //if (frameCount <= 300) {
  //  saveFrame("terrain-#######.png");
  //}
}

// Possible interactions with keystrokes; was used to position 3d-light accordingly
//void keyPressed() {
//  if (key == 'd') {
//    lightX += 10;
//  } else if (key == 'a') {
//    lightX -= 10;
//  } else if (key == 'w') {
//    lightZ += 10;
//  } else if (key == 's') {
//    lightZ -= 10;
//  } else if (key== CODED) {
//    if (keyCode == LEFT) 
//    {
//      lightY += 10;
//    } else if (keyCode == RIGHT) 
//    {
//      lightY -= 10;
//    }
//  }
//  println("lightX: "+lightX + "\nlightY: "+lightY+"\nlightZ: "+lightZ);
//}

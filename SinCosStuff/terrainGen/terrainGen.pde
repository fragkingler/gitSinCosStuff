int cols, rows, blockSize, w, h, waterHeight, cloudCount, cloudStartZ, cPerc, rFrame;
color gradient1, gradient2; // Color for background-fade
color stone, dirt, grass, waterColor, activeColor;
float flying, flyingInc, cloudFlyingMod, lightX, lightY, lightZ, cloudZ, killCloud;
float terrainMax, terrainMin, stoneEnd, dirtEnd, grassEnd;
float[][] terrain; // Array which stores calculated terrain
String text = "Procedural Generation by Yannis Vogel"; // Words to be drawn on clouds
boolean drawImg, drawText, pause, plainWater, record, stopCloud, cloudStopper = false;

ArrayList<Cloud> clouds; // Array containing cloud-objects

CalcTerrain cTerrain; // This class is providing terrain calculation
DrawTerrain dTerrain; // This class draws the calculated terrain
Water water; // This class handles water

PImage iText;
PFont font;

void setup() {
  //hint(ENABLE_KEY_REPEAT); // This activates registering long key press as multiple key-press
  //size(562, 794, P3D); // Fully adjustable scaling based on size; don't set height below 300
  size(842, 1191, P3D); // Fully adjustable scaling based on size; don't set height below 300
  frameRate(30);

  w = int(width*3.2); // Width of 2d-Terrain
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

  // Gradient background, gradient1 is the upper gradient color, gradient2 is the lower gradient color
  gradient1 = color(30, 151, 235);
  gradient2 = color(125, 214, 251);

  stone = color(100, 90, 110); // Base-color of stone
  dirt = color(120, 70, 20); // Base-color of dirt
  grass = color(60, 180, 40); // Base-color of grass
  waterColor = color(19, 31, 149); // Water-Color

  // Calculate the amount of blocks 
  cols = w / blockSize; 
  rows = h / blockSize;

  // Cloud gen modificators
  cloudCount = 1; // Initial cloud count
  cloudStartZ = -1700; // Modificator to start cloud drawing behind background
  cloudFlyingMod = 20; // Modificator for cloud-speed
  killCloud = (cloudStartZ*-1)/(cloudFlyingMod*0.5); // Kill cloud at this Z value
  cPerc = 15; // Probability of new cloud spawning at a frame

  drawImg = false; // Draw text "Procedural generation" as image at the top of poster; Looks bad so better keep disabled
  drawText = true; // Draw text on clouds
  pause = false; // Pause animation - Switches on keypress
  plainWater = true; // Draw plain (realistic) water or water that adjusts to terrain (unrealistic)
  record = false; // Record animation for next 300 frames. Activate on key "r"
  cloudStopper = false; // When active, clouds that are hovered over will be stopped

  // Enable lights and draw basic 3d-lightning
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ);

  // Load text-image that will appear at the top of poster if enabled
  if (drawImg)
    iText = loadImage("ProcGen.png");
    
  // Set text defaults and font. TextMode(SHAPE) is responsible for quality-lossless text display
  font = createFont("Minecrafter.Reg.ttf", 32);
  textFont(font);
  textMode(SHAPE);

  // Constructor for each class
  cTerrain = new CalcTerrain(cols, rows, terrainMin, terrainMax); // Params: as var-names
  terrain = cTerrain.calcTerrain(flying); // Params: speed at which terrain should move
  water = new Water(cols, rows, blockSize, waterHeight, waterColor, plainWater, terrain); // Params: as var-names
  dTerrain = new DrawTerrain(cols, rows, blockSize, stoneEnd, dirtEnd, grassEnd, w, h); // Params: as var-names
  clouds = new ArrayList<Cloud>(); // Initialisation of the Clouds-Array
}

void draw() {
  if (!pause) { // Check pause status
    if (record) {
      if (rFrame < frameCount+300) { // Check if 300 frames been saved since pressing "r"
        saveFrame("export/frame-#####.png");
      } else {
        record = false;
      }
    }

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

    // Draw clouds until CloudCount is reached
    for (int i = cloudCount; i > clouds.size()-1; i--) {
      clouds.add(new Cloud(clouds.size(), cloudStartZ, flying*cloudFlyingMod, text)); // Add new cloud with params: Cloud-ID, Z-Position, CloudSpeed and the words that are printed on clouds
    }

    for (int i = clouds.size()-1; i >= 0; i--) { // Iterate through all clouds, from last to first in order to prevent out of bounds on delete
      hint(ENABLE_DEPTH_SORT); // Depth sorting for transparency of clouds
      cloudZ = clouds.get(i).drawCloud(flying*cloudFlyingMod); // Draw cloud with "flying" animation
      hint(DISABLE_DEPTH_SORT); // Disable depth sorting in order to prevent render problems/bugs
      if (cloudZ >= killCloud) { // Is cloud in deadzone?
        clouds.remove(clouds.get(i)); // Kill/delete cloud to save resources
      }
    }

    // Increase or decrease base cloudCount randomly
    if (random(0, 100) < cPerc) { 
      cloudCount +=1;
    } else if (random(0, 100) < cPerc-5) {
      cloudCount -=1;
    }

    // Draw image at the top of poster, if enabled
    if (drawImg) {
      // Draw text "Procedural Generation"
      imageMode(CENTER);
      iText.resize(width/2, 0); // Resize will keep aspect ratio of original image
      image(iText, width/2, 50);
    }
  }
}

// Key interactions
void keyPressed() {
  if (key == 'c') { // Add new Cloud when "C" is pressed
    clouds.add(new Cloud(clouds.size(), cloudStartZ, flying*cloudFlyingMod, text));
  } else if (key == ' ') { // Pause/unpause program on spacebar
    pause = !pause;
  } else if (key == 's') { // Export png as single frame
    saveFrame("terrain-#######.png");
  } else if (key == 'r') { // Export png's for animation, 300 frames after pressing are "recorded"
    record = true;
    rFrame = frameCount;
  } else if (key==CODED) {
    if (keyCode == DOWN) { // Increase cloud-speed and teleport clouds forward on arrow-down key
      cloudFlyingMod +=1;
    } else if (keyCode == UP) { // Decrease cloud-speed and teleport clouds backwards on arrow-down key
      cloudFlyingMod -= 1;
    }
  }
}

// Stop clouds when clicking on it (top-front-right corner)
//void mouseReleased() {
//  cloudStopper = !cloudStopper;
//}
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

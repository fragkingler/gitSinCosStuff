int cols, rows;
int scl = 20;
int w = 1600;
int h = 800;
float lightX = 500, lightY = 1250, lightZ=1300;
color b1, b2;
float flying = 0, flyingInc = -0.005;
color stone = color(100, 90, 110);
color dirt = color(120, 70, 20);
color grass = color(60, 180, 40);
color activeColor;
float terrainMax = 100;
float terrainMin = -100;
float stoneEnd = -40;
float dirtEnd = 00;
float grassEnd = 60;
float[][] terrain;

CalcTerrain cTerrain;
DrawTerrain dTerrain;
Water water;
Gradient gradient;

void setup() {
  hint(ENABLE_KEY_REPEAT);
  size(600, 600, P3D);
  frameRate(60);
  cols = w / scl;
  rows = h / scl;
  b1 = color(30, 151, 235);
  b2 = color(125, 214, 251);
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ);
  gradient = new Gradient(0, 0, -4000, width, height, b1, b2);
  cTerrain = new CalcTerrain(cols, rows);
  terrain = cTerrain.calcTerrain(flying);
  water = new Water(cols, rows, terrain, scl);
  dTerrain = new DrawTerrain(cols, rows, scl, stoneEnd, dirtEnd, grassEnd, w, h, terrain);
}

void draw() {
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ);
  flying+=flyingInc;
  terrain = cTerrain.calcTerrain(flying);
  dTerrain.drawTerrain();
  water.calcWater(terrain);
}

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

int cols, rows;
int scl = 20;
int w = 1600;
int h = 800;
float[][] terrain;
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
  terrain = new float[cols][rows];
  calcTerrain(flying);
  drawTerrain();
}

void draw() {
  lights();
  directionalLight(126, 126, 126, lightX, lightY, lightZ);
  flying+=flyingInc;
  calcTerrain(flying);
  drawTerrain();
}

void mouseReleased() {
}

void drawTerrain() {
  setGradient(0, 0, -4000, width, height, b1, b2);
  stroke(255);
  noFill();
  translate(width/2, height/2-50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x<cols; x++) {
      //vertex(x*scl, y*scl, terrain[x][y]);
      //vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
      pushMatrix();
      noStroke();
      if (terrain[x][y] < stoneEnd) {
        activeColor = stone;
      } else if (terrain[x][y] < dirtEnd) {
        activeColor = lerpColor(stone, dirt, map(terrain[x][y], stoneEnd, dirtEnd, 0, 1));
      } else {
        activeColor = lerpColor(dirt, grass, map(terrain[x][y], dirtEnd, grassEnd, 0, 1));
      }
      fill(activeColor, 10);
      translate(x*scl, y*scl, terrain[x][y]);
      box(scl);
      translate(0, 0, 0-scl);
      box(scl);
      popMatrix();
      fill(255);
      stroke(255);
      if (terrain[x][y] < 20) {
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
    }
    endShape();
  }
}

void calcTerrain(float flying) {
  float yoff = flying;
  for (int y = 0; y<rows; y++) {
    float xoff = 0;
    for (int x = 0; x<cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
}

void setGradient(int x, int y, int z, float w, float h, color c1, color c2) {
  pushMatrix();
  translate(-3000, -3000, 000);
  noFill();
  for (int i = y; i <= y+h*10; i++) {
    float inter = map(i, y, y+h*10, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, z, x+w*10, i, z);
  }
  popMatrix();
}

void keyPressed() {
  if (key == 'd') {
    lightX += 10;
  } else if (key == 'a') {
    lightX -= 10;
  } else if (key == 'w') {
    lightZ += 10;
  } else if (key == 's') {
    lightZ -= 10;
  } else if (key== CODED) {
    if (keyCode == LEFT) 
    {
      lightY += 10;
    } else if (keyCode == RIGHT) 
    {
      lightY -= 10;
    }
  }
  println("lightX: "+lightX + "\nlightY: "+lightY+"\nlightZ: "+lightZ);
}
